
*Continual next-action learning from personal read–write streams*

**Status:** Working research and implementation plan. This document specifies the data substrate, behavioral-cloning objective, daily evaluation and update loop, and initial experiments for Phase 1.

**WARNING:** human ideas, but mostly AI writing

#### Misc Notes
- "possible experiment / toy example to have the git history of notes, randomly remove increasing portions of it, in-context prompt frontier and/or weight space update a smaller LLM, rank predictions based on personal expected usefulness/predictive ability (perhaps just pairwise), establish trend line if any. compare across differing frontier models and/or differing small/local LLMs. do this online to collect more data on how it evolves over time"
- super relevant analysis of algorithms, compared to prompt space, and data tricks/tips needed to juice performance at least in that specific domain https://thinkingmachines.ai/news/learning-to-replicate-expert-judgment-in-financial-tasks/
	- is it cheaper to update weights continuously or update prompts continuously? actually feels like weights? since querying prompts on a frontier model is super expensive?
	- findings
		- data quality, specifically representation of actions, matters as much if not more than training algorithms
		- prompt/ICL baseline must be strong
		- model disagreement is useful for data auditing. could probably track which examples are consistently failing from historical replay and weight based on their failure rate? maybe could also weight based on frequency?
		- round robin interleaving of batches outperformed sequential task training AND full random mixing. hmmm.
		- plain GRPO did not work, needed interleaved batching, CISPO importance ratio clipping, OPD, and reference regularization
		- promoted teacher only after validation improved
		- does RSI lead to frontier models that can develop these algorithms for you? does that imply that you can always achieve better than frontier performance?
- computer use companies like Markov may help with raw capture, from which causal event data can be constructed in theory. in practice its unclear if there is uncaptured data when it comes down to brass tacks
- can implement on hugging face, inference net, tinker, prime intellect, unsloth, axolotl, freesolo, custom build, etc
- i suspect for phase 1 the goal will be to learn token level structure before it can learn action level content. you might get a loss discontinuity (via early flatlining before more data shows improved loss due to content learning beginning)
- if 80% and growing amount of write actions are just prompting agents, what does the phase 1 model learn?
- the intended base model starting point does not have user assistant trained into it
- still unclear whether you need to apply synthetic q/a self study to the data to improve understanding rather than memorization, and how that relates to maintaining support for question answering / chatting, and how that relates to introducing reasoning rather than pure SFT. although these are likely later ablations rather than initial work

## Abstract

Ordinary computer use produces a chronological record of information becoming action. A person reads documents, browses pages, receives messages and model outputs, edits notes, writes searches and prompts, sends messages, and changes artifacts. If these events are captured at the time they actually became available, they form a personal read–write stream from which the person's next bounded write action can be predicted. Judgment is distilled into weights.

Phase 1 builds that stream and applies behavioral cloning to it. Each example contains a fixed-length window ending immediately before an action and the complete human-authored action that followed. Read events and prior actions are context; only the next human write action receives loss.

Learning is continual. During a day, the model's weights remain fixed while every action is predicted and scored from the sliding causal context. Overnight, that day's examples become training data and are mixed with replay from earlier days. The resulting weights initialize the next day. Historical data is processed through the same chronological loop used for new data, so there is no separate offline training paradigm and no permanent partition of personal activity into training and test examples. Each action is evaluated before it is allowed to train a later model.

The first goal is deliberately narrow: implement a temporally faithful event collector, construct reliable macro-action targets, establish that personal history improves next-action prediction, measure how performance changes with context length and continual adaptation, and verify that repeated updates do not erase older behavior.

## 1. Vision

A capable general model may know how to write, search, analyze, code, and operate software while still having little basis for understanding a particular user. The missing information is often tacit and fast-changing: the argument being developed, the question behind a search, the constraint introduced by a message, the connection between two documents, or the project that has become important today.

The person's prior computer use likely contains this information. Inbound events record what became available. Outbound actions record what the person did next. Their temporal interleaving shows how changing context becomes behavior without requiring the person to stop and produce separate labels.

