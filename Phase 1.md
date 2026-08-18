
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
- can implement on hugging face, inference net, tinker, river, prime intellect, unsloth, axolotl, castform, custom build, etc
- i suspect for phase 1 the goal will be to learn token level structure before it can learn action level content. you might get a loss discontinuity (via early flatlining before more data shows improved loss due to content learning beginning)
- if 80% and growing amount of write actions are just prompting agents, what does the phase 1 model learn?
- the intended base model starting point does not have user assistant trained into it
- still unclear whether you need to apply synthetic q/a self study to the data to improve understanding rather than memorization, and how that relates to maintaining support for question answering / chatting, and how that relates to introducing reasoning rather than pure SFT. although these are likely later ablations rather than initial work
- regarding the 'training for retrieval', i already concluded that harnesses must already do this after answering prior questions i had around how it handles super long inbound info. and shaikh's longNAP does this too, so it seems obviously necessary to be able to reason over context retrieval. the question is whether to stick with existing algos (bm25, etc) or allow new tool creation (REPL, PTC, RLM)
	- want to confirm I’ve written somewhere about the potential necessity of reasoning to predict rather than raw prediction, perhaps combined with RL with semantic similarity rather than log probs
	- Also want to confirm the thinking around how context is searched agentically or fed once, which I think I’ve written about in the ablations
		- if you combine some ideas from prime intellect's python REPL / PTC recursivity in the sliding window vs context retrieval ablation, and its slow, you might be able to use OPD to convert that to a smaller model with the same performance and lower latency
	- Helpful to read the prime intellect harness to see how they do context search via Python REPL / PTC to compare, and also the actual purpose / use cases of multi agent system work they released
	- is next action prediction a forcing function for solving memory rather than solving goal and reward inference? it basically learns what to pay attention to given the full history of logs
		- from shopify ceo, state = memo(f(log))
	- does the implementation of prime intellect's harness provide a blueprint for the meta optimization required for self improvement towards next action prediction? is this 'training'? the weights arent being updated but the retrieval algorithm would be, ideally forced through iterations given the reward signal (whether thats some token level next action prediction or cosine sim score)
	- thesis has a ton of good work but it feels a bit weird since its unclear how the described solution solves the time giving context. the way it would is that the next action predictor learns how to manipulate the log history, therefore never needing explicit context? memory solutions solve a similar problem. which implies that the forcing function is learned log attention rather than goal inference. i guess thats a more specific description of learning response to stimulus, so it would make sense in that vein
	- prime intellect-like python REPL PTC might overfit to the data set. but if you just have a literal shitton of 'hardcoded rules', with some forcing function for less code + readable code, maybe thats fine? kind of reminds me of a AIXI optimal agent keeping all potential environments in its head and acting on whatever prior is most likely
	- the counterargument would be that hardcoded lost to weights long term, but can weights learn how to optimally retrieve/reason, if the context window is limited? to what extent is 'working memory' and 'memory retrieval' two separate systems in the brain? there is definitely some 'tool' being used in the brain implicitly when i read something (to connect to something else, because it 'reminds' me of something prior) which i also can somewhat 'call' explicitly if im trying really hard to remember something and then i remember it
- claude tokenizer repro https://x.com/magikarp_tokens/status/2087859173748854983?s=20
- interpretability platform https://www.goodfire.com/silico
- the retrieval ablation and the reasoning ablation are extremely critical
- https://console.river.ai/ seems cheaper + longer context than tinker, but do they support base models?
- the reason i think i will need to go as far as to determine sampling timing + harness necessary for it is that it provides a forcing function for which writes to train on, since we want to train on material content ideally, not random formatting. and determining when sampling occurs, since we want that to ideally be equivalent to training loss, implies training loss. otherwise there's no core reason for one training loss masking over the other
- what are the requirements necessary to feel like i cant live without the autocomplete? it needs to be correct and fast. it needs to predict what im going to write to a high degree. im unsure if i could get more specific than that. cost. latency. performance. it comes down to whether you can build it or not.
- codex's open source implementation has work around compaction, which is honestly extremely good, and also long context retrieval, which is also very good. 
	- reasoning to retrieve can be useful as part of the ablation
	- can the encryption blocks be used in the same way reasoning blocks were used for distillation
	- i did work in a codex app thread (explain autocompaction in codex) that shows that we can take the compaction encrypted blocks and port them to other gpt threads! we can also pass a trace into the compaction function and gets a 'compaction' capsule we can reuse in other threads as needed. you can also compose multiple compactions into a single thread and it combines the information from both
- was on twitter, saw a carmack tweet responded to by suarez, reminded of RLC, looked at papers. this feels very predictable at least the action of opening up RLC. i'd want the AI to basically show me the relevant papers im looking for rather than me writing it down in my notes as a reference for later. so this example would be the agent detects from the vector of looking it up that i want to find the streaming RL work that carmack is referencing, and find it for me. does the implementation plan lead to that? is there a shorter, generalizable way to that?
	- why not just tell the computer use agent your goals? why require it to 'infer' your goals from your context?
		- one difference is tightly coupled vs long running
		- another might be proactive vs reactive
	- i already basically do the above with the codex app
	- is this example just search learned from RL? and intermediate rewards for clicking the correct intermediate links is the equivalent of jensen's EIOS (early indicators of success)?
