
# Notes

-> time giving context and money spent processing context is already large and rapidly increasing. its usefulness, and thus time spent, correlates with intelligence per dollar.
-> augmentation > replacement due to entitlements vs obligations makes full context a non starter (any other convos re replacement vs augmentation are more about desired work / use of leverage, which unfortunately you just have to get over)
-> temporally interleaved language read/write into next action prediction (learn how you think, how you respond to stimulus, how you convert inputs to outputs)
-> phase 1 is floored at you, can surpass if suggestions are taken, zero manual labeling, only additive
-> phase 2 surpasses demonstrator performance if human can recognize better actions from the model, since likely the case that demonstrator is not optimal (best example is a better prompt for a model that encapsulates what you wanted to know better than a prompt you'd have to write)
-> many of these models can result in collective intelligence amongst a team or org
-> effectiveness of next action prediction scales with intelligence
-> there will always be a market for this for people who don't want to get stolen by big labs who need a business model to overcome their data center capex and as a result will only give them portioned context


# Post

**The most expensive part of AI is the human time required to make it useful.**

Context is already a ~$500B cost doubling every 18 months. For every $1 spent on tokens reading context, !$16 of human time went into producing it [[Thesis#^c16dcf]]. Businesses pay people to gather information, decide what matters, communicate it in meetings and messages, translate it into prompts, and correct work produced without it. As intelligence per dollar increases, more context becomes worth processing. The cost of producing and transmitting that context rises alongside the usefulness of the intelligence consuming it.

Today, every interaction with a model begins with a human manually reconstructing the relevant state. A prompt is a lossy serialization of what someone knows, what they have seen, what they are trying to accomplish, and what they would reject. More capable models increase the return on this explanation, so people respond by explaining more. The context window grows, but the human remains the API.

However, once these systems accrue assets, and more importantly, initiate liabilities, on our behalf, full context is a fundamental necessity, yet insufficient by itself. Two people can observe the same information and take different actions because context does not contain the decision rule that converts information into judgment. An agent acting for a person needs a model of that person.

Daily computer use produces the raw material for such a model. People read documents, receive messages, inspect model outputs, browse, search, write prompts, edit notes, and change artifacts. These are not isolated files to retrieve later. They are a temporally interleaved stream of stimulus and response: what entered a person's field of view and what they did next. That stream records how a mind converts inbound information into outbound action.

Next-action prediction is the forcing function for learning this conversion. A system that can predict what someone will write, search, edit, or ask next has learned more than their stated preferences or a summary of their past. It has learned how their current context interacts with the goals organizing their work. The prediction becomes more useful as the underlying model becomes more intelligent, because greater general intelligence can extract more of the person-specific signal contained in the same history.

The algorithmic path is prediction, suggestion, and agency. Behavior cloning turns the read-write stream into a model of how the person acts. Sampling that model produces possible next actions using capabilities broader than the person's demonstrated policy. Those samples are shown as suggestions. The person's continued work supplies a preferred continuation that may be influenced by the suggestions, but recognized as the best option against all alternatives. Pairwise preference optimization against these hard negatives teaches the system more robust goal directed behavior. In all cases, zero manual labeling or workflow changes are required from the human.

This creates a human+ model rather than a replacement human. Replacement is the wrong frame because agents can produce assets while the people behind them remain responsible for their liabilities. The valuable system is therefore one that increases a person's leverage while remaining continuously coupled to the context, goals, and judgment of the person bearing the consequences. It should require no repeated briefing before it becomes useful. It should already understand the moving edge of the work and step in when its capabilities can accelerate it.

The same construction changes coordination. Organizations do not think with one mind. Their intelligence comes from many people holding different information, pursuing partially different goals, and updating one another through slow, lossy communication. A single company agent collapses those differences. A human model for every participant preserves them, while allowing each person's context and judgment to participate in far more interactions than the person could attend themselves. Those models can predict one another, exchange information, negotiate, and search for outcomes their humans recognize as progress.

The medium-term future consists of billions of these models coordinating at machine speed. Each remains grounded in a different human history; together they form a collective intelligence that dwarfs what can be produced through human bandwidth meetings, messages, and prompting.

Today, a person is present in only as many decisions as they have time to read and answer. In an agentic economy, that becomes extinction by bandwidth. A human model is how a person's context, goals, and judgment remain present at machine speed. Billions of them coordinating is not a world without humans. It is the next scale of human collective intelligence.

## Appendix

^c16dcf

The St. Louis Fed's Real-Time Population Survey — the only nationally representative tracker of AI usage intensity — found in its May 2026 wave that 45.2% of employed Americans use generative AI for their jobs (up from 40.7% in November 2025), and that genAI now accounts for 6.3% of total U.S. work hours, up from 4.1% in late 2024. Screen-recording studies of AI-assisted work (METR) and prompt-level data — the median chatbot message is ~15 words but the mean is ~86, because people paste in documents, code, and briefs — imply roughly 40% of that interaction time goes to supplying context rather than consuming output. Scaled across the ~1 billion knowledge workers worldwide at usage-weighted wages (~$22/hr), that's ~25 billion hours and ~$550B of human time annually — independently cross-checked by ~1 trillion work-related AI messages per year at ~85 seconds of human effort each. The token side has exploded: OpenAI hit $25B annualized revenue by February 2026 and disclosed $2B in monthly revenue this spring, while Anthropic confirmed a $30B run-rate in March — up from $9B at year-end 2025 — and reportedly reached ~$47B by mid-May, driven largely by Claude Code. Of the ~$110B industry total, roughly $40B/yr pays for input tokens processing work context — about $1 for every $13 of salaried human time