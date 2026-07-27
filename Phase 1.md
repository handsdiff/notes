
*Learning to assist from personal read–write streams*

**Status:** Working research plan. This document contains no experimental results. It specifies the predictive bootstrap, closed-loop behavioral learning, assumptions, and executable experiments for the first phase of the project.

WARNING: human ideas, but AI writing

## Abstract

Most AI systems learn about a person only when the person stops working to explain what they want. Ordinary computer use already contains a richer record. A person reads documents, browses pages, receives messages and model outputs, edits notes, writes queries, sends messages, and changes artifacts. Together these events form a temporal stream of information becoming action.

This paper learns from that stream by predicting each bounded human write action from the events that were available before it. Historical activity bootstraps a personalized model. Once deployed, the model samples possible next actions and presents them to the person as part of the ordinary information stream. The person may use, ignore, transform, or move beyond them. Whatever the person does next becomes a new training target conditioned on the history they actually experienced. Continual updates mix these recent examples with stratified replay and publish new model versions only after prediction, retention, and capability checks.

The aim is an increasingly capable human–model system. The model contributes broad knowledge, speed, and alternative continuations; the person contributes goals, private context, judgment, synthesis, and authority. The central hypothesis is that good next-action prediction in difficult cases requires useful representations of what the person is locally trying to accomplish, and that samples from such a model can help the person reach acceptable outcomes faster or better. Causally masked actions test the predictive model. Controlled comparisons with unaided work and static assistance test the system it becomes part of.

## 1. The Missing Substrate for Personal AI

A broadly capable model may know how to write, search, analyze, code, or operate software while still having little basis for deciding which action would matter to a particular person now. The missing information is often tacit and fast-changing: the argument the person is developing, the question behind a search, the constraint introduced by a message, the connection they have not yet written down, or the project that has quietly become more important than yesterday's task.

Explicit prompts reveal fragments of this state. Conventional memory systems preserve facts the person or model already chose to record. Ratings and rankings can provide clearer feedback, but asking for them continuously would turn ordinary work into a labeling exercise. Personal, nondeterministic, and fresh context cannot simply be purchased with more compute or recovered reliably after the fact.

The work itself is a more natural source of supervision. Inbound events show what became available to the person. Outbound actions show what they did next. Their temporal interleaving records how context, judgment, and intention became behavior. A model that can predict that transformation has learned something more useful than a profile of stable preferences: it has learned to track the moving edge of a person's work.

The learning loop becomes richer when the model participates. Its samples are not merely answers to accept or reject; once shown, they become material the person can think with. A suggestion may be copied, edited, combined with another idea, rejected, or used as the catalyst for a different action. The resulting human action remains in the same stream. The interface therefore creates continual supervision without requiring a separate feedback ritual: the model contributes possibilities, the person continues working, and the shared history teaches the next version.

The object of study is the joint system

$$
\mathcal S_u
=
(\text{person},\text{model},\text{shared event stream},\text{continual update loop}).
$$

This system is successful when the model's capabilities and the person's judgment combine to produce work that is faster, better, or newly possible. A useful suggestion need not resemble the final action. Its value may lie in reminding, challenging, reframing, or making an otherwise costly line of thought available at the right moment. The project therefore tests both whether the model learns the person and whether the person–model loop benefits from what it learns.

The research claims form a ladder:

1. Ordinary activity can be reconstructed as a faithful chronological event stream.
2. Prior events contain signal about the person's next bounded write action.
3. Personal history, memory, or weight adaptation improves extraction of that signal.
4. Continual adaptation preserves useful older behavior while tracking genuine change.
5. Model outputs inserted into the stream can scaffold different or better human actions.
6. The continually personalized human–model system improves task outcomes relative to unaided work and static assistance.

Claims 1–4 concern data and prediction. Claims 5–6 concern the deployed system and require intervention-aware outcome evaluation. A failure at one step should not be hidden by adding machinery at a later step.

### 1.1 From prediction to implied local objectives

Much of a person's next action can be predicted from repetition, style, and workflow regularity. The more consequential cases require something else. To anticipate a novel sentence, search, edit, or prompt, a model may need to infer what the current work is for: which ambiguity is being resolved, which result would count as progress, and which constraint makes an otherwise sensible action wrong.

