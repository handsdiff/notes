# Continual Next-Action Learning from Personal Human–Model Event Streams

*A focused method for personalized prediction and closed-loop human–model assistance*

**Status:** Working paper proposal. This document contains no experimental results. The executable bootstrap experiment is specified in [[Phase 1 Details]].

## Abstract

A person's computer activity forms a temporally ordered stream of information and action. Documents, webpages, messages, tool results, and model outputs become available; the person then writes, edits, searches, prompts, and sends. This paper studies personalized prediction of each bounded human write action from the events available before it. Eligible human writes supply targets, while previously observed events—including rendered model outputs—supply context.

The model is bootstrapped from historical activity and then deployed inside the stream it learns from. Rendered predictions are recorded as assistant-authored read events, so later human actions are conditioned on the information the person actually encountered. The canonical model is updated continually from recent examples mixed with stratified historical replay and is published only after chronological prediction, retention, and capability checks.

The human–model system is the object of evaluation. The central hypothesis is that continually personalized predictions help a person achieve acceptable outcomes faster or better than unaided work or static assistance. Good next-action prediction may benefit from representing the person's local objectives, although likelihood training alone cannot identify a unique goal or reward. Predictive accuracy and system benefit are therefore measured separately: held-out actions test the model, while controlled outcome comparisons test the assistance.

## 1. Vision and Claims

Modern models possess broad knowledge but little grounding in the local state of one person's work. Explicit prompts expose only part of that state. Ordinary computer use supplies a denser record: what the person encountered, what they produced, how their work changed, and which model outputs became part of their thinking.

The project studies the joint system

$$
\mathcal S_u
=
(\text{person},\text{model},\text{shared event stream},\text{continual update loop}).
$$

The model supplies timely possible actions; the person contributes private context, judgment, correction, synthesis, and authority; the shared stream preserves their interaction; and continual adaptation updates the model as the person's work evolves. The project tests whether this joint system improves task outcomes relative to the same person working unaided or with a static assistant.

The research claims form a ladder:

1. Ordinary activity can be reconstructed as a faithful chronological event stream.
2. Prior events contain signal about the person's next bounded write action.
3. Personal history, memory, or weight adaptation improves extraction of that signal.
4. Continual adaptation preserves useful older behavior while tracking genuine change.
5. Model outputs inserted into the stream can scaffold different or better human actions.
6. The continually personalized human–model system improves task outcomes relative to unaided work and static assistance.

Claims 1–4 concern data and prediction. Claims 5–6 concern the deployed system and require intervention-aware outcome evaluation. A failure at one step should not be hidden by adding machinery at a later step.

### 1.1 Implied local objectives

Let $g_t$ denote the person's active local objective. It may be explicit in the stream or latent to the model. Conceptually, human behavior can be written as $H_u(y\mid h,g)$, while a predictor without a separate goal label estimates

$$
p_u(y\mid h)
=
\int H_u(y\mid h,g)\,p_u(g\mid h)\,dg.
$$

Accurate prediction in novel or ambiguous situations may reward an internal representation of $p_u(g\mid h)$. It does not require that the representation be unique, human-readable, stable across tasks, or equivalent to a reward function. A model may also predict well from repetition, style, or shallow workflow regularities.

Objective understanding is therefore a diagnostic hypothesis rather than an assumption of the loss. It can be tested by comparing raw history with explicit objective induction, by evaluating contexts with similar surface form but different goals, and by measuring generalization to new actions within a familiar objective. Prediction remains anchored to held-out human actions; system benefit remains anchored to outcomes.

## 2. Interleaved Event Stream

For principal $u$, let

$$
\mathcal E_u=(e_1,e_2,\ldots,e_T)
$$

be a stable temporal ordering of events from all relevant actors:

$$
\operatorname{actor}(e)
\in
\{\text{human},\text{assistant},\text{external},\text{system}\}.
$$

Events include visible document spans, received messages, browser navigation, searches, model outputs, tool results, application state changes, and human edits. Their role is determined by the prediction boundary:

- Events available before a target action are context.
- A finalized human-authored write macro-action may become a target.
- Events that were generated but never rendered are not part of the person's observed history.

For a human action $y_t$ beginning at time $t$, construct

$$
h_t=C_\phi(\{e_i:\operatorname{available\_at}(e_i)<t\}),
$$

where $C_\phi$ is a versioned context builder that orders, selects, truncates, retrieves, or compresses events to a token budget. The exact context supplied to a reported model call is content-addressed for audit.

Rendered model outputs are assistant-authored events in $\mathcal E_u$. Their availability times place them in the history of every later action, just as received messages or visible tool results are placed in that history. The earlier prefix of the ordered stream records what was available when each assistant event was generated, and generation provenance links the event to its exact model call.

### 2.1 Macro-actions

Raw keystrokes are too granular and commits are often too coarse. A human write target is a bounded macro-action

$$
y_t=(d_t,\ell_t,o_t,c_t),
$$

where $d_t$ is the application or domain, $\ell_t$ is the object location, $o_t$ is the operation, and $c_t$ is its content. Examples include adding one bullet, replacing a coherent span, submitting a search, or sending one message.

Macro-actions are segmented using observable commit boundaries such as submit or save events, focus changes, coherent edit completion, and idle-time debounce. Every target retains provenance. Copied text, model-authored text, automatic edits, and independently authored text must not be conflated.

### 2.2 Temporal fidelity

The core data constraint is availability, not eventual presence in an export. A completed assistant response cannot be placed before tokens rendered. A full webpage cannot be attached when only a small viewport was visible. A later note version cannot become context for an earlier edit. When availability is ambiguous, the event is marked uncertain or excluded rather than silently moved backward in time.

## 3. Next-Action Objective

For serialized target tokens $y_t=(y_{t,1},\ldots,y_{t,L_t})$, define

$$
\ell_\theta(y_t\mid h_t,u)
=
\sum_{j=1}^{L_t}
\log\pi_\theta(y_{t,j}\mid h_t,u,y_{t,<j}).
$$

The learning objective is

$$
\boxed{
\mathcal L_{\mathrm{BC}}(\theta)
=
-\mathbb E_{(u,h_t,y_t)}
\left[\ell_\theta(y_t\mid h_t,u)\right]
}.
$$

Loss is masked on every context token and applied only to the human target. Assistant outputs, received messages, and earlier human actions supply context but are not copied as targets by virtue of appearing in the input.

Every training example has the form $(u,h_t,y_t)$. Bootstrap examples are constructed from historical activity. During closed-loop deployment, some histories also contain rendered outputs from the deployed model as preceding assistant events. In both settings, the target is the person's subsequent bounded write action and the likelihood is defined exactly as above.

The objective estimates behavior. It does not assert that the observed action is optimal, recover a counterfactual unaided action, identify which preceding event caused which target span, or optimize a global reward.

## 4. Bootstrap and Closed-Loop Deployment

Training begins with a historical bootstrap and continues during closed-loop deployment.

### 4.1 Bootstrap

Historical human activity supplies chronological next-action examples. The initial personalized canonical policy $\pi_0$ is trained or configured using in-context history, retrieval, memory, supervised fine-tuning, or a measured combination. [[Phase 1 Details]] specifies the gated experiment that tests collection fidelity, predictive signal, personalization mechanisms, objective-representation diagnostics, and local scaling behavior before live deployment.

### 4.2 Closed-loop continual deployment

At an appropriate action opportunity, the current canonical policy samples possible next human actions:

$$
z_{t,1:K}\sim\pi_d(\cdot\mid h_t,u).
$$

The interface may render some of these outputs. Every rendered output is appended to the ordinary event stream with assistant provenance and the time it became available. The person continues working. Their next finalized write is later converted into the same kind of BC example using all events available before it.

The loop is:

1. build the current history from the shared stream;
2. sample and optionally render possible next actions;
3. append rendered outputs as assistant-authored events;
4. observe subsequent ordinary human activity;
5. construct new next-action examples at human write boundaries;
6. update the canonical model from recent examples plus replay;
7. publish only if prediction, retention, capability, and safety gates pass.

Both periods use the event-to-example construction in Section 2 and the objective in Section 3. Exact copying, refinement, synthesis, rejection, and task switching appear directly as different human actions following different histories.

### 4.3 Endogenous feedback

The model changes the stream from which its future labels are collected. This creates a joint, nonstationary process: model outputs may inform, anchor, distract, homogenize, or manipulate; human responses then enter later training data. Behavioral replay reduces forgetting but does not establish that this feedback is beneficial.

The system must therefore retain user control, visible provenance, exposure-rate limits, rollback, and randomized evaluation. Prediction metrics alone cannot detect harmful convergence toward behavior made easier for the model to predict.

## 5. Continual Adaptation and Replay

Accepted canonical policies form one lineage

$$
\pi_0,\pi_1,\ldots,\pi_d.
$$

For update $d$, initialize a candidate from the previously deployed policy $\pi_{d-1}$. Let $\mathcal N_d$ contain recent finalized examples and let $\mathcal R_d$ be a stratified sample of older accepted examples. The continual objective is

$$
\boxed{
\mathcal L_d(\theta)
=
\lambda_{\mathrm{recent}}\mathcal L_{\mathrm{BC}}(\mathcal N_d)
+
\lambda_{\mathrm{replay}}\mathcal L_{\mathrm{BC}}(\mathcal R_d)
}.
$$

The mixture defines a stability–plasticity tradeoff. Recent data tracks current projects and behavior; replay preserves sparse workflows and reduces domination by one correlated session. Replay is stratified by time period, application, action family, provenance, and whether the preceding history contained assistant outputs. That final field is metadata for sampling and evaluation, not a different estimator.

### 5.1 Distinct resource decisions

Four choices should not be collapsed under the word *memory*:

1. **Context memory:** which prior events $C_\phi$ serializes for one prediction.
2. **Replay memory:** which historical examples remain available for future updates.
3. **Parametric memory:** which observations enter adaptable model weights.
4. **Training memory:** the accelerator budget for parameters, optimizer state, contexts, and targets.

Likewise, update trigger, microbatch size, effective optimizer batch, and replay capacity are different quantities. Variable-length examples are packed by total serialized tokens, and gradient accumulation targets a stable number of action tokens per optimizer step.

### 5.2 Immutable publication

Collection continues while a candidate trains. Every job records its parent policy, data cutoff, recent examples, replay sample, context-builder version, optimizer configuration, and validation report. Acceptance creates a new immutable canonical version. Rejection leaves the deployed version and accepted-data watermark unchanged. The previous adapter and optimizer state remain available for rollback.

At minimum, publication requires:

- improvement or non-inferiority on a recent chronological holdout;
- no unacceptable regression on a fixed historical holdout;
- no failed high-priority application, action-family, provenance, or target-length slice;
- finite, stable optimization and no failed general capability check;
- no triggered closed-loop safety or outcome regression gate when such data is available.

Explicit KL anchoring, teacher distillation, parameter isolation, meta-learned initialization, or adaptive replay are escalation paths when measured failures justify them. They are not prerequisites for the minimal system.

## 6. Minimal Records

The primary store is append-only and versioned. It separates raw events, derived actions, derived examples, replay state, and training manifests.

