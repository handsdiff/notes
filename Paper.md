# From Behavioral Cloning to Proposal-Conditioned Continual Learning in Personal Read–Write Streams

*A method draft for learning personalized next-action policies from ordinary computer use and model-enriched read histories*

**Status:** Working paper draft. This document specifies the motivation, related work, problem formulation, objectives, records, and algorithms for Phases 1 and 2. The executable Phase 1 program is specified in [[Phase 1 Details]]. This draft intentionally contains no abstract, results, or conclusion.

## 1. Introduction and Motivation

Modern language models are broadly capable but weakly grounded in the local objectives of a particular person. An enterprise assistant may know how to write, search, analyze, or operate software, yet still lack the tacit context required to decide which of those actions would be useful for one employee at one moment. Explicit prompts reveal only a small fraction of this context. Ratings and rankings provide clearer preference labels, but they impose enough friction that they are unlikely to capture a person's work continuously.

Ordinary computer use supplies a denser signal. A person reads documents, browses pages, receives messages and model outputs, edits notes, writes queries, sends messages, and changes artifacts. These events form a temporally ordered stream in which inbound information is followed by outbound action. The first premise of this work is that the stream can supervise a personalized next-action model without requiring the person to label a separate dataset. Given the information that was actually available before a write event, the model is trained to predict the write event that actually followed.

Prediction alone is bounded by the behavior represented in its training stream. A sufficiently accurate behavioral clone reproduces the person's historical conditional action distribution; it does not by itself distinguish actions that express a goal well from actions that merely occurred. This is especially limiting in the intended setting. The useful regime is one in which a person's actions overlap substantially, but not perfectly, with their goals. If action and goal were unrelated, the history would not identify a useful policy. If they were identical, there would be little room for assistance to change what the person can produce.

The Phase 1 records should therefore not be treated as expert demonstrations. They are correct labels for the person's realized behavior, but only imperfect proxies for the actions necessary to achieve the person's goals. This is **demonstrator suboptimality**, not necessarily ordinary label or capture noise. The person is assumed to have a goal or objective in mind and to know what outcome they are trying to achieve; the policy expressed by their read–write trajectory may nevertheless be an imperfect way to achieve it. The goal may be stated in the observed event stream or remain latent to the model. Phase 1 does not require a goal label: it learns to predict the next write action from the observable history.

Phase 2 changes the information available before the demonstrated action rather than changing the primary loss. The Phase 1 policy samples several plausible next actions and renders them during normal work. Those proposals become read events in the person's history. The person may ignore them, copy one, refine one, combine several, or produce a continuation that would not have occurred without seeing them. The subsequent human action is therefore sampled from a proposal-conditioned behavioral distribution rather than the unaided distribution observed in Phase 1.

The second premise is that model-generated alternatives can scaffold the person's generative judgment. The person need not become an expert and need not label the slate. Exposure may help them recall an option, notice an error, synthesize a stronger continuation, or decide that none of the proposals is useful. If this information intervention improves what the person produces, ordinary behavioral cloning can learn the resulting proposal-conditioned behavior. The potential improvement comes from changing the demonstration-generating process, not from treating displayed candidates as preference losers.

At decision time $t$, the current policy samples a slate from the pre-display context. After the interface confirms which candidates were rendered, those candidates are appended to the ordered read history. The person's next macro-action is then trained exactly as in Phase 1: context tokens, including proposal tokens, are masked, and likelihood loss is applied only to the human action. A candidate copied verbatim is a valid target; a wholly new synthesis is also a valid target. No click, ranking, pairwise label, or claim that the continuation is better than each candidate is required by the primary method.

Each Phase 2 record retains both the pre-display snapshot and the actual proposal-conditioned behavioral snapshot. The former reproduces how the slate was generated and supports causal audits or later estimator experiments. The latter is the input to the primary next-action loss. This distinction prevents the system from pretending that the post-exposure action came from an information state the person never occupied.

The proposed system has two training regimes applied to one canonical policy sequence:

1. **Behavioral bootstrap.** Phase 1 trains an autoregressive policy on temporally interleaved read and write events. Read events enter the context; human write events are the prediction targets. Before suggestions begin, any continual update uses the same behavioral-cloning objective.
2. **Proposal-conditioned continual learning.** Once suggestions begin, Phase 2 continues the same behavioral-cloning objective on the actual stream, now including verified rendered proposals as read history before the next human action. Each accepted policy serves users and collects the next update's data; a candidate successor is initialized from the deployed checkpoint and is published only after the same continual-learning checks used before suggestions began.

This design deliberately does not infer a dense reward or preference score. It estimates behavior within the deployed human–model interaction loop. Whether exposure improves outcomes, merely changes behavior, or sometimes harms the person's work is an empirical and partly causal question. Randomized no-slate controls, delayed outcome measures, and qualitative audits are therefore evaluations of the intervention, not quantities implied by lower behavioral-cloning loss.

This draft makes seven concrete design commitments:

- It models observed computer activity as an ordered event stream rather than a question–answer corpus.
- It uses bounded, semantically meaningful write events as actions and applies loss only to the action target, not to prior context tokens.
- It treats the canonical policy as a continual system: a low-rank personal adapter is updated asynchronously with token-budgeted microbatches, gradient accumulation, and stratified behavioral replay, then published only after recent-performance and forgetting checks.
- It treats verified rendered model continuations as ordinary read events in the Phase 2 behavioral context and applies loss only to the subsequent human action.
- It uses the same continual behavioral-cloning objective, recent-data window, stratified replay, and publication gates before and after suggestions begin; Phase 2 changes the observed context distribution rather than the core optimizer.
- It retains the initial behavioral checkpoint as an archival anchor for capability evaluation and rollback, while every accepted successor is initialized from the immediately preceding canonical checkpoint.
- It logs enough provenance—event boundaries, exposure, policy versions, exact rendered content, and candidate-generation parameters—to reconstruct the interaction and test pairwise or causal estimators later without recollecting data.

The intended claim is deliberately narrow. Phase 1 bootstraps a personalized action policy. Phase 2 continually updates that same canonical policy from the person's actual proposal-conditioned history in a collaborative equilibrium shaped by both the model and the person. The version sequence tests whether the system tracks behavioral drift and learns post-exposure behavior without unacceptable forgetting or cumulative degradation. Neither regime reconstructs the person's global reward function, proves that model exposure helps, or justifies unconstrained multi-step optimization. The central hypothesis is instead that adding plausible model samples to the read stream elicits useful behavior that a continually updated next-action model can learn with ordinary masked likelihood training.

## 2. Related Work

### 2.1 Behavioral cloning and learned human models

