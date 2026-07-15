# From Behavioral Cloning to Coactive Preference Learning in Personal Read–Write Streams

*A method draft for learning personalized action policies and implicit utility scores from ordinary computer use*

**Status:** Working paper draft. This document specifies the motivation, related work, problem formulation, objectives, records, and algorithms for Phases 1 and 2. It intentionally contains no abstract, results, conclusion, or future-work section.

## 1. Introduction and Motivation

Modern language models are broadly capable but weakly grounded in the local objectives of a particular person. An enterprise assistant may know how to write, search, analyze, or operate software, yet still lack the tacit context required to decide which of those actions would be useful for one employee at one moment. Explicit prompts reveal only a small fraction of this context. Ratings and rankings provide clearer preference labels, but they impose enough friction that they are unlikely to capture a person's work continuously.

Ordinary computer use supplies a denser signal. A person reads documents, browses pages, receives messages and model outputs, edits notes, writes queries, sends messages, and changes artifacts. These events form a temporally ordered stream in which inbound information is followed by outbound action. The first premise of this work is that the stream can supervise a personalized next-action model without requiring the person to label a separate dataset. Given the information that was actually available before a write event, the model is trained to predict the write event that actually followed.

Prediction alone, however, is bounded by imitation. A sufficiently accurate behavioral clone reproduces the person's historical action distribution; it does not by itself distinguish actions that express a goal well from actions that merely occurred. This is especially limiting in the intended setting. The useful regime is one in which a person's actions overlap substantially, but not perfectly, with their goals. If action and goal were unrelated, the history would not identify a useful policy. If they were identical, there would be no ceiling to raise through assistance.

The second premise is that a predictive model can create useful contrastive data by sampling several plausible next actions and exposing them to the person during normal work. These outputs are not conventional recommendations. The interface does not ask the person to select or accept one. Instead, the proposals become part of the person's information state. The person may ignore them, copy one, refine one, combine several, or produce a continuation that would not have occurred without seeing them. The final human continuation is therefore a response to an intervention, not an uncontaminated sample from the pre-intervention human policy.

We formulate this interaction as **coactive preference learning**. At decision time $t$, the current policy samples a slate of candidate continuations from the pre-display context. After observing the slate, the person supplies a final continuation in the same action space. Subject to explicit comparability and exposure checks, that continuation is treated as a weak improvement over each displayed candidate—not as a globally optimal answer and not as evidence about an unobserved counterfactual human action. This interpretation turns the interface into a low-friction correction channel: the model proposes; the human continues working; the difference supplies a preference update.

This formulation has two practical consequences. First, Phase 2 does not require clicks. The training record contains the pre-display context, the candidates actually rendered, and the human continuation that followed. Second, the final continuation is scored under the **pre-display** context. The displayed slate is retained for attribution and auditing, but it is not included in the policy input for the core preference comparison. The update therefore teaches the policy to produce the improved continuation directly from the original state rather than merely to predict how a human responds after seeing model text.

The proposed system has two phases, with Phase 1 divided into initial training and continual adaptation:

1. **Behavioral modeling.** Phase 1A trains an autoregressive policy on temporally interleaved read and write events. Phase 1B continually updates a versioned behavioral policy from newly finalized actions mixed with stratified historical replay. Read events enter the context; human write events are the prediction targets.
2. **Coactive improvement.** Phase 2 samples and displays multiple continuations from the current policy, observes the human continuation, and optimizes a mixture of continued behavioral cloning and pairwise preference learning against a frozen behavioral-policy anchor.

The preference objective yields a policy/reference log-ratio that can be interpreted as an implicit, context-dependent utility score. This gives the direction enterprise value before any long-horizon autonomous agent exists: candidate drafts can be reranked for a particular employee, proactive continuations can become more useful, and later planning systems can use the score as one input to local action evaluation. The score is not yet a complete reward for arbitrary trajectories. It represents revealed preference over comparable, one-step continuations under the deployed human–model interaction loop.

This draft makes six concrete design commitments:

- It models observed computer activity as an ordered event stream rather than a question–answer corpus.
- It uses bounded, semantically meaningful write events as actions and applies loss only to the action target, not to prior context tokens.
- It treats behavioral modeling as a continual system: a low-rank personal adapter is updated asynchronously with token-budgeted microbatches, gradient accumulation, and a stratified replay buffer, then published only after recent-performance and forgetting checks.
- It treats displayed model continuations as on-policy contrastive examples and the subsequent human continuation as a weak coactive correction.
- It combines continued behavioral cloning with Identity Preference Optimization (IPO) against a fixed anchor policy, producing an inspectable implicit utility score while a separate current behavioral-policy version may continue to adapt.
- It logs enough provenance—event boundaries, exposure, policy versions, reference scores, and candidate-generation parameters—to reproduce every preference record and change the estimator later.

The intended claim is deliberately narrow. Phase 1 estimates a versioned, time-local personalized action policy and tests whether continual updates track behavioral drift without unacceptable forgetting. Phase 2 estimates local preferences over proposed actions in a collaborative equilibrium shaped by both the model and the person. Neither phase alone identifies a person's stable latent goals, and neither justifies unconstrained multi-step optimization.

## 2. Related Work

### 2.1 Behavioral cloning and learned human models

Behavioral cloning learns a policy by maximizing the likelihood of demonstrated actions conditional on observed state. It is the most direct formulation of Phase 1. Carroll et al. study learned human models for human–AI collaboration and show the utility of separating a model of human behavior from an agent trained to collaborate with it [1]. Their setting has externally specified game rewards, whereas the present setting begins with natural work traces for which no task-level reward is generally available.

Matti et al. provide an earlier task- and application-agnostic precedent for personalized next-action prediction [20]. They train recurrent models on approximately one week of a single user's keyboard and mouse activity to predict the next action from the preceding five actions over a fixed vocabulary of 442 recurring input classes. Their low-level discrete representation and short context differ from the semantically bounded, open-ended write actions and richer event history proposed here, but their results establish the feasibility of learning real-time computer-action predictions from an individual's ordinary use.

Shaikh et al. formalize next action prediction from naturalistic computer use and introduce NAPsack, a passive VLM annotation pipeline, and LongNAP, a retrieval-augmented predictor trained with an LLM-judged temporal similarity reward [13]. This is the closest direct precedent for Phase 1: both works learn person-specific future actions from chronological interaction streams. Their target is an eight-action trajectory of unified natural-language computer events, however, whereas the present proposal predicts one bounded human write action from a functional separation of reads and writes. LongNAP also addresses long-history selection through generated reasoning traces and retrieval rather than the versioned context construction specified here. It does not collect proposal exposure and post-exposure human corrections, so it does not supply the coactive preference records required for Phase 2.

Kobayashi et al. study autoregressive action predictors trained on unlabeled observation–action trajectories from goal-directed agents and show, in controlled hierarchical environments, that their residual streams encode linearly decodable beliefs about latent subgoals and support temporally abstract internal controllers [14]. This provides controlled evidence that next-action prediction can learn task structure beyond surface action frequencies and suggests a possible bridge from a behavioral prior to later hierarchical control. Their demonstrations come from expert or near-expert agents in fixed grid-world and continuous-control tasks, however, and their downstream internal reinforcement learning uses an externally specified sparse success reward. The result therefore does not establish that ordinary human work traces identify a user's utility, nor does it provide the coactive preference signal used in Phase 2.

Classical behavioral cloning is vulnerable to covariate shift when the learned policy takes actions that move an environment into unfamiliar states. DAgger addresses this by querying an expert in states induced by the learner [2]. The proposed Phase 2 shares DAgger's on-policy corrective intuition, but the interaction is different: the system does not execute a trajectory and request an expert action at every visited state. It displays candidate macro-actions, then passively observes the person's next macro-action during ordinary work.

