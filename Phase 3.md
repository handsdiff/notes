# Phase 3 Direction: Model-Based Assistance over Increasing Horizons - WIP

**Status:** Directional extension to [[Phase 1]] and [[Phase 2]]. This note isolates multi-step planning, simulation, reward learning, and guarded execution ideas that are outside the local next-action program.

#### Unstructured Notes - to be incorporated
- https://coasty.ai/

## Abstract

Phase 3 extends the one-step proposal-and-refinement loop into bounded model-based assistance. Its objective is to improve the outcome of the human–model system relative to unaided work and shorter-horizon assistance, not to replace the person with a policy that acts unilaterally. At a decision point, the system simulates several short action trajectories, shows their predicted results and uncertainty, and lets the person select, edit, reject, or ask for clarification. A selected plan authorizes guarded execution in the real computer environment. The resulting transitions, interventions, comparisons, and outcomes supervise later dynamics, reward, and planning updates.

This direction becomes justified only if the earlier phases establish their narrower claims. Phase 1 must produce a faithful event stream, a useful behavioral model, and a safe continual update loop. Phase 2 must show that local comparisons improve proposals or yield a reward model that transfers beyond its collection policy. Phase 3 begins when the main remaining failures are sequential: good local actions do not compose, consequences are delayed, information-gathering actions matter, or planning requires counterfactual state transitions.

## 1. Relationship to Assistance Games

The intended interaction is structurally an assistance game. Human and assistant actions alter a shared environment; the assistant is uncertain about the person's objective; human actions and corrections provide information; and useful assistant actions may either advance the task or reduce uncertainty. Cooperative inverse reinforcement learning formalizes this structure as a partial-information game with a shared reward known to the human but initially hidden from the assistant [3]. AssistanceZero demonstrates a scalable instance in which a planner predicts human actions and beliefs over reward parameters while assisting in a complex Minecraft environment [4].

The proposed system should be described as **assistance-game-inspired**, not as a literal instantiation of either framework. Here the person may know what they want without being able to state it as a reward parameter or machine-verifiable payoff. Their behavior can be suboptimal, goals can vary across tasks, the action space is open-ended, and Phase 2 supplies local comparisons rather than an observed shared return. Phase 3 must therefore maintain uncertainty, measure actual outcomes, and preserve human authority rather than claiming the optimality or incentive guarantees of a classical assistance game.

The system remains collaborative even if planning becomes powerful. A human response is evidence about both the task and the assistance process. The assistant can ask, show alternatives, predict consequences, or execute a reversible subplan; the person retains the authority to redefine the goal, reject the model's framing, withhold permission, or stop the loop.

## 2. Separation of Model Roles

The following roles should remain conceptually and operationally distinct even if an implementation shares encoders or base weights:

1. **Behavioral human-response model.** The Phase 1 lineage $\pi_d^B$ predicts the person's next action from the history they actually experienced. In Phase 3 it can model likely responses at plan checkpoints, but planner gradients must not silently redefine the behavioral estimator. A versioned response-specific copy $H_\omega$ may be safer.
2. **Personalized action prior.** The Phase 2 proposer $\rho_d$ generates actions near the person's learned behavioral and coactive distribution. It supplies search priors and candidate representations; it is not a world model or a complete objective.
3. **Local action reward.** An explicit Phase 2 scorer $r_\varphi(h,a,u)$, if validated, can rerank actions at the same state or initialize shaping. The IPO policy ratio provides a related implicit score. Neither is assumed to be an additive trajectory return.
4. **World-dynamics model.** An action-conditioned model $\widehat T_\phi$ predicts computer, artifact, and external transitions. It models application state separately from the person's response whenever the data supports that factorization.
5. **Trajectory planner.** A policy or search procedure $q_\psi$ proposes joint futures from the action prior, response model, dynamics model, tool constraints, reward or value estimates, and sandbox.
6. **Trajectory scorer.** A model $V_\xi$ learns from displayed-plan selections, edits, execution interventions, delayed outcomes, and trajectory comparisons. It is the candidate long-horizon value object—not the Phase 2 local score relabeled.
7. **Execution governor.** A non-learned or separately audited layer enforces typed permissions, reversibility, checkpoints, rate limits, sandbox requirements, and rollback. A high planner score never substitutes for authority to act.

