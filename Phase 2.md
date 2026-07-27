# Phase 2

*Coactive improvement from model proposals and human continuations*

**Status:** Research direction following the predictive system in [[Phase 1]]. This document specifies the comparative signal created when the model shows a possible next action, the person subsequently chooses what to do, and the system learns whether and when to intervene.

## Abstract

Phase 1 learns from what the person does. Phase 2 also learns from what the person does *instead of* a model proposal.

At a bounded decision point, a proposal policy samples possible next actions from the history available before display. Some samples are shown. The person reads them and then writes, searches, edits, or sends something of their own. The core Phase 2 assumption is that this later human action is locally superior to each distinct, comparable proposal the person actually saw. The person need not be an optimal demonstrator in general. They need only be a reliable adjudicator of these local alternatives after the model has made them concrete.

A shown interaction supports three learning problems. The human continuation remains a behavioral-cloning target under the history that includes the displayed samples. The comparison between that continuation and each displayed sample can improve a separate pre-display proposal policy with Identity Preference Optimization (IPO). The same comparisons can train an explicit reward model if a reusable scalar is needed for later reinforcement learning. Across eligible decision points, randomized show-or-abstain outcomes support a fourth problem: learning when an intervention is worthwhile. These roles share data but not objectives or model identity.

The separation matters. Behavioral cloning models how the person acts inside the collaboration. IPO improves what the system proposes before the person acts. A reward model preserves the comparative judgment for later planning or policy-gradient training. A separate proactivity policy decides whether and when showing anything is worth interrupting the person. None is asked to stand in for the others.

## 1. From Prediction to Coactive Improvement

The model's samples are useful even when they are wrong. They turn a vague decision into visible alternatives. The person can accept a direction, repair a flaw, synthesize several ideas, reject the premise, or take a better action that becomes apparent only after seeing what the model produced. The resulting action contains information that was absent from the original behavior log: not merely what the person did, but what they did after considering specific machine-generated possibilities.

This is a form of coactive learning. The interface does not interrupt work to ask for a rating. It places bounded alternatives into the work, observes which continuation the person actually authors, and derives a local comparison from that interaction. The supervision is dense, naturally on-policy, and tied to the person's current context.

The ambition remains a human–model system that learns implied objectives and reaches acceptable outcomes faster or better. Phase 1 tests whether objective-relevant state is legible in the personal stream. Phase 2 tests whether the person's response to model samples supplies a directional signal for improving assistance. The signal is local: it says which action was better at one decision point. It does not yet define a trajectory return or a complete reward for the person's life.

## 2. Assumptions

Phase 2 adds the following assumptions to the collection and modeling conditions in [[Phase 1]]:

1. **Post-proposal local superiority.** If the person sees a proposal and then produces a distinct action addressing the same local decision, the human action is superior to the proposal. This is a core modeling assumption, not an inference from textual similarity.
2. **Global imperfection is compatible with local authority.** The person may be a noisy, inconsistent, or suboptimal demonstrator across trajectories while still being the authoritative comparator between a displayed sample and the action they choose after seeing it.
3. **Rendered exposure is necessary.** An unrendered candidate cannot be treated as rejected. Only alternatives confirmed as visible before the human action may become preference losers.
4. **The actions must be comparable.** A task switch, timeout, deletion with a different scope, or action at a different boundary does not create a pair merely because it occurred later.
5. **Equivalent actions are ties.** Exact copies and semantically equivalent realizations supply positive behavioral data but no strict negative preference.
6. **Local comparison need not reveal causal credit.** A slate may contain several samples, and the later action may combine them. Phase 2 does not infer which token or sample caused which part of the action.
7. **The comparison is stronger than imitation but weaker than a global reward.** It orders bounded actions at a shared pre-display state. Extrapolation across states, time, or tasks requires evaluation and, eventually, additional outcome data.
8. **Proposal quality and proactivity are different decisions.** A good candidate can still be shown at a bad time. Silence, dismissal, or the absence of a following action is not by itself a clean label for either candidate quality or timing.