Behavioral cloning learns a policy by maximizing the likelihood of demonstrated actions conditional on observed state. It is the most direct formulation of Phase 1. Carroll et al. study learned human models for human–AI collaboration and show the utility of separating a model of human behavior from an agent trained to collaborate with it [1]. Their setting supplies a machine-evaluable game reward at every relevant transition. The present setting also assumes that the person has a goal and knows the outcome they are trying to achieve, but that global reward is not generally observed by the system as a dense numerical training signal.

Matti et al. provide an earlier task- and application-agnostic precedent for personalized next-action prediction [20]. They train recurrent models on approximately one week of a single user's keyboard and mouse activity to predict the next action from the preceding five actions over a fixed vocabulary of 442 recurring input classes. Their low-level discrete representation and short context differ from the semantically bounded, open-ended write actions and richer event history proposed here, but their results establish the feasibility of learning real-time computer-action predictions from an individual's ordinary use.

Shaikh et al. formalize next action prediction from naturalistic computer use and introduce NAPsack, a passive VLM annotation pipeline, and LongNAP, a retrieval-augmented predictor trained with an LLM-judged temporal similarity reward [13]. This is the closest direct precedent for Phase 1: both works learn person-specific future actions from chronological interaction streams. Their target is an eight-action trajectory of unified natural-language computer events, however, whereas the present proposal predicts one bounded human write action from a functional separation of reads and writes. LongNAP also addresses long-history selection through generated reasoning traces and retrieval rather than the versioned context construction specified here. It does not intervene by rendering model samples and then continue next-action training on the resulting proposal-conditioned stream, which is the defining change in Phase 2.

Kobayashi et al. study autoregressive action predictors trained on unlabeled observation–action trajectories from goal-directed agents and show, in controlled hierarchical environments, that their residual streams encode linearly decodable beliefs about latent subgoals and support temporally abstract internal controllers [14]. This provides controlled evidence that next-action prediction can learn task structure beyond surface action frequencies and suggests a possible bridge from a behavioral prior to later hierarchical control. Their demonstrations come from expert or near-expert agents in fixed grid-world and continuous-control tasks, however, and their downstream internal reinforcement learning uses an externally specified sparse success reward. The result therefore does not establish that ordinary human work traces identify the user's global reward or that model-generated read events improve the human demonstrations subsequently observed.

Classical behavioral cloning is vulnerable to covariate shift when the learned policy takes actions that move an environment into unfamiliar states. DAgger addresses this by querying an expert in states induced by the learner [2]. The proposed Phase 2 shares the idea of collecting new labels after a learner-induced change in the observation stream, but the interaction is different: the system does not execute a trajectory and request an expert action at every visited state. It displays candidate macro-actions as information, then passively observes the person's next macro-action during ordinary work.

Neither phase should be described as reward inference. Maximum-likelihood imitation can assign high probability to observed actions without identifying why the person took them. Phase 2 estimates a different conditional behavioral distribution because the observation history now contains model proposals; it does not convert those observations into an action-value function.

Inverse reinforcement learning instead attempts to recover a reward that explains demonstrated trajectories. AIRL learns rewards through adversarial training with agent rollouts and environment dynamics [15]. D-REX weakens the expert-demonstrator assumption by injecting noise into a behavioral-cloning policy to construct automatically ranked trajectories, then learning and optimizing a reward that can outperform the original demonstrator [16]. These methods show how trajectory rankings can move beyond pure imitation, but they do not instantiate the primary method here, which performs ordinary next-action likelihood training after changing the information presented to the person.

### 2.2 Continual adaptation and dynamic evaluation

The person's activity distribution is not stationary. Projects, collaborators, applications, vocabulary, and habits change, so a one-time behavioral clone becomes stale even if its original training loss was low. Dynamic evaluation adapts a language model to recent sequence history through continued likelihood updates and has improved prediction of recurring sequential patterns [21]. The present proposal adopts the operational principle—adapt from recent chronological data—but updates a bounded personal adapter asynchronously rather than mutating the full serving model after every token.

End-to-End Test-Time Training reframes long-context modeling as continual learning: a model uses next-token prediction to compress observed context into weights, while meta-learning optimizes the initial weights for their ability to adapt at test time [22]. This result is relevant because an initialization optimized only for current training loss need not be an initialization that learns efficiently from a person's future stream. It does not make meta-learning a prerequisite for the first experiment. The minimal system first tests ordinary continual behavioral cloning with replay and publication gates; meta-learned initialization is an escalation path if that system adapts too slowly or unstably.

Continual adaptation creates a stability–plasticity problem. Training only on the newest editing session can overfit a correlated local distribution and forget older workflows; training uniformly on all history can prevent the policy from tracking genuine change. The proposed system therefore distinguishes a recent-data window from stratified historical replay and evaluates both recent chronological likelihood and fixed historical retention. Replay changes the chosen training distribution and reduces short-range correlation, but it does not make the underlying human stream independent and identically distributed.

### 2.3 Generative sequential recommendation

Recent recommender systems cast recommendation as autoregressive sequence modeling. HSTU models user histories as sequential transduction and demonstrates that generative architectures can replace several conventional recommendation components [3]. Shopify's generative recommendation system similarly trains on raw customer event sequences, predicts subsequent products autoregressively, and uses negative sampling to improve ranking [4]. These systems demonstrate that useful prediction and ranking can be learned without a complete causal model of how exposure changes users.

The analogy is operationally valuable but incomplete. Conventional recommender systems usually choose from a catalog and observe clicks, purchases, or other discrete outcomes. Here the action space is open-ended text and structured computer operations, and the human rarely accepts a candidate literally. The displayed outputs alter the information available to the person, after which the person synthesizes a new action. We therefore borrow sequential event modeling and exposure logging from recommender systems while replacing click-based recommendation language with a proposal-conditioned generative interaction.

### 2.4 Coactive learning and assisted demonstrations

Coactive learning assumes that a system proposes a structured output and a user returns a slightly improved output rather than an optimal label. Shivaswamy and Joachims show that such improvements can support online learning even when optimal demonstrations are costly [5]. Tucker et al. develop a coactive algorithm for LLMs from implicit feedback in user edits [6]. These works motivate the possibility that model proposals can elicit more informative human behavior than unaided collection alone.

The present primary method makes a weaker labeling commitment. The system presents a slate rather than a single structured object; the subsequent action can be a synthesis that does not explicitly reference any candidate; and the action is collected as a natural work event rather than through a dedicated correction box. The method therefore records the slate as observed context and clones the action that followed. It does not initially convert the interaction into the preference label $y_t \succ z_{t,i}$.

Kleine Buening et al. likewise learn directly from ordinary user interactions without explicit preference labels [17]. Their method conditions on a later user message to construct a hindsight token distribution, then distills that distribution into the policy. This is a close alternative estimator for the same broad source of supervision. The present proposal instead places candidates actually rendered into the chronological read history and applies the same masked next-action likelihood used in Phase 1 to the human action that followed. It does not use the later action as a teacher distribution for an earlier response.

