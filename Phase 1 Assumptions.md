# Phase 1 Assumptions

The project aims to build a human–model system whose usefulness compounds through shared work. A broadly capable model contributes knowledge, speed, and alternative continuations; the person contributes goals, private context, judgment, synthesis, and authority. The system learns from the temporally interleaved stream of what the person encounters, what the model shows, and what the person does next.

Phase 1 establishes the predictive substrate for that system. It asks whether a faithful personal read–write stream contains information that a model can use to anticipate bounded future actions. Closed-loop deployment then tests whether samples from that predictor become useful material for thought and whether continuing the same next-action training over the expanded stream improves the joint system.

The ranked assumptions are:

1. **The observable read–write stream contains marginal, goal-relevant information.**
   Correctly timed browser activity, chats, note state, and prior actions must predict the semantic content of the next action better than the current artifact and generic world knowledge alone. This is the foundation of the data-legibility thesis. If a capable model performs equally well without the personal stream, neither personal data collection nor continual personalization creates much advantage.

2. **Difficult next-action prediction contains objective-level structure.**
   Repetition, style, and workflow regularity may explain many actions. The stronger hypothesis is that predicting novel or ambiguous actions benefits from representing what the person is locally trying to accomplish: the question being answered, the ambiguity being resolved, or the constraint that determines what progress means. Phase 1 tests this through explicit objective-induction baselines, similar-surface/different-goal cases, and novel actions serving familiar objectives. It does not require a unique or stable representation of that objective.

3. **Predictive competence transfers into useful possibilities for the person.**
   A model that lowers loss by learning punctuation, favorite files, or repeated phrases could be a good compressor while offering little useful assistance. The deployed predictor must produce plausible continuations that can remind, challenge, reframe, or expose a line of thought the person would not otherwise have reached as quickly. This is the central bridge from “predicts me” to “helps the human–model system.” Its truth is determined by controlled system outcomes, not by textual overlap between a sample and the next action.

4. **The exposed interaction remains learnable as next-action prediction.**
   Once a sample is rendered, it becomes an assistant-authored read event in the same temporal stream. The person's later action is therefore a valid behavioral target conditioned on the information they actually encountered. Copying, refinement, synthesis, rejection, and task switching are expressed directly as ordinary human actions following different histories. This assumption depends on accurate exposure times, adequate context retention, and action boundaries that preserve the relevant interaction.

5. **The closed loop improves the joint system without harmful convergence.**
   Repeated exposure and retraining may improve local relevance, but they may also anchor the person, narrow behavior, select for predictability, or amplify temporary patterns. The project requires randomized unaided and static-assistant comparisons, exposure controls, behavioral-diversity audits, user override, rollback, and capability checks. Lower next-action loss is insufficient evidence for this assumption.

6. **Personal context continues to add value at frontier model capability.**
   The important quantity is a within-model gain: the same capable model performs better with correct personal history than without it or with plausible but mismatched history. A smaller personalized model beating an older generic model would confound personal evidence with base capability. The defensible advantage of the stream is whether it tells strong models something consequential that scale alone does not.

7. **The actual pre-action information state can be captured faithfully.**
   The system must know what text was visible, how much of a page or video had been consumed, which assistant tokens had rendered, what was authored versus pasted, and when an action began. Otherwise it learns and evaluates against a fictional history. This is why the capture audit is the first experimental gate in [[Phase 1 Details#Experiment 0: Collector and reconstruction audit]].

8. **The chosen macro-action is a meaningful prediction boundary.**
   A sentence, bullet, search query, prompt, or coherent edit burst must correspond to a useful unit of behavior. Tokens are too small; Git commits often combine several intentions. The same boundary must remain coherent when the history contains assistant outputs so that bootstrap and closed-loop examples estimate the same kind of next action.

9. **Personalization can add local knowledge without sacrificing general capabilities.**
   A personal adapter might improve next-write likelihood while degrading reasoning, instruction following, tool use, or unfamiliar-task performance. That would weaken the human–model system even if behavioral prediction improved. Continual publication therefore requires both personal prediction gains and retention of the base model capabilities on which useful alternatives depend.

10. **Relevant information can be selected or encoded from a long, noisy history.**
    The necessary signal may exist while raw long-context prompting, retrieval, memory, and supervised fine-tuning all fail to expose it. An oracle-context comparison distinguishes missing information from failed selection. If manually selected context helps while automatic context does not, the data thesis survives but the deployable system remains unsolved.

11. **Useful personal evidence accumulates faster than it becomes stale.**
    There must be enough per-user data to learn before projects, vocabulary, collaborators, and objectives change. Recent examples must track genuine movement without letting one correlated session dominate, while replay must preserve durable workflows without freezing the model in the past.

12. **Evaluation can separate personalization, representation, and system benefit.**
    Chronological splits, temporal embargoes, wrong-time and mismatched-history controls, hard negatives, and session-level uncertainty are needed to establish predictive gain. Goal-representation diagnostics must remain tied to held-out actions. Randomized outcome comparisons are needed to establish that rendered samples help. These are distinct claims and must not be collapsed into a single score.

A credible definition of Phase 1 success is therefore:

> On future chronological macro-actions, a frontier-capable model with automatically constructed, temporally valid personal context produces a repeatable, product-relevant improvement over the same model without personal context and with mismatched personal context. The improvement survives content-sensitive evaluation, is not explained by leakage or stylistic mimicry, supports content-sensitive top-$k$ prediction suitable for controlled deployment, and does not degrade general capabilities.

Phase 1 need not make a small personalized model outperform the strongest generic model in absolute terms. The primary quantity is the marginal personal-history gain at each capability level. A stronger base model can always be inherited; the research question is whether the personal stream contributes information that the base model could not obtain elsewhere.

The largest unresolved bridge is Assumption 3. Excellent Phase 1 likelihood would establish that the stream contains learnable personal state and that a model can use it to generate relevant possible continuations. It would not establish that showing those continuations helps. [[Phase 1 Details#17. Handoff to Closed-Loop Deployment]] therefore begins a controlled deployment in which rendered samples enter the ordinary history, later actions remain ordinary behavioral targets, and joint-system outcomes determine whether participation by the model is beneficial.