Let $g_t$ denote this active local objective. It may be stated explicitly in the stream or remain latent to the model. Conceptually, human behavior can be written as $H_u(y\mid h,g)$, while a predictor without a separate goal label estimates

$$
p_u(y\mid h)
=
\int H_u(y\mid h,g)\,p_u(g\mid h)\,dg.
$$

Accurate prediction in novel or ambiguous situations may reward an internal representation of $p_u(g\mid h)$. The representation need not be unique, human-readable, stable across tasks, or equivalent to a reward function. The claim is practical: a model that tracks the person's local objective should generalize beyond literal repetition and produce more relevant possibilities at the frontier of the work.

This is a testable bridge rather than a property guaranteed by likelihood training. Raw history can be compared with explicit objective induction; contexts with similar surface form but different goals can test discrimination; and novel actions within a familiar objective can test abstraction. Held-out actions measure prediction, while task outcomes measure whether whatever the model learned is useful in the joint system.

### 1.2 Assumptions and claim boundaries

The work rests on a ranked set of assumptions. They are ordered so that an early failure can stop or redirect the program before later machinery obscures it.

1. **The observable stream contains marginal, goal-relevant information.** Correctly timed browser activity, chats, note state, and prior actions must predict semantic content better than the current artifact and generic knowledge alone.
2. **Difficult prediction contains objective-level structure.** Repetition and style will explain some behavior, but novel or ambiguous actions should benefit from representing what the person is locally trying to accomplish. No unique, stable, or human-readable latent goal is assumed.
3. **Predictive competence produces useful possibilities.** A model that learns punctuation or favorite files may compress behavior without helping. Samples must sometimes remind, challenge, reframe, or make a costly continuation available sooner.
4. **The exposed interaction remains a valid prediction problem.** Once a model sample is rendered, it is part of the person's actual information state. The later human action is therefore a valid behavioral target conditioned on that expanded history.
5. **The closed loop can improve the joint system without harmful convergence.** Repeated exposure may also anchor the person, narrow behavior, or select for predictability. Outcome controls, exposure limits, provenance, override, diversity audits, and rollback are mandatory.
6. **Personal context still matters at high base-model capability.** The principal quantity is the within-model gain from correct personal history over no, wrong, or mismatched history—not whether a small personalized model beats an older generic model.
7. **The pre-action information state can be reconstructed faithfully.** Visible spans, rendered assistant tokens, authorship, timing, and action onset must be known well enough to prevent future leakage.
8. **The macro-action is a meaningful boundary.** Sentences, bullets, queries, messages, and coherent edit bursts must be large enough to express intent and small enough to be predicted from a single information state.
9. **Personalization can add local knowledge without sacrificing general capability.** Publication requires both personal prediction gains and retention of reasoning, instruction following, tool use, and unfamiliar-task performance.
10. **Relevant evidence can be selected from a long, noisy history.** Oracle-context comparisons distinguish missing information from failed retrieval, compression, or context construction.
11. **Useful evidence accumulates faster than it becomes stale.** Recent data must track genuine movement without letting one session dominate; replay must preserve durable workflows without freezing the model in the past.
12. **Evaluation can separate prediction, representation, and system benefit.** Chronological prediction, objective-representation diagnostics, and randomized outcome comparisons are different claims and require different evidence.

The observed human action is not assumed to be globally optimal. Phase 1 learns behavior and tests whether predictions help the person; it does not recover a reward function. After samples are shown, the stronger local assumption needed for comparative learning is deferred to [[Phase 2]]: the person's subsequent action is treated as superior to the rendered proposal for the local decision. Keeping that assumption out of the Phase 1 objective preserves a clean test of the behavioral substrate.

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

Historical human activity supplies chronological next-action examples. The initial personalized canonical policy $\pi_0$ is trained or configured using in-context history, retrieval, memory, supervised fine-tuning, or a measured combination. Section 8 specifies the gated experiment that tests collection fidelity, predictive signal, personalization mechanisms, objective-representation diagnostics, and local scaling behavior before live deployment.

### 4.2 Learning through participation