### 2.5 Preference optimization as a possible extension

Direct Preference Optimization (DPO) reparameterizes a KL-regularized reward optimization problem so that a language-model policy can be optimized directly from preferred and dispreferred completions relative to a reference policy [7]. Identity Preference Optimization (IPO) replaces DPO's unbounded logistic separation with a squared objective targeting a finite log-ratio margin [8]. Both require preference labels that the primary Phase 2 implementation does not claim to observe.

IPO remains a useful exploration if proposal-conditioned BC fails to improve pre-display samples or if explicit relative training adds measurable value. One could treat a post-exposure human action as weakly preferred to a rendered, comparable, non-equivalent candidate and optimize a rolling-reference objective. Calandriello et al. study online IPO and establish an equivalence to Nash mirror descent under their online sampling and preference-model assumptions [9], but those assumptions do not establish the validity of preference labels inferred from the interaction proposed here.

Reference choice is itself consequential. Liu et al. show that DPO is sensitive to the reference policy and regularization strength, and that stronger references help only when sufficiently similar to the policy being optimized [23]. An IPO experiment would therefore use the immediately preceding checkpoint as its rolling reference and retain the initial personalized checkpoint for capability evaluation and rollback. These complications are reasons to test preference optimization as an ablation rather than make it part of the minimal system.

Multiple displayed candidates could alternatively be handled with pairwise, listwise, or softmax preference losses. The append-only interaction record retains the pre-display context, rendered slate, subsequent action, and policy version so these estimators can be compared later without changing the core data collection loop.

### 2.6 Personalized rewards and influenceable preferences

Personalized reward modeling conditions judgments on individual or group differences rather than fitting a single population reward. Recent work studies personalized reward benchmarks and decompositions of heterogeneous preference data [10, 11]. The present proposal is a behavioral rather than reward-modeling method: each person's event history initializes an action prior, and subsequent proposal-conditioned actions continually update a person-specific adapter or policy head.

Li et al. propose Personalized-RLHF, which jointly learns a lightweight user model and a personalized language model from explicit or implicit individual feedback [18]. Their framework establishes a direct personalized-feedback baseline. The present proposal differs by initializing personalization from passive chronological action traces and then continuing maximum-likelihood training after verified model proposals become part of the observed stream, rather than beginning with a conventional human-feedback dataset.

Local judgments and behavior may also change because of the system itself. Carroll et al. formalize alignment problems with changing and influenceable reward functions [12]; their earlier recommender work proposes estimating induced preference shifts relative to a behavioral trust region [24]. In that setting, long-horizon optimization creates an incentive to change users when doing so makes future feedback easier to satisfy. Phase 2 does not optimize clicks, engagement, acceptance, or the quantity of future feedback. It predicts the continuation conditional on the actual slate, but that narrower objective still absorbs behavior induced by the system and therefore requires intervention-aware evaluation.

Proposals can change the person's beliefs, plan, action policy, or subsequent goal specification as an exposure side effect, and continual training can absorb that drift. The core estimator describes the resulting conditional behavior; it does not determine whether the change served the person's prior or current goal. Stable benefit claims require additional outcome measurements and intervention-aware evaluation beyond Phases 1 and 2.

Williams et al. provide an empirical warning about optimizing directly for user feedback: in simulated deployment settings, language models learn manipulative or deceptive feedback-gaming strategies and can identify and target a small vulnerable subset of users [19]. Their results strengthen the case for treating immediate interaction feedback as gameable and for evaluating the proposed collaborative process with outcome measurements and intervention-aware controls rather than assuming that lower local loss is sufficient.

## 3. Problem Formulation

The formalism distinguishes a person's **global goal reward** from the **behavioral prediction target** used for learning. Let $g_t$ denote the goal or objective with respect to which the person acts at time $t$, and let

$$
R_u^{G}(\tau;g_t)
$$

denote the reward of a resulting trajectory or outcome $\tau$. The person is assumed to know the goal they are pursuing, and may be able to express it, but the model need not observe a separate goal label. A goal statement, when present, is simply part of the prior read-write event history. Nor is $R_u^{G}$ assumed to be available to the system as a numerical verifier at each step. It may be sparse, delayed, or evaluable only through the person's judgment and eventual outcomes.

The human action policy can be suboptimal even though the human knows the goal. Conceptually, a human action is generated by $H_u(a\mid h,g)$, while Phase 1 observes only $h$ and learns the marginal predictive policy

$$
\pi_0(a\mid h,u)
\approx
\int H_u(a\mid h,g)\,p(g\mid h,u)\,dg.
$$

No goal annotation or reward loss is required for this behavioral objective. Phase 2 preserves the same next-action prediction task and likelihood objective while changing the information state under which actions are observed. If $Z$ denotes the rendered model slate, the proposal-conditioned human distribution is

$$
p_u^{(2)}(a\mid h,Z,u)
=
\int H_u(a\mid h,Z,g)\,p(g\mid h,Z,u)\,dg.
$$

The model estimates this conditional distribution from the actual read history. It does not infer $R_u^G$, a preference ordering over the slate, or the counterfactual action that would have occurred without exposure.

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

Let $\pi_{\mathrm{base}}$ be a pretrained base model. Phase 1 produces the initial personalized behavioral checkpoint $\pi_0$. All later accepted updates belong to one canonical sequence

$$
\pi_0,\pi_1,\ldots,\pi_d.
$$

Before suggestions begin, the sequence advances through continual masked behavioral-cloning updates on unaided histories. After suggestions begin, the same objective continues on a mixture of unaided and proposal-conditioned histories. There is no separately deployed Phase 1 policy and Phase 2 policy. In a practical enterprise implementation, each $\pi_d$ is an immutable low-rank personal adapter on top of a tenant-approved shared base model rather than a full model copy.

During update $d\geq 1$, the previously deployed canonical policy has two temporary operational roles:

$$
\mu_d = \pi_{d-1},
\qquad
\pi_{\theta_d}\leftarrow\pi_{d-1}.
$$

The deployed copy $\mu_d$ generates suggestions and data while the trainable copy $\pi_{\theta_d}$ becomes the candidate successor. These are copies or roles of one version, not separately learned long-lived policies. If publication checks fail, $\pi_d:=\pi_{d-1}$; otherwise the accepted candidate becomes $\pi_d$.

The initial personalized checkpoint $\pi_0$ is retained as an archival anchor. It does not serve traffic or constrain every update by default. It permits fixed capability evaluation and rollback across the sequence.

At interaction time $t$ during deployment interval $d$, the canonical policy samples $K$ candidates:

$$
z_{t,1:K} \sim \pi_{d-1}(\cdot \mid h_t, u).
$$

The interface renders a subset $R_t \subseteq \{1,\ldots,K\}$. After exposure to the rendered slate $Z_t^R$, the person produces a continuation with respect to their active goal $g_t$:

$$
y_t \sim H_u(\cdot \mid h_t, Z_t^R,g_t),
$$

where $H_u$ denotes the human's post-exposure behavior. The goal argument belongs to the data-generating account; $g_t$ need not be separately observed or supplied to the learned policy. This equation makes the central feedback loop explicit: $y_t$ is generally not sampled from $H_u(\cdot \mid h_t,g_t)$.

### 3.3 Proposal-conditioned behavioral target

Let the verified rendered candidates be serialized as temporally ordered read events. The primary Phase 2 context is

$$
c_t^{(2)} = C_\phi(h_t,Z_t^R),
$$

where the notation emphasizes that the same versioned context builder used in Phase 1 now includes proposal exposures that occurred before the human action began. The primary training example is

$$
(u,c_t^{(2)},y_t).
$$

Its validity requires a reliable human-action boundary and a reproducible account of which proposal content was visible before that boundary. It does not require $y_t$ to be comparable to every candidate, semantically different from them, or better than them. Exact copying is part of the behavior to be modeled. If exposure is ambiguous, the interaction remains available for audit but is excluded from the primary proposal-conditioned slice.

The pre-display context $h_t$ remains a distinct snapshot. It is used to reproduce candidate generation, measure exposure effects, and support optional future estimators. It is not substituted for $c_t^{(2)}$ in the primary loss because doing so would omit information that actually preceded and may have caused $y_t$.

### 3.4 Optimization target

The Phase 2 target is not the counterfactual action the person would have taken without exposure; that action is unobserved. Nor is it click-through rate or a latent preference score. The target is the next human action under the actual proposal-conditioned history. Data are generated under the joint deployed process:

$$
h_t \rightarrow Z_t^R \rightarrow y_t \rightarrow \text{policy update}.
$$

Accordingly, the learned policy describes a versioned collaborative equilibrium: the model changes the person's read history, the person acts in that changed information state, and later model versions learn the resulting conditional behavior. Lower next-action loss shows better prediction of that behavior. It does not show that the rendered candidates improved the action, that the next proposal distribution improved, or that realized global reward increased. Those claims require downstream outcome evaluation and, where causal attribution matters, randomized no-slate or alternative-slate controls.

## 4. Method

### 4.1 Phase 1: initial next-write behavioral cloning

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

#### 4.1.1 Phase 1 failure modes and escalation paths

| Plausible failure                                                                                   | Hypothesized next steps                                                                                                                                          |
| --------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| The event timeline, authorship, or action boundaries cannot be reconstructed reliably               | Collector audits, versioned segmentation, provenance checks, confidence filtering                                                                                |
| The captured stream omits the information that caused the action, making the target underdetermined | Collect browser/chat context; oracle-context ablation; change the target if no signal exists                                                                     |
| Useful context exists but raw context selection fails                                               | Recent-context ICL, BM25 retrieval, GUM semantic propositions, JIT-objective induction, then LongNAP learned reason–retrieve–predict                             |
| The model learns style, formatting, location, or repetition rather than semantic intent             | Five-action GRU/trivial baselines, content-matched hard negatives, field-decomposed metrics                                                                      |
| Plain LoRA SFT cannot exploit demonstrably useful data                                              | Compare ICL, retrieval, and SFT on the same model; then DITTO, LongNAP, or E2E-TTT depending on the diagnosis                                                    |
| Phase 1 becomes stale or forgets sparse workflows as new data arrives                               | Time-balanced sampling, recent-plus-stratified replay, rolling and fixed holdouts, rollback                                                                      |
| Fine-tuning damages reasoning, instruction following, or tool use                                   | KL anchoring or teacher distillation, synthetic QA/self-study, parameter isolation or retrieval–weight hybrids                                                   |
| Demonstrations are noisy, expedient, copied, AI-authored, or inconsistent                           | Provenance filtering and confidence weighting; robust/noisy BC or demonstration-derived contrast when quality signals exist; otherwise later coactive correction |
| One low-rank adapter cannot represent conflicting workflows or reaches capacity                     | Partitioned adapters, parameter isolation, additional adapter capacity, retrieval–weight hybrids                                                                 |
| No tested method can exploit data that oracle tests show is useful                                  | Open source a benchmark on the data stream, allow submissions; use it to challenge frontier model performance and algorithmic sample efficiency                  |

### 4.2 Continual canonical-policy infrastructure

Initial training produces a useful prior but not a permanently current policy. New projects, tools, collaborators, vocabulary, habits, and later model interventions change the distribution of $(h,y)$ over time. The same asynchronous update infrastructure therefore spans both phases. Before suggestions begin, the canonical policy is updated with BC on unaided histories. After suggestions begin, it is updated with the same BC objective on the actual mixture of unaided and proposal-conditioned histories. Newly finalized examples are accumulated, mixed with historical BC replay, used to train a candidate adapter initialized from $\pi_{d-1}$, and published as the new immutable $\pi_d$ only after validation.

The behavioral component of continual training does not require a new label or loss function. Let $\mathcal{N}_d$ be a batch sampled from a recent window of newly finalized examples and let $\mathcal{R}_d$ be a stratified replay batch from older accepted examples. Before Phase 2, the update objective is

$$
\begin{aligned}
\mathcal{L}_{\mathrm{BC}}^{(\mathrm{cont})}(\theta;d)
={}&
\rho_d\mathcal{L}_{\mathrm{BC}}(\mathcal{N}_d) \\
&+(1-\rho_d)\mathcal{L}_{\mathrm{BC}}(\mathcal{R}_d),
\end{aligned}
$$

where $\rho_d\in[0,1]$ controls the stability–plasticity tradeoff. A larger value follows recent behavior more aggressively; a smaller value preserves the historical distribution more strongly. $\rho_d$ is selected against both recent and fixed historical validation sets rather than treated as a universal constant. The same two batches and weighting remain in Phase 2. Recency weighting defines which time-local behavior the model is intended to estimate. It is not automatically an importance-sampling correction.

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
5. **Asynchronous immutable publication.** Collection continues while a candidate adapter trains. The candidate, optimizer configuration, data cutoff, update trigger, replay composition, and parent version are logged. Publication creates the next immutable canonical version; rejection leaves the deployed canonical version unchanged.
6. **Two-horizon evaluation.** A delayed rolling chronological set measures freshness on recent behavior. A fixed historical set measures forgetting. Both are supplemented by domain, action-family, boundary-confidence, target-length, and archival-anchor capability slices.

Replay does not make chronological observations independent and identically distributed. It deliberately constructs a less correlated, inspectable training mixture. The chosen mixture is part of the estimator and must be reported. The initial system uses ordinary masked next-action likelihood throughout; it does not require a new continual-learning objective merely because updates recur.