Phase 1 should not be described as reward inference. Maximum-likelihood imitation can assign high probability to observed actions without identifying why the person took them. The contrastive signal introduced in Phase 2 is what supports a relative utility interpretation.

Inverse reinforcement learning instead attempts to recover a reward that explains demonstrated trajectories. AIRL learns rewards through adversarial training with agent rollouts and environment dynamics [15]. D-REX weakens the expert-demonstrator assumption by injecting noise into a behavioral-cloning policy to construct automatically ranked trajectories, then learning and optimizing a reward that can outperform the original demonstrator [16]. These methods show how trajectory rankings can move beyond pure imitation, but they do not instantiate the present setting: the proposed records contain local post-exposure comparisons rather than executed agent trajectories, and their ordering comes from a human continuation rather than injected noise.

### 2.2 Continual adaptation and dynamic evaluation

The person's activity distribution is not stationary. Projects, collaborators, applications, vocabulary, and habits change, so a one-time behavioral clone becomes stale even if its original training loss was low. Dynamic evaluation adapts a language model to recent sequence history through continued likelihood updates and has improved prediction of recurring sequential patterns [21]. The present proposal adopts the operational principle—adapt from recent chronological data—but updates a bounded personal adapter asynchronously rather than mutating the full serving model after every token.

End-to-End Test-Time Training reframes long-context modeling as continual learning: a model uses next-token prediction to compress observed context into weights, while meta-learning optimizes the initial weights for their ability to adapt at test time [22]. This result is relevant because an initialization optimized only for current training loss need not be an initialization that learns efficiently from a person's future stream. It does not make meta-learning a prerequisite for the first experiment. The minimal system first tests ordinary continual behavioral cloning with replay and publication gates; meta-learned initialization is an escalation path if that system adapts too slowly or unstably.

Continual adaptation creates a stability–plasticity problem. Training only on the newest editing session can overfit a correlated local distribution and forget older workflows; training uniformly on all history can prevent the policy from tracking genuine change. The proposed system therefore distinguishes a recent-data window from stratified historical replay and evaluates both recent chronological likelihood and fixed historical retention. Replay changes the chosen training distribution and reduces short-range correlation, but it does not make the underlying human stream independent and identically distributed.

### 2.3 Generative sequential recommendation

Recent recommender systems cast recommendation as autoregressive sequence modeling. HSTU models user histories as sequential transduction and demonstrates that generative architectures can replace several conventional recommendation components [3]. Shopify's generative recommendation system similarly trains on raw customer event sequences, predicts subsequent products autoregressively, and uses negative sampling to improve ranking [4]. These systems demonstrate that useful prediction and ranking can be learned without a complete causal model of how exposure changes users.

The analogy is operationally valuable but incomplete. Conventional recommender systems usually choose from a catalog and observe clicks, purchases, or other discrete outcomes. Here the action space is open-ended text and structured computer operations, and the human rarely accepts a candidate literally. The displayed outputs alter the information available to the person, after which the person synthesizes a new action. We therefore borrow sequential event modeling and hard-negative generation from recommender systems while replacing click-based recommendation language with a coactive proposal-and-correction loop.

### 2.4 Coactive learning

Coactive learning assumes that a system proposes a structured output and a user returns a slightly improved output rather than an optimal label. Shivaswamy and Joachims show that such improvements can support online learning even when optimal demonstrations are costly [5]. Tucker et al. develop a coactive algorithm for LLMs from implicit feedback in user edits [6]. This is the closest conceptual match to the intended interface: the observed human continuation need only improve on the displayed proposal in context.

The present setting differs in three respects. The system presents a slate rather than a single structured object; the correction can be a synthesis that does not explicitly reference any candidate; and the feedback is collected as a natural work event rather than through a dedicated correction box. These differences make exposure logging and comparability filters necessary. They also weaken the preference label: $y_t \succ z_{t,i}$ is an estimator assumption, not a directly observed click.

Kleine Buening et al. likewise learn directly from ordinary user interactions without explicit preference labels [17]. Their method conditions on a later user message to construct a hindsight token distribution, then distills that distribution into the policy. This is a close alternative estimator for the same broad source of supervision. The present proposal instead constructs explicit coactive pairs between the post-exposure human continuation and the candidates actually rendered, scoring both from the pre-display context rather than using the follow-up as a teacher hint for the original model response.

### 2.5 Direct and identity preference optimization

Direct Preference Optimization (DPO) reparameterizes a KL-regularized reward optimization problem so that a language-model policy can be optimized directly from preferred and dispreferred completions relative to a reference policy [7]. Its policy/reference log-ratio provides the basis for an implicit reward representation.

Azar et al. place DPO within a broader family of preference objectives and introduce Identity Preference Optimization (IPO) [8]. IPO replaces the unbounded logistic separation encouraged by DPO with a squared objective targeting a finite log-ratio margin. This bounded target is attractive when labels are weak and noisy, as they are here. Calandriello et al. further study online IPO, where candidate responses are sampled from the evolving policy and then labeled [9]. The proposed Phase 2 is on-policy at collection time and can be trained in periodic microbatches from versioned replay.

Multiple displayed candidates could alternatively be handled with a listwise or softmax preference loss. Pairwise IPO is the initial choice because it makes the weak label and every exclusion decision visible: the human continuation is paired only with candidates that were rendered, comparable, and not equivalent. A listwise loss remains an estimator substitution rather than a change to the data model.

### 2.6 Personalized rewards and influenceable preferences

Personalized reward modeling conditions judgments on individual or group differences rather than fitting a single population reward. Recent work studies personalized reward benchmarks and decompositions of heterogeneous preference data [10, 11]. The present proposal is more local: each person's event history initializes an action prior, and subsequent coactive comparisons update a person-specific adapter or policy head.

Li et al. propose Personalized-RLHF, which jointly learns a lightweight user model and a personalized language model from explicit or implicit individual feedback [18]. Their framework establishes a direct personalized-feedback baseline. The present proposal differs by initializing personalization from passive chronological action traces and then deriving weak preference comparisons from proposal exposure during ordinary work rather than beginning with a conventional human-feedback dataset.

Preferences may also change because of the system itself. Carroll et al. formalize alignment problems with changing and influenceable reward functions [12]. This concern is not removable by renaming the interface. The proposals are interventions and may shift what the person writes or wants. The method therefore targets the deployed collaborative process, not an unchanging reward function presumed to exist before exposure. Stable long-horizon claims require additional outcome measurements and intervention-aware evaluation beyond Phases 1 and 2.

Williams et al. provide an empirical warning about optimizing directly for user feedback: in simulated deployment settings, language models learn manipulative or deceptive feedback-gaming strategies and can identify and target a small vulnerable subset of users [19]. Their results strengthen the case for treating immediate interaction feedback as gameable and for evaluating the proposed collaborative process with outcome measurements and intervention-aware controls rather than assuming that lower local loss is sufficient.

## 3. Problem Formulation

### 3.1 Event stream and macro-actions

Let $u$ denote a principal: the individual whose policy is being modeled. Their computer activity is an ordered stream

$$
\mathcal{E}_u = (e_1, e_2, \ldots, e_T).
$$

Each event has a timestamp, application, object or location, provenance, and payload. Events are divided initially into two broad classes:

- A **read event** records information made available to the person, such as a visible document span, a watched transcript interval, an AI response, or a received message.
- A **write event** records an attributable outward action, such as an inserted note block, a search query, a prompt, an edit, or a sent message.

The distinction is functional rather than metaphysical. Read events enter model context. Write events are potential targets. Events that merely indicate navigation, focus, or tool state may enter context without belonging to either semantic class.

Raw keystrokes are too granular and git commits may be too coarse. We define a bounded **macro-action**

$$
a_t = (d_t, \ell_t, o_t, c_t),
$$

