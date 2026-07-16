# Weakest-Link Tests for Personal Next-Action Prediction

## Status

This document specifies a toy experiment. It is a companion to [[Paper]], not a replacement for it. [[Paper]] describes a broader path from behavioral cloning to coactive preference learning. This document stops much earlier. Its purpose is to determine which of the earliest assumptions in that path are true before investing in more complex algorithms.

The proposal contains no experimental results. Operational choices below are proposed defaults and should be fixed before inspecting held-out results.

## Abstract

Personal AI requires data that makes an individual's context, behavior, and developing intentions legible. The first load-bearing claim is not that a system can infer a complete reward function or act superintelligently. It is that a temporally correct record of a person's read and write activity contains usable signal about what the person will do next.

We propose a sequence of deliberately small experiments that attempts to invalidate this claim as cheaply as possible. Browser and AI-chat collection begins immediately because prospective context cannot be reconstructed reliably after the fact. In parallel, existing Obsidian Git history is used to validate event reconstruction, action segmentation, chronological splitting, and evaluation code. Once enough browser and chat context has accumulated, a fixed model is used to measure the incremental predictive value of each data source. Only if richer personal context improves prediction do we compare in-context learning, explicit memory or retrieval, and supervised fine-tuning. Only if at least one method exploits the signal do we study scaling with data volume, context budget, recency, and online accumulation.

The primary target is the next human-authored Obsidian macro-action: initially an added sentence or bullet, and later a coherent edit burst. The primary metric for open models is the negative log-likelihood of the observed action. A candidate-ranking task provides a model-independent secondary evaluation. The experiment is successful even when a hypothesis fails, provided the failure isolates a specific weak link: data capture, temporal reconstruction, context signal, context selection, model capability, or adaptation method.

## 1. Purpose

The long-run stack currently implied by the project is:

1. ordinary computer use produces granular personal data;
2. the data can be reconstructed into a faithful chronological event stream;
3. prior events contain signal about the person's next action;
4. a model can extract that signal;
5. personalization through context, memory, or weight updates improves extraction;
6. model predictions can be exposed as useful recommendations;
7. interaction with recommendations supplies preference information;
8. learned preferences can support increasingly capable local action selection and planning.

Later claims depend on earlier ones. Testing the entire stack at once would make a negative result uninterpretable. This toy experiment therefore addresses only Claims 1-5. Recommendation, preference learning, implicit reward modeling, multi-step planning, and multi-agent coordination are downstream work.

The governing principle is:

> Add one source of complexity only after the simpler system works or has failed in a way that identifies what must change.

This is not primarily an attempt to maximize benchmark performance. It is an attempt to learn what the next experiment should be.

## 2. Core Questions

The experiment asks five questions in order.

### Q0. Can the personal event stream be reconstructed faithfully?

Can we determine what information was available before a write, distinguish authored text from copied text, and segment a stream of edits into stable targets? If not, algorithm comparisons are premature.

### Q1. Does the existing Obsidian history support a mechanically valid prediction task?

Can we construct examples, run trivial baselines, score predictions, and reproduce results from a frozen manifest? This stage is a pipeline test, not a strong test of the personal-data thesis. Obsidian-only prediction is expected to be weak because it observes outputs while omitting much of the input that caused them.

### Q2. Does browser and chat context improve next-write prediction?

Holding the model, target set, prompt, and evaluation fixed, does adding temporally prior browser or chat activity reduce held-out prediction loss or improve ranking of the actual next action? This is the first direct test of whether increased legibility creates predictive value.

### Q3. Which personalization mechanism uses the signal best?

Holding the base model, training data, test data, and action representation fixed, how do the following compare?

- no personal history;
- recent raw history in context;
- selected history through explicit retrieval or memory;
- supervised fine-tuning or another direct weight-space update;
- fine-tuning plus retrieval, only after the individual methods are understood.

### Q4. How does the marginal value of personal data change with model capability?

After establishing that at least one method works, how does performance vary with the amount, age, modality, and selection of personal data? More importantly, how does the gain from that personal information change as the underlying model becomes more capable? This capability-by-personal-data interaction is the central local scaling-law question.

## 3. Why Data Collection Begins Before Algorithm Comparison

Browser and chat data should begin accumulating immediately. Obsidian Git history can be reconstructed retrospectively, but the information actually viewed before a write usually cannot. A future browser-history export may reveal a URL, but not necessarily which text was visible, which portion was read, or whether the page was available before a particular thought was written. Chat history may preserve messages, but timestamps, partial responses, tool outputs, deleted conversations, and cross-application ordering may be missing or unreliable.

This does not imply that all other work should wait. Two tracks should proceed concurrently.

### Track A: prospective collection