The deployed model turns prediction into an interaction. At an appropriate moment, it produces several possible continuations and makes some of them visible. These are possibilities for the person to think with, not items that must be graded. Their effect may appear as direct use, refinement, synthesis, rejection, a task switch, or an action whose connection to the sample is invisible from text alone. The observable learning signal is the next human action in the history that actually occurred.

Formally, the current canonical policy samples possible next human actions:

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

## 8. Experimental Program

Phase 1 is a sequence of gates, not a single end-to-end wager. Prospective collection begins immediately because the most important evidence cannot be reconstructed reliably after the fact. In parallel, existing Obsidian history is used to validate segmentation, serialization, training, and evaluation without pretending that it contains browser or chat context that was never captured.

### 8.1 Core questions

- **Q0 — reconstruction:** can the event stream and exact pre-action information state be reconstructed faithfully?
- **Q1 — signal:** does existing note history support a mechanically valid next-action task and defeat trivial baselines?
- **Q2 — source value:** do correctly timed browser and chat events improve prediction beyond the artifact and prior writes?
- **Q3 — personalization:** when raw context is insufficient, which combination of retrieval, semantic memory, explicit objective induction, and supervised adaptation extracts the signal best?
- **Q4 — scaling:** how does the marginal value of personal evidence change with model capability, data quantity, recency, and context budget?

The central unit is a finalized human write macro-action. The input contains only events whose `available_at` precedes the action's `began_at`; the target contains the complete committed action; evaluation is paired on identical future targets. Token-level likelihood is reported per action and aggregated with session- or day-level uncertainty so long editing bursts do not masquerade as independent evidence.

### 8.2 Data collection and integrity

Collection covers three initial surfaces:

- **Obsidian:** note snapshots or patches, cursor and selection state when available, visible text, save or focus boundaries, pasted-versus-authored provenance, and coherent edit bursts.
- **Browser:** URL and title, visible or consumed spans rather than eventual page contents, searches, navigation, media progress, focus state, and timestamps.
- **AI chats:** prompts, token-render times, tool results, attachments, branching or regeneration state, and assistant text actually exposed before the next human action.

All sources map into the common `Event` record in Section 6. Raw content is immutable and content-addressed; corrections create superseding records. Clock normalization, collector version, privacy state, duplicate suppression, uncertain availability, and source provenance remain explicit. Sensitive or excluded content is removed before dataset publication, not merely hidden from the serializer.

Before modeling, a manually audited sample must pass reconstruction gates for temporal ordering, visible-content fidelity, authorship, action boundaries, source completeness, and absence of future leakage. Failure here blocks predictive claims.

### 8.3 Chronology, manifests, and readiness gates

Splits are chronological and separated by an embargo at least as long as the largest ordinary context window. No random action-level split is permitted. Context retrieval may search only records available by the target cutoff; fine-tuning sees only the training window; model and context-builder selection use validation; the final test window remains sealed until the analysis is frozen.

Every dataset release freezes:

- raw-event snapshot and exclusion policy;
- segmentation and context-builder versions;
- train, validation, embargo, and test cutoffs;
- example IDs, content hashes, and target-token counts;
- model, tokenizer, prompt, retrieval index, and sampling configuration;
- metric definitions and predeclared slices.

The first full comparison begins only after the capture audit passes, the target boundary is stable, each major source has usable coverage, and the sealed window contains enough independent sessions and content-bearing actions to estimate paired effects. Calendar time and number of actions are reported, but readiness is determined by coverage and effective sample size.

### 8.4 Experimental staircase

**Experiment 0 — collector and reconstruction audit.** Manually replay sampled sessions from each source. Measure missing-event rate, ordering error, incorrect visible-span rate, authorship error, segmentation disagreement, and leakage. This experiment establishes whether the proposed dataset exists.

**Experiment 1 — Obsidian-only smoke test.** Construct chronological note-edit examples and compare last-action repetition, nearest-neighbor continuation, current-note-only prompting, and temporally valid note history. Inspect high-gain examples to determine whether improvements concern content or only syntax and location.

**Experiment 2 — source ablation.** On an identical sealed target set, compare current artifact; recent writes; notes; browser; chats; all correctly timed sources; shuffled sources; wrong-time sources; and a small manually selected oracle context. The oracle distinguishes a failed data thesis from a failed selector.

