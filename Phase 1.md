
*Continual next-action learning from personal read–write streams*

**Status:** Working research and implementation plan. This document specifies the data substrate, live prediction surface, behavioral-cloning objective, daily scoring and update loop, and initial experiments for Phase 1.

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

Phase 1 builds that stream and applies behavioral cloning to it. Each example contains a fixed-length causal history plus the observed destination, semantic cursor context, and current clipboard state immediately before an action, followed by a structured write completion. Authored text, grounded paste actions, and a structural end-of-sequence token receive loss; copied payload tokens do not, although their resolved content and provenance remain available in later history.

During live use, the model is queried when a text field receives focus and its predicted write completion is shown to the user for qualitative inspection. Grounded action markers such as paste are rendered by the interface rather than displayed as literal text. The displayed prediction is captured in the raw stream as a model-authored read event but excluded from the Phase 1 dataset. Modeling how the prediction changes later human behavior begins in Phase 2.

Learning is continual. During a day, the model's weights remain fixed while every action is scored from the sliding causal context. Overnight, that day's examples become training data and are mixed with replay from earlier days. The resulting weights initialize the next day. Historical data can be processed through the same chronological loop when its causal inputs are sufficiently complete. Each action contributes a pre-update loss before it is allowed to train a later model.

The first goal is deliberately narrow: implement a temporally faithful event collector, construct reliable write-completion targets, establish that personal history improves next-write prediction, measure how performance changes with context length and continual adaptation, and observe whether repeated updates erase older behavior.

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

Matti et al. predict one user's keyboard and mouse actions from a short discrete history [2]. Shaikh et al. study next-action prediction from naturalistic computer-use streams and compare prompting, retrieval, supervised adaptation, and learned reasoning–retrieval methods [3]. These works provide the closest task-level precedents and useful baselines for event construction and action prediction. This work is a more rigorous decomposition and test of the same direction.

Dynamic evaluation updates a language model on recent tokens before predicting later tokens in the same stream [4]. End-to-End Test-Time Training extends this idea by meta-learning an initialization that is explicitly optimized for online next-token updates and by using weight updates to carry information beyond a sliding attention window [5]. Phase 1 uses the same score-before-update principle at a different boundary: human write events are scored throughout a day, and ordinary behavioral-cloning updates occur overnight. The model state persists across days and historical replay is included.

Lifelong pretraining studies chronological adaptation to emerging corpora while measuring performance on both new and earlier distributions [6]. Its stability–plasticity problem is directly relevant: recent data should update the personal model without allowing one project or period to erase older workflows or general language-model capabilities.

## 3. Data Construction - WIP, driven by [[Data]]

The data construction is not solved by writing down an event schema in advance. The first job is to build a sensor, use the computer normally, and inspect whether its output looks like a faithful account of what was read and written. The representation should change in response to failures observed in real traces.

The north star is qualitative temporal fidelity: the stored stream should approximate the information that was available to the person and the output the person produced, in the order in which this happened. Relevance to next-write prediction is the practical test. If a trace omits information that obviously mattered, includes information the person did not see, or breaks one action into nonsensical pieces, the sensor or conversion rule is wrong.

### 3.1 Sensor iteration loop

The first implementation should include a separate debugging window that is excluded from collection and displays the stream being stored. The loop is:

1. deploy the smallest useful sensor set across Obsidian, Chrome, and Codex;
2. do normal work;
3. watch the resulting read/write stream in the debugging window;
4. compare it with the actual experience of reading and writing;
5. fix snapshotting, extraction, delay, deduplication, or event construction;
6. repeat for at least a day or two before treating the output as training data.

The raw representation should initially preserve more information than seems necessary. Different algorithms may need different derived structures, and premature filtering may permanently remove the evidence needed to construct them. Raw snapshots, input signals, timestamps, source information, and later interpretations should remain distinguishable.

### 3.2 Candidate snapshot triggers

The initial sensor uses delays to reduce noise and to obtain a rough signal of attention:

- after keyboard input, wait `WRITE_DELAY` seconds—perhaps three—without additional input before taking a write snapshot;
- after a mouse movement, click, or scroll, wait `READ_DELAY` seconds—perhaps one—before taking a read snapshot.

These are starting points to tune through the debugging display, not settled action boundaries. The write delay should remove some noise from backspacing, typo correction, and cursor movement. The read delay should avoid treating content passed during a fast scroll as though it were read. Both introduce failure modes:

- text written and deleted inside the delay may disappear from a final diff;
- multiple meaningful actions may occur inside one delay window;
- a short but meaningful exposure may be missed;
- a delayed snapshot may capture a later state rather than the state that triggered it;
- keyboard and mouse activity may interact in ways that make a single global timer misleading.