where $d_t$ is the application or action domain, $\ell_t$ is the object location, $o_t$ is the operation, and $c_t$ is its content. Examples include appending one bullet to a note, submitting one browser query, or sending one chat message. Macro-actions are segmented by observable boundaries such as submit/save events, focus changes, semantic block completion, or an idle-time debounce.

Let

$$
h_t = C_\phi(e_{1:t-1})
$$

be the context constructed from events available strictly before action $a_t$. $C_\phi$ is a versioned context-construction function. It enforces temporal ordering, selects or compresses content to a token budget, and records the exact inputs used. The Phase 1 target is the next human macro-action $y_t = a_t$.

### 3.2 Policies

Let $\pi_0$ be a pretrained base model. Phase 1A produces an initial personalized behavioral policy $\pi_{\mathrm{BC},0}$. Phase 1B maintains a sequence of immutable accepted versions

$$
\pi_{\mathrm{BC},0},\pi_{\mathrm{BC},1},\ldots,\pi_{\mathrm{BC},m},
$$

where each version is trained only from behavioral-cloning targets and is published after chronological validation. The current version $\pi_{\mathrm{BC},m}$ is the best accepted estimate of the person's action policy under the data and deployment regime observed through its cutoff time. In a practical enterprise implementation, these versions are low-rank personal adapters on top of a tenant-approved shared base model rather than full model copies.

At the start of the initial Phase 2 experiment, freeze one accepted behavioral version as a stable anchor

$$
\pi_{\mathrm{anchor}} := \operatorname{Freeze}(\pi_{\mathrm{BC},m_0}).
$$

The continually updated behavioral policy and the fixed anchor have different roles. $\pi_{\mathrm{BC},m}$ tracks current behavior; $\pi_{\mathrm{anchor}}$ supplies a stable coordinate system for IPO training and historical implicit-score comparisons. They may initially be the same checkpoint, but they must not be treated as the same mutable object after Phase 2 begins.

Phase 2 initializes an active policy $\pi_\theta$ from the anchor or from a fully logged later behavioral checkpoint. At interaction time $t$, a versioned generation policy $\mu_t$, normally the currently deployed $\pi_{\theta_t}$, samples $K$ candidates:

$$
z_{t,1:K} \sim \mu_t(\cdot \mid h_t, u).
$$

The interface renders a subset $R_t \subseteq \{1,\ldots,K\}$. After exposure to the rendered slate $Z_t^R$, the person produces a continuation

$$
y_t \sim H_u(\cdot \mid h_t, Z_t^R),
$$

where $H_u$ denotes the human's post-exposure behavior. This equation makes the central feedback loop explicit: $y_t$ is generally not sampled from $H_u(\cdot \mid h_t)$.

### 3.3 Weak coactive preference assumption

For each rendered candidate $z_{t,i}$, the core estimator constructs

$$
y_t \succ_{h_t,u} z_{t,i}
$$

only if all of the following hold:

1. The candidate was actually visible before the human action began.
2. The candidate and human continuation belong to a comparable macro-action family.
3. The human continuation is not an exact or semantic equivalent of the candidate.
4. The event boundary is reliable enough that the continuation can reasonably be associated with the exposure.

This is a **weak improvement assumption**. It does not assert that $y_t$ is optimal, that the person evaluated every candidate explicitly, or that the candidate failed to help. A candidate may have been causally useful by inspiring the human continuation. The estimator asks a narrower training question: after human refinement, which action should the policy be more able to produce directly from the original context?

The assumption can fail. A person may act under time pressure, misunderstand a proposal, produce an incomparable action, or be negatively influenced. The record format therefore retains the full interaction so that stronger causal or slate-level estimators can replace the pairwise labels without recollecting the data.

### 3.4 Optimization target

The Phase 2 target is not the counterfactual action the person would have taken without exposure; that action is unobserved. Nor is it click-through rate. The target is a policy that improves its expected local continuation quality under the joint deployed process:

$$
h_t \rightarrow Z_t^R \rightarrow y_t \rightarrow \text{policy update}.
$$

Accordingly, the resulting utility score is identified only over actions that are comparable to the proposals shown in observed contexts. The score is local to a user, context-construction policy, action segmentation policy, and reference model.

## 4. Method

### 4.1 Phase 1A: initial next-write behavioral cloning

The Phase 1 dataset is

$$
\mathcal{D}_1 = \{(u, h_t, y_t)\}_{t=1}^{N_1}.
$$

Every structured action is serialized into a canonical token sequence. For example:

```text
<ACTION>
<APP>obsidian</APP>
<LOCATION>Algorithms.md#block-193</LOCATION>
<OP>append_block</OP>
<CONTENT>...</CONTENT>
</ACTION>
```

The model receives the serialized event context followed by the action prefix. Loss is masked on all context tokens and applied only to tokens of the human action. This prevents long read contexts from dominating the target objective.

For a target action $y_t=(y_{t,1},\ldots,y_{t,L_t})$, define the sequence log-likelihood

$$
\ell_\theta(y_t \mid h_t,u)
= \sum_{j=1}^{L_t}
\log \pi_\theta(y_{t,j}\mid h_t,u,y_{t,<j}).
$$

The Phase 1 objective is ordinary token-level negative log-likelihood:

$$
\mathcal{L}_{\mathrm{BC}}^{(1)}(\theta)
= -\mathbb{E}_{(u,h,y)\sim\mathcal{D}_1}
\left[\ell_\theta(y\mid h,u)\right].
$$

The loss is conventional; the central research object is the construction of $h_t$ and $y_t$. In particular, a read event should contain the content actually consumed before the write, not the entire page retroactively attached at page-open time. A watched video should contribute the transcript interval watched before a note was written. Copied text should retain its source and should not be mislabeled as independently authored text.

The initial prototype should use one serialization and one autoregressive head rather than separate action-type, location, and content heads. Separate heads introduce weighting choices before the event representation has been validated. Structured tokens still make field-level accuracy measurable.

### 4.2 Phase 1B: continual behavioral adaptation

Initial training produces a useful prior but not a permanently current human model. New projects, tools, collaborators, vocabulary, and habits change the distribution of $(h,y)$ over time. Phase 1B therefore treats behavioral cloning as a persistent asynchronous service. Newly finalized examples are accumulated, mixed with historical replay, used to train a candidate adapter, and published as a new immutable $\pi_{\mathrm{BC},m}$ only after validation.

The continual objective does not require a new label or loss function. Let $\mathcal{N}_m$ be a batch sampled from a recent window of newly finalized examples and let $\mathcal{R}_m$ be a stratified replay batch from older accepted examples. The update objective is

$$
\begin{aligned}
\mathcal{L}_{\mathrm{BC}}^{(\mathrm{cont})}(\theta;m)
={}&
\rho_m\mathcal{L}_{\mathrm{BC}}(\mathcal{N}_m) \\
&+(1-\rho_m)\mathcal{L}_{\mathrm{BC}}(\mathcal{R}_m),
\end{aligned}
$$

where $\rho_m\in[0,1]$ controls the stability–plasticity tradeoff. A larger value follows recent behavior more aggressively; a smaller value preserves the historical distribution more strongly. $\rho_m$ is selected against both recent and fixed historical validation sets rather than treated as a universal constant. Recency weighting defines which time-local behavior the model is intended to estimate. It is not automatically an importance-sampling correction.

#### 4.2.1 Four distinct memory and batching problems

The word *memory* refers to four different resources in this system, and they require different solutions:

1. **Context memory** determines which prior events are serialized into $h_t$. It is controlled by $C_\phi$, the context token budget, truncation, compression, and later retrieval policies.
2. **Replay memory** determines which past BC examples remain available for future gradient updates. It is controlled by retention, stratification, reservoir or eviction policy, and privacy requirements.
3. **Parametric memory** determines which observations become encoded in adaptable model weights. The minimal system writes only to a low-rank personal adapter while keeping the approved base model fixed.
4. **Training memory** is the accelerator memory required for parameters, optimizer state, activations, and variable-length contexts. It is controlled by token-budgeted microbatches, length bucketing, precision, activation checkpointing if needed, and gradient accumulation.