The working hypothesis is that a model trained on this stream can become a useful predictive model of one person's work. Easy gains may come from style, repetition, and workflow regularity. Harder cases may require tracking what the person is presently trying to accomplish. Phase 1 does not attempt to identify a unique latent goal or reward function; it tests the more direct claim that temporally valid personal history improves prediction of future actions.

The research claims are:

1. ordinary activity can be reconstructed as a faithful chronological event stream;
2. prior read and write events contain signal about the next human write action;
3. behavioral cloning can accumulate that signal in model weights;
4. longer causal context improves prediction when it contains relevant personal history;
5. daily continual updates can track changing work.

The initial implementation succeeds only if the data substrate is real and the predictive gain survives simple controls. More complicated learning methods are not a substitute for incorrect timestamps, missing visible content, weak action boundaries, or confused authorship.

## 2. Related Work

Behavioral cloning is the direct formulation of learning a human action policy from observed context–action pairs. Carroll et al. distinguish learning a model of human behavior from learning a separate policy that acts with a human [1]. Phase 1 concerns only the behavioral model.

Matti et al. predict one user's keyboard and mouse actions from a short discrete history [2]. Shaikh et al. study next-action prediction from naturalistic computer-use streams and compare prompting, retrieval, supervised adaptation, and learned reasoning–retrieval methods [3]. These works provide the closest task-level precedents and useful baselines for event construction and action prediction. This wo

Dynamic evaluation updates a language model on recent tokens before predicting later tokens in the same stream [4]. End-to-End Test-Time Training extends this idea by meta-learning an initialization that is explicitly optimized for online next-token updates and by using weight updates to carry information beyond a sliding attention window [5]. Phase 1 uses the same evaluate-before-update principle at a different boundary: human macro-actions are scored throughout a day, and ordinary behavioral-cloning updates occur overnight. The model state persists across days and historical replay is included.

Lifelong pretraining studies chronological adaptation to emerging corpora while measuring performance on both new and earlier distributions [6]. Its stability–plasticity problem is directly relevant: recent data should update the personal model without allowing one project or period to erase older workflows or general language-model capabilities.

## 3. Personal Event Stream - WIP, to be iterated on in [[Data]]

For one person, let

$$
\mathcal E=(e_1,e_2,\ldots,e_T)
$$

be an append-only, stably ordered stream of events. Every event records at least:

```text
Event {
  event_id
  actor: HUMAN | EXTERNAL_MODEL | EXTERNAL | SYSTEM
  kind: READ | WRITE | NAVIGATION | STATE
  app
  object_ref
  operation
  began_at
  available_at
  ended_at?
  content_ref?
  source_url?
  provenance
  source_event_ids
  collector_version
  privacy_state
  quality_flags
}
```

The store separates raw captured events from later interpretations. Raw records are immutable. Corrections or improved reconstructions create superseding records rather than rewriting history.

### 3.1 Temporal fidelity

The central data requirement is to make the model's external information state match the information that actually reached the person's brain as closely as the instrumentation permits. The collector cannot observe internal cognition, attention, or memory directly. It can, however, reconstruct observable exposure: what was rendered, visible, audible, foregrounded, selected, or otherwise available through the interface, and when.

Let $I_t^{H}$ denote the observable external information available to the human before action $t$, and let $I_t^{M}$ denote the information serialized into the model's context. The collection objective is:

$$
I_t^{M}\approx I_t^{H}
$$

in content, order, and timing. This alignment is what makes behavioral cloning an attempt to distill human judgment and skill into the weights. If the model receives information the person had not seen, it can explain the person's action using leaked evidence and learn a shortcut under a fictional state. If the model omits information the person did see, a skilled action can appear arbitrary or noisy. In either case, the learned conditional behavior is not a faithful model of the judgment that produced the action.

The operational rule is:

> Content may enter an action's context only if it was available through the person's interface before that action began.

Eventual presence in an export, file, page source, or transcript is not evidence of prior exposure.