The collector should therefore retain the triggering input events and their times in addition to the later snapshot. Whether the final event time should be the trigger, the settled state, or both is an empirical decision. The same applies to whether a burst becomes one action or several.

### 3.3 What a snapshot should contain

A read snapshot should contain the text the person was likely looking at, not every token technically present in the application or page. For the first version:

- ignore unselected or unfocused windows;
- prefer application, accessibility, or DOM text corresponding to the active viewport when available;
- otherwise experiment with a central screen crop that removes peripheral interface chrome;
- ignore audio and video initially;
- retain cursor, selection, viewport, focus, and application metadata when available.

The crop and focus rules are hypotheses to inspect, not claims about attention. Clicking into an Obsidian note may make the surrounding text relevant again, but it is not yet clear whether that should create a repeated read event. Similarly, scrolling back to a previously seen span may be meaningful rereading rather than duplicate data.

The viewed snapshot and the complete underlying resource must remain separate. A browser event should retain the full URL and may retain or later fetch the complete page for reconstruction or retrieval, while the read stream contains only the view that the sensor believed was exposed. Opening a URL is not evidence that the complete article was read. HTML can be converted to Markdown with tools such as Readability or Trafilatura, but this conversion does not resolve what portion belonged in the snapshot.

### 3.4 From snapshots to a read/write stream

The initial stored form can be JSON. It should be easy to inspect and contain enough information to re-run later conversion rules. Candidate fields include:

- timestamp or timestamps;
- read/write candidate;
- author or source;
- application and destination;
- application-specific location, such as an Obsidian path;
- optional full link or resource reference;
- extracted Markdown content;
- raw snapshot and input-event references;
- collector and conversion versions.

This is not yet the final event ontology. Navigation, focus changes, deletions, selections, automatic edits, and externally generated writes may eventually require additional types rather than being forced into a read/write Boolean.

Successive snapshots will often overlap. Deduplication should remove repeated content created by continuous capture without erasing a later return to the same material. The first implementation should preserve enough raw information to compare alternatives:

- remove overlap only between nearby snapshots that appear to represent one continuous exposure;
- retain a later reread, or encode it as a new exposure to the same content;
- test whether duration and repetition are useful signals rather than assuming repeated text is always noise.

Write events require similar iteration. Diffs between snapshots can consolidate raw keystrokes into useful chunks, but the collector must distinguish typing, pasting, mixed input, automatic edits, and model-authored text. Cursor movement, insertion into earlier text, deletion, and a draft that is completely removed are all cases to inspect in the debugging stream. A final empty diff should not silently prove that nothing behaviorally relevant happened. Clipboard observations and copy commands remain raw conditioning evidence rather than creating a third COPY event: the derived Phase 1 event stream remains READ and WRITE.

### 3.5 Initial surfaces and prediction opportunity

The initial surfaces are:

- Obsidian;
- browser use;
- Codex and other AI-chat interfaces.

All three surfaces are collected prospectively from the beginning so that their causal interleaving is preserved. Collection scope is separate from training scope: the first training and pipeline smoke tests may use only the Obsidian projection, without delaying Chrome or Codex collection.

Audio and video can be added after the text stream is credible. Historical Obsidian Git history is useful for testing reconstruction and diff logic, but it cannot substitute for a prospective interleaved stream because it omits browser and chat inputs.

The live model is queried when a text field receives focus outside the prediction model itself. It samples a structured write completion from the causal history plus the destination, semantic cursor context, and current clipboard state available at that moment, then displays that completion to the user. A predicted paste action is bound to the conditioned pasteboard version and is invalidated or regenerated if the clipboard changes. This focus trigger determines when a prediction is shown; it does not define the supervised training boundary. Training examples are separately constructed from the causal history and pre-mutation conditioning available before each write action actually begins. Before live prediction is implemented, the interface must capture the same destination, cursor, and clipboard query at focus time. The existing first-mutation snapshot validates offline dataset construction but cannot substitute for focus-time conditioning, and cursor, selection, or clipboard changes between focus and writing remain train–serve differences to measure.

A displayed prediction becomes information the person has read. It is therefore stored in the raw stream as a model-authored read event, but the frozen Phase 1 conversion marks it as excluded: it does not enter Phase 1 contexts, targets, or replay. Phase 2 can add these events back when it begins modeling how suggestions influence subsequent behavior. During Phase 1, the predictions are shown only for informal human inspection; no preference label or explicit response model is constructed.