Likewise, *batch size* must not denote a single ambiguous number. The implementation records separately:

- the **update trigger**, measured by newly available target tokens or macro-actions plus a maximum wall-clock delay;
- the **microbatch token budget**, constrained by accelerator memory and including both context and target tokens;
- the **effective optimizer batch**, obtained after gradient accumulation and reported in target tokens and examples; and
- the **replay capacity and mixture**, measured in retained examples or tokens and divided across explicit strata.

Actions vary too much in context and target length for an example count alone to specify compute. The first experiment therefore selects microbatch size from the available hardware, holds an effective token budget constant through gradient accumulation, and treats the update trigger and replay mixture as experimental variables.

#### 4.2.2 Minimal continual system

The minimal continual-learning system makes the following commitments:

1. **Append-only eligible examples.** A BC example becomes trainable only after its action boundary, provenance, and context snapshot are finalized past a lateness watermark. Revised segmentation creates a new version rather than mutating a previously trained example.
2. **Low-rank adaptation.** Each principal has a versioned LoRA or equivalent low-rank adapter over a fixed approved base. Full-model continual training is not required for the first experiment.
3. **Recent plus stratified replay.** The system retains a complete recent window. If all historical examples fit within the approved storage budget, they remain addressable; otherwise, a bounded replay index samples across time period, application domain, action family, and provenance so that dense editing sessions do not erase sparse workflows.
4. **Token-budgeted optimization.** Examples are bucketed by serialized length, packed into microbatches bounded by total tokens, and accumulated to a configured effective target-token budget before each optimizer step.
5. **Asynchronous immutable publication.** Collection continues while a candidate adapter trains. The candidate, optimizer configuration, data cutoff, update trigger, replay composition, and parent version are logged. Publication creates a new immutable policy version; rejection leaves the deployed version unchanged.
6. **Two-horizon evaluation.** A delayed rolling chronological set measures freshness on recent behavior. A fixed historical set measures forgetting. Both are supplemented by domain, action-family, boundary-confidence, and target-length slices.

Replay does not make chronological observations independent and identically distributed. It deliberately constructs a less correlated, inspectable training mixture. The chosen mixture is part of the estimator and must be reported. The initial system uses ordinary masked next-action likelihood throughout; it does not require a new continual-learning objective merely because updates recur.

Once Phase 2 begins, the source distribution changes because rendered proposals become read events. Each BC example must therefore record whether it was collected with no proposal, after proposal exposure, or under ambiguous exposure. For the core distillation objective, a post-exposure human continuation is still scored from the pre-display context as specified in Section 4.7. The augmented context is retained so that a separate response model $H_u(y\mid h,Z^R)$ or a different continual target can be trained later without recollecting the interaction.

#### 4.2.3 Publication criteria and failure escalation

A candidate continual update is not accepted merely because its training loss falls. At minimum, publication requires no unacceptable regression on the fixed historical holdout, improvement or non-inferiority on the recent chronological holdout, finite and stable gradients, and no failed high-priority action-family slice. The previous policy and optimizer state remain available for rollback. Update frequency is chosen by measuring the frontier among freshness, gradient variance, compute cost, and publication risk rather than by assuming that the freshest possible update is best.

Several more complex methods may become necessary, but they are ablations or escalation paths rather than prerequisites for the initial system:

- **Meta-learned or E2E-TTT initialization** is appropriate if ordinary LoRA updates learn recent behavior too slowly or destabilize after repeated updates. It optimizes initial weights for future adaptation rather than only for current training loss.
- **Teacher distillation or explicit KL anchoring** is appropriate if replay alone fails to preserve required base capabilities or older workflows. The frozen base, an earlier BC checkpoint, or a capability teacher can supply the anchor, but the retained behavior must be named explicitly.
- **Surprise-weighted updates, prioritized replay, or per-parameter adaptive learning rates** are appropriate if examples differ greatly in novelty or learning value. They should be introduced only after calibration shows that surprise predicts useful adaptation rather than telemetry noise.
- **Adaptive replay, recency weighting, or clipped importance weighting** is appropriate if the scientific target is explicitly the newest behavioral distribution and replay bias becomes measurable. Whole-sequence importance ratios are expected to be high variance.
- **Partitioned adapters, parameter isolation, or retrieval–weight hybrids** are appropriate if one adapter cannot represent conflicting workflows or if parametric capacity becomes the bottleneck. Retrieval and context compression address context memory; they do not by themselves solve replay or training memory.

The purpose of enumerating these methods is to make failure responses explicit. They should not obscure the minimal test: whether ordinary LoRA behavioral cloning with token-budgeted optimization, stratified replay, and strict publication gates can remain current enough for the intended product.

### 4.3 Phase 2: proposal generation and exposure

At a well-defined action opportunity, the deployed policy samples $K$ bounded macro-actions from the pre-display context. Sampling should preserve meaningful diversity without making candidates implausible. Temperature, nucleus threshold, random seed, stop condition, and policy version are logged for every candidate.

Only rendered candidates can become preference losers. A generated candidate hidden by truncation, ranking, latency, or interface state is not evidence. Exposure time must precede the start of the human macro-action. If the interface cannot establish visibility, the interaction contributes only a behavioral-cloning target.

The person then acts normally. There is no accept button in the core design. The system captures the next macro-action $y_t$ and stores both:

- the **pre-display context** $h_t$, used to score $y_t$ and $z_{t,i}$; and
- the **augmented audit context** $(h_t,Z_t^R)$, used to analyze influence and reconstruct what the person observed.

Conditioning the core loss on $h_t$ rather than $(h_t,Z_t^R)$ is intentional. It distills the result of human refinement into the next policy version. Training only on the augmented context would produce a model that predicts human reactions to its proposals but might not produce the improved action before the reaction occurs.

### 4.4 Pair construction

For interaction $t$, define a validity weight

$$
w_{t,i} = e_{t,i}\,c_{t,i}\,b_{t,i}\,v_{t,i},
$$

where:

- $e_{t,i}\in\{0,1\}$ indicates verified exposure;
- $c_{t,i}\in[0,1]$ indicates action-space comparability;
- $b_{t,i}\in\{0,1\}$ indicates a valid temporal boundary; and
- $v_{t,i}\in[0,1]$ discounts duplicates or semantic equivalents.

The first implementation should use conservative rules: binary exposure and boundary checks, exact action-family matching, $v=0$ for exact or high-confidence semantic equivalence, and $v=1$ otherwise. Learned confidence weighting can be added only after manual audits establish that its scores correspond to label validity.

If the human action exactly matches a candidate, the event is not a negative comparison. It remains a positive behavioral-cloning example. An explicit “accepted candidate” field may be logged if the interface can identify copying, but literal acceptance is not required for the method.

If the human performs no comparable write within the event window, the system creates no preference pair. “No action” should not initially be treated as a universal rejection: inactivity may reflect interruption, task completion, or missing telemetry.

### 4.5 Reference-relative action scores

Use the frozen Phase 2 anchor $\pi_{\mathrm{anchor}}$ to define the reference-relative sequence score

$$
q_\theta(h,u,a)
= \ell_\theta(a\mid h,u)-\ell_{\mathrm{anchor}}(a\mid h,u).
$$

For a preference pair $(y_t,z_{t,i})$, define

$$
\Delta_{t,i}(\theta)
= q_\theta(h_t,u,y_t)-q_\theta(h_t,u,z_{t,i}).
$$

The anchor is fixed across the initial Phase 2 experiment. Rolling the training reference changes the coordinate system of the implicit score and makes historical comparisons harder to combine. The continually updated $\pi_{\mathrm{BC},m}$ may also be used to compute a diagnostic contemporaneous residual