The crucial distinction is between a *generative context* and a *comparison context*. The human action was generated after seeing the proposal. Behavioral cloning must model that fact. The preference statement is different: given the original local decision, the person judges their final action better than the proposal they saw. IPO consumes that comparison; it does not claim that the human action was sampled from an unaided expert policy at the pre-display state.

## 3. One Interaction, Two Histories

For interaction $t$, define the exact pre-display history

$$
h_t^- = C_\phi(\{e_i:\operatorname{available\_at}(e_i)<\tau_t^{\mathrm{sample}}\}).
$$

This section conditions on the system having chosen to intervene. Section 4.4 defines that choice separately.

A proposal policy $\rho_d$ samples $K$ bounded actions

$$
Z_t^G=\{z_{t,1},\ldots,z_{t,K}\},
\qquad
z_{t,i}\sim\rho_d(\cdot\mid h_t^-,u).
$$

The interface renders a subset $Z_t^R\subseteq Z_t^G$. Each rendered candidate becomes an assistant-authored event with a confirmed availability time. The behavioral history before the later human action $y_t$ is simply the ordinary event stream at that later boundary:

$$
h_t^+
=
C_\phi(\{e_i:\operatorname{available\_at}(e_i)<\tau_t^{y}\}).
$$

Thus $h_t^+$ contains the rendered proposal events, any intervening reads or tool results, and anything else the person actually encountered. There is no special proposal variable in the underlying ontology and no fictional pre-display snapshot supplied to the behavioral model. The two prefixes are retained only because they answer different questions:

- $(h_t^+,y_t)$ asks: **what does this person do after experiencing this history?**
- $(h_t^-,y_t,z_{t,i})$ asks: **which action is better for the local decision that existed before display?**

The first pair trains the behavioral model. The second trains a proposer or reward model. The losses never compare log-probabilities evaluated under different histories.

## 4. Four Distinct Learning Objects

### 4.1 Behavioral policy

Let $\pi_d^B$ denote the canonical behavioral policy from Phase 1. It is continually trained on human actions under the histories that actually preceded them:

$$
\mathcal L_d^B
=
\lambda_{\mathrm{recent}}\mathcal L_{\mathrm{BC}}(\mathcal N_d)
+
\lambda_{\mathrm{replay}}\mathcal L_{\mathrm{BC}}(\mathcal R_d),
$$

where exposed examples use $h_t^+$ and unaided examples use their ordinary pre-action histories. Proposal tokens are context and are masked from target loss. Phase 1's temporal collection, daily evaluate-then-update loop, historical replay, and immutable data and model lineage remain unchanged.

This model estimates collaborative human behavior. It learns copying, refinement, synthesis, rejection, and task switching as different responses to different observed histories.

### 4.2 Proposal policy

Let $\rho_d$ denote the policy responsible for producing alternatives before display. It is initialized from a validated behavioral checkpoint or from the previous accepted proposer, then improved from local comparisons. It is not the same published artifact as $\pi_d^B$, even if both share a base model or are implemented as separate adapters on that base.

The proposer should become better at placing useful possibilities in front of the person. Its evaluation concerns pre-display proposal quality and joint-system outcomes, not fidelity to post-display human behavior.

### 4.3 Explicit reward model

Let $r_\varphi(h,a,u)$ denote an optional scalar action scorer. The same comparison pairs can train it with a Bradley–Terry loss:

$$
\boxed{
\mathcal L_{\mathrm{RM}}(\varphi)
=
-\mathbb E_{(h,y,z)}
\log\sigma\big(r_\varphi(h,y,u)-r_\varphi(h,z,u)\big)
}.
$$

This branch is appropriate when the intended product is a reusable reward for reranking, search, planning, or later policy-gradient training. It should be trained and evaluated separately from the proposer. A reward model can generalize comparisons to new actions, but that generalization is precisely where misspecification and out-of-distribution exploitation enter.