Collect browser, chat, and Obsidian events in a shared timestamped schema. Audit the collectors continuously so that weeks of unusable data do not accumulate silently.

### Track B: pipeline validation

Use existing Obsidian history to implement diff reconstruction, macro-action segmentation, chronological splits, example serialization, baselines, metrics, and reproducibility manifests. Results from this track should be described as engineering validation unless they show an unusually strong effect.

The first substantive algorithmic experiment begins only after Track A passes its capture-quality gate. Waiting to begin all work would waste time; running the full algorithm matrix before capturing the missing inputs would likely waste compute and produce an ambiguous negative result.

## 4. Scope of the First Prediction Task

### 4.1 Prediction target

The initial target is the next human-authored Obsidian macro-action. The preferred first unit is one newly added sentence or bullet. This is close to the original toy formulation: given the previous Git history of `Entry.md`, predict the next added line or bullet.

The first dataset should exclude or separately label:

- pasted quotations and copied source text;
- formatting-only changes;
- file renames and bulk reorganizations;
- automatic edits made by tools;
- changes whose start time cannot be reconstructed;
- commits containing several independent edits that cannot be separated confidently.

After the append-only task is stable, the target can expand to coherent edit bursts with operations such as append, replace, and delete. A Git commit is evidence used to reconstruct actions; it is not automatically one action.

### 4.2 Prediction input

For a target action at time `t`, the model may receive only events whose content was available before the action began. Later browser content, completed assistant responses that had not yet rendered, subsequent versions of a note, and Git metadata created after the action are forbidden.

The context can include:

- the state and recent history of the target note;
- recent writes in other notes;
- search queries and browser navigation;
- page text that was actually visible or consumed;
- user prompts to AI systems;
- assistant messages and tool results available before the write;
- application, object, and timing metadata.

Browser and chat events are initially inputs, not targets. Restricting the output space to Obsidian writes makes the first comparison easier to interpret. Later experiments may predict search queries, chat prompts, or actions in other applications.

### 4.3 Unit of evaluation

Each held-out example contains:

1. a frozen context cutoff;
2. a versioned context-construction policy;
3. the exact serialized context supplied to the model;
4. one observed next macro-action;
5. source-event references sufficient to audit the example;
6. exclusion and quality flags.

## 5. Data Collection

### 5.1 Common event record

Every collector should emit a common envelope even when its application-specific payload differs.

```yaml
event_id: stable unique identifier
source: obsidian | browser | chat
actor: human | assistant | tool | system
operation: view | query | navigate | append | edit | delete | send | receive
object_ref: file, URL, conversation, or other object
began_at: when the event began
ended_at: when the event ended, if known
available_at: when its content became available to the person
captured_at: when the collector persisted it
content_ref: immutable content or encrypted local reference
content_hash: integrity and deduplication hash
provenance: typed | pasted | rendered | extracted | inferred
collector_version: version of capture logic
privacy_state: retained | redacted | excluded
quality_flags: []
```

`available_at` is crucial. The dataset is intended to approximate what the person could have known at the moment of action, rather than what a collector discovered later.

### 5.2 Obsidian

Capture or reconstruct:

- file and block location;
- prior and resulting text;
- insertion, deletion, and replacement spans;
- typing and idle boundaries when available;
- authored versus pasted content;
- commit and working-tree provenance;
- movement or reorganization of existing text.

Git provides persistence and a useful historical skeleton. More frequent local events may be needed to disaggregate commits containing multiple actions.

### 5.3 Browser

At minimum, collect:

- active tab changes;
- URL and page title;
- searches and submitted queries;
- timestamps for navigation, focus, blur, and close;
- the content actually visible during an interval, when feasible;
- scroll or viewport information sufficient to avoid attaching an entire unread page;
- copied text and its source;
- collector failures and pages whose content could not be accessed.

A page's full text should not automatically be placed at the time the URL was opened. If only part of a paper or video transcript had been consumed before a note was written, only that part belongs in the pre-action context. When this cannot be known, the event must carry uncertainty rather than silently claiming full exposure.

### 5.4 AI chats

At minimum, collect:

- service and stable conversation identifier;
- user messages;
- assistant messages as they become available;
- attachments and linked content when actually accessible;
- tool calls and tool results visible to the user;
- message edits, retries, branches, and deletions;
- send, first-token, and completion timestamps when available.

The context for a write may include only the portion of an assistant response that was available beforehand. A final exported transcript must not be retroactively treated as prior context.

### 5.5 Privacy and integrity

The initial experiment concerns one person's data, but collection still needs explicit exclusion rules. Credentials, financial secrets, private third-party material, and data the person does not want used should be filterable before model access. Raw data, derived examples, model-visible context, and public releases are distinct layers and should not share a single visibility default.