- https://huggingface.co/Motif-Technologies/Motif-3 pretraining dataset? base model?
- historical concern: it felt like focus-time conditioning might be necessary even for offline training because the point at which to sample the model could determine which events receive loss
	- current resolution: the foundational test deliberately uses causally valid pre-mutation conditioning to test content-prediction capacity offline; focus-time conditioning and the live sampling harness follow only if that simpler test produces a useful signal

## Abstract

Ordinary computer use produces a chronological record of information becoming action. A person reads documents, browses pages, receives messages and model outputs, edits notes, writes searches and prompts, sends messages, and changes artifacts. If these events are captured at the time they actually became available, they form a personal read–write stream from which the person's next bounded write action can be predicted. Judgment is distilled into weights.

Phase 1 builds that stream and applies behavioral cloning to it. Each example contains a fixed-length causal history plus the observed destination, semantic cursor context, and current clipboard state immediately before an action, followed by a structured write completion. Authored text, grounded paste actions, and a structural end-of-sequence token receive loss; copied payload tokens do not, although their resolved content and provenance remain available in later history.

The immediate foundational test runs offline over a frozen chronological trace. It compares three conditions using the same basic sliding-window history and write query: frozen Qwen3.5-9B-Base, frozen `gpt-5.6-sol` at `xhigh` reasoning using in-context prediction, and a Qwen3.5-9B-Base model updated on preceding examples. Every example is predicted and scored before it is allowed to train the personalized Qwen condition. Chronological blocks are chosen for fast experimental iteration rather than tied to calendar days, and the same developmental trace may be rerun under separately versioned configurations.

A later prospective Phase 1 implementation queries the model automatically when a text field receives focus and shows its predicted write completion for qualitative inspection. Grounded action markers such as paste are rendered by the interface rather than displayed as literal text. Displayed predictions are captured in the raw stream as model-authored read events but excluded from the Phase 1 dataset. That later harness can use fixed daily checkpoints, overnight updates, and historical replay; modeling how displayed predictions change human behavior begins in Phase 2.

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

Dynamic evaluation updates a language model on recent tokens before predicting later tokens in the same stream [4]. End-to-End Test-Time Training extends this idea by meta-learning an initialization that is explicitly optimized for online next-token updates and by using weight updates to carry information beyond a sliding attention window [5]. Phase 1 uses the same score-before-update principle at a different boundary: the foundational test scores chronological write blocks before updating the personalized condition, while the later prospective harness may score throughout a day and update overnight. Persistent model state and historical replay belong to that later continual implementation.

Lifelong pretraining studies chronological adaptation to emerging corpora while measuring performance on both new and earlier distributions [6]. Its stability–plasticity problem is directly relevant: recent data should update the personal model without allowing one project or period to erase older workflows or general language-model capabilities.

## 3. Data Pipeline

Phase 1 uses a raw-first, versioned pipeline:

```text
lossless sensor evidence
→ semantic READ/WRITE reduction
→ causal write-prediction examples
→ model-specific packing and loss masks
```

These layers have different authority. `raw.jsonl` is the authoritative record of what the sensors observed. Finalized events are a reproducible interpretation of that evidence. Causal examples are a further interpretation for one prediction task. Packed tensors are mechanical artifacts for one tokenizer and model. A failure in a later layer should normally be repairable without recollecting the session; a failure to preserve the necessary raw evidence is not.

The north star is fidelity to the information available to the person and the content the person produced, with authorship, action boundaries, and causal order preserved well enough to support next-write prediction. The live preview is useful for finding obvious failures, but it is not training authority.

### 3.1 Prospective collection and session authority

The collector records ordinary work prospectively across Obsidian, Chrome/browser interfaces, Codex, and supported text surfaces such as Visual Studio Code. Capturing all supported applications from the beginning preserves their causal interleaving. An Obsidian-only reconstruction cannot recover research read in Chrome or prompts and responses exchanged in Codex after the fact.

Each run begins with an immutable `session.json` containing the resolved read/write delays, crop settings, application allowlist and exclusions, schema and collector versions, start time, and executable digest. A run writes:

- `raw.jsonl`, containing sensor observations, input timing, screenshots and OCR references, Accessibility states, clipboard evidence, checkpoints, suppressions, and unresolved attempts;
- `events.preview.jsonl`, containing provisional READ/WRITE interpretations for inspection only;
- retained full-window screenshots and their hashes, unless image retention was deliberately disabled.

The separate Coupled event viewer and collector are excluded from semantic collection. The viewer mirrors the provisional stream and resolved session settings, but closing it does not stop collection and neither its display nor JSONL line order defines the dataset. Both raw text observations and screenshots may contain sensitive content, so collection must be paused around material that should not be retained.

The current delays are trailing quiet-period segmentation rules, not causal timestamps. Activity resets the relevant timer; settlement starts capture or closes a burst. The exact configured values remain versioned and tunable, but changing them changes event demarcation and therefore the dataset.

### 3.2 READ evidence