This separation follows the useful distinction between learning a model of human behavior and training an agent to collaborate with it [1]. It also makes failures attributable: a bad plan may arise from dynamics error, human-response error, value error, search error, or an unsafe execution layer rather than from one undifferentiated model.

## 3. World-Dynamics Learning and Sandbox Grounding

Let $x_t$ denote a structured observation of the computer environment and let $a_t^H$, $a_t^A$, and $e_t$ denote human actions, assistant actions, and observed exogenous events. The initial high-confidence dynamics objective is action-conditioned next-state likelihood:

$$
\mathcal L_{\mathrm{dyn}}(\phi)
=
-\mathbb E_{\mathcal D_{\mathrm{dyn}}}
\left[
\sum_t
\log \widehat T_\phi
\left(
x_{t+1}\mid x_{\leq t},a_t^H,a_t^A,e_t
\right)
\right].
$$

The observation loss may combine structured-state prediction, latent consistency, reconstruction, or perceptual terms depending on the application. Dreamer 4 provides a relevant precedent for learning a fast action-conditioned world model from offline video and action data, then training behavior through simulated experience inside that model [5]. The analogy is architectural rather than complete: Dreamer 4 has a single controlling agent and an environment reward, whereas this project has an assistant uncertain about a human-known objective and accountable to that human.

The earlier event stream contains many observed transitions, but only under historical human and deployed-assistant policies. Before/after state snapshots, joint action attribution, exogenous events, and environment-instance identifiers must remain reconstructable. Passive traces do not identify the result of arbitrary untried actions. A computer-use sandbox supplies safer counterfactual coverage and grounds imagined rollouts against actual application behavior.

The initial simulator should be hybrid. Structured APIs, document diffs, accessibility trees, DOM state, files, and application snapshots are preferred to pixel-only prediction when available. The learned model performs cheap broad search; promising branches are re-executed in isolated sandbox clones; only selected and authorized plans cross into production. A sandbox can test many local computer transitions but cannot simulate a person's future response, another person's reaction, or an irreversible external side effect. Such boundaries require uncertainty, abstention, or a real-world approval checkpoint.

## 4. Trajectory Proposals and Human Feedback

At horizon $H$, let a displayed trajectory bundle contain assistant actions, modeled human checkpoints, simulated states, and a predicted result:

$$
\tau_i^{(H)}
=
\left(
a_{i,1:H}^A,
\widehat a_{i,1:H}^H,
\widehat x_{i,1:H}
\right).
$$

Null human actions are allowed when a plan is intended to execute without intermediate interaction. The system generates several diverse bundles, validates promising ones in the sandbox where possible, and displays the exact actions, predicted result, uncertainty, simulator version, and approval boundaries. The person can select one, edit it, reject all, or request clarification. The exact displayed bundle is part of the feedback record: selecting an attractive forecast is not evidence that the person would prefer an incorrectly simulated real outcome.

A selection creates a trajectory-level comparison $\tau^+\succ\tau_i^-$ among the bundles actually displayed. It does not automatically create a winner label for every individual step. A proposal may be valuable because of its combined outcome even if one isolated step appears unnecessary, and an execution intervention may localize a failure to only one prefix. Edits, aborts, rollback requests, simulator disagreements, and observed final outcomes remain distinct feedback types rather than collapsing into one binary label.

The data record must distinguish at least:

- planned versus sandbox-verified versus actually executed actions;
- predicted, simulated, and observed states;
- displayed forecasts and uncertainty from later revised estimates;
- selection, edit, rejection, clarification, intervention, abort, and outcome feedback;
- the person or system that authorized each external side effect.

## 5. Local Rewards Do Not Automatically Compose

The high-confidence requirement is to learn from complete displayed trajectories rather than sum the Phase 2 action score as though it were already a return. The person's broader objective exists, but Phase 2 only identifies same-state local comparisons. Different rollouts visit different contexts, so arbitrary state terms in policy-ratio rewards do not cancel across paths. The scores are also calibrated near collected one-step alternatives rather than under planner-induced trajectory distributions.