The first implementation may use remote models and storage to iterate quickly and make larger-model comparisons practical. The collector still needs explicit exclusions and provenance so that sensitive data and model-authored content can be identified rather than silently mixed into human targets.

### 3.6 Freezing a version for training

Only after the sensor produces a convincing stream should one snapshot-to-event conversion be frozen for an experiment. That version converts the richer records into chronologically ordered read/write events and constructs candidate write targets. The exact segmentation remains versioned because changing delay, deduplication, or diff rules changes the learning problem.

Each converted write keeps observed pre-mutation state distinct from the human output. The conditioning state contains the destination, bounded semantic context around the initial caret or selection, and current clipboard state; it is appended to the causal history as model input. The WRITE event retains the exact resolved net content and structured authorship provenance. In the Phase 1 target, authored spans are tokenized normally and each Cmd-V span proven to use the conditioned clipboard becomes the reserved `<|paste|>` marker encoded by the selected model's unchanged tokenizer. The pasted payload receives no target loss, but its resolved content and paste provenance remain in the event and in subsequent history. The model loader maps the structured segments, appends exactly one EOS token from the selected tokenizer, and applies loss to authored tokens, paste-marker tokens, and EOS. EOS is a structural terminator, not captured human content. Operation, removed content, provenance, and net edit offset remain event metadata for reconstruction, audit, later context, evaluation strata, and possible later objectives, but receive no Phase 1 loss. Numeric cursor offsets are retained as diagnostics but neither alter the canonical diff nor impose a separate eligibility gate when complete range-native semantic cursor context is available. The conservative conversion excludes pure deletions, incomplete semantic conditioning, unresolved authorship, and legacy writes with paste evidence that cannot be segmented, while retaining otherwise verified WRITE events in subsequent causal history. Action and capture timestamps remain example metadata, and whether temporal information should appear in model inputs is tested separately.

The historical model context may contain only Phase 1-eligible records available before the action boundary chosen by the conversion version. The conversion must explicitly assign and document any `available_at` timestamp used for a derived input event and any `began_at` timestamp used for a candidate write target; these are decisions made by the frozen conversion, not timestamps silently inferred from snapshot finalization. Prior WRITE serialization retains resolved pasted content together with its paste provenance, because that content was present in the artifact and may condition later actions even though it received no loss when originally pasted. The pre-mutation conditioning state is separately admitted as observed query state: the active tap captures it after intercepting the first input but before returning that mutation to the application, and it must not be silently backdated as an ordinary history event. Each training example stores the exact derived history, query, complete model input, structured target segments, resolved outcome metadata, source records, conversion version, and target-mask contract. The model-facing history serializer is intentionally compact: READ text appears once as top-level content; a structured WRITE's resolved text appears once across provenance-bearing authorship segments rather than being duplicated as top-level content; semantic source or destination, write operation, and nonempty removal remain available. Collector identifiers, numeric offsets, boundary reasons, redundant resolved text, and sensor provenance remain in a separate audit projection. The tokenizer-specific loader packs the newest complete serialized event blocks plus the complete query within the input budget. If the oldest retained event crosses the boundary, only its semantic text tail may be retained behind an explicit truncation marker; a structured WRITE retains the authorship types of the surviving segments, and malformed partial JSON is never emitted. The loader then tokenizes authored segments and the reserved `<|paste|>` marker without automatic special tokens or vocabulary modification, appends exactly one tokenizer EOS token, and masks loss onto authored tokens, paste-marker tokens, and EOS. The packing manifest distinguishes the history-plus-query input budget from total training-sequence capacity: the target is appended outside the input budget and must never be silently truncated. The daily update manifest separately records the parent model, data cutoff, recent and replay examples, optimizer configuration, and resulting model. These are algorithm-specific derived records, not the authoritative form of the raw activity.

**Causal dataset construction is a required conversion step.** JSONL append order, sequence number, and collector emission time must never be used as the training chronology. A write may be appended only after `WRITE_DELAY`, while a read observed during that write may be appended earlier. Treating all earlier file records as context would therefore allow information captured after the action began—and potentially part of the target itself—to enter the model input.

The frozen conversion must assign event times from the underlying evidence and construct every example by time, for example:

```text
procedure BUILD_CAUSAL_EXAMPLE(converted_events, target_write, config):
    target_start <- target_write.began_at

    prior <- events in converted_events where
             PHASE1_ELIGIBLE(event) and
             event.available_at < target_start

    ordered_prior <- STABLE_TEMPORAL_SORT(prior)
    serialized_events <- MAP(config.model_serializer, ordered_prior)
    query <- SERIALIZE_PRE_MUTATION_CONDITIONING(target_write)
    model_input <- PACK_EVENT_SUFFIX(
        serialized_events,
        query,
        tokenizer=config.tokenizer,
        token_budget=config.context_length,
        oldest_oversized_event="explicit_authorship_preserving_text_tail"
    )
    history <- HISTORY_PORTION(model_input)

    return FREEZE_EXAMPLE(
        context=history,
        query=query,
        model_input=model_input,
        target=BUILD_STRUCTURED_WRITE_TARGET(target_write.authorship_segments),
        source_event_ids=IDS(EVENTS_CONTRIBUTING_TO(history)),
        conversion_version=config.conversion_version
    )
```

For the initial conservative conversion, a read's `available_at` should be the screen-capture time recorded by the sensor (currently approximated by `settledAt`), not OCR completion or JSONL emission time. A write target's `began_at` should be its first mutating input time. A completed prior write receives a separately defined terminal `available_at` from the frozen conversion; it must not become context merely because its derived record happens to appear earlier in the file. The exact timestamp mapping may be revised between conversion versions, but the filter `event.available_at < target_write.began_at` is mandatory. For example, if a Codex write begins at 13:36:24.882, a read captured at 13:36:25.808 is excluded from that write's context even when the read is physically written to `events.jsonl` before the delayed write record.

## 4. Training Paradigm

### 4.1 Fixed-length causal context

For a human action $y_t$ beginning at time $t$, first collect all events that were available before action onset:

$$
P_t=\{e_i:\operatorname{available\_at}(e_i)<\operatorname{began\_at}(y_t)\}.
$$

Let $q_t$ be the serialized observed destination, semantic cursor state, and current clipboard state. Let $\operatorname{pack}_L$ retain the newest complete serialized event blocks plus the complete query within $L$ tokens, with explicit content-tail truncation only for the oldest retained oversized event. The model input is:

$$
h_t^{(L)}
=
\operatorname{pack}_L\!\left(
\operatorname{serialize}(\operatorname{sort}(P_t)), q_t
\right).
$$

$L$ is the total history-plus-query input-token budget, so the query consumes part of it and remains at the right edge while older complete events are removed first. Target tokens are appended outside $L$; the training harness must provide the resulting total sequence capacity and may not truncate the target. The serializer, event delimiter, explicit oversized-event marker, and deterministic packing rule are versioned. The history window may cross day, session, application, and document boundaries. It does not reset at midnight.

There is no retrieval, semantic memory, objective induction, or learned selection in the initial method. If relevant information falls outside the last $L$ tokens, the model does not receive it. Context-length experiments test how strongly this limitation matters.

### 4.2 Daily score-then-update loop

Phase 1 uses two different triggers deliberately. Live generation occurs when a text field receives focus. Supervised scoring and training use the causal prefix immediately before the resulting write action begins. The earlier focus-time query is a user-interface decision; it does not redefine which preceding information belongs to the training example.

Let $\theta_d$ be the model at the beginning of day $d$. Its weights remain fixed throughout the day.

For every human write event $y_{d,i}$:

1. construct the causal context $h_{d,i}^{(L)}$;
2. predict and record the likelihood of the action under $\theta_d$;
3. store the completed action as a frozen training example;
4. allow the observed action to enter the causal context of later actions that day;
5. do not update model weights until the day is complete.

The day's examples provide a pre-update loss trace for $\theta_d$. After they have all been scored, they become eligible training data for the overnight update.

Let $\mathcal N_d$ be the examples collected on day $d$, and let $\mathcal R_d$ be replay sampled from days before $d$. Overnight training produces:

$$
\theta_{d+1}
=
\operatorname{Update}(\theta_d,\mathcal N_d,\mathcal R_d).
$$

The resulting weights persist. The model does not reset to a generic initialization each morning. A once-daily update is the deliberate initial baseline: it keeps the collection period stationary, makes model lineage legible, and permits batched training. It is not a claim that one day is the optimal update interval.

### 4.3 Historical and prospective data use the same loop

Historical activity is replayed in chronological day order:

```text
start from the base model
for each historical day:
    score that day's actions with the current fixed weights
    update overnight on that day plus replay from earlier days
```

Newly collected activity then continues the same lineage without a change in objective, context construction, or update rule. This applies only where the historical source contains enough information to reconstruct the required causal examples. Existing Obsidian Git history is a pipeline test, not a substitute for the prospectively captured interleaved stream.