```text
Event {
  event_id
  principal_id
  actor: HUMAN | ASSISTANT | EXTERNAL | SYSTEM
  kind: READ | WRITE | NAVIGATION | STATE
  app
  object_ref
  operation
  began_at
  available_at
  ended_at?
  content_ref?
  provenance
  source_event_ids
  collector_version
  privacy_state
  quality_flags

  // Optional metadata for assistant-authored events:
  policy_version?
  sampling_config?
  interaction_id?
  rank?
  generation_context_hash?
}

MacroAction {
  action_id
  principal_id
  source_event_ids
  domain
  location?
  operation
  content_ref
  began_at
  committed_at
  boundary_reason
  segmentation_version
  provenance_summary
  confidence
}

BCExample {
  example_id
  principal_id
  context_event_ids
  serialized_context_ref
  target_action_id
  loss_mask_ref
  context_builder_version
  target_token_count
  total_token_count
  finalized_at
  supersedes_example_id?
}

TrainingBatchManifest {
  batch_id
  parent_policy_version
  candidate_policy_version
  published_policy_version?
  data_cutoff_at
  recent_example_ids
  replay_example_ids
  replay_mixture
  replay_buffer_version
  microbatch_token_limit
  effective_target_tokens_per_step
  objective_config_hash
  optimizer_config_hash
  validation_report_ref
}
```

Each rendered assistant sample is stored as an event whose provenance supports exact history reconstruction. Unrendered generation telemetry may be retained operationally outside the person's observed stream.

## 7. Evaluation

The evaluation must keep prediction, representation, and system benefit separate.

### 7.1 Predictive validity

Primary prediction metrics include action-token negative log-likelihood, candidate rank of the recorded action, operation accuracy, location accuracy, and content-sensitive hard-negative ranking. Comparisons are paired on identical future targets. Chronological splits and day- or session-level uncertainty prevent adjacent correlated edits from masquerading as independent evidence.

Necessary controls include no personal history, correct history, shuffled history, wrong-time history, damaged timestamps, trivial repetition baselines, and a manually selected oracle context on a small diagnostic subset. Performance should be reported separately for histories with and without assistant-authored events, while using the same underlying estimator.

### 7.2 Local-objective representation

Goal understanding is tested only after predictive signal exists. Useful diagnostics include:

- raw history versus retrieved raw events;
- semantic propositions versus the same source evidence;
- an explicitly induced current objective versus raw context under a matched budget;
- held-out situations with similar language but different active goals;
- novel action forms serving a familiar goal;
- independent human audits of induced objectives.

An objective representation that improves future-action prediction supports a bridge from legible behavior to local intention modeling. It does not establish a stable reward function or explain every prediction.

### 7.3 Joint-system outcomes

The central product evaluation compares at least:

1. the person working without model outputs;
2. the person with a fixed generic or personalized model;
3. the person with the continually adapted personalized system.

Let $J(\mathcal S)$ measure outcomes such as time to an acceptable result, final quality, errors, rework, task completion, or user-assessed goal satisfaction. The system hypothesis is

$$
J(\text{human + continual personalized model})
>
J(\text{human alone})
$$

and, more stringently,

$$
J(\text{human + continual personalized model})
>
J(\text{human + static model}).
$$

Training need not require goal annotations, but an outcome experiment needs bounded tasks, completion criteria, or later human judgment. Randomized no-output or alternative-output windows are required when causal benefit is claimed.

### 7.4 Closed-loop stability

Track prediction and outcomes across policy versions, exposure rates, applications, and projects. Audit anchoring, copied-content rate, behavioral diversity, reversals, ignored suggestions, interruption, user override, capability retention, and recovery after rollback. A system that becomes easier to predict while making the person's work worse has failed.

## 8. Algorithms

### Algorithm 1: Construct next-action examples

```text
procedure BUILD_EXAMPLES(events, segmentation_config, context_config):
    ordered <- STABLE_TEMPORAL_SORT(events)
    actions <- SEGMENT_HUMAN_WRITES(ordered, segmentation_config)
    examples <- []

    for action y in actions:
        if y.confidence < segmentation_config.minimum_confidence:
            continue

        prior <- events with available_at strictly before y.began_at
        h <- BUILD_CONTEXT(prior, context_config)

        if LEAKS_FUTURE_INFORMATION(h, y):
            continue

        examples.append(BCExample(
            context_event_ids=IDS(prior),
            serialized_context=FREEZE(h),
            target_action=y,
            loss_mask=MASK_CONTEXT_AND_SCORE_TARGET(h, y)
        ))

    return examples
```