### 4.4 Proactivity and abstention policy

Let $\rho(a\mid h)$ answer **what should be proposed?** Let a separate gate

$$
g_\psi(h)=P_\psi(\text{SHOW}\mid h)
$$

answer **should anything be proposed now?** The gate may also choose among intervention modes or defer until a later decision point. Keeping it separate prevents a poor proposal from being misdiagnosed as bad timing and prevents an intrusive interface from being mistaken for a weak content model.

The first implementation should keep proactivity outside the generative model. A deterministic, versioned rule identifies safe eligible decision points; within those points, a logged randomization assigns some opportunities to `SHOW` and some to `ABSTAIN`. This produces an interpretable baseline and the counterfactual data needed to measure whether an intervention helped. Always showing only reveals outcomes under showing, while never showing reveals no proposal comparisons.

A learned gate is a later experiment. It can be implemented as a separate head or as an explicit `NO_PROPOSAL` action inside the model, but accepted and rejected proposals alone cannot train it correctly. Those observations lack the counterfactual outcome under silence, and an ignored proposal can mean bad content, bad timing, no current need, or simple distraction. Training requires propensity-logged intervention decisions plus downstream outcomes or explicit timing labels.

For an outcome measure $J$ and interruption cost $c(h)$, the relevant quantity is the incremental value

$$
A(h)
=
\mathbb E[J\mid \text{SHOW},h]
-
\mathbb E[J\mid \text{ABSTAIN},h]
-
c(h).
$$

The learned policy shows a proposal only when the estimated advantage is positive at the chosen operating threshold. Contextual-bandit, propensity-weighted, or doubly robust estimation can use randomized collection data; a direct supervised head is justified only when its labels encode the same incremental decision. The gate version, eligibility rule, offer probability, sampled decision, candidates if any, and outcomes are all immutable records.

## 5. Pair Construction

For each rendered candidate, define a pair weight

$$
w_{t,i}=e_{t,i}\,c_{t,i}\,b_{t,i}\,v_{t,i},
$$

where:

- $e_{t,i}=1$ only if the candidate was confirmed visible before the human action began;
- $c_{t,i}=1$ only if the candidate and human action address the same local decision;
- $b_{t,i}=1$ only if both can be serialized at a shared macro-action boundary;
- $v_{t,i}=1$ only if they are not exact or semantic equivalents.

When $w_{t,i}=1$, the labeled comparison is

$$
y_t \succ z_{t,i}\mid h_t^-.
$$

Every rendered, valid candidate may form a loser. Unrendered samples, overwritten drafts that were never visible, candidates displayed after action onset, and candidates from another task are excluded. If the person exactly copies a proposal, the action remains a positive BC target under $h_t^+$ but the pair is a tie and contributes no strict preference. If no comparable human write follows, the interaction may remain useful behavioral data without creating a preference pair.

Slate-level interfaces do not imply a ranking among model candidates. Phase 2 knows only that the final human action is preferred to each valid rendered candidate. Position, dwell time, selection, edits, and explicit reactions are stored for later analysis but do not silently become preference labels.

Length is a confound because sequence log-probability sums grow more negative with more tokens. The primary analysis should compare actions at matched boundaries and report both summed and length-normalized scores. Any normalization used for training must be fixed in the batch manifest and evaluated for a bias toward terse or verbose actions.

## 6. Identity Preference Optimization

For serialized action $a$, let

$$
\ell_\rho(a\mid h,u)
=
\sum_j \log\rho(a_j\mid h,u,a_{<j}).
$$

During preference update $d$, freeze the policy that generated the data as the reference $\rho_{d-1}$. Define the reference-relative score

$$
q_d(h,u,a)
=
\ell_{\rho_\theta}(a\mid h,u)
-
\ell_{\rho_{d-1}}(a\mid h,u),
$$

and the pair margin

$$
\Delta_{t,i}
=
q_d(h_t^-,u,y_t)-q_d(h_t^-,u,z_{t,i}).
$$