Once Phase 2 begins, the source distribution changes because rendered proposals become read events. Each BC example must therefore record whether it was collected with no proposal, after verified proposal exposure, or under ambiguous exposure. For verified proposal exposure, the BC context is the actual history $(h_t,Z_t^R)$ and loss remains masked to the subsequent human action $y_t$. For an unaided action, the BC context remains $h_t$. Ambiguous exposure is retained for audit but excluded from the primary proposal-conditioned slice. The pre-display snapshot is stored separately to reproduce candidate generation and support intervention analysis or future estimator substitutions.

#### 4.2.3 Publication criteria and failure escalation

A candidate continual update is not accepted merely because its training loss falls. At minimum, publication requires no unacceptable regression on the fixed historical holdout, improvement or non-inferiority on the recent chronological holdout, finite and stable gradients, and no failed high-priority action-family slice. Once Phase 2 begins, recent next-action likelihood is reported separately for unaided contexts $h_t$ and proposal-conditioned contexts $(h_t,Z_t^R)$ so one conditional cannot hide degradation in the other. The previous policy and optimizer state remain available for rollback. Update frequency is chosen by measuring the frontier among freshness, gradient variance, compute cost, and publication risk rather than by assuming that the freshest possible update is best.

Several more complex methods may become necessary, but they are ablations or escalation paths rather than prerequisites for the initial system:

- **Meta-learned or E2E-TTT initialization** is appropriate if ordinary LoRA updates learn recent behavior too slowly or destabilize after repeated updates. It optimizes initial weights for future adaptation rather than only for current training loss.
- **Teacher distillation or explicit KL anchoring** is appropriate if replay and publication gates fail to preserve required base capabilities or older workflows. The frozen base, $\pi_0$, an intermediate canonical checkpoint, or a capability teacher can supply the additional anchor, but the retained behavior must be named explicitly.
- **Surprise-weighted updates, prioritized replay, or per-parameter adaptive learning rates** are appropriate if examples differ greatly in novelty or learning value. They should be introduced only after calibration shows that surprise predicts useful adaptation rather than telemetry noise.
- **Adaptive replay, recency weighting, or clipped importance weighting** is appropriate if the scientific target is explicitly the newest behavioral distribution and replay bias becomes measurable. Whole-sequence importance ratios are expected to be high variance.
- **Partitioned adapters, parameter isolation, or retrieval–weight hybrids** are appropriate if one adapter cannot represent conflicting workflows or if parametric capacity becomes the bottleneck. Retrieval and context compression address context memory; they do not by themselves solve replay or training memory.

The purpose of enumerating these methods is to make failure responses explicit. They should not obscure the minimal test: whether one LoRA-based canonical policy, updated with token-budgeted optimization, proposal-conditioned examples, stratified BC replay, and strict publication gates can remain current enough for the intended product.

### 4.3 Phase 2: proposal generation and exposure

At a well-defined action opportunity, the deployed policy samples $K$ bounded macro-actions from the pre-display context. Sampling should preserve meaningful diversity without making candidates implausible. Temperature, nucleus threshold, random seed, stop condition, and policy version are logged for every candidate.

Only content confirmed as rendered becomes part of the behavioral history. A generated candidate hidden by truncation, ranking, latency, or interface state was not available to the person and must not be serialized as a read event. Exposure time must precede the start of the human macro-action. If the interface cannot establish visibility or temporal order, the interaction is retained as ambiguous but excluded from the primary proposal-conditioned slice.

The person then acts normally. There is no accept button in the core design. The system captures the next macro-action $y_t$ and stores both:

- the **pre-display context** $h_t$, used to generate the slate and reproduce the intervention; and
- the **behavioral context** $(h_t,Z_t^R)$, used to predict the subsequent human action and reconstruct what the person observed.

The masked BC loss conditions on $(h_t,Z_t^R)$ and applies loss only to $y_t$. Proposal tokens are read context, not prediction targets. Omitting the slate would hide information that actually preceded and may have caused the human action; scoring the slate itself would train the model to imitate its own samples. The primary method does neither.

### 4.4 Proposal-conditioned behavioral examples

For any finalized next-action example, define the behavioral context

$$
c_t^{\mathrm{BC}}
=
\begin{cases}
h_t, & \text{without proposal exposure},\\
(h_t,Z_t^R), & \text{after verified proposal exposure}.
\end{cases}
$$

The action-only mask is unchanged from Phase 1. For a batch $\mathcal B$,

$$
\mathcal L_{\mathrm{BC}}(\mathcal B)
=
-\mathbb E_{(c^{\mathrm{BC}},y)\sim\mathcal B}
\left[\ell_\theta(y\mid c^{\mathrm{BC}},u)\right].
$$

Rendered proposal tokens receive no target loss. If the human copies a proposal exactly, the resulting action remains a valid behavioral target. If the human combines proposals, rejects their framing, changes action family, or produces something new, the finalized action also remains the target because the estimator models what followed the observed history rather than constructing candidate-level labels.

If no reliable human macro-action follows within the interaction window, no BC example is finalized for that exposure. Inactivity is not a rejection label. The rendered proposals remain auditable read events, but they are not paired with an unrelated action after a task switch, long interruption, or uncertain boundary.

### 4.5 Phase 2 continual objective

Let $\mathcal N_d$ be recent finalized examples and $\mathcal R_d$ be the stratified historical replay batch defined in Section 4.2. Both carry the behavioral context actually observed at collection time. The canonical update remains

$$
\begin{aligned}
\mathcal L_d(\theta)
={}&
\lambda_{\mathrm{new}}\mathcal L_{\mathrm{BC}}(\mathcal N_d) \\
&+\lambda_{\mathrm{replay}}\mathcal L_{\mathrm{BC}}(\mathcal R_d),
\end{aligned}
$$

with nonnegative coefficients selected against recent and fixed validation sets. Setting $\lambda_{\mathrm{new}}=\rho_d$ and $\lambda_{\mathrm{replay}}=1-\rho_d$ recovers the continual objective in Section 4.2. Phase 2 introduces no additional primary loss coefficient. Its implementation change is that verified proposal content now appears inside $c_t^{\mathrm{BC}}$ for the affected examples.

Recent and historical batches may contain both unaided and proposal-conditioned examples. Every example is replayed with its stored behavioral context, so an old action observed after a slate remains conditioned on that slate. Sampling strata should include collection regime to prevent a high-volume proposal-conditioned workflow from eliminating unaided examples or vice versa.

Publication reports next-action likelihood separately on unaided and proposal-conditioned chronological holdouts, in addition to fixed historical and capability slices. This separation tests whether the model learns the new conditional distribution without allowing one regime to conceal degradation in the other.

The objective directly improves prediction under $(h_t,Z_t^R)$; it does not directly optimize the quality of samples generated from $h_t$ before the slate exists. Parameter sharing may transfer learning across the two context regimes, but that transfer is an empirical result rather than a consequence of the loss. Pre-display sample quality and human outcome quality must therefore be evaluated separately.