The Phase 2 proposer and reward model may guide same-state pruning, proposal initialization, uncertainty-aware heuristics, or short-horizon shaping. But the following quantity is not, without new evidence, the Phase 3 objective:

$$
\sum_{k=1}^{H}
r_\varphi(h_k,a_k,u).
$$

This is the point at which classic inverse reinforcement learning becomes a live option. If the sandbox supplies transitions and learner rollouts, trajectory evidence is adequate, and reward transfer across dynamics matters, AIRL's structured adversarial discriminator can be compared with direct trajectory preference learning [7]. GAIL remains an occupancy-matching baseline [8]. Neither should inherit an “expert” label merely because the trajectories came from the person: the human is a noisy demonstrator, and Phase 2's reliable local comparisons should be preserved as additional supervision rather than discarded.

Possible reward-learning branches include:

1. **Trajectory preference model:** learn a scalar from displayed-plan or segment comparisons and explicit outcomes.
2. **Trajectory IPO:** directly improve a normalized planner policy from comparisons when planner log-probabilities are meaningful.
3. **AIRL-style reward recovery:** use expert and learner transitions plus rollouts when dynamics transfer and sequential reward identification are central.
4. **Outcome model:** predict task-specific completion, quality, error, time, or human judgment without claiming a universal reward.

The initial program should compare these objects rather than combine them prematurely.

## 6. Directional Trajectory Objectives

If the planner defines a tractable probability over serialized trajectory bundles, selected and unselected plans can extend the rolling-reference IPO construction [2]. Define

$$
\Delta_\psi^\tau
=
\log\frac{q_\psi(\tau^+\mid x,u)}{q_{\mathrm{ref}}(\tau^+\mid x,u)}
-
\log\frac{q_\psi(\tau^-\mid x,u)}{q_{\mathrm{ref}}(\tau^-\mid x,u)},
$$

and optimize

$$
\mathcal L_{\mathrm{traj\text{-}IPO}}(\psi)
=
\mathbb E
\left[
\left(
\Delta_\psi^\tau-\frac{1}{2\beta_H}
\right)^2
\right],
$$

where the reference and $\beta_H$ are versioned by horizon.

If planning relies on search rather than a normalized trajectory policy, a separate scorer can use a pairwise objective following the trajectory-segment preference-learning precedent of Christiano et al. [6]:

$$
\mathcal L_V(\xi)
=
-\mathbb E
\left[
\log\sigma\left(
V_\xi(x,u,\tau^+)-V_\xi(x,u,\tau^-)
\right)
\right].
$$

An AIRL branch would instead learn a structured discriminator from transitions and alternating planner rollouts. It is attractive if the inferred reward transfers across environment dynamics; it is less attractive if human response, partial observability, or preference shifts dominate the transition signal. The comparison must include reward transfer, optimization robustness, and actual assistance outcomes—not merely discriminator accuracy.

These are alternative starting estimators, not requirements to optimize every loss. Direct trajectory IPO is natural when planner log-probabilities are meaningful; a separate scorer is natural for reranking heterogeneous search outputs and incorporating outcomes; AIRL is natural when an executable environment and dynamics-robust reward are central. None solves causal assistance evaluation by itself. Randomized no-plan or alternative-slate holdouts and downstream outcome measurements remain necessary.

## 7. Horizon Curriculum and Bounded Execution

Phase 3 begins at the already observed one-step boundary and expands to $H=2,3,\ldots$ only after passing horizon-specific gates. At minimum, those gates measure:

- dynamics calibration and uncertainty over the full rollout;
- agreement between learned-model predictions and sandbox transitions;
- agreement between sandbox predictions and authorized production outcomes;
- plan selection, editing, rejection, intervention, abort, and rollback rates;
- reward-model transfer under planner-induced actions;
- downstream assistance quality relative to no-plan and shorter-horizon controls;
- safety, reversibility, tool permission, and support-coverage checks.

The intended loop is:

```text
procedure RUN_PHASE3_ASSISTANCE_CYCLE(
    current_state x, horizon H,
    behavioral_model pi_B, action_prior rho,
    response_model H_omega, dynamics T_phi,
    planner q_psi, trajectory_scorer V_xi, sandbox
):
    imagined <- PLAN_DIVERSE_TRAJECTORIES(
        x,
        horizon=H,
        prior=rho,
        response_model=H_omega,
        dynamics=T_phi,
        scorer=V_xi
    )

    verified <- SANDBOX_VALIDATE_PROMISING_BRANCHES(imagined, sandbox)
    displayed <- SHOW_ACTIONS_RESULTS_UNCERTAINTY_AND_BOUNDARIES(verified)
    response <- WAIT_FOR_SELECT_EDIT_REJECT_OR_CLARIFY(displayed)
    STORE_EXACT_DISPLAY_AND_RESPONSE(displayed, response)

    if response selects or edits a plan:
        plan <- APPLY_USER_EDITS_AND_REVALIDATE(response.plan, sandbox)
        trace <- GUARDED_EXECUTE_WITH_CHECKPOINTS(plan)
        STORE_PREDICTED_AND_ACTUAL_TRANSITIONS(trace)

    BUILD_WHOLE_TRAJECTORY_FEEDBACK(displayed, response, trace?)
    ASYNCHRONOUSLY_UPDATE_SEPARATE_MODELS()

    if PASSES_HORIZON_EXPANSION_GATES(H):
        authorize experiments at horizon H + 1
```

This pseudocode fixes information and authority flow, not the final planning optimizer. Search may later use sampling, beam search, Monte Carlo tree search, model-predictive control, actor–critic learning in imagination, or hybrids. The choice depends on simulator fidelity, action branching, reward identifiability, and compute. Regardless of optimizer, learned-model rollouts do not authorize real side effects: sandbox validation, user selection, typed permissions, checkpoints, and rollback remain separate execution requirements.

## 8. Experimental Sequence

1. Reconstruct short action-conditioned transitions from Phase 1 and Phase 2 data.
2. Choose one reversible application with a structured state and deterministic sandbox.
3. Establish one-step and two-step dynamics calibration against sandbox truth.
4. Display predicted outcomes without execution and audit whether uncertainty is legible.
5. Collect whole-plan selections, edits, rejections, and later outcome judgments.
6. Compare trajectory preference scoring, trajectory IPO, task-specific outcome models, and—when rollouts are available—AIRL.
7. Execute selected two-step plans with checkpoints and immediate rollback.
8. Expand horizon only when dynamics, reward transfer, assistance outcomes, and intervention rates pass predeclared gates.
9. Add irreversible or socially consequential actions only under a separately reviewed authority model, if at all.

Phase 3 succeeds only if longer-horizon assistance improves real outcomes beyond the strongest shorter-horizon system while retaining calibration, user control, reversibility, and recovery from model error. A planner that wins its own simulated reward but makes the joint system worse has failed.

## References

[1] M. Carroll et al. [*On the Utility of Learning about Humans for Human-AI Coordination*](https://arxiv.org/abs/1910.05789). 2019.

[2] M. G. Azar et al. [*A General Theoretical Paradigm to Understand Learning from Human Preferences*](https://arxiv.org/abs/2310.12036). 2023.

[3] D. Hadfield-Menell, A. Dragan, P. Abbeel, and S. Russell. [*Cooperative Inverse Reinforcement Learning*](https://arxiv.org/abs/1606.03137). 2016.

[4] C. Laidlaw et al. [*AssistanceZero: Scalably Solving Assistance Games*](https://arxiv.org/abs/2504.07091). 2025.

[5] D. Hafner, W. Yan, and T. Lillicrap. [*Training Agents Inside of Scalable World Models*](https://arxiv.org/abs/2509.24527). 2025.

[6] P. F. Christiano et al. [*Deep Reinforcement Learning from Human Preferences*](https://arxiv.org/abs/1706.03741). 2017.

[7] J. Fu, K. Luo, and S. Levine. [*Learning Robust Rewards with Adversarial Inverse Reinforcement Learning*](https://arxiv.org/abs/1710.11248). 2017.

[8] J. Ho and S. Ermon. [*Generative Adversarial Imitation Learning*](https://arxiv.org/abs/1606.03476). 2016.