**Experiment 3 — personalization mechanism.** Under matched model and evidence budgets, compare raw long context, retrieval, semantic memory, explicit current-objective induction, supervised adaptation, and measured combinations. The explicit-objective condition must be evaluated by its effect on held-out actions, not by how persuasive its summaries sound.

**Experiment 4 — local scaling.** Vary base-model capability, personal-data quantity, recency, context budget, and adaptation capacity. Report the within-model gain from correct personal evidence and interactions among these factors. This tests whether capability substitutes for personal context or makes better use of it.

**Experiment 5 — prospective repetition and continual update.** Freeze the analysis, repeat it on a later untouched interval, then simulate or deploy recent-plus-replay updates. Measure recent gain, historical retention, capability retention, calibration, and recovery after project changes. Only after these gates pass are samples rendered in controlled live windows.

### 8.5 Baselines and metrics

The adopted baseline schedule is deliberately narrow at first:

1. last action, common action, and edit-location heuristics;
2. same model with no personal history;
3. same model with correct, shuffled, mismatched-person, and wrong-time history;
4. retrieval and semantic-memory baselines;
5. explicit-objective induction;
6. supervised personalization and recent-plus-replay continual adaptation.

Primary predictive metrics are target-token negative log-likelihood, recorded-action rank among content-sensitive alternatives, operation and location accuracy, exact or semantic top-$k$ inclusion, and calibration. Hard negatives should preserve surface form while changing the active goal, or preserve the goal while changing the plausible action. Report by application, action family, target length, novelty, copy provenance, and whether assistant-authored events occur in context.

The live system evaluation compares unaided work, a fixed assistant, and the continually adapted assistant on bounded tasks. Outcomes include time to an acceptable result, blinded quality, error and rework, completion, interruption, and user-assessed goal satisfaction. Exposure is randomized where causal benefit is claimed.

### 8.6 Confounds and stopping rules

The analysis must not conflate data quantity, context quantity, and optimizer exposure; base capability and personalization method; stylistic fit and content prediction; repeated text and authorship; or next-action prediction and eventual outcome. Behavioral adaptation to collection is measured by pre/post capture comparisons. Inferred objectives are constructed from training-time evidence only and never validated against information from the target action itself.

Stop or redirect when the corresponding weakest link fails:

| Failure | Interpretation | Next move |
|---|---|---|
| reconstruction audit fails | the proposed stream is fictional | repair capture before modeling |
| correct history does not beat controls | little usable personal signal at this boundary | change source coverage or action granularity |
| oracle context helps but automatic context does not | selection, not data, is the bottleneck | improve retrieval or representation |
| personalization helps likelihood but not content-sensitive ranking | mostly style or workflow mimicry | redesign targets and hard negatives |
| stronger models erase personal-history gain | scale substitutes for the stream | narrow the thesis or test rarer private context |
| live prediction improves but outcomes do not | predictor is not useful assistance | change interface, timing, or sample diversity |
| outcomes or diversity regress | harmful closed-loop convergence | stop exposure and roll back |

### 8.7 Phase 1 success

Phase 1 succeeds when a frontier-capable model with automatically constructed, temporally valid personal context produces a repeatable and product-relevant gain on future chronological macro-actions over the same model with no, wrong, and mismatched history; the gain survives content-sensitive controls, appears in novel or goal-ambiguous cases, and does not degrade general capabilities. Controlled deployment must then show that rendering samples can improve bounded human–model outcomes without unacceptable anchoring or loss of diversity.

It need not show that a smaller personal model surpasses the strongest generic model. It need not recover a reward function, prove a unique latent goal, or make every suggestion useful. The output of the phase is a validated event substrate, a canonical continually trained behavioral policy, and a controlled interaction stream from which Phase 2 can learn explicit local comparisons.

## 9. Algorithms

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

## 10. What the Method Can Establish

The proposal supports three progressively stronger kinds of claim:

1. **Predictive:** temporally valid personal history improves prediction of future human actions.
2. **Representational:** goal-like abstractions help especially when surface behavior changes but the local objective persists.
3. **System-level:** exposing the person to samples from a continually personalized model improves bounded task outcomes.

Each claim has its own evidence. Likelihood on held-out actions establishes predictive performance. Representation diagnostics test whether local-objective structure explains some of that performance. Controlled outcome comparisons establish whether participation by the model helps the human–model system.