### 4.6 Potential exploration: coactive IPO

Preference optimization remains a potential follow-on estimator, not part of the primary Phase 2 implementation. It is motivated only if proposal-conditioned BC does not improve pre-display samples sufficiently or if explicit negative information adds value beyond the behavioral target.

For an exploratory interaction-level dataset $\mathcal P_d$, a candidate pair may be constructed only when the proposal was rendered before the human action, the two actions are comparable, and they are not semantically equivalent. This introduces the additional assumption

$$
y_t \succ_{h_t,u,g_t} z_{t,i},
$$

which the core BC method does not need. A rendered candidate may have been useful in producing $y_t$, and the user did not explicitly rank the slate, so this label must be treated as weak and tested through manual audits and outcome evaluation.

If the experiment is enabled, freeze the collection policy $\pi_{d-1}$ and define

$$
q_d(\theta;h,u,a)
=\ell_\theta(a\mid h,u)-\ell_{d-1}(a\mid h,u),
$$

$$
\Delta_{d,t,i}(\theta)
=q_d(\theta;h_t,u,y_t)-q_d(\theta;h_t,u,z_{t,i}),
$$

and optimize the finite-margin objective

$$
\begin{aligned}
\mathcal L_{\mathrm{IPO}}^{(d)}(\theta)
=
\mathbb E_{t\sim\mathcal P_d}\!\Bigg[
\frac{1}{\sum_i w_{t,i}}
\sum_i w_{t,i}
\left(
\Delta_{d,t,i}(\theta)-\frac{1}{2\beta}
\right)^2
\Bigg],
\end{aligned}
$$

omitting interactions with $\sum_iw_{t,i}=0$. Averaging within interaction prevents a large slate from giving one human action disproportionate weight. The exploratory combined loss would be

$$
\mathcal L_d^{(\mathrm{explore})}
=
\mathcal L_d
+\lambda_{\mathrm{pref}}\mathcal L_{\mathrm{IPO}}^{(d)}.
$$

Fresh pairs must name the collection policy used as their reference. Historical preference replay would require retaining that collection-time reference and is not implied by the core BC replay system. IPO should be retained only if it improves preregistered pre-display proposal or outcome metrics beyond proposal-conditioned BC while passing the same retention and capability gates.

## 5. Data Structures

The storage design is append-only and versioned. Raw observations, exposures, and derived BC examples are separate records. Optional preference records can be derived later from the retained interaction. Derived data can be rebuilt when action segmentation, context construction, exposure policy, or an exploratory label policy changes.

### 5.1 Event record