The weighted IPO objective is

$$
\boxed{
\mathcal L_{\mathrm{IPO}}^d(\theta)
=
\mathbb E_t
\left[
\frac{1}{\sum_i w_{t,i}}
\sum_i w_{t,i}
\left(
\Delta_{t,i}-\frac{1}{2\beta}
\right)^2
\right]
}.
$$

Interactions with no valid pairs are omitted from this loss. Both $y_t$ and $z_{t,i}$ are scored under the same pre-display history $h_t^-$. The human action's actual generation after exposure is represented by the preference label, not by mixing its behavioral likelihood into the IPO margin.

IPO is preferred to DPO for the initial direct-policy branch because the comparisons are numerous but locally noisy in magnitude. DPO uses

$$
\mathcal L_{\mathrm{DPO}}
=
-\mathbb E\log\sigma(\beta\Delta),
$$

which continually rewards larger separation on every labeled pair. IPO's finite target margin expresses a more conservative claim: the human continuation should be favored over the proposal by a controlled amount, not driven toward infinite relative odds. DPO remains an important ablation, particularly if empirical results show that the comparisons are clean and additional margin correlates with outcome quality.

The reference-relative score can be interpreted as an *implicit local reward* up to a state-dependent constant:

$$
r_d^{\mathrm{implicit}}(h,a)
\propto
\beta\left[
\log\rho_d(a\mid h)-\log\rho_{d-1}(a\mid h)
\right].
$$

This is useful for understanding or reranking the current policy. It is not automatically a stationary environment reward. It changes with the reference, is defined through one policy family, and is identified only by the collected comparisons. If later reinforcement learning requires a score that can be frozen, audited, and applied to actions from a different policy, the explicit reward-model branch is the cleaner object.

## 7. Separation, Versioning, and Continual Updates

The original combined form

$$
\lambda_{\mathrm{recent}}\mathcal L_{\mathrm{BC}}
+
\lambda_{\mathrm{replay}}\mathcal L_{\mathrm{BC}}
+
\lambda_{\mathrm{pref}}\mathcal L_{\mathrm{IPO}}
$$

is a valid ablation but not the canonical architecture. It asks one policy to imitate the person's exposed response and simultaneously behave as though it had produced that response before exposure. The two gradients may be mathematically evaluable, but they answer different product questions and make failures difficult to interpret.

The primary architecture keeps separate lineages:

$$
\pi_0^B,\pi_1^B,\ldots
\qquad\text{and}\qquad
\rho_0,\rho_1,\ldots,
$$

with an optional reward lineage $r_{\varphi_0},r_{\varphi_1},\ldots$ and proactivity lineage $g_{\psi_0},g_{\psi_1},\ldots$. A practical implementation can use one frozen base model with a BC adapter, an IPO adapter, a reward head, and a gate head, although the initial gate is an external versioned rule. Separate artifacts, optimizer states, data cutoffs, and publication gates are required even when deployment composes them.

Three coupling choices should be tested:

1. **Periodic rebase — recommended first.** At the start of a collection epoch, copy the accepted behavioral policy into $\rho_0$, freeze that reference, collect proposal interactions, train a new proposer with IPO, and evaluate it. A later epoch may rebase onto a newer behavioral checkpoint. This is simple and makes each comparison's reference exact.
2. **Independent proposer lineage.** Initialize once from Phase 1 and continue IPO updates. This preserves preference learning cleanly but may fail to absorb new personal knowledge learned by BC.
3. **Composable adapters.** Maintain a continually changing personal BC adapter and a distinct preference adapter. This may share knowledge efficiently but requires careful reference accounting whenever the underlying BC adapter changes.

Fresh preference pairs should be consumed against the exact proposer checkpoint that generated their candidates. Replaying an older pair under a new reference changes the objective. Safe options are to store and reload the collection-time reference, cache both reference log-probabilities with audit hashes, or distill old preferences into a separate reward model. The minimal IPO experiment consumes fresh pairs once within a versioned epoch; broader replay is an explicit extension.