The initial run is developmental: segmentation, context length, replay, and optimizer choices may change between days, with each version recorded alongside its loss trace. A later robust comparison can freeze those choices before a prospective interval. The model can still update after each scored day inside that interval.

### 4.4 Historical replay

Training only on the latest day would allow a dense or unusual session to dominate the model. Replay mixes older examples into every overnight update.

The initial replay policy is deliberately simple. Once the conversion schema has been frozen, replay is stratified using stable fields actually present in the data, initially:

- time periods;
- applications;
- target provenance;
- target length.

The first implementation uses an explicit recent/replay mixture rather than an adaptive policy. Sampling weights, replay capacity, strata, and the number of optimizer steps are recorded in the daily manifest. Replay examples preserve the causal contexts that existed when their targets occurred; they are never rebuilt from later artifact state.

Replay is intended to preserve older workflows, not to freeze the model in the past. Its effectiveness is measured rather than assumed.

### 4.5 Initial model configuration

The first implementation uses [Qwen3.5-9B-Base](https://huggingface.co/Qwen/Qwen3.5-9B-Base) [7] with a 32K-token causal history window. Its weights remain fixed throughout each day and update overnight using that day's scored examples plus historical replay.

Qwen3.5-9B-Base is a nine-billion-parameter base model. It is dense in the routing sense, although its stack is a hybrid of Gated DeltaNet and gated-attention layers rather than a conventional all-full-attention Transformer. The official model card reports a native context length of 262,144 tokens. The initial 32K window is therefore an implementation and compute choice, not the checkpoint's native limit.

Once this baseline works, the ablation matrix in Section 7 varies context length, checkpoint recency, and model family without changing the event construction, causal serialization, or daily scoring protocol. The once-daily LoRA update with explicit replay is a deliberate baseline against which more complicated continual-learning methods can later be compared.

## 5. Behavioral-Cloning Objective

For the tokenizer-specific serialization of the structured write target—authored spans tokenized normally, each grounded paste represented by the reserved `<|paste|>` marker encoded with the unchanged tokenizer, and exactly one EOS token appended by the loader—

$$
y_t=(y_{t,1},\ldots,y_{t,M_t}),
$$

where $y_{t,M_t}=\langle\mathrm{EOS}\rangle$, let $m_{t,j}=1$ for every authored token, paste-marker token, and EOS token. Resolved pasted payload tokens are omitted from the target rather than masked in place. Destination, cursor state, clipboard state, timestamps, operation, removed content, and edit offset are query state or example metadata rather than target fields. The masked log-likelihood under context length $L$ is

$$
\ell_\theta(y_t\mid h_t^{(L)})
=
\sum_{j=1}^{M_t}
m_{t,j}
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
\frac{1}{\sum_j m_j}
\ell_\theta(y\mid h)
}.
$$

Loss is masked on every model-input token and applied to authored target tokens, every existing-vocabulary token spelling the reserved marker for each grounded paste action, and the single loader-appended EOS token. Read events, earlier human actions, resolved pasted payloads, received messages, external model responses, tool results, destination, initial cursor state, clipboard state, and edit metadata provide input or audit evidence but do not become targets merely because they are available. Model predictions displayed during Phase 1 are excluded from the Phase 1 context as well as from its targets.

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

The candidate model is initialized from $\theta_d$, optimized on the recent/replay mixture, checked for numerical failure, and then stored as $\theta_{d+1}$ together with update diagnostics. A parameter-efficient adapter is the default initial implementation because it makes daily training, versioning, and rollback tractable; the data and objective are unchanged if later experiments use full-model updates. Practical starting points for LoRA learning rate, batch size, rank, scaling, and epoch count are reported by O'Neill et al. [8]; these are sweep priors rather than assumed optima because their study uses static, judge-filtered SFT data rather than continual personal action data.

The objective estimates behavior. It does not assert that the observed action was optimal, identify a reward function, or require a labeled goal.

## 6. Algorithms

### Algorithm 1: Display a prediction when a text field receives focus

```text
procedure PREDICT_ON_FOCUS(model_d, raw_stream, focus_event, config):
    converted <- APPLY_FROZEN_CONVERSION(
        raw_stream,
        cutoff=focus_event.time,
        version=config.conversion_version
    )
    eligible <- PHASE1_ELIGIBLE(converted)
    query <- SERIALIZE_FOCUS_CONDITIONING(focus_event)
    h <- PACK_EVENT_SUFFIX(
        MAP(config.model_serializer, STABLE_TEMPORAL_SORT(eligible)),
        query,
        tokenizer=config.tokenizer,
        token_budget=config.context_length,
        oldest_oversized_event="explicit_content_tail"
    )

    predicted_completion <- GENERATE_WRITE_COMPLETION_UNTIL_EOS(model_d, h, config)
    DISPLAY_WRITE_COMPLETION(predicted_completion)

    raw_stream.append(MODEL_READ_EVENT(
        content=RENDERED_CONTENT(predicted_completion),
        actions=GROUNDED_ACTIONS(predicted_completion),
        available_at=DISPLAY_TIME(),
        excluded_from_phase1=true
    ))

    return predicted_completion
```