$$
q_{\mathrm{local},t}(h,u,a)
=\ell_{\theta_t}(a\mid h,u)-\ell_{\mathrm{BC},m(t)}(a\mid h,u),
$$

which asks how the active coactive policy differs from the current behavioral model at that moment. This moving-baseline score is useful for local diagnosis but is not directly comparable across BC updates. It is not silently substituted for $\pi_{\mathrm{anchor}}$ in the core IPO loss. If a rolling-reference optimizer is later tested, all active, behavioral, and anchor versions must remain available and historical scores must be recomputed against a stable anchor.

Standard preference derivations use the sum of token log-probabilities. Variable-length actions can create length effects, so the primary control is **action segmentation**: compare bounded actions of the same family and similar semantic granularity. A length-normalized score,

$$
\ell_\theta^{(\alpha)}(a\mid h,u)
= |a|^{-\alpha}\ell_\theta(a\mid h,u),
\qquad \alpha\in(0,1],
$$

may be tested as an ablation, but it no longer has the exact policy log-ratio interpretation used in DPO/IPO. It should not silently replace the core score.

### 4.6 Coactive IPO loss

For inverse-temperature or regularization parameter $\beta>0$, the weighted pairwise IPO objective is

$$
\begin{aligned}
\mathcal{L}_{\mathrm{IPO}}(\theta)
&=
\mathbb{E}_{t}\!\Bigg[
\frac{1}{\sum_i w_{t,i}}
\sum_{i=1}^{K} w_{t,i} \\
&\qquad\quad {}\times
\left(
\Delta_{t,i}(\theta)-\frac{1}{2\beta}
\right)^2
\Bigg].
\end{aligned}
$$

where interactions with $\sum_i w_{t,i}=0$ are omitted. The score $q_\theta$ does **not** contain a factor of $\beta$; the margin $1/(2\beta)$ introduces it once. This avoids the common double-scaling error.

IPO is preferred over logistic DPO for the first experiment because its finite target avoids pushing noisy weak preferences toward infinite separation. DPO remains a direct baseline:

$$
\mathcal{L}_{\mathrm{DPO}}(\theta)
=-
\mathbb{E}_{t,i}
\left[
w_{t,i}\log\sigma\left(\beta\Delta_{t,i}(\theta)\right)
\right].
$$

Pairwise expansion gives one comparison per valid rendered candidate. These comparisons are correlated because they share $h_t$ and $y_t$, so the implementation averages within interaction before averaging across interactions, as in the IPO expression above. This prevents a large slate from giving one human action disproportionate batch weight.

### 4.7 Continued behavioral cloning and replay

The human continuation remains the highest-density positive signal in Phase 2. Preference-only updates could improve relative ordering while degrading next-action calibration or forgetting earlier behavior. The Phase 2 objective therefore mixes three terms:

$$
\begin{aligned}
\mathcal{L}_{\mathrm{Phase\ 2}}(\theta)
={}&
\lambda_{\mathrm{new}}\mathcal{L}_{\mathrm{BC}}(\mathcal{B}_2) \\
&+\lambda_{\mathrm{pref}}\mathcal{L}_{\mathrm{IPO}}(\mathcal{B}_2) \\
&+\lambda_{\mathrm{replay}}\mathcal{L}_{\mathrm{BC}}(\mathcal{B}_{\mathrm{BC}}).
\end{aligned}
$$

where:

- $\mathcal{B}_2$ contains recent human continuations and valid coactive pairs;
- $\mathcal{B}_{\mathrm{BC}}$ is a replay batch drawn from the versioned continual-BC replay index; and
- the $\lambda$ coefficients are selected using held-out next-action likelihood, preference accuracy, and drift checks.

The new-action BC term scores $y_t$ under the pre-display context $h_t$, not the augmented context. The replay term anchors the behavioral prior using observed targets rather than requiring an expensive full-vocabulary KL at every update. Its replay sample should be drawn through the same versioned replay policy used in Phase 1B, although the Phase 2 mixture coefficients remain separate hyperparameters. A KL penalty to $\pi_{\mathrm{anchor}}$ can be added if replay does not control drift, but it is not part of the minimal objective.

The data are on-policy when collected but become stale as $\pi_\theta$ changes. DPO and IPO can optimize a fixed empirical preference dataset without importance sampling. Importance weights are therefore not required in the core loss. If the scientific target is explicitly the expectation under the newest deployment policy, logged generation probabilities permit clipped off-policy or recency weighting. Whole-sequence importance ratios are high variance and should not be added by default.

### 4.8 Implicit personalized utility

The reference-relative policy defines an implicit utility score

$$
\widehat r_u(h,a)
= \beta q_\theta(h,u,a) + c(h,u),
$$

where $c(h,u)$ is an arbitrary context-only constant. It cancels when actions are ranked in the same context, so the operational score is

$$
\widehat r_u(h,a)
= \beta
\left[
\ell_\theta(a\mid h,u)-\ell_{\mathrm{anchor}}(a\mid h,u)
\right].
$$

This is the enterprise-relevant artifact of Phase 2. It can score or rerank candidate continuations for a person, compare an active policy with its frozen behavioral anchor, or provide a local terminal score to a bounded search procedure. It is not a separately trained universal reward network, and its scale is meaningful only relative to the same anchor, segmentation, and context policy. Because the active policy also receives BC and replay gradients, the ratio reflects the full Phase 2 update, not an uncontaminated standalone preference model; the contemporaneous residual against $\pi_{\mathrm{BC},m}$ should be reported separately when that distinction matters.

The phrase **implicit reward model** should therefore be qualified. The model estimates a local revealed-preference score over actions similar to those sampled and corrected during deployment. It does not yet estimate delayed organizational outcomes, causal effects on other people, or arbitrary multi-step trajectory returns. Those require additional state-transition and outcome data.

## 5. Data Structures

The storage design is append-only and versioned. Raw observations, derived examples, exposures, and training pairs are separate records. Derived data can be rebuilt when action segmentation, context construction, or label policy changes.

### 5.1 Event record

```text
Event {
  event_id: UUID
  tenant_id: UUID
  principal_id: UUID
  session_id: UUID?
  started_at: timestamp
  ended_at: timestamp
  kind: READ | WRITE | NAVIGATION | SYSTEM
  app: string
  object_uri: string?
  operation: string
  content_ref: encrypted_blob_ref?
  visible_or_edited_span: Span?
  source_event_ids: [UUID]
  state_before_hash: bytes?
  state_after_hash: bytes?
  capture_version: string
  provenance: HUMAN_TYPED | COPIED | MODEL_OUTPUT | RECEIVED | UNKNOWN
  metadata: map<string, scalar>
}
```

Important invariants:

- The timestamp reflects when content became available or an operation occurred, not when a collector later ingested it.
- Read payloads contain the portion plausibly consumed before the cutoff when telemetry permits.
- Copied and model-generated spans retain provenance so they are not credited as independent human generation.
- Tenant and principal boundaries are present in every primary record; they are not inferred from a session join.

### 5.2 Macro-action record

```text
MacroAction {
  action_id: UUID
  principal_id: UUID
  source_event_ids: [UUID]
  domain: string                 // e.g. obsidian, browser-search, chat
  location: string?
  operation: string              // append_block, replace_span, submit, send
  content_ref: encrypted_blob_ref
  content_hash: bytes
  began_at: timestamp
  committed_at: timestamp
  boundary_reason: SUBMIT | SAVE | FOCUS_CHANGE | IDLE | SEMANTIC | GIT_DIFF
  segmentation_version: string
  provenance_summary: map<string, float>
  confidence: float
}
```

An action is immutable after creation. A revised segmentation produces a new record linked to the same source events. For the first Obsidian experiment, the preferred unit is a committed sentence, bullet, or coherent edit burst. A git commit can help reconstruct diffs but should not automatically define a single action if it aggregates several independent edits.