Behavioral replay continues exactly as in Phase 1. Preference replay and reward replay are separate design decisions. A reward model may use stratified historical comparisons more naturally than rolling-reference IPO, but should still report recency, task, application, proposer version, and exposure-policy slices.

## 8. Minimal Records

The Phase 1 event store remains authoritative. Phase 2 adds immutable derived records:

```text
InterventionDecision {
  intervention_id
  decision_point_id
  pre_display_context_event_ids
  pre_display_context_hash
  eligibility_rule_version
  eligible
  eligibility_reason
  gate_version
  show_probability
  randomized
  decision: SHOW | ABSTAIN
  decision_reason
  decided_at
  outcome_ref?
}

ProposalGeneration {
  interaction_id
  intervention_id
  principal_id
  proposer_version
  pre_display_context_event_ids
  pre_display_context_hash
  sampling_config
  generated_candidates[]
  generated_at
}

CandidateExposure {
  interaction_id
  candidate_id
  rendered_at
  fully_rendered_at?
  position
  visible_token_span
  exposure_confirmed
}

PreferencePair {
  pair_id
  interaction_id
  pre_display_context_hash
  human_action_id
  candidate_id
  exposure_valid
  comparable
  boundary_valid
  equivalent
  weight
  proposer_reference_version
  reference_logprobs_ref?
  pair_builder_version
}

PreferenceBatchManifest {
  batch_id
  parent_proposer_version
  candidate_proposer_version
  pair_ids
  objective: IPO | DPO | REWARD_MODEL
  beta?
  length_normalization
  reference_artifact_hash?
  optimizer_config_hash
  evaluation_report_ref
}
```

The full generated slate is retained for audit, but only confirmed rendered candidates can become labeled losers. The exact behavioral context need not be duplicated: it is reconstructed from the event stream at the human action boundary.

## 9. Algorithms

### Algorithm 1: Collect one coactive interaction

```text
procedure COACTIVE_INTERACTION(gate, rho_deployed, live_stream, K):
    h_minus <- FREEZE(BUILD_CONTEXT(events available now))
    decision <- DECIDE_AND_LOG(gate, h_minus)
    SCHEDULE_OUTCOME_MEASUREMENT(decision, live_stream)

    if decision == ABSTAIN:
        return

    generated <- SAMPLE_BOUNDED_ACTIONS(rho_deployed, h_minus, K)
    rendered <- INTERFACE_RENDER(generated)

    record generation, all candidates, and exact render telemetry
    append confirmed rendered candidates to live_stream as assistant READ events

    y <- next finalized human macro-action, if any
    if y exists:
        h_plus <- BUILD_CONTEXT(events available before y began)
        emit BCExample(h_plus, y)

        for z in rendered:
            if EXPOSED_BEFORE(z, y)
               and COMPARABLE(z, y)
               and SAME_BOUNDARY(z, y)
               and not EQUIVALENT(z, y):
                emit PreferencePair(h_minus, winner=y, loser=z,
                                    reference=VERSION(rho_deployed))
```

### Algorithm 2: Update the separate proposer

```text
procedure UPDATE_PROPOSER(rho_reference, fresh_pairs, config):
    assert every pair.reference == VERSION(rho_reference)
    candidate <- CLONE(rho_reference)

    for batch in PACK_BY_TOTAL_ACTION_TOKENS(fresh_pairs):
        delta <- relative logprob margin of winner over loser
                 under candidate versus rho_reference
        loss <- weighted mean((delta - 1/(2 * beta))^2)
        candidate <- OPTIMIZER_STEP(candidate, gradient(loss))

    report <- EVALUATE_PAIR_GENERALIZATION_PROPOSALS_AND_CAPABILITIES(
        candidate, rho_reference, heldout_pairs, blinded_tasks
    )

    if PASSES_PROPOSER_GATES(report):
        return PUBLISH_IMMUTABLE(candidate)
    return rho_reference
```

