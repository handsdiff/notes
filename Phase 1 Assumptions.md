
The final goal is: a system that combines frontier-model capabilities with a person-specific understanding of goals, eventually proposing and safely executing actions the person would not have found alone. Under that interpretation, Phase 1 matters primarily as the behavioral prior for later coactive learning—not as an end in itself.

The ranked assumptions are:

1. **The observable read–write stream contains marginal, goal-relevant information.**  
    Correctly timed browser activity, chats, note state, and prior actions must predict the _semantic content_ of the next action better than the current artifact and generic world knowledge alone. This is the foundation of the data-legibility thesis: if a frontier model performs equally well without the personal stream, neither personal data collection nor most of the later stack creates much advantage.
    
2. **Your behavior is informative about your goals, but not identical to optimal goal pursuit.**  
    This is the crucial “Goldilocks” assumption in [Paper.md (line 13)]. If behavior and goals have little overlap, Phase 1 learns an irrelevant or harmful prior. If they coincide perfectly, prediction may work but there is no headroom for Phase 2 or Phase 3 to improve you. Phase 1 can test informativeness; it cannot establish the existence or size of the improvement headroom.
    
3. **One-step predictive competence transfers into a useful proposal distribution.**  
    Phase 2 needs Phase 1 to generate plausible, diverse, comparable alternatives near your behavioral distribution. A model that lowers loss by learning your punctuation, favorite files, or repeated phrases could look excellent while producing no useful counterfactual ideas. This bridge—from “predicts me” to “generates alternatives I can refine”—is more important to the final goal than raw next-token accuracy.
    
4. **Personal context continues to add value at frontier model capability.**  
    You need to distinguish “this model is generally smarter” from “this model learned something specific about me.” The important result is a within-model gain: the same frontier-capable model performs better with the correct personal history than without it or with plausible but mismatched history. A fine-tuned local model beating an older generic model would be much weaker evidence.
    
5. **The actual pre-action information state can be captured faithfully.**  
    The system must know what text was visible, how much of a page or video had been consumed, which assistant tokens had rendered, what was authored versus pasted, and when an action began. Otherwise it is learning and evaluating against a fictional information state. This is why the capture audit is rightly the first experimental gate in [Toy Experiment.md (line 372)] even though it ranks below the conceptual assumptions above.
    
6. **The chosen macro-action is the right abstraction.**  
    A sentence, bullet, search query, prompt, or coherent edit burst must correspond to a meaningful decision. Tokens are too small; Git commits often combine several intentions. The Phase 1 action space should also be the space in which Phase 2 comparisons are meaningful and from which Phase 3 can eventually construct plans. Otherwise each phase learns a different object.
    
7. **Personalization can add local knowledge without sacrificing frontier capabilities.**  
    A personal adapter might improve next-write likelihood while degrading reasoning, instruction following, tool use, or unfamiliar-task performance. That would produce a better behavioral clone but a worse prospective assistant. The final goal requires personal state to augment the frontier prior, not replace its superhuman traits.
    
8. **Relevant information can be selected or encoded from a long, noisy history.**  
    The necessary signal may exist while raw long-context prompting, retrieval, memory, and SFT all fail to expose it. The oracle-context comparison in your experiment is especially important here: if manually selected context helps but automatic context does not, the data thesis survives, but the deployable system has not yet been solved.
    
9. **Useful personal evidence accumulates faster than it becomes stale.**  
    There must be enough per-user data to learn before projects, vocabulary, collaborators, and goals change. Continual updates must track genuine drift without overfitting temporary sessions or forgetting durable workflows. Otherwise the canonical policy is always either undertrained or obsolete.
    
10. **The evaluation can distinguish real personalization from leakage, style, and repetition.**  
    Chronological splits, temporal embargoes, wrong-time and wrong-person controls, hard negatives with matched style, and session-level uncertainty are necessary to _show_ frontier performance credibly. I rank this last only because it validates the capability rather than causing it; experimentally, it must be implemented near the beginning.
    

A credible definition of “Phase 1 frontier performance” would therefore be:

> On future chronological macro-actions, a frontier-capable model with automatically constructed, temporally valid personal context produces a repeatable, product-relevant improvement over the same model without personal context and with mismatched personal context; the improvement survives content-sensitive evaluation, does not depend on leakage or stylistic mimicry, produces useful top-\(k\) alternatives, and does not degrade general capabilities.

Do not require a small personalized model to beat the strongest generic model in absolute terms. The more important quantity is the **marginal personal-history gain at each capability level**. The final system can always inherit a stronger base model; its defensible advantage is whether the local stream tells that model something consequential that scale alone does not.

The biggest unresolved bridge is assumption 3. The [Toy Experiment.md (line 681)] correctly stops before recommendation, but excellent Phase 1 likelihood would still not demonstrate reward inference, usefulness, or better-than-human action selection. It would establish that the stream contains learnable personal state and that a model can construct a behavioral prior from it. That is necessary—and genuinely valuable—but Phase 2 must separately show that exposing samples from that prior elicits corrections that improve actual outcomes.