### 5.3 Context snapshot

```text
ContextSnapshot {
  context_id: UUID
  principal_id: UUID
  cutoff_at: timestamp
  ordered_event_ids: [UUID]
  serialized_context_ref: encrypted_blob_ref
  serialized_context_hash: bytes
  token_count: int
  tokenizer_version: string
  context_builder_version: string
  truncation_log: [TruncationDecision]
  optional_task_id: UUID?
  optional_goal_text_ref: encrypted_blob_ref?
}
```

The snapshot is the reproducibility boundary for $h_t$. It records the actual serialized context, not merely a query that might return different data later. Explicit task or goal fields may be included when naturally available, but they are not required for Phase 1.

### 5.4 Candidate and exposure records

```text
Candidate {
  candidate_id: UUID
  interaction_id: UUID
  rank: int
  serialized_action_ref: encrypted_blob_ref
  action_hash: bytes
  semantic_hash: bytes?
  generation_policy_version: string
  current_bc_policy_version: string
  stable_anchor_policy_version: string
  sampling_temperature: float
  sampling_top_p: float
  random_seed: int
  generation_logprob: float
  current_bc_logprob: float
  stable_anchor_logprob: float
  generated_at: timestamp
  rendered_at: timestamp?
  render_completed_at: timestamp?
  visible_duration_ms: int?
  rendered: bool
}

ExposureInteraction {
  interaction_id: UUID
  principal_id: UUID
  context_id: UUID
  requested_at: timestamp
  candidate_ids: [UUID]
  rendered_candidate_ids: [UUID]
  human_action_id: UUID?
  human_action_began_at: timestamp?
  capture_closed_at: timestamp
  interface_version: string
  interaction_status: COMPLETE | NO_ACTION | INTERRUPTED | AMBIGUOUS
}
```

Generation, current-BC, and stable-anchor log-probabilities should be stored at collection time and be recomputable from retained model versions. Render status is candidate-specific: generating a candidate does not imply exposure.

### 5.5 Preference record

```text
PreferencePair {
  pair_id: UUID
  interaction_id: UUID
  principal_id: UUID
  context_id: UUID
  winner_action_id: UUID          // observed human continuation
  loser_candidate_id: UUID        // rendered model proposal
  exposure_weight: float
  comparability_weight: float
  boundary_weight: float
  equivalence_weight: float
  aggregate_weight: float
  label_policy_version: string
  active_policy_version_at_collection: string
  current_bc_policy_version_at_collection: string
  stable_anchor_policy_version: string
  exclusion_reason: string?
}
```

Excluded pairs should be retained with `aggregate_weight = 0` and an exclusion reason. This makes changes in label policy auditable and permits reconstruction without revisiting raw UI logs.

### 5.6 Training example and replay records

```text
BCExample {
  example_id: UUID
  principal_id: UUID
  context_id: UUID
  augmented_context_id: UUID?
  target_action_id: UUID
  source_phase: PHASE_1_INITIAL | PHASE_1_CONTINUAL | PHASE_2
  collection_regime: UNAIDED | PROPOSAL_EXPOSED | AMBIGUOUS
  source_interaction_id: UUID?
  action_family: string
  target_token_count: int
  total_serialized_token_count: int
  finalized_at: timestamp
  supersedes_example_id: UUID?
  loss_mask_ref: blob_ref
  example_builder_version: string
}

ReplayBufferState {
  buffer_version: string
  principal_id: UUID
  recent_example_ids: [UUID]
  historical_strata: map<string, [UUID]>
  retention_cutoff_at: timestamp
  capacity_examples: int?
  capacity_tokens: int?
  sampling_policy_version: string
  created_at: timestamp
}

TrainingBatchManifest {
  batch_id: UUID
  training_kind: INITIAL_BC | CONTINUAL_BC | COACTIVE
  parent_policy_version: string
  candidate_policy_version: string
  published_policy_version: string?
  current_bc_policy_version: string?
  stable_anchor_policy_version: string?
  data_cutoff_at: timestamp
  update_trigger_reason: NEW_TOKEN_THRESHOLD | NEW_ACTION_THRESHOLD | MAX_DELAY | MANUAL | NONE
  recent_bc_example_ids: [UUID]
  replay_bc_example_ids: [UUID]
  phase2_interaction_ids: [UUID]
  recent_target_tokens: int
  replay_target_tokens: int
  microbatch_total_token_limit: int
  effective_target_tokens_per_step: int
  gradient_accumulation_steps: int
  replay_mixture: map<string, float>
  replay_buffer_version: string?
  objective_config_hash: bytes
  optimizer_config_hash: bytes
  optimizer_state_before_ref: blob_ref?
  optimizer_state_after_ref: blob_ref?
  started_at: timestamp
  completed_at: timestamp?
  validation_report_ref: blob_ref?
}
```

The replay state records the sampling index, not a second mutable copy of raw content. The manifest makes every initial, continual, and coactive update reproducible, including rejected candidates. In an enterprise deployment, raw content remains inside its tenant boundary; cross-user learning should operate on approved shared parameters or privacy-preserving aggregates rather than pooled plaintext traces.

## 6. Algorithms

### Algorithm 1: Construct behavioral-cloning examples

```text
procedure BUILD_BC_EXAMPLES(events, segmentation_config, context_config, source_phase):
    ordered_events <- stable_sort(events, by=(timestamp, ingestion_sequence))
    macro_actions <- SEGMENT_WRITES(ordered_events, segmentation_config)
    dataset <- empty list

    for action y in macro_actions:
        if y.confidence < segmentation_config.minimum_confidence:
            continue

        prior_events <- events strictly before y.began_at
        h <- BUILD_CONTEXT(prior_events, context_config)

        if LEAKS_TARGET(h, y):
            continue

        serialized_y <- SERIALIZE_ACTION(y)
        loss_mask <- MASK_CONTEXT_AND_SCORE_TARGET(h, serialized_y)

        dataset.append(
            BCExample(
                context_snapshot=FREEZE(h),
                target_action=y,
                loss_mask=loss_mask,
                source_phase=source_phase,
                collection_regime=CLASSIFY_COLLECTION_REGIME(y, ordered_events)
            )
        )

    return dataset
```

`BUILD_CONTEXT` must preserve temporal interleaving. It may truncate or summarize older events, but it records every decision. The same builder runs over the initial corpus and incrementally over events finalized past the continual-learning watermark; the source phase and exposure join distinguish initial, continual, and post-proposal examples. Splits should be chronological: train on earlier actions, validate and test on later actions. Randomly splitting adjacent events would leak repeated local context and overstate generalization.

### Algorithm 2: Train the Phase 1 behavioral prior

```text
procedure TRAIN_BEHAVIORAL_PRIOR(base_policy pi_0, phase1_dataset D1):
    pi_theta <- INITIALIZE_PERSONAL_ADAPTER(pi_0)

    repeat until stopping criterion:
        B1 <- SAMPLE_TIME_BALANCED_BATCH(D1)
        L_bc <- 0

        for (h, y) in B1:
            L_bc <- L_bc - TOKEN_LOGPROB(pi_theta, y | h)

        L_bc <- L_bc / size(B1)
        theta <- OPTIMIZER_STEP(theta, gradient(L_bc))

        periodically:
            evaluate chronological next-action NLL
            evaluate field accuracy and action-boundary slices
            stop or roll back on validation degradation

    pi_bc_0 <- PUBLISH_IMMUTABLE(pi_theta, role=BEHAVIORAL)
    return pi_bc_0
```

Time-balanced sampling prevents dense editing sessions from completely dominating sparse but distinct workflows. The exact mixture is part of the dataset specification and should be reported with results when experiments exist. When Phase 2 begins, one accepted behavioral version is separately frozen as $\pi_{\mathrm{anchor}}$; publishing later BC versions does not mutate that checkpoint.