### Algorithm 2: Render model predictions into the stream

```text
procedure OFFER_POSSIBLE_NEXT_ACTIONS(pi_canonical, live_event_stream, K):
    h <- BUILD_CONTEXT(events available before current time)
    samples <- SAMPLE_BOUNDED_ACTIONS(pi_canonical, h, K)

    rendered <- INTERFACE_RENDER(samples)

    for sample z in rendered:
        APPEND_EVENT(live_event_stream, Event(
            actor=ASSISTANT,
            kind=READ,
            operation=RENDER_SUGGESTION,
            content=z,
            available_at=CONFIRMED_RENDER_TIME(z),
            policy_version=VERSION(pi_canonical),
            sampling_config=SAMPLING_CONFIG(z),
            generation_context_hash=HASH(h),
            provenance=MODEL_OUTPUT
        ))
```

Later human writes are processed by `BUILD_EXAMPLES`, which includes rendered assistant events whenever they occurred before the action.

### Algorithm 3: Continually update the canonical policy

```text
procedure UPDATE_CANONICAL(pi_previous, incoming_examples, replay_state, config):
    eligible <- FINALIZE_PAST_WATERMARK(incoming_examples, config)
    replay_state <- UPDATE_REPLAY_INDEX(replay_state, eligible)
    pending <- EXAMPLES_SINCE_ACCEPTED_CUTOFF(replay_state)

    if not UPDATE_TRIGGERED(pending, config):
        return pi_previous, replay_state

    recent <- SAMPLE_RECENT_WINDOW(
        replay_state,
        exclude=config.recent_holdout
    )
    replay <- SAMPLE_STRATIFIED_HISTORY(
        replay_state,
        strata=(time, app, action_family, provenance, assistant_history),
        exclude=(recent, config.fixed_historical_holdout)
    )

    candidate <- CLONE_ADAPTER(pi_previous)

    for group in PACK_AND_ACCUMULATE(recent, replay, config.token_budgets):
        L_recent <- MASKED_ACTION_NLL(candidate, group.recent)
        L_replay <- MASKED_ACTION_NLL(candidate, group.replay)
        L <- config.lambda_recent * L_recent
             + config.lambda_replay * L_replay
        candidate <- OPTIMIZER_STEP(candidate, gradient(L))

    report <- EVALUATE_PREDICTION_RETENTION_CAPABILITY_AND_SAFETY(
        candidate, config.holdouts, config.slices
    )

    STORE_MANIFEST(candidate, recent, replay, report)

    if PASSES_PUBLICATION_GATES(report):
        pi_next <- PUBLISH_IMMUTABLE(candidate)
        ADVANCE_ACCEPTED_CUTOFF(replay_state, pending)
        return pi_next, replay_state

    return pi_previous, replay_state
```

## 9. Identification Boundaries and Non-Goals

The method does not establish:

- that recorded human behavior is optimal;
- that prediction necessarily implies semantic understanding;
- that one true or stable personal reward has been recovered;
- that a particular model output caused a later action;
- that lower next-action loss improves human outcomes;
- that continual training directly optimizes which intervention should be shown;
- that replay prevents all forgetting or harmful convergence;
- that the model is a world simulator, planner, or autonomous executor;
- that one person's raw activity can be pooled safely across users or tenants.

This scope defines a continually updated behavioral component inside a human-authorized system. Measured system failures can motivate additional capabilities such as intervention selection, explicit outcome learning, simulation, or planning.

## 10. Related Work

Behavioral cloning is the direct statistical formulation of next-action learning. Carroll et al. motivate separating a learned human model from an agent designed to collaborate with it [1]. The architecture here uses a canonical predictor within the collaborative system and evaluates its predictive accuracy separately from its effect on system outcomes.