### Algorithm 2: Construct and score one day

```text
procedure BUILD_AND_SCORE_DAY(model_d, frozen_events, config):
    model_d <- FREEZE_WEIGHTS(model_d)
    examples <- []
    losses <- []

    actions <- HUMAN_WRITE_EVENTS(frozen_events)
    for y in STABLE_TEMPORAL_SORT(actions):
        prior <- events in frozen_events where
                 PHASE1_ELIGIBLE(event) and
                 event.available_at < y.began_at
        serialized_events <- MAP(config.model_serializer, STABLE_TEMPORAL_SORT(prior))
        query <- SERIALIZE_PRE_MUTATION_CONDITIONING(y)
        h <- PACK_EVENT_SUFFIX(
            serialized_events,
            query,
            tokenizer=config.tokenizer,
            token_budget=config.context_length,
            oldest_oversized_event="explicit_authorship_preserving_text_tail"
        )
        included <- EVENTS_CONTRIBUTING_TO(HISTORY_PORTION(h))

        if y.content is empty or
           not HAS_COMPLETE_SEMANTIC_CONDITIONING(y) or
           not HAS_RESOLVED_AUTHORSHIP(y):
            RETAIN_AS_HISTORY_BUT_SKIP_TARGET(y)
            continue
        target <- BUILD_STRUCTURED_WRITE_TARGET(y.authorship_segments)
        training_target <- LOAD_PHASE1_TARGET(
            target,
            paste_marker="<|paste|>",
            eos_token_id=config.tokenizer.eos_token_id,
            add_special_tokens=false
        )
        target_mask <- MASK_ALL_TOKENS(training_target)
        loss <- MASKED_TARGET_NLL(model_d, h, training_target, target_mask)
        losses.append(loss)

        examples.append(FREEZE_TRAINING_EXAMPLE(
            context=HISTORY_PORTION(h),
            query=query,
            model_input=h,
            target=target,
            target_mask=target_mask,
            source_event_ids=IDS(included),
            conversion_version=config.conversion_version,
            serializer_version=VERSION(config.serializer)
        ))

    return examples, AGGREGATE_DAILY_LOSS(losses)
```

### Algorithm 3: Update overnight

```text
procedure OVERNIGHT_UPDATE(model_d, day_examples, replay_index, config):
    replay <- SAMPLE_STRATIFIED_REPLAY(
        replay_index,
        strata=config.replay_strata,
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

    if OPTIMIZATION_FAILED(candidate):
        return model_d, replay_index

    diagnostics <- RECORD_UPDATE_DIAGNOSTICS(model_d, candidate, config)
    model_next <- STORE_IMMUTABLE(candidate)
    replay_index <- ADD_EXAMPLES(replay_index, day_examples)
    STORE_DAILY_UPDATE_MANIFEST(
        parent=model_d,
        result=model_next,
        recent=day_examples,
        replay=replay,
        diagnostics=diagnostics,
        config=config
    )
    return model_next, replay_index
```

## 7. Initial Experimental Program

The initial program is exploratory. Live predictions are displayed and judged informally while pre-update loss provides the quantitative trace. The first purpose of the ablations is to see whether changing the data, context, objective, or checkpoint causes interpretable changes in loss and in the apparent quality of sampled predictions. Robust competitive baselines and a formal human-evaluation protocol come after the data and training pipeline are credible.

### Experiment 0: Collector and reconstruction audit

Build the debugging display and run minimum viable Obsidian, Chrome, and Codex sensors during ordinary work. Inspect the resulting snapshots and derived stream against the actual experience, then revise delays, crops, extraction, deduplication, provenance, and event boundaries. Once the qualitative output is credible, manually replay sampled sessions and measure missing-event rate, temporal-ordering error, incorrect content inclusion, authorship error, action-boundary disagreement, and future leakage. Modeling does not begin until one conversion version is frozen.

### Experiment 1: Obsidian-only smoke test

Project the already collected stream down to Obsidian events, together with historical note edits where useful, to validate temporal reconstruction, write-event construction, serialization, masked loss, daily processing, and overnight replay. Compare current-note context with trailing note history and inspect the resulting loss and predictions. This is a pipeline test, not evidence for the full read–write thesis or a competitive baseline.