- Opening an article records its URL, title, and navigation state. Only the spans actually exposed as the person reads or scrolls become read content. The unread remainder of the article does not.
- A video or podcast contributes only the material available through the observed playback position, not its complete transcript.
- An AI-chat response becomes available according to rendered content and timing. A completed response cannot be placed before the tokens or spans the person could see.
- A note contributes the version and visible state that existed at the time. A later revision cannot become context for an earlier edit.
- Tool results, received messages, and application state changes enter the stream when they become available, not when a later export happens to record them.

When precise exposure cannot be reconstructed, the event is marked uncertain or excluded from predictive examples. URLs and object identifiers may remain as navigation metadata even when the underlying content was not observed.

Collectors use a normalized clock and record both when a state change occurred and when a later debounce or collector process finalized its record. Finalization time must never replace the earlier exposure or action-onset time. Cross-application ordering must be stable enough to determine which information preceded an action. A manually replayed sample of sessions is required before modeling to measure missing events, ordering errors, incorrect visible spans, and future leakage.

### 3.2 Snapshot-based human macro-actions

Raw keystrokes are too granular, while commits and final document snapshots are usually too coarse. The prediction target is a bounded human write macro-action:

$$
y_t=(d_t,\ell_t,o_t,c_t),
$$

where $d_t$ is the application or domain, $\ell_t$ is the object location, $o_t$ is the operation, and $c_t$ is the committed content.

Examples include:

- adding or replacing one coherent note span;
- submitting a search;
- sending a prompt or message;
- committing a coherent code or document edit.

The initial Obsidian rule mirrors the vault's current automatic snapshot behavior:

1. The first human text mutation opens a write burst and fixes its `began_at`.
2. Each subsequent human text mutation in that object resets a three-second idle timer.
3. After three seconds without another text mutation, the collector snapshots the object. The diff from the prior finalized snapshot becomes one write event if it is nonempty.
4. Submit, save, focus change, navigation, application shutdown, or another context-changing exposure force the current burst to close without waiting for the timer.

The three-second delay is a deterministic *finalization rule*, not the time at which the action began or its content became available. The record preserves the first mutation time, last mutation time, and later finalization time. This prevents a debounce from moving a human action or a newly visible input across the causal boundary.

The same burst-and-debounce idea applies to viewport changes, but not as one global timer for all keyboard and mouse activity:

- A scroll changes the person's observable information immediately. The collector records viewport state and rendered spans at their actual times, then may consolidate a rapid scroll sequence after three seconds of scroll inactivity. It must preserve all spans exposed during the burst rather than only the final viewport.
- A context-changing scroll, selection, hover panel, tooltip, focus change, or navigation closes any active write burst before the newly exposed information can condition later writing.
- Raw pointer movement that changes nothing in the interface is activity telemetry, not a semantic read event and not automatically a write boundary.
- Timers are per object and modality. Unrelated mouse movement should not silently merge two write bursts or postpone a write boundary.

Three seconds is an initial, versioned hyperparameter. A replayed session audit should compare the resulting boundaries with human judgments and test nearby delays. The goal is not to recover an abstract “turn,” but to construct targets that are both learnable and causally homogeneous: one target should not span an intervening input that changed what the person knew.

Authorship and input method are mandatory. Keyboard/input events, clipboard events, editor transaction metadata, and resulting diffs distinguish independently typed text, pasted text, mixed typed-and-pasted bursts, externally generated text, automatic edits, and tool-written content. A paste may still be a deliberate human action, but it is not evidence that the person generated the pasted tokens. It remains a separately labeled operation available for filtering or for a different prediction target. Only finalized human actions become behavioral-cloning targets.

```text
MacroAction {
  action_id
  source_event_ids
  domain
  location?
  operation
  content_ref
  began_at
  last_mutation_at
  finalized_at
  boundary_reason
  segmentation_version
  input_provenance_summary
  confidence
}
```

### 3.3 Initial collection surfaces

The first implementation covers:

- **Obsidian:** mutation-triggered snapshots and diffs, first and last mutation times, three-second per-object debounce, forced boundaries, object location, visible text, cursor and selection when available, and typed-versus-pasted-versus-external provenance.
- **Browser:** URL, title, navigation, search submissions, visible or consumed spans, focus state, scroll position, media progress, and timestamps.
- **AI chats:** prompts, attachments, branching or regeneration state, rendered response spans, tool results, and token or span availability times.