A READ candidate begins after pointer movement, click, scroll, or application activation and settles only after a complete `READ_DELAY`. At settlement the collector re-resolves the application, content window, display, title, and bounds together. If the surface changed, writing began, or the screenshot completed against a different surface, the stale candidate remains in raw evidence and does not become a READ.

For an eligible stable surface, the collector captures the target window's screen-coordinate rectangle, retains the full source image, applies the configured recognition crop, and runs local OCR. The current default crop keeps the middle 80 percent of the window width and the vertical band from 10 through 65 percent. This is a deliberately rough attention proxy, not a claim about gaze. The complete OCR result for that recognition region is retained before semantic overlap removal, and the full screenshot allows OCR and crop rules to be rerun later.

The screenshot mechanism is rectangular rather than truly window-isolated. A covering window can therefore appear in the pixels even when its application is excluded. Capture-time surface revalidation prevents wrong metadata from being silently attached to a different surface, while the raw screenshot remains necessary for auditing residual occlusion and OCR errors. Tiny helper and auxiliary browser surfaces are retained raw but suppressed as candidate READs.

A mutating input supersedes an unsettled READ on the same work surface so that partially authored output is not mislabeled as inbound information. The offline reducer also removes delayed captures proven to land inside an active WRITE. Genuine new viewing activity during a long write can remain eligible when the evidence does not contain the active write's output.

### 3.3 WRITE evidence and authorship

WRITE capture is based on editable state, not reconstructed keystroke characters. On the first mutation-capable input, an active event tap synchronously captures the focused Accessibility element before returning the input to the application. The attempt retains:

- the `BEFORE` value and selection, with explicit completeness and truncation status so transitions requiring unavailable text are ineligible;
- application, window, role, and available field identity;
- range-native semantic text before, inside, and after the caret or selection, with bounded fallbacks;
- numeric selection coordinates as diagnostic evidence;
- the current clipboard text, types, hash, truncation state, and pasteboard version;
- ordered input classes and subsequent editable checkpoints, without storing typed key characters.

The collector holds that specific editable element through the burst. Each subsequent input resets `WRITE_DELAY`; pointer or caret relocation, focus loss, Return in applicable fields, and other proven boundaries may settle it earlier. Short post-input checkpoints and a synchronous pre-Return observation preserve transient submission fields that clear or disappear before the normal delay. Secure fields are excluded.

The semantic write is reconstructed from complete editable states as the canonical smallest contiguous `BEFORE → AFTER` change. Initial cursor position never biases this diff, and there is no synthetic `BEFORE → empty` deletion fallback. Deletions, replacements, automatic formatting, transient checkpoints, and Accessibility epoch changes remain observable evidence; the reducer selects an outcome only when the transition is supported rather than guessing from input signals. Application-generated formatting inside an otherwise verified transition currently remains part of the resolved content rather than receiving a separate provenance type.

Pastes require separate authorship evidence. Cmd-V captures immediate pre/post-paste editable states and binds the observed transition to the clipboard version present in the write's conditioning state. A verified WRITE retains its resolved document change plus ordered `authored_text`, `paste`, or unresolved authorship segments. The pasted payload and provenance remain available in the event and later history, but pasted payload tokens are not treated as human-generated target text. Copy and clipboard changes remain raw environment evidence and conditioning state; they do not create a third semantic `COPY` event. Mixed type–paste–type bursts are eligible only when their authorship segmentation can be proved.

The result is deliberately asymmetric: a WRITE event is a faithful record of the resolved edit, while a Phase 1 target is only the portion of that edit the model is meant to predict. Operation, removal, edit offset, destination, and reconstruction provenance remain audit or conditioning metadata and receive no content-prediction loss.

### 3.4 Semantic READ/WRITE reduction

After collection, the versioned reducer consumes only `session.json` and `raw.jsonl`. It never treats `events.preview.jsonl` as evidence. Its output is:

- `events.jsonl`, the finalized semantic READ and WRITE stream;
- `unresolved.jsonl`, ambiguous attempts and deliberate non-event dispositions;
- `reduction.json`, the configuration, counts, and hashes binding the raw and derived artifacts.

Every finalized event carries stable raw lineage, the selected observation, the rule applied, and the reason for the decision. Re-running the same reducer over the same evidence must be byte-identical. Event identifiers remain stable across reducer revisions so that a later rule change can be compared with the earlier interpretation.

The reducer performs the semantic decisions that do not belong in the live collector: canonical write reconstruction, transient Return recovery, deletion and Cut handling, paste authorship resolution, composition of same-editable attempts when the evidence proves one completion, active-write READ suppression, helper-surface filtering, and adjacent viewport overlap removal in semantic time. Overlap is removed only between compatible adjacent READs; an intervening WRITE or surface change resets the comparison so a later reread is not erased. Evidence that cannot support a conservative decision remains unresolved rather than becoming a guessed event.

The finalized ontology for the initial experiment contains only READ and WRITE. This does not mean every raw signal is one of those events: focus, navigation, copy, selection, and suppression records can remain evidence or conditioning without becoming prediction targets.

### 3.5 Causal example compilation

The causal compiler verifies the reducer manifest, hashes, stable event IDs, and raw lineage, then evaluates every finalized WRITE for use as a training example. It does not repeat semantic reduction. The chronology is derived from capture evidence:

```text
read.available_at        = read.capturedAt
target_write.began_at    = target_write.beganAt
prior_write.available_at = prior_write.terminalDecisionAt

context(target) = stable_sort(
    eligible events where event.available_at < target_write.began_at
)
```

JSONL append order, sequence number, settlement time, OCR completion time, and event emission time are never substitutes for this chronology. A delayed WRITE may be appended after a READ that was actually captured after the write began. Including that READ because it appeared earlier in the file would leak post-action information—and potentially the target itself—into the model input.

The model input for the initial task is:

```text
causally available READ/WRITE history
+ pre-mutation destination, semantic cursor, and clipboard query
```

The pre-mutation query is admitted under its explicit capture semantics: the first input has been intercepted, but the application has not processed it. It is not silently backdated as an ordinary historical event. Each example preserves the exact contributing event IDs, serialized history, query, structured target, resolved outcome metadata, conversion version, and raw lineage.

Event validity and target eligibility remain separate. Verified WRITEs stay in later causal history even when they receive no target loss. The conservative initial target set excludes pure deletions, incomplete conditioning, unresolved authorship, and text-only completions shorter than four trimmed user-perceived characters. Grounded paste-only and mixed-paste completions bypass the length threshold because the paste action itself is loss-bearing. Records explicitly marked ineligible for Phase 1—including future displayed model predictions—are excluded from both targets and Phase 1 context.

### 3.6 Model-specific packing and loss boundary

Compiled examples are tokenizer-independent. A model-specific packer retains the newest complete serialized event blocks plus the complete query within the history-plus-query input budget. The query stays at the right edge. Older events are removed first; if the oldest retained event itself crosses the boundary, only an explicitly marked, authorship-preserving semantic text tail may be retained. Partial JSON is never emitted, and the target is appended outside the input budget rather than silently truncated.

For Qwen, authored spans are tokenized normally. Each proven paste segment becomes the literal reserved string `<|paste|>`, encoded with the unchanged native tokenizer rather than by adding a token to its vocabulary. The loader appends exactly one native EOS token. Loss is masked off the entire history, query, and padding and applied only to authored target tokens, the existing-token sequence spelling `<|paste|>`, and EOS. The copied payload is absent from the current target but remains resolved in the historical WRITE event that later examples can observe.

The packing manifest pins the tokenizer identity and revision, input budget, paste-marker encoding, EOS identifier, truncation rule, file digests, and loss-mask contract. This keeps the semantic dataset reusable across Qwen, frontier in-context baselines, and later model choices without treating one tokenizer's tensors as data authority.

### 3.7 Iteration, freeze, and current boundary

The practical iteration loop is:

1. collect normal interleaved work while using the excluded viewer only as a debugging aid;
2. reduce the raw session and inspect finalized events, screenshots, and unresolved evidence;
3. compile and audit causal examples, then inspect the actual loss-bearing targets;
4. pack and audit the model-specific representation;
5. fix recurrent material errors at the earliest responsible layer, version the changed rule, and replay the preserved raw evidence;
6. freeze collector, reducer, compiler, serializer, tokenizer, and packing manifests before comparing models.

The current training candidate implements this boundary with the `phase1-semantic-v6` reducer and `phase1-causal-v14` compiler. Those names identify the present frozen interpretation, not timeless theoretical requirements. Historical Obsidian Git data remains useful for unit tests, but the foundational experiment uses prospective, interleaved browser, Codex, Obsidian, and supported editor/terminal activity.

The initial offline experiment intentionally predicts write content with destination, semantic cursor context, clipboard state, and causal history already observed. It does not predict where the future write will occur, when the model should intervene, or how the user will react to a suggestion. A later live interface must capture the same query when a text field receives focus; first-mutation conditioning is sufficient to validate the offline task but is too late to serve a live prediction. Train–serve differences between focus and mutation must be measured before that interface is evaluated. Idle-triggered prediction, destination prediction, richer resource identity, true window-isolated capture, audio/video, and learned proactivity are deferred assumption-removal experiments rather than blockers for the foundational comparison.

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

### 4.2 Foundational chronological score-then-update loop

The foundational test uses a frozen, audited trace divided into contiguous chronological blocks $B_1,\ldots,B_K$. A block is a versioned experimental unit—initially a convenient number of eligible writes or one or more captured sessions—not a calendar-day commitment. There is no random or permanently held-out train/validation/test split. Within each run, every example is predicted and scored before it may enter the personalized model's training set.

For block $B_k$, compare three conditions:

1. frozen Qwen3.5-9B-Base using the trailing causal window in context;
2. frozen `gpt-5.6-sol` at `xhigh` reasoning using the same trailing causal information in context;
3. personalized Qwen3.5-9B-Base checkpoint $\theta_k$, trained only on blocks preceding $B_k$.

The conditions receive the same tokenizer-independent plan of event IDs, serialized text, destination, semantic cursor context, clipboard state, and target. Model-specific tokenization may differ, but one condition must not receive older or additional semantic information merely because its tokenizer packs differently. Record each generated prediction and, where the interface exposes a valid target likelihood, its per-example pre-update loss; metrics that are not exposed comparably across model interfaces must be reported separately rather than treated as identical.