### Algorithm 3: Continually update the behavioral policy

```text
procedure UPDATE_CONTINUAL_BC(pi_bc, incoming_examples N, replay_state R, config):
    finalized <- examples in N that are:
        before config.lateness_watermark,
        not superseded,
        above minimum boundary confidence,
        and eligible under the current data policy

    R <- UPDATE_REPLAY_INDEX(R, finalized)
    pending <- UNCONSUMED_FINALIZED_EXAMPLES(R)

    if NEW_TARGET_TOKENS(pending) < config.update_trigger_tokens
       and NEW_ACTIONS(pending) < config.update_trigger_actions
       and TIME_SINCE_LAST_JOB() < config.maximum_update_delay:
        return pi_bc, R without launching a training job

    recent <- SAMPLE_RECENT_TRAINING_WINDOW(
        R,
        exclude=config.rolling_recent_holdout
    )
    replay <- SAMPLE_STRATIFIED_HISTORY(
        R,
        strata=(time_period, domain, action_family, provenance),
        exclude=(recent, config.fixed_historical_holdout)
    )

    candidate <- CLONE_ADAPTER(pi_bc)
    groups <- PACK_AND_ACCUMULATE(
        recent,
        replay,
        microbatch_total_token_limit=config.microbatch_total_tokens,
        effective_target_token_budget=config.effective_target_tokens
    )

    for optimizer group G in groups:
        L_recent <- MEAN_MASKED_ACTION_NLL(candidate, G.recent)
        L_replay <- MEAN_MASKED_ACTION_NLL(candidate, G.replay)
        L_total <- config.rho * L_recent
                 + (1 - config.rho) * L_replay
        candidate <- OPTIMIZER_STEP(candidate, gradient(L_total))

    report <- EVALUATE(
        candidate,
        rolling_recent_holdout=config.rolling_recent_holdout,
        fixed_historical_holdout=config.fixed_historical_holdout,
        slices=(domain, action_family, boundary_confidence, target_length)
    )

    store TrainingBatchManifest for the candidate and report
    MARK_UPDATE_TRIGGER_CONSUMED(R, pending)

    if PASSES_CONTINUAL_PUBLICATION_GATES(report):
        pi_bc_next <- PUBLISH_IMMUTABLE(candidate, role=BEHAVIORAL)
        return pi_bc_next, R
    else:
        reject candidate and retain pi_bc
        return pi_bc, R
```

The update trigger controls freshness, not the number of examples in one gradient step. Microbatch size is determined by total serialized tokens that fit in memory; gradient accumulation determines the effective target-token budget. The replay state is updated even when training is deferred or a candidate is rejected, so collection and model publication remain decoupled.

### Algorithm 4: Collect one coactive interaction

```text
procedure COLLECT_COACTIVE_INTERACTION(
    pi_active, pi_bc_current, pi_anchor, live_event_stream, K
):
    cutoff <- current time
    h <- FREEZE(BUILD_CONTEXT(events before cutoff))

    candidates <- SAMPLE_DIVERSE_MACRO_ACTIONS(
        policy=pi_active,
        context=h,
        count=K,
        bounded_to=ACTIVE_ACTION_FAMILY
    )

    for z_i in candidates:
        log candidate text, policy version, sampling parameters,
            TOKEN_LOGPROB(pi_active, z_i | h),
            TOKEN_LOGPROB(pi_bc_current, z_i | h),
            TOKEN_LOGPROB(pi_anchor, z_i | h)

    rendered_candidates <- RENDER_AND_CONFIRM_VISIBILITY(candidates)
    log exposure timestamps for each rendered candidate
    h_augmented <- FREEZE(APPEND_RENDERED_READ_EVENTS(h, rendered_candidates))

    y <- WAIT_FOR_NEXT_COMPARABLE_HUMAN_MACRO_ACTION()

    if y does not exist or its boundary is ambiguous:
        close interaction without preference pairs
        return

    store BCExample(
        context=h,
        augmented_context=h_augmented,
        target=y,
        source_phase=PHASE_2,
        collection_regime=PROPOSAL_EXPOSED
    )

    for z_i in rendered_candidates:
        if z_i was not visible before y began:
            store excluded pair(reason=NO_VERIFIED_EXPOSURE)
            continue

        if not COMPARABLE_ACTION_FAMILY(y, z_i):
            store excluded pair(reason=INCOMPARABLE_ACTION)
            continue

        if SEMANTICALLY_EQUIVALENT(y, z_i):
            store excluded pair(reason=EQUIVALENT_ACTION)
            continue

        store PreferencePair(
            context=h,
            winner=y,
            loser=z_i,
            weight=VALIDITY_WEIGHT(y, z_i),
            collection_policy_version=VERSION(pi_active),
            current_bc_policy_version=VERSION(pi_bc_current),
            stable_anchor_policy_version=VERSION(pi_anchor)
        )

    close interaction
```

This algorithm waits for a natural action but does not ask the user to grade the slate. A practical interface should close the capture window on task switch, long inactivity, or an incompatible action so that unrelated future work is not mislabeled as a correction.

### Algorithm 5: Update the active policy from coactive data

```text
procedure UPDATE_ACTIVE_POLICY(pi_theta, pi_anchor, phase2_buffer B2, bc_replay R_bc):
    assert pi_anchor is frozen
    interactions <- SAMPLE_RECENT_DIVERSE_INTERACTIONS(B2)
    replay <- SAMPLE_STRATIFIED_HISTORY(R_bc)

    L_new <- 0
    L_pref <- 0

    for interaction t in interactions:
        h <- t.pre_display_context
        y <- t.human_continuation
        L_new <- L_new - TOKEN_LOGPROB(pi_theta, y | h)

        valid_pairs <- pairs in t with aggregate_weight > 0
        if valid_pairs is not empty:
            interaction_loss <- 0
            total_weight <- sum(pair.weight for pair in valid_pairs)

            for pair (y, z_i, w_i) in valid_pairs:
                q_y <- TOKEN_LOGPROB(pi_theta, y | h)
                       - TOKEN_LOGPROB(pi_anchor, y | h)
                q_z <- TOKEN_LOGPROB(pi_theta, z_i | h)
                       - TOKEN_LOGPROB(pi_anchor, z_i | h)
                delta <- q_y - q_z
                interaction_loss <- interaction_loss
                    + w_i * (delta - 1 / (2 * beta))^2

            L_pref <- L_pref + interaction_loss / total_weight

    L_new <- L_new / count(interactions with a human continuation)
    L_pref <- L_pref / count(interactions with at least one valid pair)

    L_replay <- 0
    for (h_old, y_old) in replay:
        L_replay <- L_replay - TOKEN_LOGPROB(pi_theta, y_old | h_old)
    L_replay <- L_replay / size(replay)

    L_total <- lambda_new * L_new
             + lambda_pref * L_pref
             + lambda_replay * L_replay

    candidate_theta <- OPTIMIZER_STEP(theta, gradient(L_total))

    if PASSES_DRIFT_AND_HELDOUT_CHECKS(candidate_theta):
        publish new immutable active-policy version
    else:
        reject update and retain prior active policy
```

Updates occur in microbatches rather than after each action. This reduces gradient variance, permits within-batch normalization, and makes policy publication auditable. The collection policy can continue serving while a new adapter is trained; the interaction record always names the exact version that generated its candidates.

### Algorithm 6: Use the learned implicit utility to rerank actions

```text
procedure RERANK_FOR_PRINCIPAL(
    pi_theta, pi_anchor, pi_bc_current, context h, candidate_set A
):
    scored <- empty list

    for action a in A:
        q_anchor <- TOKEN_LOGPROB(pi_theta, a | h)
                    - TOKEN_LOGPROB(pi_anchor, a | h)
        q_local <- TOKEN_LOGPROB(pi_theta, a | h)
                   - TOKEN_LOGPROB(pi_bc_current, a | h)
        implicit_utility <- beta * q_anchor
        scored.append((a, implicit_utility, q_local))

    return sort_descending(scored, by=implicit_utility)
```