```text
Event {
  event_id: UUID
  tenant_id: UUID
  principal_id: UUID
  session_id: UUID?
  environment_instance_id: UUID?
  started_at: timestamp
  ended_at: timestamp
  kind: READ | WRITE | NAVIGATION | SYSTEM
  actor: HUMAN | ASSISTANT | EXTERNAL | SYSTEM
  app: string
  object_uri: string?
  operation: string
  content_ref: encrypted_blob_ref?
  visible_or_edited_span: Span?
  source_event_ids: [UUID]
  state_before_snapshot_ref: encrypted_blob_ref?
  state_after_snapshot_ref: encrypted_blob_ref?
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
- When telemetry permits, before/after snapshot references preserve structured application or computer state for later transition learning. Hashes verify those snapshots but cannot replace their contents as world-model supervision.
- Actor and environment-instance identifiers distinguish human actions, assistant actions, exogenous changes, production traces, and sandbox traces.
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
  context_role: PRE_DISPLAY | BEHAVIORAL
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

The snapshot is the reproducibility boundary for a model input. It records the actual serialized context, not merely a query that might return different data later. An unaided interaction can reuse one snapshot for both roles; proposal exposure produces a pre-display snapshot $h_t$ and a behavioral snapshot $(h_t,Z_t^R)$. Explicit task or goal fields may be included when naturally available, but they are not required for Phase 1.

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
  sampling_temperature: float
  sampling_top_p: float
  random_seed: int
  generation_logprob: float
  generated_at: timestamp
  rendered_at: timestamp?
  render_completed_at: timestamp?
  visible_duration_ms: int?
  rendered: bool
}

ExposureInteraction {
  interaction_id: UUID
  principal_id: UUID
  pre_display_context_id: UUID
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

Generation-policy log-probabilities should be stored at collection time and be recomputable from retained model versions. They reproduce how the intervention was generated and support later off-policy or preference experiments. Render status is candidate-specific: generating a candidate does not imply exposure.

### 5.5 Optional derived preference record

The primary Phase 2 pipeline does not construct or consume preference pairs. If the IPO exploration in Section 4.6 is enabled, the following derived record can be built from retained interactions without changing raw collection:

```text
PreferencePair {
  pair_id: UUID
  interaction_id: UUID
  principal_id: UUID
  pre_display_context_id: UUID
  preferred_action_id: UUID       // inferred post-exposure human continuation
  dispreferred_candidate_id: UUID // rendered model proposal
  exposure_weight: float
  comparability_weight: float
  boundary_weight: float
  equivalence_weight: float
  aggregate_weight: float
  label_policy_version: string
  collection_policy_version: string
  eligible_reference_policy_version: string
  exclusion_reason: string?
}
```

Excluded exploratory pairs should be retained with `aggregate_weight = 0` and an exclusion reason. Any training manifest for an IPO experiment must name the pair identifiers and the frozen collection-time reference separately. None of this state is required for the primary BC update.

### 5.6 Training example and replay records

```text
BCExample {
  example_id: UUID
  principal_id: UUID
  pre_display_context_id: UUID
  behavioral_context_id: UUID       // equals pre-display when unaided; includes rendered proposals when exposed
  rendered_candidate_ids: [UUID]
  target_action_id: UUID
  source_regime: BC_BOOTSTRAP | BC_ONLY_CONTINUAL | PROPOSAL_CONDITIONED_CONTINUAL
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

BCReplayBufferState {
  buffer_version: string
  principal_id: UUID
  recent_example_ids: [UUID]
  historical_strata: map<string, [UUID]>
  last_accepted_data_cutoff_at: timestamp?
  retention_cutoff_at: timestamp
  capacity_examples: int?
  capacity_tokens: int?
  sampling_policy_version: string
  created_at: timestamp
}

TrainingBatchManifest {
  batch_id: UUID
  training_kind: BC_BOOTSTRAP | BC_ONLY_CONTINUAL | PROPOSAL_CONDITIONED_CONTINUAL
  parent_canonical_policy_version: string
  archival_anchor_policy_version: string?
  candidate_policy_version: string
  published_canonical_policy_version: string?
  data_cutoff_at: timestamp
  update_trigger_reason: NEW_TOKEN_THRESHOLD | NEW_ACTION_THRESHOLD | MAX_DELAY | MANUAL | NONE
  recent_bc_example_ids: [UUID]
  replay_bc_example_ids: [UUID]
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

The BC replay state records the sampling index and the last data cutoff incorporated by an accepted update, not a second mutable copy of raw content. BC examples remain replayable after that watermark advances. The manifest makes every bootstrap, BC-only continual, and proposal-conditioned continual update reproducible, including rejected candidates and the exact recent/replay mixture. An optional IPO experiment extends rather than changes this core manifest with its pair identifiers and frozen reference. In an enterprise deployment, raw content remains inside its tenant boundary; cross-user learning should operate on approved shared parameters or privacy-preserving aggregates rather than pooled plaintext traces.

## 6. Algorithms

### Algorithm 1: Construct behavioral-cloning examples

```text
procedure BUILD_BC_EXAMPLES(events, segmentation_config, context_config, source_regime):
    ordered_events <- stable_sort(events, by=(timestamp, ingestion_sequence))
    macro_actions <- SEGMENT_WRITES(ordered_events, segmentation_config)
    dataset <- empty list

    for action y in macro_actions:
        if y.confidence < segmentation_config.minimum_confidence:
            continue

        prior_events <- events strictly before y.began_at
        h_behavioral <- BUILD_CONTEXT(prior_events, context_config)
        h_pre_display <- PRE_DISPLAY_CONTEXT_OR_SELF(
            h_behavioral, y, ordered_events
        )

        if LEAKS_TARGET(h_behavioral, y):
            continue

        serialized_y <- SERIALIZE_ACTION(y)
        loss_mask <- MASK_CONTEXT_AND_SCORE_TARGET(h_behavioral, serialized_y)

        dataset.append(
            BCExample(
                pre_display_context=FREEZE(h_pre_display),
                behavioral_context=FREEZE(h_behavioral),
                rendered_candidate_ids=RENDERED_CANDIDATES_IN_INTERACTION(y),
                target_action=y,
                loss_mask=loss_mask,
                source_regime=source_regime,
                collection_regime=CLASSIFY_COLLECTION_REGIME(y, ordered_events)
            )
        )

    return dataset
```

`BUILD_CONTEXT` must preserve temporal interleaving. It may truncate or summarize older events, but it records every decision. A rendered assistant proposal before the human action is therefore part of `h_behavioral`; an unrendered candidate is not. The pre-display snapshot is retained separately to reproduce generation and support intervention analysis or optional future estimators. The same builder runs over the initial corpus and incrementally over events finalized past the continual-learning watermark; the source regime and exposure join distinguish bootstrap, BC-only continual, and proposal-conditioned continual examples. Splits should be chronological: train on earlier actions, validate and test on later actions. Randomly splitting adjacent events would leak repeated local context and overstate generalization.

### Algorithm 2: Train the Phase 1 bootstrap policy

```text
procedure TRAIN_BEHAVIORAL_BOOTSTRAP(base_policy pi_base, phase1_dataset D1):
    pi_theta <- INITIALIZE_PERSONAL_ADAPTER(pi_base)

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

    pi_0 <- PUBLISH_IMMUTABLE(pi_theta, role=CANONICAL)
    RETAIN_AS_ARCHIVAL_ANCHOR(pi_0)
    return pi_0
```

Time-balanced sampling prevents dense editing sessions from completely dominating sparse but distinct workflows. The exact mixture is part of the dataset specification and should be reported with results when experiments exist. $\pi_0$ is both the first canonical policy and the archival checkpoint for capability measurement and rollback. It is not a separately updated Phase 1 model after Phase 2 begins.

### Algorithm 3: Collect one proposal-conditioned interaction

```text
procedure COLLECT_PROPOSAL_CONDITIONED_INTERACTION(
    pi_canonical, live_event_stream, K
):
    cutoff <- current time
    h <- FREEZE(BUILD_CONTEXT(events before cutoff))

    candidates <- SAMPLE_DIVERSE_MACRO_ACTIONS(
        policy=pi_canonical,
        context=h,
        count=K,
        bounded_to=ACTIVE_ACTION_FAMILY
    )

    for z_i in candidates:
        log candidate text, policy version, sampling parameters,
            TOKEN_LOGPROB(pi_canonical, z_i | h)

    rendered_candidates <- RENDER_AND_CONFIRM_VISIBILITY(candidates)
    log exposure timestamps for each rendered candidate
    APPEND_RENDERED_READ_EVENTS_TO_STREAM(
        live_event_stream, rendered_candidates
    )

    y <- WAIT_FOR_NEXT_HUMAN_MACRO_ACTION_WITHIN_WINDOW()

    if y does not exist or its boundary is ambiguous:
        close interaction without a BC example
        return

    h_behavioral <- FREEZE(
        BUILD_CONTEXT(events strictly before y.began_at)
    )

    if not CONTAINS_VERIFIED_EXPOSURES(h_behavioral, rendered_candidates):
        close interaction as ambiguous without a BC example
        return

    store BCExample(
        pre_display_context=h,
        behavioral_context=h_behavioral,
        rendered_candidate_ids=IDS(rendered_candidates),
        target=y,
        source_regime=PROPOSAL_CONDITIONED_CONTINUAL,
        collection_regime=PROPOSAL_EXPOSED
    )

    close interaction
```

This algorithm waits for a natural action but does not ask the user to grade the slate. A practical interface should close the capture window on a confirmed task switch or long inactivity so that unrelated future work is not attached to the exposure. Exact copying and action-family changes require no special label treatment: the finalized action is simply the next write target under the recorded read history.

### Algorithm 4: Continually update the canonical policy

```text
procedure UPDATE_CANONICAL_POLICY(
    pi_previous, incoming_bc N, bc_replay_state R, config
):
    candidate <- CLONE_ADAPTER(pi_previous)

    finalized <- examples in N that are:
        before config.lateness_watermark,
        not superseded,
        above minimum boundary confidence,
        and eligible under the current data policy

    R <- UPDATE_BC_REPLAY_INDEX(R, finalized)
    pending_bc <- NEWLY_FINALIZED_SINCE(
        R,
        R.last_accepted_data_cutoff_at
    )
    if NEW_TARGET_TOKENS(pending_bc) < config.update_trigger_tokens
       and NEW_ACTIONS(pending_bc) < config.update_trigger_actions
       and TIME_SINCE_LAST_JOB() < config.maximum_update_delay:
        return pi_previous, R without launching a training job

    recent <- SAMPLE_RECENT_TRAINING_WINDOW(
        R,
        exclude=config.rolling_recent_holdout
    )
    replay <- SAMPLE_STRATIFIED_HISTORY(
        R,
        strata=(time_period, domain, action_family, provenance, collection_regime),
        exclude=(recent, config.fixed_historical_holdout)
    )

    groups <- PACK_AND_ACCUMULATE(
        recent,
        replay,
        microbatch_total_token_limit=config.microbatch_total_tokens,
        effective_target_token_budget=config.effective_target_tokens
    )

    for optimizer group G in groups:
        L_new <- 0
        L_replay <- 0

        if G.recent is not empty:
            L_new <- MEAN_MASKED_ACTION_NLL(
                candidate, G.recent, context_field=behavioral_context
            )
        if G.replay is not empty:
            L_replay <- MEAN_MASKED_ACTION_NLL(
                candidate, G.replay, context_field=behavioral_context
            )
        L_total <- config.lambda_new * L_new
                 + config.lambda_replay * L_replay
        candidate <- OPTIMIZER_STEP(candidate, gradient(L_total))

    report <- EVALUATE(
        candidate,
        archival_anchor=config.archival_pi_0,
        rolling_recent_holdout=config.rolling_recent_holdout,
        fixed_historical_holdout=config.fixed_historical_holdout,
        slices=(domain, action_family, capability, target_length, collection_regime)
    )

    store TrainingBatchManifest for the candidate and report

    if PASSES_CONTINUAL_PUBLICATION_GATES(report):
        pi_next <- PUBLISH_IMMUTABLE(candidate, role=CANONICAL)
        if pending_bc is not empty:
            ADVANCE_ACCEPTED_BC_CUTOFF(R, MAX_FINALIZED_AT(pending_bc))
        return pi_next, R
    else:
        reject candidate and retain pi_previous
        retain pending_bc for a later candidate job
        return pi_previous, R
```

The same update runs before and after suggestions begin. The difference is entirely in the behavioral contexts carried by newly finalized examples. The update trigger controls freshness, not the number of examples in one gradient step. Microbatch size is determined by total serialized tokens that fit in memory; gradient accumulation determines the effective target-token budget. Collection continues from $\pi_{d-1}$ while its candidate successor trains, and an accepted candidate becomes $\pi_d$.

## 7. Assumptions and Identification Boundaries

The formalism depends on the following assumptions. They should be tested as data-quality and product assumptions rather than hidden inside the optimizer.

### 7.1 Informative but imperfect behavior

The person is assumed to have a goal or objective in mind and to know the outcome they are trying to achieve. Their observed actions must contain signal about that objective while leaving room for assistance. The mismatch is between the goal and the policy used to pursue it, not evidence that the goal is nonexistent or unknown to the person. If the person routinely acts against their own goal for reasons absent from the context, behavioral cloning can learn the wrong prior, and proposal exposure does not automatically repair it.

### 7.2 Temporal drift and the target distribution

Recent behavior is not automatically better evidence than older behavior. It may represent a durable change, a temporary project, missing context, or noise. The recent-window definition, replay mixture, collection-regime mixture, and update cadence jointly define the time-local distribution that the current canonical policy $\pi_d$ estimates. A continual model can be more current while becoming less representative of stable behavior. Both properties require separate evaluation.

### 7.3 Replay and capability retention

Stratified replay reduces forgetting risk but does not guarantee retention of old workflows, instruction following, tool use, or general reasoning. A low-rank adapter also imposes a capacity and interference constraint. The minimal system relies on fixed historical evaluations and rollback; distillation, explicit KL anchoring, parameter isolation, or additional capacity are justified only when those measurements reveal a concrete failure.

### 7.4 Faithful exposure reconstruction

The primary estimator requires the behavioral context to contain what was actually available before the target action. Generated-but-hidden candidates must be excluded, late renders must not appear before the action, and content visible only after truncation or navigation must not be reconstructed retroactively. Action segmentation and exposure timing are therefore parts of the statistical estimator rather than mere logging details.

### 7.5 Exposure is not assumed to be beneficial

The core likelihood estimator assumes only that the recorded action followed the recorded history. It does not assume that the action is better than each proposal or better than the action the person would have produced unaided. The product hypothesis is that plausible alternatives often scaffold useful recall, criticism, or synthesis. Proposals may instead distract, anchor, manipulate, or confuse the person. Outcome audits and randomized no-exposure or alternative-exposure controls are required to distinguish behavioral change from benefit.

### 7.6 No causal credit assignment among slate items

Proposal-conditioned BC learns the distribution of actions following the entire rendered history. It does not identify which candidate inspired which span, whether one candidate offset harm from another, or whether the same action would have occurred without the slate. Candidate-level credit assignment requires an explicitly intervention-aware estimator. The optional IPO extension introduces a relative label but still does not establish causal contribution.

### 7.7 Behavioral prediction versus global reward

The person's global goal reward and Phase 2 next-action likelihood are not interchangeable. The former evaluates the outcome the person is trying to achieve; the latter measures how well the model predicts a macro-action under its observed history. Lower likelihood loss does not solve temporal credit assignment, reveal the person's objective, or validate multi-step planning. A later planner would need a learned or external transition model, delayed outcome signals, uncertainty controls, and checks that optimizing any dense proxy improves rather than exploits the sparse global reward.

### 7.8 Task-local goals and a dynamic collaborative equilibrium

At any valid interaction, the person is assumed to know the goal they are pursuing, although the model need not observe it separately. Goals can differ across tasks and change over time. The person may learn from the policy, the policy learns from the person, and proposals may change the person's beliefs or action policy even when the active goal remains fixed. The learned behavioral distribution therefore belongs to a versioned joint process rather than an immutable human policy. This is acceptable for modeling the collaboration actually deployed, but changes in goal, belief, behavior, and outcome must remain distinct in any benefit claim.

### 7.9 Versioned support and uncertainty

Next-action estimates are trustworthy only near the contexts and actions represented in the collected stream. Proposal-conditioned examples introduce a distinct regime whose support depends on the candidate policy, sampling configuration, interface, and exposure rate. Every record must therefore carry its current-policy, context-builder, action-segmentation, interface, and data-window versions. Enterprise deployment should attach uncertainty or support checks and abstain from treating likelihood as an unrestricted verifier. Per-user data scarcity makes shared representation learning useful, but tenant and user identity must not be erased by indiscriminate pooling. If IPO is tested later, its collection-time reference becomes additional estimator state rather than ordinary provenance [23].

Multi-step planning, simulation, and execution are outside this paper's scope; the directional extension is specified separately in [[Phase 3 Direction]].


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

[23] Y. Liu, P. Liu, and A. Cohan. [*Understanding Reference Policies in Direct Preference Optimization*](https://arxiv.org/abs/2407.13709). 2024.

[24] M. Carroll, D. Hadfield-Menell, S. Russell, and A. D. Dragan. [*Estimating and Penalizing Induced Preference Shifts in Recommender Systems*](https://arxiv.org/abs/2204.11966). 2022.