Only after all examples in $B_k$ have been scored may they enter the cumulative training set $A_k=\bigcup_{j\leq k}B_j$. Updating the personalized condition produces $\theta_{k+1}$ for the next block. The two frozen in-context conditions never train on the personal examples. This is prequential evaluation inside each run:

```text
start personalized Qwen from the base checkpoint
for each chronological block:
    score every example with frozen base Qwen
    sample and score as available with frozen gpt-5.6-sol xhigh
    score every example with the current personalized Qwen
    train the personalized Qwen on cumulative preceding examples
```

The same trace may be rerun rapidly while data conversion, context construction, optimizer, block size, or evaluation changes. Each rerun is a new developmental lineage and must not be described as fresh prospective evidence. Once a configuration is frozen, newly arriving blocks provide genuinely prospective score-before-update evidence without requiring a static validation partition.

### 4.3 Later prospective continual loop

If the foundational comparison shows useful predictive capacity, Phase 1 can test the content predictor in a live continual harness. Live generation then occurs when a text field receives focus and uses the destination, semantic cursor context, clipboard state, and causal history captured for that actual focus-time query. A displayed prediction must be evaluated against the subsequent eligible write using the exact input from which it was generated; later pre-mutation state cannot be substituted into that prediction's score.

The current offline training examples remain conditioned on the richer pre-mutation observation because focus-time capture has not yet been collected. The prospective harness therefore records paired focus-time and pre-mutation states, measures their drift, and treats this as an explicit train–serve difference. Training directly on focus-time opportunities is a later versioned dataset decision, not something introduced by silently moving timestamps or fields inside the existing examples.

The initial prospective cadence may use one day as a block. Let $\theta_d$ be the personalized model at the beginning of day $d$ and keep its weights fixed while every eligible action that day receives a pre-update score. After the complete day has been scored, training produces:

$$
\theta_{d+1}
=
\operatorname{Update}(\theta_d,\mathcal N_d,\mathcal R_d),
$$

where $\mathcal N_d$ is the newly scored day and $\mathcal R_d$ is replay from prior days. The resulting weights persist. A daily boundary keeps live collection stationary and model lineage legible, but it is a later operational baseline rather than a prerequisite for the foundational capacity test or a claim that one day is the optimal update interval.

### 4.4 Later replay and persistent lineage

The foundational test can train on all cumulative preceding examples directly. Explicit replay becomes necessary when the corpus or prospective update schedule makes full cumulative retraining impractical. Its purpose is to preserve older workflows rather than freeze the model in the past.

The first prospective replay policy is deliberately simple. Once the conversion schema has been frozen, replay is stratified using stable fields actually present in the data, initially:

- time periods;
- applications;
- target provenance;
- target length.

Sampling weights, replay capacity, strata, optimizer steps, parent checkpoint, and resulting checkpoint are recorded in the daily manifest. Replay examples preserve the causal contexts that existed when their targets occurred; they are never rebuilt from later artifact state. Replay effectiveness is measured rather than assumed.

### 4.5 Foundational model configuration