Matti et al. predict one user's keyboard and mouse actions from a short discrete history [2]. Shaikh et al. introduce naturalistic next-action prediction from multimodal computer-use streams and compare prompting, retrieval, supervised adaptation, and learned reasoning–retrieval [3]. These works provide the nearest predictive baselines.

DAgger collects labels in states induced by a learner [4]. The closed loop here has a related on-policy character, but model outputs are information supplied to a person rather than actions executed in an environment, and ordinary human writes—not expert corrections requested at every state—remain the targets.

Dynamic evaluation and end-to-end test-time training show that likelihood-based adaptation can encode recent sequence structure into weights [5, 6]. They motivate repeated chronological evaluation but do not remove the need for replay, retention tests, and immutable publication.

General User Models and Just-In-Time Objectives provide contrasting representations of personal evidence: retrieved semantic propositions and explicit current-goal abstractions [7, 8]. They are useful diagnostics for whether goal-like representations improve next-action prediction without claiming reward identification.

Finally, work on influenceable preferences and feedback optimization warns that systems can change the behavior they later learn from and may optimize for easier feedback rather than better outcomes [9, 10]. The proposed closed loop therefore requires outcome controls, exposure provenance, and rollback even though it does not optimize clicks or ratings.

## 11. Minimal Implementation Sequence

1. Collect and audit the interleaved event stream across Obsidian, browser, and AI chat.
2. Reconstruct bounded human write actions and immutable chronological examples.
3. Establish predictive signal and defeat trivial, wrong-history, and leakage baselines.
4. Compare recent context, retrieval or memory, explicit objective induction, and supervised adaptation.
5. Measure scaling with personal-data quantity, recency, modality, context budget, and model capability.
6. Repeat on sealed future windows and implement recent-plus-replay continual updates.
7. Deploy model predictions as clearly attributed events at a controlled exposure rate.
8. Compare human–model outcomes with unaided and static-assistant baselines.
9. Continue only while prediction, retention, capability, user-control, and outcome gates pass.

This sequence makes failures attributable while moving directly from personal event data to continually adapted assistance. The first paper tests whether the stream supports useful personalized next-action prediction and whether embedding that predictor in the person's workflow improves joint-system outcomes.

## References

[1] M. Carroll et al. [*On the Utility of Learning about Humans for Human-AI Coordination*](https://arxiv.org/abs/1910.05789). 2019.

[2] F. Matti, P. Dillenbourg, and L. Novelli. [*A Click Ahead: Real-Time Forecasting of Keyboard and Mouse Actions using RNNs and Computer Vision*](https://arxiv.org/abs/2309.12170). 2023.

[3] O. Shaikh et al. [*Learning Next Action Predictors from Human-Computer Interaction*](https://arxiv.org/abs/2603.05923). 2026.

[4] S. Ross, G. Gordon, and D. Bagnell. [*A Reduction of Imitation Learning and Structured Prediction to No-Regret Online Learning*](https://arxiv.org/abs/1011.0686). 2011.

[5] B. Krause, E. Kahembwe, I. Murray, and S. Renals. [*Dynamic Evaluation of Transformer Language Models*](https://arxiv.org/abs/1904.08378). 2019.

[6] A. Tandon et al. [*End-to-End Test-Time Training for Long Context*](https://arxiv.org/abs/2512.23675). 2025.

[7] O. Shaikh et al. [*Creating General User Models from Computer Use*](https://arxiv.org/abs/2505.10831). 2025.

[8] M. S. Lam et al. [*Just-In-Time Objectives: A General Approach for Specialized AI Interactions*](https://arxiv.org/abs/2510.14591). 2025.

[9] M. Carroll, D. Hadfield-Menell, S. Russell, and A. D. Dragan. [*Estimating and Penalizing Induced Preference Shifts in Recommender Systems*](https://arxiv.org/abs/2204.11966). 2022.

[10] M. Williams et al. [*On Targeted Manipulation and Deception when Optimizing LLMs for User Feedback*](https://arxiv.org/abs/2411.02306). 2024.