This score can rerank candidates produced by the active policy, a larger frontier model, or a bounded search process, provided the actions share a comparable representation and context. Out-of-distribution actions require calibration or abstention; a high score is not evidence of validity outside the support of collected comparisons.

## 7. Assumptions and Identification Boundaries

The formalism depends on the following assumptions. They should be tested as data-quality and product assumptions rather than hidden inside the optimizer.

### 7.1 Informative but imperfect behavior

Observed human actions must contain signal about the person's objectives while leaving room for improvement. If the person routinely acts against their own goals for reasons absent from the context, behavioral cloning can learn the wrong prior and coactive corrections may not repair it.

### 7.2 Temporal drift and the target distribution

Recent behavior is not automatically better evidence than older behavior. It may represent a durable change, a temporary project, missing context, or noise. The recent-window definition, replay mixture, and update cadence jointly define the time-local distribution that $\pi_{\mathrm{BC},m}$ estimates. A continual model can be more current while becoming less representative of stable behavior. Both properties require separate evaluation.

### 7.3 Replay and capability retention

Stratified replay reduces forgetting risk but does not guarantee retention of old workflows, instruction following, tool use, or general reasoning. A low-rank adapter also imposes a capacity and interference constraint. The minimal system relies on fixed historical evaluations and rollback; distillation, explicit KL anchoring, parameter isolation, or additional capacity are justified only when those measurements reveal a concrete failure.

### 7.4 Comparable local actions

The human continuation and displayed proposals must be alternatives at roughly the same decision granularity. Comparing a one-sentence note with “do nothing,” a multi-hour project, or an unrelated message does not yield a meaningful pairwise label. Action segmentation is therefore part of the statistical estimator, not merely preprocessing.

### 7.5 Weak improvement after exposure

The method assumes that, on average across valid records, the human continuation is a weak improvement over each non-equivalent proposal. It does not assume optimality. If proposals commonly manipulate, confuse, or distract the person, the labels may optimize a harmful equilibrium. Outcome audits and no-exposure holdouts are required to detect this, even though they are outside the core loss.

### 7.6 No causal credit assignment among slate items

Pairwise IPO does not identify which candidate inspired which part of the human continuation. A highly useful catalytic candidate can still appear as a loser because the refined human action is the training winner. The intended effect is distillation: move probability toward the refinement so that the policy can produce it directly later. If the product objective is instead to maximize how proposals improve the person's subsequent thinking, the slate itself must be treated as an intervention and evaluated against outcomes or randomized no-slate controls. That is a different estimator from the one specified here.

### 7.7 Local rather than trajectory-level reward

The implicit utility ranks one macro-action in one context. It does not solve temporal credit assignment and should not be summed across long rollouts without validation. A later planner would need a learned or external transition model, delayed outcome signals, uncertainty controls, and checks against reward exploitation.

### 7.8 Dynamic collaborative equilibrium

The person may learn from the policy, the policy learns from the person, and preferences may change. The learned score therefore describes a versioned joint process rather than an immutable individual. This is acceptable for the Phase 2 product goal—improving the collaboration actually deployed—but it must remain visible in any claim about reward inference.

### 7.9 Versioned references, support, and uncertainty

Policy/reference log-ratios are trustworthy only near the contexts and actions on which preferences were collected. A score against the fixed anchor is historically comparable within its stated context and representation; a score against the current BC policy is a moving contemporaneous residual. Neither should be presented without its active, behavioral, and anchor version identifiers. Enterprise deployment should attach uncertainty or support checks and abstain from using the implicit score as an unrestricted verifier. Per-user data scarcity makes shared representation learning useful, but tenant and user identity must not be erased by indiscriminate pooling.

## References

[1] M. Carroll et al. [*On the Utility of Learning about Humans for Human-AI Coordination*](https://arxiv.org/abs/1910.05789). 2019.

[2] S. Ross, G. Gordon, and D. Bagnell. [*A Reduction of Imitation Learning and Structured Prediction to No-Regret Online Learning*](https://arxiv.org/abs/1011.0686). 2011.

[3] Z. Zhai et al. [*Actions Speak Louder than Words: Trillion-Parameter Sequential Transducers for Generative Recommendations*](https://arxiv.org/abs/2402.17152). 2024.

[4] Y. Liu and A. Khanafer. [*The Generative Recommender Behind Shopify's Commerce Engine*](https://shopify.engineering/generative-recommendations). Shopify Engineering, 2026.

[5] P. Shivaswamy and T. Joachims. [*Online Structured Prediction via Coactive Learning*](https://arxiv.org/abs/1205.4213). 2012.

[6] A. D. Tucker et al. [*Coactive Learning for Large Language Models using Implicit User Feedback*](https://proceedings.mlr.press/v235/tucker24a.html). ICML 2024.

[7] R. Rafailov et al. [*Direct Preference Optimization: Your Language Model is Secretly a Reward Model*](https://arxiv.org/abs/2305.18290). 2023.

[8] M. G. Azar et al. [*A General Theoretical Paradigm to Understand Learning from Human Preferences*](https://arxiv.org/abs/2310.12036). 2023.

[9] D. Calandriello et al. [*Human Alignment of Large Language Models through Online Preference Optimisation*](https://arxiv.org/abs/2403.08635). 2024.

[10] M. Shenfeld et al. [*Language Model Personalization via Reward Factorization*](https://arxiv.org/abs/2503.06358). 2025.

[11] Q. Ma et al. [*Personalized RewardBench: Evaluating Reward Models with Human Aligned Personalization*](https://arxiv.org/abs/2604.07343). 2026.

[12] M. Carroll et al. [*AI Alignment with Changing and Influenceable Reward Functions*](https://arxiv.org/abs/2405.17713). 2024.

[13] O. Shaikh et al. [*Learning Next Action Predictors from Human-Computer Interaction*](https://arxiv.org/abs/2603.05923). 2026.

[14] S. Kobayashi et al. [*Emergent Temporal Abstractions in Autoregressive Models Enable Hierarchical Reinforcement Learning*](https://arxiv.org/abs/2512.20605). 2025.

[15] J. Fu, K. Luo, and S. Levine. [*Learning Robust Rewards with Adversarial Inverse Reinforcement Learning*](https://arxiv.org/abs/1710.11248). 2017.

[16] D. S. Brown, W. Goo, and S. Niekum. [*Better-than-Demonstrator Imitation Learning via Automatically-Ranked Demonstrations*](https://arxiv.org/abs/1907.03976). 2019.

[17] T. Kleine Buening et al. [*Aligning Language Models from User Interactions*](https://arxiv.org/abs/2603.12273). 2026.

[18] X. Li, R. Zhou, Z. C. Lipton, and L. Leqi. [*Personalized Language Modeling from Personalized Human Feedback*](https://arxiv.org/abs/2402.05133). 2024.

[19] M. Williams et al. [*On Targeted Manipulation and Deception when Optimizing LLMs for User Feedback*](https://arxiv.org/abs/2411.02306). 2024.

[20] F. Matti, P. Dillenbourg, and L. Novelli. [*A Click Ahead: Real-Time Forecasting of Keyboard and Mouse Actions using RNNs and Computer Vision*](https://arxiv.org/abs/2309.12170). 2023.

[21] B. Krause, E. Kahembwe, I. Murray, and S. Renals. [*Dynamic Evaluation of Transformer Language Models*](https://arxiv.org/abs/1904.08378). 2019.

[22] A. Tandon et al. [*End-to-End Test-Time Training for Long Context*](https://arxiv.org/abs/2512.23675). 2025.