The collector must record gaps. Missingness is part of the dataset; pretending that the captured stream is complete would make later failures harder to diagnose.

## 6. Dataset Construction and Splitting

### 6.1 Chronology

Training, validation, and test data must be separated chronologically. Randomly splitting neighboring edits would leak near-duplicate note state and future project information into training.

The preferred design is rolling-origin evaluation:

1. train or construct memory using an initial time interval;
2. tune fixed choices on the following interval;
3. evaluate on the next untouched interval;
4. advance the boundary and repeat on several future intervals.

Closely adjacent actions from the same editing burst should remain in the same partition. A short temporal embargo around boundaries may be used to prevent one session from crossing train and test.

### 6.2 Readiness gates

Algorithmic comparison should not be triggered by a calendar date alone. The prospective dataset is ready when:

- each source maintains stable identifiers and timestamps;
- target actions can be reconstructed with an acceptably low error rate in manual audit;
- most retained targets have a nonempty, temporally valid preceding context;
- collector outages and missing intervals are explicit;
- enough eligible targets exist to form multiple chronological evaluation windows;
- the evaluation manifest can be rebuilt exactly from raw events.

An early smoke test may use a small number of targets. Claims about context value or adaptation should wait for multiple active days and enough targets that results are not determined by one project or editing session.

### 6.3 Frozen manifests

Before a reported run, freeze:

- raw-data snapshot identifiers;
- collector and segmentation versions;
- inclusion and exclusion rules;
- context policy and token budget;
- train, validation, and test target identifiers;
- model and prompt versions;
- negative-candidate construction;
- metrics and success criterion.

Future data should produce a new manifest rather than mutating an old test set.

## 7. Evaluation Tasks and Metrics

No single metric covers all model types or all parts of an action. We therefore use two complementary tasks.

### 7.1 Generative next-action loss

For models exposing token probabilities, score the observed action under the model:

$$
\mathcal{L}_{\mathrm{NLL}}
=
-\frac{1}{|\mathcal{T}|}
\sum_{t \in \mathcal{T}}
\frac{1}{|y_t|}
\log p_\theta(y_t \mid h_t).
$$

Here, $h_t$ is the strictly prior context and $y_t$ is the observed next action content. Report both total and per-token loss. The main comparison is paired: the same targets under different context or personalization conditions.

Loss can also be decomposed by action field:

- operation type;
- target file or location;
- content.

This prevents success at predicting `append_bullet` from hiding failure to predict what the bullet says.

### 7.2 Candidate ranking

For each context, construct a slate containing the actual next action and several plausible alternatives. Ask the model to score or rank the candidates. Report:

- rank of the observed action;
- mean reciprocal rank;
- top-1 accuracy;
- recall at `k`;
- pairwise win rate of the observed action against alternatives.

Negatives should be difficult enough to test personalization. Useful negatives include actions from the same file, project, time period, and approximate length. Random text from unrelated notes would make the task artificially easy. Candidate ranking also permits comparison with closed models that do not expose reliable token probabilities.

### 7.3 Human usefulness is not the primary metric yet

The original notes consider ranking predictions by expected personal usefulness as well as predictive ability. These should be separated. The toy's primary question is whether the system predicts the observed next action. Usefulness requires counterfactual judgment and belongs to the later recommendation phase.

A small blinded human review may still diagnose whether high-probability alternatives are semantically appropriate despite differing from the recorded action, but it must not silently replace the preregistered prediction metric.

### 7.4 Uncertainty

Actions within a day or editing session are correlated. Confidence intervals should therefore resample at the day or session level rather than treating every target as independent. Report paired effects and intervals, not only aggregate averages.

## 8. Related Work and Baseline Selection

Related work belongs in this proposal when it supplies an executable comparison or a diagnostic design choice. The goal is not to establish that every adjacent research area has been surveyed. Each adopted baseline should answer a specific question about the stack while changing as little else as possible.

### 8.1 Direct next-action prediction