This separation matters because the stream records temporal conditioning, not full causal credit. An observed action need not be optimal; a preceding model output need not have caused it; and a good predictor need not have recovered a unique personal reward. Continual likelihood learning also estimates behavior rather than directly selecting the best moment or content for an intervention. Replay, capability tests, exposure controls, and rollback keep those limits measurable while the core hypothesis is tested.

## 11. Related Work

Behavioral cloning is the direct statistical formulation of next-action learning. Carroll et al. motivate separating a learned human model from an agent designed to collaborate with it [1]. The architecture here uses a canonical predictor within the collaborative system and evaluates its predictive accuracy separately from its effect on system outcomes.

Matti et al. predict one user's keyboard and mouse actions from a short discrete history [2]. Shaikh et al. introduce naturalistic next-action prediction from multimodal computer-use streams and compare prompting, retrieval, supervised adaptation, and learned reasoning–retrieval [3]. These works provide the nearest predictive baselines.

DAgger collects labels in states induced by a learner [4]. The closed loop here has a related on-policy character, but model outputs are information supplied to a person rather than actions executed in an environment, and ordinary human writes—not expert corrections requested at every state—remain the targets.

Dynamic evaluation and end-to-end test-time training show that likelihood-based adaptation can encode recent sequence structure into weights [5, 6]. They motivate repeated chronological evaluation but do not remove the need for replay, retention tests, and immutable publication.

General User Models and Just-In-Time Objectives provide contrasting representations of personal evidence: retrieved semantic propositions and explicit current-goal abstractions [7, 8]. They are useful diagnostics for whether goal-like representations improve next-action prediction without claiming reward identification.

Finally, work on influenceable preferences and feedback optimization warns that systems can change the behavior they later learn from and may optimize for easier feedback rather than better outcomes [9, 10]. The proposed closed loop therefore requires outcome controls, exposure provenance, and rollback even though it does not optimize clicks or ratings.

## 12. Implementation Order and Required Artifacts

The local work proceeds in the following order:

1. implement append-only collectors and clock normalization;
2. audit reconstructed sessions and repair capture until Experiment 0 passes;
3. version macro-action segmentation and build immutable examples;
4. freeze chronological manifests and implement leakage tests;
5. run the Obsidian smoke test and source ablations;
6. add retrieval, semantic memory, objective induction, and supervised adaptation;
7. measure local scaling and repeat on a sealed prospective interval;
8. implement recent-plus-replay continual publication with rollback;
9. render samples only in controlled, attributable exposure windows;
10. evaluate joint-system outcomes and closed-loop stability;
11. publish the Phase 2 comparison dataset only after pair-validity audits pass.

The required artifacts are the collector specification, privacy and exclusion policy, reconstruction audit, segmentation guide, immutable dataset manifests, leakage test suite, baseline harness, evaluation protocol, continual-training manifest, replay index, capability-retention suite, exposure log, randomized outcome protocol, rollback procedure, and model card for every accepted policy version.

The clean handoff to [[Phase 2]] is a stream of interactions containing: the exact prefix before proposal generation, every candidate generated, the subset actually rendered with token-level availability, the later human macro-action, and the behavioral prefix containing what the person really saw. Phase 1 can ignore the pairwise interpretation and continue BC. Phase 2 can use the same immutable events to improve a separate proposer or learn a reusable local reward.

## 13. Conclusion

Personal AI needs a way to learn how one person's changing context becomes action. A temporally faithful read–write stream provides that substrate. It contains what the person encountered, what they chose to do, how their work evolved, and—once the model is deployed—how model-generated possibilities entered the process.

Next-action likelihood turns this stream into a renewable training signal. The model first learns by observing the person's work. It then participates by offering possible continuations. The person continues thinking and acting with those possibilities in view, and the resulting history teaches the next model version. Continual replay preserves older evidence while the model tracks the moving edge of current work.

If the hypothesis holds, the result is a personal model whose usefulness compounds through shared work. Its value comes from predicting the person well enough to place relevant possibilities within reach, while leaving goals, judgment, and authority with the person. The larger possibility is assistance that learns at the pace of a life or organization and helps people reach outcomes that would otherwise take longer, require more effort, or remain undiscovered.

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