The foundational comparison uses [Qwen3.5-9B-Base](https://huggingface.co/Qwen/Qwen3.5-9B-Base) [7] and `gpt-5.6-sol` at `xhigh` reasoning with the same basic trailing causal context plan, initially bounded by the 32K history-plus-query baseline. The two Qwen conditions begin from the same base checkpoint. One remains frozen and predicts through in-context history only; the other receives parameter-efficient updates on preceding chronological blocks. `gpt-5.6-sol` remains frozen and predicts through in-context history only.

Qwen3.5-9B-Base is a nine-billion-parameter base model. It is dense in the routing sense, although its stack is a hybrid of Gated DeltaNet and gated-attention layers rather than a conventional all-full-attention Transformer. The official model card reports a native context length of 262,144 tokens. The authenticated Tinker runtime currently exposes a 65,536-token maximum for this model. The initial 32K history-plus-query window is therefore an implementation and compute choice that fits the validated runtime after allowing additional capacity for the untruncated target. Any larger-context ablation must record and respect the actual serving or training runtime's total sequence limit rather than relying only on the checkpoint's advertised native length.

This three-way comparison precedes the larger ablation matrix. Later experiments may vary context length, checkpoint recency, model family, update cadence, and replay without changing the event construction, causal serialization, or score-before-update rule.

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

This definition is the macro example-average objective: each write first produces its own mean target-token negative log-likelihood, and each write then contributes equally regardless of target length. The experiment also reports micro token NLL,

$$
\mathcal L_{\mathrm{micro}}(\theta;\mathcal D)
=
-\frac{
\sum_{(h,y)\in\mathcal D}\ell_\theta(y\mid h)
}{
\sum_{(h,y)\in\mathcal D}\sum_j m_j
},
$$

which weights longer targets in proportion to their loss-bearing tokens. Every example retains its individual pre-update NLL, and block reports contain both macro example-average and micro target-token averages. The mechanical Tinker overfit reports micro weighted-token NLL as its headline aggregate; it must not be presented as the same statistic as macro example-average loss. Each training run records its actual provider-side reduction and example-sampling policy so that optimization weighting is not inferred from an aggregate evaluation metric.

Loss is masked on every model-input token and applied to authored target tokens, every existing-vocabulary token spelling the reserved marker for each grounded paste action, and the single loader-appended EOS token. Read events, earlier human actions, resolved pasted payloads, received messages, external model responses, tool results, destination, initial cursor state, clipboard state, and edit metadata provide input or audit evidence but do not become targets merely because they are available. Model predictions displayed during Phase 1 are excluded from the Phase 1 context as well as from its targets.

For foundational update $k$, let $\mathcal A_k$ contain all eligible examples from chronological blocks through $B_k$. The personalized Qwen objective is:

$$
\boxed{
\mathcal L_k(\theta)
=
\mathcal L_{\mathrm{BC}}(\theta;\mathcal A_k)
}.
$$

The candidate is initialized from the preceding personalized checkpoint $\theta_k$, optimized only after $B_k$ has been scored, checked for numerical failure, and stored as $\theta_{k+1}$ together with run diagnostics. A parameter-efficient adapter is the default foundational implementation because it makes rapid training, versioning, and rollback tractable; the data and objective are unchanged if later experiments use full-model updates. A later prospective harness may replace full cumulative training with the recent/replay mixture in Section 4.3 without changing which target tokens receive loss. Practical starting points for LoRA learning rate, batch size, rank, scaling, and epoch count are reported by O'Neill et al. [8]; these are sweep priors rather than assumed optima because their study uses static, judge-filtered SFT data rather than continual personal action data.

The objective estimates behavior. It does not assert that the observed action was optimal, identify a reward function, or require a labeled goal.

## 6. Algorithms

### Algorithm 1 (later prospective): Display a prediction when a text field receives focus

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
        oldest_oversized_event="explicit_authorship_preserving_text_tail"
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

### Algorithm 2: Construct and score one chronological block

```text
procedure BUILD_AND_SCORE_BLOCK(model_k, frozen_events, block_action_ids, config):
    model_k <- FREEZE_WEIGHTS(model_k)
    examples <- []
    losses <- []

    actions <- HUMAN_WRITE_EVENTS(frozen_events) where
               action.id in block_action_ids
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
        loss <- MASKED_TARGET_NLL(model_k, h, training_target, target_mask)
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

    return examples, AGGREGATE_BLOCK_LOSS(losses)
```

### Algorithm 3: Update personalized Qwen after a scored block

```text
procedure UPDATE_PERSONALIZED_QWEN(model_k, scored_blocks, config):
    cumulative_examples <- UNION_EXAMPLES(scored_blocks)
    candidate <- CLONE_ADAPTER(model_k)

    for batch in PACK_BY_TARGET_AND_CONTEXT_TOKENS(
        cumulative_examples,
        config
    ):
        loss <- MASKED_ACTION_NLL(candidate, batch)
        candidate <- OPTIMIZER_STEP(candidate, gradient(loss))

    if OPTIMIZATION_FAILED(candidate):
        return model_k

    diagnostics <- RECORD_UPDATE_DIAGNOSTICS(model_k, candidate, config)
    model_next <- STORE_IMMUTABLE(candidate)
    STORE_FOUNDATIONAL_RUN_MANIFEST(
        parent=model_k,
        result=model_next,
        scored_blocks=scored_blocks,
        cumulative_examples=cumulative_examples,
        diagnostics=diagnostics,
        config=config
    )
    return model_next
```

## 7. Initial Experimental Program

The initial program is an offline, exploratory capacity test over collected chronological data. Pre-update loss where available and generated predictions provide the quantitative and qualitative traces; no live suggestion interface or daily deployment scheduler is required. Rapid reruns are expected while the data, context, optimizer, block size, and evaluation are being developed, with every run versioned and score-before-update ordering preserved. A later prospective harness freezes a credible configuration, displays focus-triggered predictions, and updates on newly arriving data.

### Experiment 0: Collector and reconstruction audit

Build the debugging display and run minimum viable Obsidian, Chrome, and Codex sensors during ordinary work. Inspect the resulting snapshots and derived stream against the actual experience, then revise delays, crops, extraction, deduplication, provenance, and event boundaries. Once the qualitative output is credible, manually replay sampled sessions and measure missing-event rate, temporal-ordering error, incorrect content inclusion, authorship error, action-boundary disagreement, and future leakage. Modeling does not begin until one conversion version is frozen.

### Experiment 1: Foundational three-model predictive-capacity test

Use one frozen, audited chronological stream containing ordinary work across Obsidian, Chrome/browser, Codex, and other already supported writing surfaces such as VS Code. Divide eligible writes into contiguous developmental blocks and condition every arm on the same basic trailing causal READ/WRITE history plus destination, semantic cursor context, and clipboard state. Compare:

1. frozen Qwen3.5-9B-Base using sliding-window in-context prediction;
2. frozen `gpt-5.6-sol` at `xhigh` reasoning using sliding-window in-context prediction;
3. personalized Qwen3.5-9B-Base, which scores each block before training on that block and all preceding eligible examples.

Validate the three arms against the same tokenizer-independent event and serialized-text plan. Record every generated completion, per-example Qwen pre-update loss, any genuinely comparable frontier-model score exposed by its interface, block aggregates, and per-application projections. Inspect predictions directly for an initial capacity signal. The same trace may be rerun for fast, versioned development; these reruns are not fresh prospective evidence. Historical note edits may remain a separate reconstruction diagnostic, but they do not replace the interleaved test.

### Experiment 2: Prospective continual interleaved stream

Only after Experiment 1 produces a signal worth deploying, continue collecting and scoring the interleaved stream prospectively across fixed score-before-update intervals, initially days. Implement focus-time destination/cursor/clipboard capture and display focus-triggered predictions for qualitative inspection while excluding those prediction events from the Phase 1 dataset. Add persistent checkpoint lineage and explicit replay when full cumulative training becomes impractical. Test whether correctly timed read and write history improves pre-update loss over the current artifact and damaged-history controls.

### Experiment 3: Ablation matrix

After the foundational comparison is stable, ablations use the same chronological score-before-update protocol. During development the unit may be a fixed example block or captured session; during later prospective use it may be a day. Every condition scores the same actions in the same order before any weight update, and earlier actions enter the causal context for later actions. Cross-model contexts are frozen by event IDs and serialized text so that every model receives the same information, regardless of tokenizer. Open-model updates occur only after the complete block has been scored.

**Learning Objective**. Replace token-level cross-entropy loss and behavioral cloning with cosine similarity on the embeddings of the ground-truth and predicted resolved write content as the reward for GRPO or RLOO. This compares sequence-likelihood training with semantic-similarity reward maximization.

**Time Data**. Include event and query timestamps in the model input while leaving them outside the structured write target. Freeze a common semantic event suffix for the timestamp-on and timestamp-off conditions so timestamp tokens do not indirectly remove more historical events from only one arm. This determines whether temporal information changes prediction by allowing the model to use delays between events.

**Checkpoint recency.** On day $d$, score every action using the current checkpoint and retained checkpoints from $d-1$, $d-3$, and $d-7$. All remain frozen throughout the day and receive the identical causal event-stream context. This measures the predictive value of recent overnight updates and reveals when those updates hurt current-day prediction.

**Context scaling.** Compare 8K, 16K, 32K, and 64K causal windows using matched Qwen3.5-9B-Base lineages, with 32K as the initial baseline. Action targets, chronological block boundaries, cumulative training data, target-token exposure, and optimizer steps remain matched; later prospective comparisons also match replay selection. “More data” here means more prior event-stream data in context, not more historical training examples. This alludes to discussions around what 'model capabilities' even mean when discussed broadly. Are 64K and 8K context windows both 'model capabilities'? How do we normalize for prompt quality or available tools?

**Sliding window versus context retrieval.** At the fixed 32K baseline context budget, compare the trailing 32K causal prefix against a context containing the most recent 16K tokens plus 16K tokens retrieved from the earlier causally available history. BM25 uses the serialized recent 16K token prefix as its query, and fetched items are chronologically packed into context. Because a long event-stream query may be dominated by generic interface language, query preprocessing removes or downweights common interface boilerplate using a fixed rule established before prospective evaluation. This tests whether selecting related older events is more predictive than allocating the entire context budget to contiguous recent history. Dense, hybrid, reranked, learned, embedded, LongNAP-style reasoned retrieval, and agent-controlled retrieval tool use are possible later extensions but are outside the initial ablation matrix.

**Direct prediction versus reasoning before prediction.** Using the same checkpoint and causal context, compare direct generation of the next structured write completion against generation with a fixed-budget private reasoning scratchpad before the same completion. The scratchpad is model-authored intermediate computation: it is not displayed, does not enter the human event stream, and is not scored as though it were observed human reasoning. Only the final completion through EOS is evaluated. Hold the final-completion decoding budget and decoding rule fixed, and report the additional reasoning tokens, latency, and compute separately. This tests whether explicit deliberation about the current task, likely objective, and causal dependencies improves write prediction independently of context retrieval.

**Practical system comparison.** Experiment 1 establishes the initial comparison among frozen base Qwen3.5-9B, frozen `gpt-5.6-sol` at `xhigh` using ICL only, and personalized Qwen3.5-9B, with identical semantic contexts and targets. Later repetitions may substitute other frontier closed models. This asks whether personal weight updates allow the local open model to compete with a stronger frozen model and quantifies the difference between supplying personal information only in context and also storing regularities in weights.

**Closed-model scaling.** Compare less-capable and frontier closed models, all using ICL only. This tests whether greater closed-model capability improves personal next-action prediction when the model cannot receive personal weight updates. 

**Open-model scaling.** Compare Qwen3.5-9B-Base with stronger open models using the same continual-training and replay recipe. Where feasible, also score each open model without personal weight updates. This tests whether greater open-model capability improves baseline prediction and whether it changes the value obtained from continual weight updates.

For the context and open-model conditions, also report adaptation after each update, older-workflow retention, general capability retention, and training cost. Dense-versus-MoE behavior, active and total parameters, memory, and throughput are secondary model-level analyses.

The foundational Phase 1 bar is deliberately provisional: the collector produces an intelligible causal stream, training runs stably, offline sampled predictions sometimes appear relevant, and the three-model comparison produces loss or prediction-quality differences worth investigating. Those results determine whether a live focus-triggered harness, broader ablations, robust baselines, and formal human evaluation are justified.

## 8. Implementation Order

1. build an excluded debugging display for the raw snapshots and read/write stream;
2. implement minimum viable Obsidian, Chrome, and Codex sensors with rich snapshots, input events, source identity, and timestamps;
3. run all three during ordinary work and inspect both source-specific capture and cross-application causal ordering;
4. iterate on delays, extraction, viewport capture, diffs, provenance, deduplication, and event boundaries across the combined stream;
5. freeze and version one snapshot-to-event and write-target conversion;
6. reconstruct historical note edits as a pipeline test without treating them as a complete historical stream;
7. implement the deterministic serializer, causal prefix, pre-mutation destination/cursor/clipboard query, and structured target loader that maps grounded paste actions to a reserved marker encoded by the unchanged tokenizer and appends one loss-bearing EOS token;
8. build the behavioral-cloning dataset, per-example loss tracker, and versioned chronological-block runner;
9. collect a substantial ordinary-work trace and freeze a tokenizer-independent event and serialized-text context plan;
10. implement the three foundational arms: frozen base Qwen3.5-9B, frozen `gpt-5.6-sol` at `xhigh` using ICL, and cumulatively trained Qwen3.5-9B;
11. run and iterate on the offline three-model predictive-capacity comparison, preserving score-before-update ordering inside every versioned run;
12. add broader objective, context, retrieval, checkpoint, and model-family ablations only after the foundational result is interpretable;
13. if the result justifies live use, implement focus-time destination/cursor/clipboard conditioning, the focus-triggered prediction display, and explicit Phase 1 exclusion for displayed predictions;
14. then implement the prospective update cadence, stratified replay, persistent model lineage, and later robust human evaluation.

The required foundational artifacts are the excluded debugging display, raw snapshot and input-event store, inspected trace log, privacy and exclusion policy, frozen conversion specification, reconstruction and authorship audit, serializer and authored-text/paste-action/EOS target mask, immutable example store, leakage tests, per-example scoring and sampling harness, chronological block plan, three model-condition manifests, and personalized Qwen update lineage. Focus-time capture, the live prediction display, displayed-prediction exclusions, a daily update manifest, and a replay index are required for the later prospective harness rather than for the initial capacity test.

## 9. Conclusion

Phase 1 asks first whether one person's ordinary computer activity contains enough signal to predict what they will write next, and later whether that predictor can improve continually in live use. The hard prerequisite is a credible sensor-derived account of observable exposure and authorship: what appeared to be read, when it became available, what the person produced, and how the frozen conversion divided that activity into bounded write bursts.

The foundational learning rule is simple. A fixed-length suffix of prior Phase 1-eligible READ and WRITE events plus the observed destination, semantic cursor context, and current clipboard state predicts the next human write completion. The target contains authored text and grounded paste actions rather than copied payload tokens, while resolved pasted content remains available to later history. A frozen base Qwen, a frozen frontier model using the same information in context, and a cumulatively trained Qwen are compared over chronological blocks; every example is scored before it can train the personalized condition.

The initial evidence is intentionally lightweight: per-example pre-update losses where available, aggregate and per-application traces, and direct inspection of offline generated predictions. If those results are promising, Phase 1 proceeds to focus-triggered live predictions, persistent score-before-update updates, replay, robust baselines, and formal human evaluation. Displayed predictions are then stored in the raw stream but excluded from Phase 1 learning; modeling the resulting feedback loop begins in Phase 2. If the foundational result is not promising, the auditable event and run lineage should make the failure attributable to collection, write-event construction, context, model capacity, or optimization rather than hidden inside a more complicated deployed system.

## References

[1] M. Carroll et al. [*On the Utility of Learning about Humans for Human-AI Coordination*](https://arxiv.org/abs/1910.05789). 2019.

[2] F. Matti, P. Dillenbourg, and L. Novelli. [*A Click Ahead: Real-Time Forecasting of Keyboard and Mouse Actions using RNNs and Computer Vision*](https://arxiv.org/abs/2309.12170). 2023.

[3] O. Shaikh et al. [*Learning Next Action Predictors from Human-Computer Interaction*](https://arxiv.org/abs/2603.05923). 2026.

[4] B. Krause, E. Kahembwe, I. Murray, and S. Renals. [*Dynamic Evaluation of Transformer Language Models*](https://arxiv.org/abs/1904.08378). 2019.

[5] A. Tandon et al. [*End-to-End Test-Time Training for Long Context*](https://arxiv.org/abs/2512.23675). 2025.

[6] X. Jin et al. [*Lifelong Pretraining: Continually Adapting Language Models to Emerging Corpora*](https://arxiv.org/abs/2110.08534). 2022.

[7] Qwen Team. [*Qwen3.5-9B-Base Model Card*](https://huggingface.co/Qwen/Qwen3.5-9B-Base). 2026.

[8] C. O'Neill, M. Jayasekara, and H. Partridge. [*Post-Training Science for Supervised Fine-Tuning*](https://www.datocms-assets.com/104802/1781805778-baseten-research-sft.pdf). 2026.