[Learning Next Action Predictors from Human-Computer Interaction](https://arxiv.org/abs/2603.05923) is the closest direct precedent. It formalizes next-action prediction from longitudinal multimodal computer-use streams, introduces NAPsack for grouping and labeling interaction bursts, and compares prompted, retrieval-augmented, supervised fine-tuned, and learned reason-retrieve-predict systems. Its LongNAP method learns user-specific reasoning traces, retrieves related traces and observations with BM25, and predicts a future natural-language action trajectory.

This work supplies three core baselines that should be reproduced even if the full LongNAP system is not initially run:

1. recent-context prompting without retrieval;
2. BM25 retrieval over prior observations followed by prompted prediction;
3. supervised fine-tuning on chronological next-action examples.

The full LongNAP method is an advanced baseline after these components are understood. As of this proposal, its [project page](https://generalusermodels.github.io/nap/) marks the GitHub release as forthcoming, so the toy experiment should not depend on its release. Its reported numbers are also not directly comparable: LongNAP predicts multi-action natural-language trajectories from screen activity and uses semantic similarity judged by an LLM, whereas the initial toy predicts one bounded write action and can compute its likelihood directly.

[A Click Ahead](https://arxiv.org/abs/2309.12170) provides a deliberately simpler precedent. It trains a small recurrent model on approximately one week of one person's keyboard and mouse activity to predict the next action from the previous five actions over a fixed vocabulary. That closed action space cannot model the semantic content of a new bullet, but it provides a useful low-capacity baseline for structured fields such as application, operation type, file, or coarse action class. A GRU that consumes the previous few structured actions should therefore be included in the smoke-test stage. It can reveal whether an apparent LLM gain is merely short-range repetition.

### 8.2 Raw history, semantic memory, and inferred objectives

[Creating General User Models from Computer Use](https://arxiv.org/abs/2505.10831) supplies a semantic-memory baseline. A General User Model converts observations into confidence-weighted propositions about the person's current state, habits, knowledge, and preferences; retrieves relevant propositions; and revises them as new evidence arrives. Its [implementation is available](https://generalusermodels.github.io/gum/). For the toy experiment, the relevant comparison is not its proactive assistant. It is whether a prompted next-action predictor performs better with retrieved GUM-style propositions than with retrieved raw events under a matched context budget.

This baseline tests whether lossy semantic abstraction helps. It should retain links from every proposition to its source observations so that errors can be attributed to inference, retrieval, or prediction. Propositions must not be treated as observed facts.

[Just-In-Time Objectives](https://arxiv.org/abs/2510.14591) supplies a complementary goal-abstraction baseline. It infers a short, explicit current objective from a snapshot of user context, then conditions both generation and evaluation on that objective. Unlike a longitudinal user model, the method primarily asks what the person is trying to accomplish now. The paper intentionally evaluates a minimal context setting using one screenshot, making it a useful test of whether current context contains enough information to infer a task-level objective without a long personal history.

For this toy, define a JIT-objective condition as follows:

1. give an objective-induction model exactly the temporally valid context available to the predictor;
2. produce one or more weighted natural-language objectives;
3. add the objectives to the next-action generation or candidate-ranking prompt;
4. score against the actual held-out action using the toy's objective metrics.

Compare this with the same predictor receiving raw context, retrieved raw events, and GUM-style propositions. This isolates three representations of the same evidence: event history, semantic beliefs, and an explicit current goal. A gain from JIT objectives would support the bridge from legible behavior to local goal inference, but would not prove that a stable reward function had been recovered.

### 8.3 Demonstration-derived preference optimization

[Show, Don't Tell: Aligning Language Models with Demonstrated Feedback](https://arxiv.org/abs/2406.00888) introduces DITTO, a few-shot adaptation method with an [available implementation](https://github.com/SALT-NLP/demonstrated-feedback). DITTO treats user demonstrations as preferred to samples from the base model and intermediate checkpoints, then uses those induced comparisons for preference optimization. It is designed for very small demonstration sets and directly compares against few-shot prompting and SFT.

DITTO is relevant because the personal action stream already contains demonstrations. It can be adapted by treating each chronological pair $(h_t,y_t)$ as a demonstrated response: sample alternative next actions from the current model, rank the observed action above those samples, retain replay and inter-policy comparisons, and train with the same base model used for SFT.

This is not a neutral replacement for behavioral cloning. It adds the assumption that the person's observed action is preferable to the model's sampled alternatives. Ordinary work traces may contain mistakes, expedient actions, or actions the person would reject on reflection. DITTO should therefore be an advanced Phase 1 baseline run after plain SFT, with the assumption and any filtering stated explicitly. If it improves prediction, the result shows that negative contrast helps model the demonstrated policy; it does not yet establish that the learned policy improves the person.

### 8.4 Continual-learning evaluation

[Continual Learning Bench](https://arxiv.org/abs/2606.05661) is not a direct personal next-action baseline. Its useful contribution here is experimental structure: compare a stateless system, naive ICL, and dedicated memory while measuring improvement from sequential experience separately from the underlying model's initial capability. Its [benchmark harness](https://continual-learning-bench.com/) also demonstrates how to report both absolute performance and gain across an ordered sequence.

The toy should adopt that separation. For each model, report:

- absolute performance without personal history;
- absolute performance with the permitted history;
- personal-history gain, computed as the paired difference on identical future targets;
- how that gain changes across chronological evaluation windows.

This prevents a stronger base model from appearing to be a better continual learner merely because it starts at a higher level.

### 8.5 Adopted baseline schedule

The baselines should enter in stages rather than as one large initial leaderboard.

| Stage | Baselines | Question isolated |
|---|---|---|
| Pipeline smoke test | frequency baseline, current-note continuation, five-action GRU | Does the evaluation behave sensibly, and how much comes from short-range repetition? |
| Data-source value | no personal context, correct raw context, shuffled or wrong-time context, oracle-selected context | Does the captured personal stream contain temporally specific predictive signal? |
| Core mechanism comparison | recent-context ICL, BM25 retrieval over raw events, chronological LoRA SFT | Should the same evidence live in prompt space, selected memory, or weights? |
| Representation comparison | GUM-style retrieved propositions, JIT inferred objectives | Does semantic compression or explicit goal inference improve use of the evidence? |
| Advanced adaptation | DITTO, full LongNAP-style learned retrieval when practical | Do negative contrast or learned retrieval improve beyond the simple methods? |
| Longitudinal evaluation | stateless, ICL, memory, and weight-updated systems repeated over future windows | Does the system actually improve from accumulating experience? |

Every condition must use the same target set and respect the same temporal cutoff. Where the underlying model must differ, report that as a separate capability comparison rather than attributing the result entirely to the algorithm.

### 8.6 Deliberate exclusions

Memory systems evaluated only on question answering or factual recall are not primary baselines for next-action prediction. Neither are recommendation, coactive preference learning, online DPO from proposal exposure, reward-model planning, or autonomous computer-use agents. Those methods address later links in the stack. They should be introduced only after the toy establishes that the captured personal stream contains usable signal and that at least one simple mechanism can exploit it.

## 9. Experimental Staircase

### Experiment 0: Collector and reconstruction audit

**Question:** Is the data representation faithful enough to support any later claim?

Procedure:

1. Sample events and target actions across sources and days.
2. Reconstruct the timeline and compare it manually with the raw application history.
3. Verify timestamps, content availability, authorship, copied-text provenance, and action boundaries.
4. Attempt to rebuild the same examples twice from the frozen raw snapshot.

Pass condition:

- reconstruction is reproducible;
- severe ordering or authorship errors are rare and explicitly measurable;
- ambiguous examples can be excluded without manual one-off edits to the test set.

If this fails, improve collection and segmentation. Do not interpret model loss.

### Experiment 1: Obsidian-only pipeline smoke test

**Question:** Can the complete evaluation pipeline run on existing data?

Conditions:

1. unconditional or frequency baseline;
2. target-note prefix only;
3. recent Obsidian state;
4. longer Obsidian history;
5. a five-action GRU predicting structured action fields.

This experiment validates serialization, model calls, scoring, chronological splits, caching, and reporting. A weak result is expected and does not yet refute the value of personal context, because much of the causal input is absent.

Pass condition:

- the pipeline is reproducible;
- trivial leakage tests fail to reveal future information;
- metrics respond sensibly to deliberately informative and deliberately corrupted contexts.

### Experiment 2: Data-source value

**Question:** Does added read context improve prediction?

Use one fixed, strong model and one fixed context-construction method. Evaluate the same held-out targets under cumulative conditions:

1. local note state only;
2. plus prior Obsidian history;
3. plus prior AI-chat events;
4. plus browser metadata and queries;
5. plus browser content actually consumed;
6. full captured read/write stream.

Add leave-one-source-out comparisons after the cumulative run if interactions between sources make attribution unclear.

Do not mix representation methods into the primary modality attribution. If the full stream improves prediction, run a secondary diagnostic on the same targets and source events comparing: full raw context, automatically retrieved raw events, GUM-style retrieved propositions, and an induced JIT objective. Keep the downstream predictor fixed. This asks how the useful evidence should be represented without changing the conclusion about which data source supplied it.

The model should be held fixed here because the purpose is to evaluate the data, not algorithms. A strongest-accessible model is useful as a signal detector: if a capable model cannot use the context, immediately training smaller models is unlikely to clarify whether the data contains value.

Primary comparison:

$$
\Delta_m
=
\mathcal{L}(h_t^{\text{without modality }m})
-
\mathcal{L}(h_t^{\text{with modality }m}).
$$

A positive value indicates that modality $m$ reduced loss.

Interpretation:

- **Full context improves:** proceed to algorithm comparison.
- **Metadata improves but raw content does not:** context selection or noise is likely the bottleneck.
- **Manually selected relevant context improves but automatic context does not:** retrieval or representation is the bottleneck.
- **No context condition improves:** inspect capture fidelity, target predictability, model capability, and the possibility that the chosen next action is inherently underdetermined before proceeding.

For a small diagnostic subset, manually identify the prior observations that plausibly informed each write. This oracle-context condition is not a deployable method; it distinguishes missing signal from failed context selection.

### Experiment 3: Personalization mechanism

**Question:** Given evidence that the stream contains usable signal, where should personalization live?

Hold constant:

- base model;
- chronological train and test targets;
- event representation;
- maximum information available by time;
- evaluation metrics.

Run the comparison in tiers.

Core mechanisms:

1. no personal history;
2. fixed recent raw context;
3. BM25 retrieval over prior raw events;
4. supervised fine-tuning on prior next-action examples.

Representation baselines, using the same evidence:

5. GUM-style retrieved propositions;
6. an inferred JIT objective added to generation or candidate ranking.

Advanced adaptation, only after the simpler methods are understood:

7. DITTO using the observed next action as the demonstration and sampled actions as negatives;
8. a full LongNAP-style learned reason-retrieve-predict method when practical;
9. fine-tuning plus retrieval, after weight-space and retrieval-only methods are understood separately.

The primary comparison should use the same open model wherever possible. A frontier-model ICL result may be reported separately as a capability ceiling, but it should not be used to conclude that prompt-space adaptation is superior to weight-space adaptation when the underlying models differ substantially.

Interpretation:

- **Raw ICL works; retrieval does not:** the memory implementation is discarding useful information.
- **Retrieval works; raw ICL does not:** selection and context budget matter more than total raw context.
- **GUM propositions beat retrieved raw events:** semantic compression is removing more noise than useful evidence.
- **JIT objectives beat raw and proposition context:** an explicit current-goal abstraction is especially predictive.
- **SFT works; context methods do not:** relevant regularities may be easier to encode in weights than retrieve at test time.
- **Context works; SFT does not:** sample size, training construction, or catastrophic averaging may be the bottleneck.
- **DITTO beats SFT:** sampled negative actions provide useful contrast, conditional on the stronger demonstrated-preference assumption.
- **LongNAP beats fixed BM25:** learned reasoning and retrieval add value beyond a conventional retriever.
- **No method beats the no-history model despite Experiment 2 succeeding:** the comparison has introduced a representation, capacity, or implementation failure.

### Experiment 4: Local scaling laws for personal data and model capability

**Question:** How does the marginal predictive value of personal information vary with the information available and the capability of the underlying model?

Only run this after selecting one or two functioning methods. Vary separate axes rather than calling all of them "amount of data."

For model capability level $M$, personal-history quantity $D$, selected personalization method $R$, and future evaluation window $w$, define the marginal personal-history gain as

$$
\Delta_{\mathrm{local}}(M,D;R,w)
=
\mathcal{L}(M,0;R,w)
-
\mathcal{L}(M,D;R,w).
$$

Here $D=0$ is the matched no-personal-history condition for that model, and a positive value means that personal history reduced held-out loss. Candidate-ranking gains should be defined analogously for models without comparable token probabilities. Absolute performance remains important, but the primary scaling object is the improvement attributable to personal history at each capability level.

The first crossed design should hold $R$, the target set, action representation, and evaluation protocol fixed while evaluating multiple chronological history quantities $D_0,\ldots,D_k$ at every selected capability level $M_1,\ldots,M_j$. Plot $\Delta_{\mathrm{local}}(M,D)$ against $D$ with one curve per model. Differences in slope, sample efficiency, saturation, or asymptotic gain indicate whether general capability and personal experience are complements, substitutes, or approximately independent.

#### Training-history volume

Train or build memory using progressively larger chronological prefixes. This tests whether more accumulated personal experience improves future prediction.

#### Test-time context budget

Hold training history fixed while varying how many selected tokens or events are available for a target. This tests context selection and saturation, not learning from additional experience.

#### Recency and data half-life

Compare recent windows with older windows of similar size. Remove history by age as well as through random dropout. Random removal alone conflates redundant examples with stale information.

#### Modality

Vary Obsidian, browser, and chat coverage while holding target actions fixed. This tests which forms of legibility contribute predictive signal.

#### Model capability and its interaction with personal history

After data and method effects are understood on one model, repeat the same history quantities and no-history baseline across frontier, older, open, and local models. First use a shared prompt-space or retrieval method wherever possible so that differences more cleanly reflect capability. Separately report an access-constrained system comparison between the best available closed-model prompt-space method and open-model weight-space methods. That comparison answers a practical deployment question, but it must not be presented as an isolated causal estimate of prompt space versus weight space because base capability and model access also differ.

The desired output is a family of capability-conditioned local scaling curves, not a single leaderboard number. A positive capability-by-data interaction means that stronger models extract more marginal value from personal history; a negative interaction means that general capability substitutes for some personal evidence; a near-zero interaction means that personalization supplies a relatively stable gain across capability levels. All three are informative outcomes.

### Experiment 5: Prospective repetition

**Question:** Do the conclusions hold as new data arrives and the person's work changes?

Repeat the frozen evaluation protocol on future windows. Each run trains or constructs memory only from earlier data and evaluates on a newly sealed interval. Track:

- absolute performance;
- improvement from added personal context;
- improvement from each personalization mechanism;
- changes in which modalities matter;
- decay or transfer across projects;
- collector and representation changes.

This is the first meaningful test of continual personalization. It should remain offline. Exposing recommendations would change the data-generating process and begins the separate coactive-learning experiment in [[Paper]].

## 10. Baselines and Sanity Checks

At minimum, include:

- unconditional action-type and file frequencies;
- continuation using only the current note prefix;
- a five-action GRU for structured action fields;
- recency-only history;
- BM25 retrieval over raw events;
- GUM-style proposition retrieval;
- JIT objective induction from the current context;
- chronological LoRA SFT;
- DITTO after SFT is understood;
- LongNAP-style learned retrieval when practical;
- shuffled personal history;
- history from the wrong time period;
- history with timestamps destroyed;
- no-personal-context base model;
- an oracle context selected manually for a small diagnostic subset.

Shuffling and wrong-person controls are valuable because a model might improve merely from receiving more topical English text. If true personal chronology does not outperform plausible but mismatched context, the result does not yet establish personalization.

Deliberately insert a future event in a private test fixture and verify that leakage detection catches it. Deliberately corrupt timestamps and content provenance to verify that the audit reports change.

## 11. Weakest-Link Decision Table

| Observation | Most likely weak link | Next action |
|---|---|---|
| Timeline cannot be reconstructed reliably | collection or segmentation | fix collectors and target construction |
| Obsidian smoke test is unstable or irreproducible | evaluation pipeline | fix manifests, splitting, and scoring |
| Oracle context helps but automatic context does not | retrieval or context construction | improve selection before training |
| Browser/chat context does not help, including oracle context | missing signal, model capability, or target unpredictability | inspect targets and capture before adding algorithms |
| Added context helps but only on style-like metrics | content learning is unproven | add content-sensitive ranking and hard negatives |
| ICL works but SFT does not | weight-update data or optimization | debug SFT; do not infer weights are intrinsically worse |
| SFT works but ICL does not | context budget or retrieval | test memory and context selection |
| JIT objectives work but longitudinal memory does not | current task inference dominates stable personal history | prioritize local objective capture and test when history adds marginal value |
| GUM propositions work but raw retrieval does not | raw history is too noisy for the context budget | improve semantic compression while retaining source provenance |
| DITTO works but SFT does not | negative contrast is informative | retain DITTO as a prediction method while keeping its preference assumption explicit |
| Methods improve offline but decay quickly | data half-life or project shift | emphasize recent updates and online repetition |
| No current method exploits demonstrably useful data | algorithmic benchmark | preserve the dataset and expose the failure clearly |

The final row is an acceptable research outcome. It turns the personal stream into a concrete continual-learning benchmark rather than forcing a downstream recommendation system to be built on an invalidated foundation.

## 12. Main Confounds to Prevent

### 12.1 Data amount, context amount, and training amount

These are different variables. More historical events, more tokens in one prompt, more retrieved memories, and more optimization examples must not be treated as the same scaling axis.

### 12.2 Model capability versus personalization method

Comparing a frontier model using ICL with a smaller open model using SFT confounds algorithm and base capability. First compare mechanisms on the same model; then compare model classes.

### 12.3 Style versus content

Lower token loss may come from learning punctuation, casing, vocabulary, and note structure. Report content-sensitive candidate ranking with hard negatives sharing similar style. Also decompose predictable operation and location from semantic content.

### 12.4 Chronological leakage

Current note snapshots, retroactively attached page text, completed chat responses, and neighboring edits can expose future information. Every example must be reconstructible from immutable events available before the target began.

### 12.5 Action granularity

Word-level actions are numerous but noisy; entire commits are clean but may combine several intentions. Sentence, bullet, or coherent edit bursts are the initial compromise. Results should be reported by segmentation version.

### 12.6 Copying versus authorship

Pasted source text is not equivalent to a self-generated continuation. It may still be a meaningful action, but it requires distinct provenance and should not be scored as though the model were expected to invent the copied text.

### 12.7 Behavioral adaptation to collection

Knowing that activity is recorded may change writing, browsing, or chat behavior. Collector visibility and major workflow changes should be logged. Online comparisons should not assume stationarity.

### 12.8 Prediction versus preference

Observed behavior is not automatically optimal behavior. Success at predicting a next action establishes modeling ability, not alignment with an ideal self or proof of a true reward function. That bridge remains a later hypothesis.

### 12.9 Inferred-objective circularity

An objective or proposition generated by the same model that later scores candidates can create self-consistent but behaviorally false improvements. Primary evaluation must remain tied to the actual held-out action. Report the objective-induction model separately from the predictor and evaluator, and use an independent model or human audit for a diagnostic subset.

## 13. Success Criteria

The overall toy program succeeds if it produces an interpretable answer to each reached gate.

### Data success

A versioned, temporally ordered read/write stream can be reconstructed and audited without relying on future information.

### Signal success

Adding correct personal browser or chat context produces a repeatable improvement over the same model without that context on future actions.

### Personalization success

At least one of ICL, raw-event retrieval, semantic memory, JIT objective conditioning, SFT, or demonstration-derived adaptation improves over a no-history baseline on future actions, and the effect is not explained solely by style or leakage.

### Scaling success

Marginal personal-history gain is estimated for multiple history quantities and multiple model-capability levels on matched future targets. The resulting curves characterize whether the value of personal experience changes systematically with capability, while separate curves identify effects of context budget, modality coverage, and recency. Complementarity is not required for a scientifically useful result: substitution, independence, saturation, or a stable null result are also interpretable if estimated with adequate uncertainty and replicated on prospective windows. A product-facing positive result additionally requires a repeatable, content-sensitive gain from correct personal history over the matched no-history and mismatched-history controls.

The exact minimum effect size should be fixed after the pipeline smoke test but before examining the substantive held-out comparison. It should be large enough to affect a product or research decision, not merely statistically distinguishable because many correlated edits were counted as independent.

## 14. Implementation Order

1. Start browser and chat collectors immediately.
2. Define the common event envelope and local privacy boundaries.
3. Reconstruct append-only Obsidian targets from existing Git history.
4. Build chronological manifests and leakage tests.
5. Implement trivial, no-context, and five-action GRU baselines.
6. Run the Obsidian-only smoke test while richer data accumulates.
7. Audit prospective browser/chat timelines manually and repair collectors.
8. Freeze the first multimodal read/write dataset.
9. Run the data-source value experiment with one fixed strong model.
10. If signal exists, compare recent-context ICL, BM25 retrieval, and SFT on one fixed open model.
11. Compare GUM-style proposition memory and JIT objective conditioning against the same raw evidence.
12. If the simple methods work, add DITTO and a LongNAP-style learned retrieval condition.
13. Cross selected model-capability levels with chronological history quantities, then measure context-budget scaling, recency, modality, and data half-life using the methods that survived.
14. Repeat on future sealed windows.
15. Only then design the recommendation and coactive-preference experiment.

This order moves quickly because collection and pipeline development overlap, but each reported comparison changes one main uncertainty at a time.

## 15. Required Artifacts

The toy program should produce:

- versioned Obsidian, browser, and chat collectors;
- an immutable or content-addressed raw event store;
- a reproducible event-to-action segmentation pipeline;
- dataset and context manifests;
- chronological split definitions;
- leakage and provenance tests;
- frequency, GRU, raw-ICL, BM25, GUM, JIT-objective, SFT, DITTO, and learned-retrieval evaluation adapters;
- generative and candidate-ranking metrics;
- capability-conditioned local scaling curves, marginal personal-history gains, and interaction estimates with uncertainty;
- a qualitative failure analysis keyed to source events;
- a short decision report after each experimental gate.

The decision reports matter as much as the final benchmark. Each should state which assumption survived, which failed, and what new complexity is justified next.

## 16. Non-Goals

This experiment does not attempt to establish:

- a complete or stable human reward function;
- that recorded behavior is optimal;
- that prediction necessarily implies understanding;
- that recommendations improve the person;
- online preference optimization from live proposal exposure; DITTO is included only as an offline demonstration-derived algorithm baseline;
- an implicit value function for long-horizon planning;
- autonomous computer use;
- multi-agent coordination;
- cross-user or enterprise generalization;
- a final product architecture.

Those questions become worth testing only after the event stream has demonstrated predictive signal and at least one tractable method can use it.

## 17. Conclusion

The fastest path is not to run the largest model-method-data matrix immediately. It is to collect the irrecoverable browser and chat context now while using existing Obsidian history to make the pipeline real. The first substantive experiment then holds the model fixed and asks whether richer personal context improves prediction. The second holds the model and data fixed and asks whether raw ICL, retrieval, semantic memory, inferred objectives, or SFT uses that signal best. Demonstration-derived preference optimization and learned retrieval enter only after the simpler comparisons. Scaling, half-life, online repetition, and model-class comparisons follow only after these earlier claims survive.

This sequence preserves the original ambition while making failure useful. It can show that collection is inadequate, that personal context lacks signal for the chosen target, that context construction is poor, that current algorithms cannot exploit the signal, or that one personalization mechanism works. Any of those results is more valuable than a complex end-to-end system whose failure cannot be located.