Historical Obsidian Git history is useful for validating note reconstruction, segmentation, serialization, and training. It does not contain browser or chat context that was never captured, and it must not be treated as a complete historical event stream. Full claims about interleaved read–write context require prospective collection.

Sensitive or excluded content is removed before examples are published to the training store. Privacy state and exclusions remain explicit in the raw-event index so that omissions are auditable without exposing excluded content.

### 3.4 Derived examples and manifests

Each action produces a derived example containing references to the causal events, the exact serialized context, the target, and the target-only loss mask.

```text
BCExample {
  example_id
  context_event_ids
  serialized_context_ref
  target_action_id
  loss_mask_ref
  context_length
  serializer_version
  target_token_count
  finalized_at
}
```

Each overnight update records the parent model, the day cutoff, recent examples, replay examples, optimizer configuration, and resulting model:

```text
DailyUpdateManifest {
  day
  parent_model_version
  resulting_model_version
  data_cutoff_at
  recent_example_ids
  replay_example_ids
  replay_mixture
  context_length
  objective_config_hash
  optimizer_config_hash
  pre_update_report_ref
  retention_report_ref
}
```

These records make it possible to reproduce any daily prediction or update and to determine whether a result came from more context, different data, or different optimizer exposure.

## 4. Training Paradigm

### 4.1 Fixed-length causal context

For a human action $y_t$ beginning at time $t$, first collect all events that were available before action onset:

$$
P_t=\{e_i:\operatorname{available\_at}(e_i)<\operatorname{began\_at}(y_t)\}.
$$

The context is the most recent $L$ tokens of the serialized ordered prefix:

$$
h_t^{(L)}
=
\operatorname{suffix}_L\!\left(
\operatorname{serialize}(\operatorname{sort}(P_t))
\right).
$$

$L$ is the history-token budget. The serializer and deterministic left-truncation rule are versioned. The window may cross day, session, application, and document boundaries. It does not reset at midnight.

There is no retrieval, semantic memory, objective induction, or learned selection in the initial method. If relevant information falls outside the last $L$ tokens, the model does not receive it. Context-length experiments test how strongly this limitation matters.

### 4.2 Daily evaluate-then-update loop

Let $\theta_d$ be the model at the beginning of day $d$. Its weights remain fixed throughout the day.

For every human macro-action $y_{d,i}$:

1. construct the causal context $h_{d,i}^{(L)}$;
2. predict and record the likelihood of the action under $\theta_d$;
3. store the completed action as a new `BCExample`;
4. allow the observed action to enter the causal context of later actions that day;
5. do not update model weights until the day is complete.

The day's examples are therefore test examples for $\theta_d$. After they have all been scored, they become eligible training data for the overnight update.

Let $\mathcal N_d$ be the examples collected on day $d$, and let $\mathcal R_d$ be replay sampled from days before $d$. Overnight training produces:

$$
\theta_{d+1}
=
\operatorname{Update}(\theta_d,\mathcal N_d,\mathcal R_d).
$$

The resulting weights persist. The model does not reset to a generic initialization each morning.

### 4.3 Historical and prospective data use the same loop

Historical activity is replayed in chronological day order:

```text
start from the base model
for each historical day:
    score that day's actions with the current fixed weights
    update overnight on that day plus replay from earlier days
```

Newly collected activity then continues the same lineage without a change in objective, context construction, or update rule.

There is no permanent personal test set in this paradigm. Each day is evaluated before it is learned. Days used while changing segmentation, context length, replay, or optimizer choices form the development stream. For a final reported comparison, the protocol is frozen before a later prospective interval and is not changed until that interval ends. The model still updates after each scored day inside that interval.

### 4.4 Historical replay

Training only on the latest day would allow a dense or unusual session to dominate the model. Replay mixes older examples into every overnight update.

Replay is stratified across:

- time periods;
- applications;
- action families;
- target provenance;
- target length.