### Experiment 2: Prospective interleaved stream

Use the prospectively collected interleaved Obsidian, Chrome, and Codex stream. Display focus-triggered predictions for qualitative inspection while excluding those prediction events from the Phase 1 dataset. Test whether correctly timed read and write history improves pre-update loss over the current artifact and damaged-history controls.

### Experiment 3: Ablation matrix

All nine comparisons use the same live daily protocol. On a given day, every condition scores the same actions in the same order before any weight update. Earlier actions from that day enter the causal context for later actions. Cross-model contexts are frozen by event IDs and serialized text so that every model receives the same information, regardless of tokenizer. Open-model updates occur only after the complete day has been scored.

**Learning Objective**. Replace token-level cross-entropy loss and behavioral cloning with cosine similarity on the embeddings of the ground-truth and predicted resolved write content as the reward for GRPO or RLOO. This compares sequence-likelihood training with semantic-similarity reward maximization.

**Time Data**. Include event and query timestamps in the model input while leaving them outside the structured write target. Freeze a common semantic event suffix for the timestamp-on and timestamp-off conditions so timestamp tokens do not indirectly remove more historical events from only one arm. This determines whether temporal information changes prediction by allowing the model to use delays between events.

**Checkpoint recency.** On day $d$, score every action using the current checkpoint and retained checkpoints from $d-1$, $d-3$, and $d-7$. All remain frozen throughout the day and receive the identical causal event-stream context. This measures the predictive value of recent overnight updates and reveals when those updates hurt current-day prediction.

**Context scaling.** Compare 8K, 16K, 32K, and 64K causal windows using matched Qwen3.5-9B-Base lineages, with 32K as the initial baseline. Action targets, day boundaries, recent/replay sampling, target-token exposure, and optimizer steps remain matched. “More data” here means more prior event-stream data in context, not more historical training examples. This alludes to discussions around what 'model capabilities' even mean when discussed broadly. Are 64K and 8K context windows both 'model capabilities'? How do we normalize for prompt quality or available tools?

**Sliding window versus context retrieval.** At the fixed 32K baseline context budget, compare the trailing 32K causal prefix against a context containing the most recent 16K tokens plus 16K tokens retrieved from the earlier causally available history. BM25 uses the serialized recent 16K token prefix as its query, and fetched items are chronologically packed into context. Because a long event-stream query may be dominated by generic interface language, query preprocessing removes or downweights common interface boilerplate using a fixed rule established before prospective evaluation. This tests whether selecting related older events is more predictive than allocating the entire context budget to contiguous recent history. Dense, hybrid, reranked, learned, embedded, LongNAP-style reasoned retrieval, and agent-controlled retrieval tool use are possible later extensions but are outside the initial ablation matrix.

**Direct prediction versus reasoning before prediction.** Using the same checkpoint and causal context, compare direct generation of the next structured write completion against generation with a fixed-budget private reasoning scratchpad before the same completion. The scratchpad is model-authored intermediate computation: it is not displayed, does not enter the human event stream, and is not scored as though it were observed human reasoning. Only the final completion through EOS is evaluated. Hold the final-completion decoding budget and decoding rule fixed, and report the additional reasoning tokens, latency, and compute separately. This tests whether explicit deliberation about the current task, likely objective, and causal dependencies improves write prediction independently of context retrieval.

**Practical system comparison.** Compare continually updated Qwen3.5-9B-Base against frontier closed models using ICL only, with identical contexts and targets. This asks whether personal weight updates allow the local open model to compete with a stronger frozen API model and quantifies the difference in value between supplying information in context and storing judgment in weights.

**Closed-model scaling.** Compare less-capable and frontier closed models, all using ICL only. This tests whether greater closed-model capability improves personal next-action prediction when the model cannot receive personal weight updates. 

**Open-model scaling.** Compare Qwen3.5-9B-Base with stronger open models using the same continual-training and replay recipe. Where feasible, also score each open model without personal weight updates. This tests whether greater open-model capability improves baseline prediction and whether it changes the value obtained from continual weight updates.

For the context and open-model conditions, also report adaptation after overnight training, older-workflow retention, general capability retention, and training cost. Dense-versus-MoE behavior, active and total parameters, memory, and throughput are secondary model-level analyses.

The initial Phase 1 bar is deliberately provisional: the collector produces an intelligible causal stream, training runs stably, displayed predictions sometimes appear relevant, and the ablations produce loss changes worth investigating. Those results determine which comparisons deserve robust baselines and formal human evaluation.