The behavioral updater from [[Phase 1#Algorithm 3: Update overnight]] runs independently on the newly created BC examples.

## 10. IPO, Reward Modeling, and Adversarial IRL

These methods solve related but different problems. The choice should follow the object the project needs next.

| Method | Supervision and machinery | Learned object | Best fit here | Principal limitation |
|---|---|---|---|---|
| BC | human action under actual history | behavioral policy | continual model of the collaborator | imitates noisy behavior |
| IPO or DPO | same-state action comparisons plus reference policy | improved proposal policy | direct improvement without an environment | implicit score is policy- and reference-relative |
| pairwise reward model | same comparisons | reusable scalar action scorer | reranking and later RL | exploitable OOD generalization |
| GAIL | expert trajectories and learner rollouts | policy via occupancy matching | imitation in an executable environment | tends to reproduce demonstrator occupancy |
| AIRL | transitions, expert trajectories, policy rollouts, adversarial discriminator | decomposed reward and policy | sequential reward recovery under changing dynamics | stronger environment and expert-rationality assumptions |
| D-REX-style ranking | ordered trajectories, often generated by degraded policies | reward from relative trajectory quality | surpassing a noisy demonstrator when rankings exist | requires meaningful trajectory construction and ranking |

### 10.1 Why IPO is the first direct-policy method

The available primitive is a comparison between bounded textual or computer actions at one exact pre-display history. There is no need to execute long policy rollouts, learn occupancy measures, or identify transition dynamics. IPO consumes precisely this primitive, preserves a KL-like relationship to a known proposer checkpoint, and can be evaluated by whether the next proposals improve. It is therefore the lowest-assumption route from coactive comparisons to a better proposal policy.

The human's global suboptimality does not invalidate the label because the Phase 2 assumption is comparative, not demonstrative: after seeing $z$, the person chooses $y$ and $y\succ z$ for that local decision. The method never assumes that the whole human trajectory is optimal.

### 10.2 Why not classic GAIL or AIRL yet

Generative Adversarial Imitation Learning matches the learner's occupancy measure to expert demonstrations and directly extracts a policy [8]. With a noisy human demonstrator, successful occupancy matching can faithfully reproduce the very limitations the system is meant to improve upon. It also requires an environment in which the learner can generate meaningful rollouts.

Adversarial Inverse Reinforcement Learning introduces a structured discriminator to recover a reward that can remain useful when dynamics change [9]. In its standard formulation, the discriminator uses state–action–next-state transitions from expert data and learner rollouts, and the theoretical reward-recovery story relies on stronger assumptions about expert behavior and environment dynamics than Phase 2 can defend. A temporally interleaved computer-use stream contains transitions, but it does not yet provide a safe simulator in which arbitrary learner policies can act or a reason to treat noisy human trajectories as approximately optimal.

The coactive comparisons are actually *more informative for the local question* than an unlabeled noisy demonstration: they explicitly say that one action should outrank an on-policy alternative. D-REX supports this direction by showing how ranked behavior can learn a reward that exceeds the quality of suboptimal demonstrations [10]. Here the rankings arise naturally from human refinements rather than from synthetic corruption levels.

AIRL becomes appropriate later if the project has: a validated sequential state and action representation; a world model or sandbox supporting policy rollouts; trajectory-level evidence; a need for a dynamics-robust reward; and diagnostics showing that local action comparisons do not compose over the horizon. That boundary is developed in [[Phase 3]].

### 10.3 When the reward-model branch is preferable

If the immediate goal is to improve the next proposal, IPO avoids fitting a separately exploitable reward. If the goal is eventual policy-gradient RL, search over novel actions, or planning across policies, a discriminator-style pairwise reward model is more direct. It converts the same labels into a frozen object whose calibration, transfer, and failure modes can be studied before any optimizer is allowed to exploit it.

The IPO policy ratio is not a substitute for this branch merely because it can be written as an implicit reward. Using model log-probabilities of the human action versus a top sample measures current-policy surprise, not human superiority. The preference label supplies the direction; the reference-relative objective determines how the proposer changes. A reusable reward must be learned from labeled comparisons or outcomes, not inferred from which string the model already assigns more probability.

## 11. Evaluation and Branched Decisions

### 11.1 Pair validity

Audit exposure telemetry, task comparability, boundary agreement, equivalence detection, and time from display to action. Independently label a sample of interactions. Report the fraction of generated candidates that become rendered candidates, valid comparisons, ties, incomparable actions, and missing responses. The preference thesis fails operationally if too few ordinary interactions yield defensible pairs.

### 11.2 Proposer evaluation

Compare the IPO proposer against its exact reference, the current BC policy, a DPO proposer, a BC-only proposer, and generic/static baselines. Metrics include held-out preference accuracy, margin calibration, proposal diversity, novelty, content-sensitive quality, copy/refinement rate, user interruption, and blinded judgment of local usefulness. The decisive test remains randomized joint-system outcomes: time, quality, error, rework, and goal satisfaction.

Because training preferences all favor the human action, held-out evaluation should include independently judged model-versus-model comparisons and delayed outcome labels. Otherwise a proposer can appear successful merely by becoming more human-like.

### 11.3 Proactivity evaluation

Evaluate proposal content under a fixed gate and evaluate the gate under a fixed proposer. Compare `ALWAYS_SHOW`, `NEVER_SHOW`, the deterministic eligibility rule, and each learned gate using randomized or propensity-corrected opportunities. Report intervention rate, helpful-intervention rate, interruption cost, dismissal or ignore rate, time to next useful action, downstream quality and rework, and calibration of estimated incremental value by application and task state.

The decisive question is not whether people often accept suggestions. It is whether showing a proposal at states selected by the gate improves outcomes relative to abstaining at comparable states. A gate that appears selective only because it avoids difficult contexts has not established proactivity.

### 11.4 Reward-model evaluation

Evaluate pairwise accuracy and calibration on later proposer versions, applications, and projects; robustness to length, style, and action-boundary perturbations; cyclic or inconsistent comparisons; and adversarially searched high-reward actions. Before RL, test whether reward differences correlate with blinded outcomes and whether optimization moves samples out of the reward model's training support.

### 11.5 Decision branches

- If Phase 1 BC improves the joint system and valid pairs are sparse, remain in Phase 1.
- If valid comparisons are plentiful and direct IPO improves proposals and outcomes, publish a separate proposer lineage.
- If IPO improves pair margins but not outcomes, revisit interface timing, pair validity, and the local-superiority assumption before increasing optimization pressure.
- If proposal content is useful under a fixed gate but interventions remain disruptive, improve the external eligibility rule and collect randomized `SHOW`/`ABSTAIN` outcomes before training proactivity inside the model.
- If a learned gate improves randomized joint-system outcomes at an acceptable intervention rate, publish it as a separate versioned policy rather than treating abstention as an incidental decoding behavior.
- If the reward model transfers across proposer versions and correlates with outcomes, carry it forward as a candidate scoring component—not yet an additive trajectory return.
- If sequential failures dominate and local comparisons do not compose, proceed to the model-based and trajectory-level experiments in Phase 3.
- If exposure causes anchoring, narrowing, manipulation, or worse outcomes, halt preference collection and roll back even if predictive or pairwise metrics improve.

## 12. Related Work

Coactive learning formalizes settings in which a user supplies a slightly improved solution rather than an optimal label [1]. Recent work applies the idea to language-model assistance and implicit edits [2]. Phase 2 adopts the interaction pattern but makes the post-proposal local-superiority assumption explicit and retains exposure provenance.

DPO shows that a KL-regularized reward-modeling objective can be expressed as a direct policy loss on preferences [3]. The general $\Psi$PO analysis identifies IPO as the identity-transform instance and motivates its finite squared-margin target [4]. Online IPO studies iterative preference collection and optimization [5]. Work on reference policies clarifies that the chosen reference materially determines direct preference optimization [6], which is why collection-time versioning is part of the data model.

GAIL learns policies by adversarial occupancy matching [8]. AIRL modifies the discriminator to recover rewards intended to transfer across dynamics [9]. D-REX learns from ranked, suboptimal demonstrations and provides a closer precedent for improving beyond a noisy demonstrator [10]. These methods become more relevant as the project moves from local text-action comparisons to executable trajectories.

Personalized RLHF shows that aggregated preferences can hide heterogeneous user rewards [11]. Here every model, pair, and reward artifact remains principal-specific unless an explicit hierarchical model is tested. Work on induced preference shifts and targeted manipulation warns that an optimizing system may change the feedback process that trains it [12, 13]. Randomized exposure, outcome gates, user authority, and rollback therefore remain part of the learning method rather than downstream product polish.

## 13. Handoff to Phase 3

Phase 2 can produce four assets: a continual behavioral model of the person inside the shared stream, a proposal policy improved by local comparisons, an intervention policy that learns when to abstain, and an optional action-level reward model. None is yet a long-horizon agent.

Phase 3 may use the behavioral model to predict human responses, the proposer as an action prior, and the reward model for same-state pruning or shaping. It must not simply sum Phase 2's local score across imagined steps and call the result the person's objective. Longer horizons introduce state transitions, delayed consequences, strategic information gathering, reward identifiability, and the possibility that the system changes the person whose preferences it models. Those questions require trajectory-level evidence, world modeling, guarded execution, and explicit preservation of human authority.

## References

[1] P. Shivaswamy and T. Joachims. [*Online Structured Prediction via Coactive Learning*](https://arxiv.org/abs/1205.4213). 2012.

[2] M. Tucker et al. [*Coactive Learning for Large Language Models*](https://proceedings.mlr.press/v235/tucker24a.html). 2024.

[3] R. Rafailov et al. [*Direct Preference Optimization: Your Language Model is Secretly a Reward Model*](https://arxiv.org/abs/2305.18290). 2023.

[4] M. G. Azar et al. [*A General Theoretical Paradigm to Understand Learning from Human Preferences*](https://arxiv.org/abs/2310.12036). 2023.

[5] D. Calandriello et al. [*Human Alignment of Large Language Models through Online Preference Optimisation*](https://arxiv.org/abs/2403.08635). 2024.

[6] A. Liu et al. [*Understanding Reference Policies in Direct Preference Optimization*](https://arxiv.org/abs/2407.13709). 2024.

[7] M. Carroll et al. [*On the Utility of Learning about Humans for Human-AI Coordination*](https://arxiv.org/abs/1910.05789). 2019.

[8] J. Ho and S. Ermon. [*Generative Adversarial Imitation Learning*](https://arxiv.org/abs/1606.03476). 2016.

[9] J. Fu, K. Luo, and S. Levine. [*Learning Robust Rewards with Adversarial Inverse Reinforcement Learning*](https://arxiv.org/abs/1710.11248). 2017.

[10] D. S. Brown, W. Goo, and S. Niekum. [*Better-than-Demonstrator Imitation Learning via Automatically-Ranked Demonstrations*](https://arxiv.org/abs/1907.03976). 2019.

[11] A. Chakraborty et al. [*MaxMin-RLHF: Alignment with Diverse Human Preferences*](https://arxiv.org/abs/2402.05133). 2024.

[12] M. Carroll, D. Hadfield-Menell, S. Russell, and A. D. Dragan. [*Estimating and Penalizing Induced Preference Shifts in Recommender Systems*](https://arxiv.org/abs/2204.11966). 2022.

[13] M. Williams et al. [*On Targeted Manipulation and Deception when Optimizing LLMs for User Feedback*](https://arxiv.org/abs/2411.02306). 2024.