The first implementation uses an explicit recent/replay mixture rather than a complicated adaptive policy. Sampling weights, replay capacity, and the number of optimizer steps are recorded in the daily manifest. Replay examples preserve the causal contexts that existed when their targets occurred; they are never rebuilt from later artifact state.

Replay is intended to preserve older workflows, not to freeze the model in the past. Its effectiveness is measured rather than assumed.

### 4.5 Initial model configuration

The first implementation uses [Qwen3.5-9B-Base](https://huggingface.co/Qwen/Qwen3.5-9B-Base) [7] with a 32K-token causal history window. Its weights remain fixed throughout each day and update overnight using that day's scored examples plus historical replay.

Qwen3.5-9B-Base is a nine-billion-parameter base model. It is dense in the routing sense, although its stack is a hybrid of Gated DeltaNet and gated-attention layers rather than a conventional all-full-attention Transformer. The official model card reports a native context length of 262,144 tokens. The initial 32K window is therefore an implementation and compute choice, not the checkpoint's native limit.

Once this baseline works, the ablation matrix in Section 8 varies context length, checkpoint recency, and model family without changing the event construction, causal serialization, or daily evaluation protocol.

## 5. Behavioral-Cloning Objective

For target action tokens

$$
y_t=(y_{t,1},\ldots,y_{t,M_t}),
$$

the log-likelihood under context length $L$ is

$$
\ell_\theta(y_t\mid h_t^{(L)})
=
\sum_{j=1}^{M_t}
\log \pi_\theta
\left(
y_{t,j}
\mid
h_t^{(L)},y_{t,<j}
\right).
$$

The behavioral-cloning loss is:

$$
\boxed{
\mathcal L_{\mathrm{BC}}(\theta;\mathcal D)
=
-\frac{1}{|\mathcal D|}
\sum_{(h,y)\in\mathcal D}
\frac{1}{|y|}
\ell_\theta(y\mid h)
}.
$$

Loss is masked on every context token and applied only to the human target. Read events, earlier human actions, received messages, external model responses, and tool results provide context but do not become targets merely because they appear in the input.

For overnight update $d$:

$$
\boxed{
\mathcal L_d(\theta)
=
\lambda_{\mathrm{recent}}
\mathcal L_{\mathrm{BC}}(\theta;\mathcal N_d)
+
\lambda_{\mathrm{replay}}
\mathcal L_{\mathrm{BC}}(\theta;\mathcal R_d)
}.
$$

The candidate model is initialized from $\theta_d$, optimized on the recent/replay mixture, checked for numerical failure and major capability regression, and then stored as $\theta_{d+1}$. A parameter-efficient adapter is the default initial implementation because it makes daily training, versioning, and rollback tractable; the data and objective are unchanged if later experiments use full-model updates. Practical starting points for LoRA learning rate, batch size, rank, scaling, and epoch count are reported by O'Neill et al. [8]; these are sweep priors rather than assumed optima because their study uses static, judge-filtered SFT data rather than continual personal action data.

The objective estimates behavior. It does not assert that the observed action was optimal, identify a reward function, or require a labeled goal.

## 6. Algorithms

### Algorithm 1: Construct causal next-action examples

```text
procedure BUILD_EXAMPLES(events, context_length, serializer, segmentation):
    ordered <- STABLE_TEMPORAL_SORT(events)
    actions <- SEGMENT_HUMAN_WRITES(ordered, segmentation)
    examples <- []

    for action y in actions:
        if y.confidence < segmentation.minimum_confidence:
            continue

        prior <- events with available_at strictly before y.began_at
        serialized <- serializer(prior)
        h <- TAKE_CAUSAL_SUFFIX(serialized, context_length)
        included <- EVENTS_CONTRIBUTING_TO(h)

        if LEAKS_FUTURE_INFORMATION(h, y):
            continue

        examples.append(BCExample(
            context_event_ids=IDS(included),
            serialized_context=FREEZE(h),
            target_action=y,
            loss_mask=MASK_CONTEXT_AND_SCORE_TARGET(h, y),
            context_length=context_length,
            serializer_version=VERSION(serializer)
        ))

    return examples
```

### Algorithm 2: Evaluate one day

```text
procedure EVALUATE_DAY(model_d, day_events, prior_event_stream, config):
    model_d <- FREEZE_WEIGHTS(model_d)
    stream <- prior_event_stream
    examples <- []
    predictions <- []

    for event_group in CHRONOLOGICAL_ACTION_GROUPS(day_events):
        stream.append(event_group.events_before_action)

        y <- FINALIZED_HUMAN_ACTION(event_group)
        h <- TAKE_CAUSAL_SUFFIX(
            config.serializer(stream events available before y.began_at),
            config.context_length
        )

        prediction <- SCORE_ACTION_BEFORE_UPDATE(model_d, h, y)
        predictions.append(prediction)
        examples.append(FREEZE_BC_EXAMPLE(h, y, config))

        stream.append(events created by y)

    report <- AGGREGATE_PRE_UPDATE_RESULTS_BY_ACTION_AND_DAY(predictions)
    return examples, report, stream
```

### Algorithm 3: Update overnight

```text
procedure OVERNIGHT_UPDATE(model_d, day_examples, replay_index, config):
    replay <- SAMPLE_STRATIFIED_PRIOR_DAYS(
        replay_index,
        strata=(time_period, app, action_family, provenance, target_length),
        budget=config.replay_budget
    )

    candidate <- CLONE_ADAPTER(model_d)

    for batch in PACK_BY_TARGET_AND_CONTEXT_TOKENS(
        day_examples,
        replay,
        config
    ):
        recent_loss <- MASKED_ACTION_NLL(candidate, batch.recent)
        replay_loss <- MASKED_ACTION_NLL(candidate, batch.replay)
        loss <- config.lambda_recent * recent_loss
              + config.lambda_replay * replay_loss
        candidate <- OPTIMIZER_STEP(candidate, gradient(loss))

    retention <- RUN_CAPABILITY_AND_HISTORICAL_CHECKS(candidate, config)

    if OPTIMIZATION_FAILED(candidate) or MAJOR_CAPABILITY_REGRESSION(retention):
        return model_d, replay_index

    model_next <- STORE_IMMUTABLE(candidate)
    replay_index <- ADD_EXAMPLES(replay_index, day_examples)
    STORE_DAILY_UPDATE_MANIFEST(
        parent=model_d,
        result=model_next,
        recent=day_examples,
        replay=replay,
        retention=retention,
        config=config
    )
    return model_next, replay_index
```

## 7. Evaluation

### 7.1 Primary measurement

The primary metric is pre-update action-token negative log-likelihood. For each day, first average target-token loss within each action and then average across actions. Report the distribution across days so that one long editing session does not masquerade as many independent successes. Raw token-level losses are compared only when tokenization and probability access are compatible; cross-model comparisons also use the action-level metrics available for every condition.

Secondary measurements include:

- operation accuracy;
- location accuracy;
- exact or semantic top-$k$ inclusion when generation is evaluated;
- performance by application, action family, target length, and provenance.

All model and context-length comparisons are paired on identical actions and use the same chronological evaluate-then-update protocol.

### 7.2 Minimal baselines and controls

The experimental program compares:

1. last-action, common-action, and edit-location heuristics;
2. the same base model with only the current artifact;
3. the same model with the correct trailing personal event stream;
4. the same model with shuffled, wrong-time, or timestamp-damaged history;
5. the continually adapted model with correct history.

The comparison should show whether the event stream adds content-predictive signal beyond repetition, location, and writing style. Wrong-time controls test the temporal construction directly: if damaged chronology performs as well as correct chronology, the collector is not supplying the hypothesized signal.

The context, checkpoint, and model-capability comparisons are defined separately in the experiment matrix in Section 8.

### 7.3 Continual-learning measurements

Track:

- pre-update prediction loss by day;
- improvement or regression after each overnight update;
- current-day prediction under checkpoints with data cutoffs one, three, and seven days earlier;
- performance when older applications and action families recur;
- performance by recency of the relevant history;
- a small static suite for reasoning, instruction following, tool use, and unfamiliar tasks;
- the effect of recent/replay mixture on adaptation and retention.

Replay succeeds when current prediction improves without systematic degradation on recurring older behavior or the external capability suite.

### 7.4 Development and prospective reporting

Historical days used while the protocol is being changed are development data even though every action is scored before training. Once segmentation, serializer, context lengths, replay mixture, optimizer, and metrics are fixed, the complete daily loop is run over a later prospective interval without changing those choices.

This is not a static held-out test set. After a prospective day is scored, its examples enter that night's update and may improve prediction on later prospective days. The reported result is the chronological sequence of losses produced by the frozen evaluate-then-update protocol.

## 8. Initial Experimental Program

### Experiment 0: Collector and reconstruction audit

Manually replay sampled sessions from each source. Measure missing-event rate, temporal-ordering error, incorrect visible-span rate, authorship error, action-boundary disagreement, and future leakage. Modeling does not begin until the stream is adequate to construct causal examples.

### Experiment 1: Obsidian-only smoke test

Use historical note edits to validate temporal reconstruction, macro-action segmentation, serialization, masked loss, daily processing, and overnight replay. Compare trivial baselines, current-note context, and trailing note history. This is a pipeline test, not evidence for the full read–write thesis.

### Experiment 2: Prospective interleaved stream

Collect Obsidian, browser, and AI-chat events prospectively. Test whether correctly timed read and write history improves next-action prediction over the current artifact and damaged-history controls.

### Experiment 3: Ablation matrix

All seven comparisons use the same live daily protocol. On a given day, every condition scores the same actions in the same order before any weight update. Earlier actions from that day enter the causal context for later actions. Cross-model contexts are frozen by event IDs and serialized text so that every model receives the same information, regardless of tokenizer. Open-model updates occur only after the complete day has been scored.

**Learning Objective**. Replace token level cross entropy loss + behavior cloning with cosine similarity on the embeddings of the ground truth and predicted outputs as the reward for GRPO or RLOO. This compares the rigidity and accuracy of behavior cloning on sequence likelihoods with the flexibility and semanticity of cosine similarity reward maximization.

**Time Data**. Include the timestamp into the data, otherwise training normally. This determines whether the inclusion of timestamps impacts model performance by introducing a potential understanding of how delays impact thinking.

**Checkpoint recency.** On day $d$, score every action using the current checkpoint and retained checkpoints from $d-1$, $d-3$, and $d-7$. All remain frozen throughout the day and receive the identical causal event-stream context. This measures the predictive value of recent overnight updates and reveals when those updates hurt current-day prediction.

**Context scaling.** Compare 8K, 16K, 32K, and 64K causal windows using matched Qwen3.5-9B-Base lineages, with 32K as the initial baseline. Action targets, day boundaries, recent/replay sampling, target-token exposure, and optimizer steps remain matched. “More data” here means more prior event-stream data in context, not more historical training examples. This alludes to discussions around what 'model capabilities' even mean when discussed broadly. Are 64K and 8K context windows both 'model capabilities'? How do we normalize for prompt quality or available tools?

**Sliding window versus context retrieval.** At the fixed 32K baseline context budget, compare the trailing 32K causal prefix against a context containing the most recent 16K tokens plus 16K tokens retrieved from the earlier causally available history. BM25 uses the serialized recent 16K token prefix as its query, and fetched items are chronologically packed into context. Because a long event-stream query may be dominated by generic interface language, query preprocessing removes or downweights common interface boilerplate using a fixed rule established before prospective evaluation. This tests whether selecting related older events is more predictive than allocating the entire context budget to contiguous recent history. Dense, hybrid, reranked, learned, embedded, LongNAP-style reasoned retrieval, and agent-controlled retrieval tool use are possible later extensions but are outside the initial ablation matrix.

**Practical system comparison.** Compare continually updated Qwen3.5-9B-Base against frontier closed models using ICL only, with identical contexts and targets. This asks whether personal weight updates allow the local open model to compete with a stronger frozen API model and quantifies the distinction in usefulness between having access to all necessary context and true judgment from actually predicting next actions, since two contexts lead to different results due to different weights.

**Closed-model scaling.** Compare less-capable and frontier closed models, all using ICL only. This tests whether greater closed-model capability improves personal next-action prediction when the model cannot receive personal weight updates. 

**Open-model scaling.** Compare Qwen3.5-9B-Base with stronger open models using the same continual-training and replay recipe. Where feasible, also score each open model without personal weight updates. This tests whether greater open-model capability improves baseline prediction and whether it changes the value obtained from continual weight updates.

For the context and open-model conditions, also report adaptation after overnight training, older-workflow retention, general capability retention, and training cost. Dense-versus-MoE behavior, active and total parameters, memory, and throughput are secondary model-level analyses.

Phase 1 succeeds when the collector produces auditable causal examples and the continually trained model obtains a repeatable improvement on future daily actions from correct personal history. The gain should increase or remain useful with longer context, survive trivial and wrong-time controls, and avoid unacceptable forgetting.

## 9. Implementation Order

1. define the event, macro-action, example, and daily-manifest schemas;
2. implement append-only Obsidian collection and clock normalization;
3. reconstruct historical note edits and audit macro-action segmentation;
4. implement the deterministic serializer and fixed causal suffix;
5. build the masked behavioral-cloning dataset and baseline harness;
6. implement the daily evaluate-then-update loop;
7. add stratified historical replay and immutable model lineage;
8. run the Obsidian smoke test;
9. add prospective browser and AI-chat collection;
10. run the interleaved-stream and context-length experiments;
11. add lagged-checkpoint, closed-model ICL, and stronger open-model comparisons after the Qwen3.5-9B-Base baseline is stable;
12. monitor continual prediction and capability retention.

The required initial artifacts are the collector specification, privacy and exclusion policy, segmentation guide, reconstruction audit, serializer, immutable example store, leakage tests, baseline harness, daily update manifest, replay index, capability-retention suite, and model card for each accepted lineage.

## 10. Conclusion

Phase 1 asks whether one person's ordinary computer activity can train a continually improving predictor of what they will write next. The hard prerequisite is a faithful event stream: what was actually visible, when it became available, what the person authored, and where one coherent action ended.

The learning rule is simple. A fixed-length suffix of prior events predicts the next human macro-action. The model is evaluated without weight changes throughout the day. Overnight, that day's scored examples are mixed with historical replay and used for behavioral cloning. The resulting weights persist into the next day. Historical and future data follow the same loop.

If this works, the result is a validated data substrate and a personal behavioral model whose performance can be measured continuously as context, experience, and current work change. If it does not, the daily losses and auditable event lineage should make the failure attributable to collection, action construction, context length, optimization, or forgetting rather than hidden inside a more complicated system.

## References

[1] M. Carroll et al. [*On the Utility of Learning about Humans for Human-AI Coordination*](https://arxiv.org/abs/1910.05789). 2019.

[2] F. Matti, P. Dillenbourg, and L. Novelli. [*A Click Ahead: Real-Time Forecasting of Keyboard and Mouse Actions using RNNs and Computer Vision*](https://arxiv.org/abs/2309.12170). 2023.

[3] O. Shaikh et al. [*Learning Next Action Predictors from Human-Computer Interaction*](https://arxiv.org/abs/2603.05923). 2026.

[4] B. Krause, E. Kahembwe, I. Murray, and S. Renals. [*Dynamic Evaluation of Transformer Language Models*](https://arxiv.org/abs/1904.08378). 2019.

[5] A. Tandon et al. [*End-to-End Test-Time Training for Long Context*](https://arxiv.org/abs/2512.23675). 2025.

[6] X. Jin et al. [*Lifelong Pretraining: Continually Adapting Language Models to Emerging Corpora*](https://arxiv.org/abs/2110.08534). 2022.

[7] Qwen Team. [*Qwen3.5-9B-Base Model Card*](https://huggingface.co/Qwen/Qwen3.5-9B-Base). 2026.

[8] C. O'Neill, M. Jayasekara, and H. Partridge. [*Post-Training Science for Supervised Fine-Tuning*](https://www.datocms-assets.com/104802/1781805778-baseten-research-sft.pdf). 2026.