## 8. Implementation Order

1. build an excluded debugging display for the raw snapshots and read/write stream;
2. implement minimum viable Obsidian, Chrome, and Codex sensors with rich snapshots, input events, source identity, and timestamps;
3. run all three during ordinary work and inspect both source-specific capture and cross-application causal ordering;
4. iterate on delays, extraction, viewport capture, diffs, provenance, deduplication, and event boundaries across the combined stream;
5. freeze and version one snapshot-to-event and write-target conversion;
6. implement and validate focus-time destination/cursor/clipboard conditioning, then the focus-triggered prediction display, and store displayed predictions as Phase 1-excluded read events;
7. reconstruct historical note edits as a pipeline test without treating them as a complete historical stream;
8. implement the deterministic serializer, causal prefix, destination/cursor/clipboard query, and structured target loader that maps grounded paste actions to a reserved marker encoded by the unchanged tokenizer and appends one loss-bearing EOS token;
9. build the behavioral-cloning dataset and loss-tracking harness;
10. implement the once-daily LoRA update;
11. add stratified historical replay and immutable model lineage;
12. run the prospective interleaved-stream and initial ablations;
13. add lagged-checkpoint, closed-model ICL, and stronger open-model comparisons after the Qwen3.5-9B-Base baseline is stable;
14. introduce robust baselines and formal human evaluation after the pipeline and early loss trends justify them.

The required initial artifacts are the excluded debugging display, raw snapshot and input-event store, focus-time destination/cursor/clipboard capture, live prediction display, inspected trace log, privacy and exclusion policy, frozen conversion specification, explicit Phase 1 exclusion for displayed predictions, reconstruction and authorship audit, serializer and authored-text/paste-action/EOS target mask, immutable example store, leakage tests, loss-tracking harness, daily update manifest, and replay index.

## 9. Conclusion

Phase 1 asks whether one person's ordinary computer activity can train a continually improving predictor of what they will write next. The hard prerequisite is a credible sensor-derived account of observable exposure and authorship: what appeared to be read, when it became available, what the person produced, and how the frozen conversion divided that activity into bounded write bursts.

The learning rule is simple. A fixed-length suffix of prior Phase 1-eligible READ and WRITE events plus the observed destination, semantic cursor context, and current clipboard state predicts the next human write completion. The target contains authored text and grounded paste actions rather than copied payload tokens, while resolved pasted content remains available to later history. The current model displays a prediction when a text field receives focus. That displayed prediction is stored in the raw stream but excluded from Phase 1 learning; modeling the resulting feedback loop begins in Phase 2. The model's weights remain fixed throughout the day. Overnight, that day's scored examples are mixed with historical replay and used for a LoRA behavioral-cloning update whose weights persist into the next day.

The initial evidence is intentionally lightweight: qualitative inspection of displayed predictions and the direction and magnitude of loss changes across ablations. If those results are promising, robust baselines and formal human evaluation follow. If they are not, the daily losses and auditable event lineage should make the failure attributable to collection, write-event construction, context, optimization, or continual updating rather than hidden inside a more complicated system.

## References

[1] M. Carroll et al. [*On the Utility of Learning about Humans for Human-AI Coordination*](https://arxiv.org/abs/1910.05789). 2019.

[2] F. Matti, P. Dillenbourg, and L. Novelli. [*A Click Ahead: Real-Time Forecasting of Keyboard and Mouse Actions using RNNs and Computer Vision*](https://arxiv.org/abs/2309.12170). 2023.

[3] O. Shaikh et al. [*Learning Next Action Predictors from Human-Computer Interaction*](https://arxiv.org/abs/2603.05923). 2026.

[4] B. Krause, E. Kahembwe, I. Murray, and S. Renals. [*Dynamic Evaluation of Transformer Language Models*](https://arxiv.org/abs/1904.08378). 2019.

[5] A. Tandon et al. [*End-to-End Test-Time Training for Long Context*](https://arxiv.org/abs/2512.23675). 2025.

[6] X. Jin et al. [*Lifelong Pretraining: Continually Adapting Language Models to Emerging Corpora*](https://arxiv.org/abs/2110.08534). 2022.

[7] Qwen Team. [*Qwen3.5-9B-Base Model Card*](https://huggingface.co/Qwen/Qwen3.5-9B-Base). 2026.

[8] C. O'Neill, M. Jayasekara, and H. Partridge. [*Post-Training Science for Supervised Fine-Tuning*](https://www.datocms-assets.com/104802/1781805778-baseten-research-sft.pdf). 2026.
