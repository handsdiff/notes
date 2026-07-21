
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

Context is already a ~$500B cost doubling every 18 months. For every $1 spent on tokens reading context, ~$12 of human time went into producing it [[Thesis#^c16dcf]]. Businesses pay people to gather information, decide what matters, communicate it in meetings and messages, translate it into prompts, and correct work produced without it. As intelligence per dollar increases, more context becomes worth processing. The cost of producing and transmitting that context rises alongside the usefulness of the intelligence consuming it.

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

### What the estimate means

The ~$500B figure is a Fermi estimate, not a reported accounting category, market size, or claim that the inputs below are known with precision. It estimates the annual global cost to businesses of actively supplying work context to generative AI: composing and revising prompts, finding and pasting source material, uploading files, briefing a model, and steering or correcting work when relevant context is missing. It also includes an allocation of model spend to processing that input. It does **not** add the much larger pre-existing cost of creating organizational knowledge or communicating it through meetings, messages, and documents.

### Central estimate

The May 2026 [Generative AI Adoption Tracker](https://www.genaiadoptiontracker.com/) reports that 45.2% of employed U.S. respondents used generative AI for work and that generative AI use occupied 6.3% of total U.S. work hours. The tracker is based on the nationally representative Real-Time Population Survey; its methodology and earlier waves are described by the [Harvard Project on Workforce](https://pw.hks.harvard.edu/post/the-generative-ai-adoption-tracker) and in the underlying [NBER research](https://www.nber.org/papers/w32966).

The central calculation is:

`~1.0B knowledge workers × ~2,000 work hours/year × 6.3% genAI-use share × ~40% context-supply share × ~50% global-intensity adjustment ≈ 25B hours/year`

`~25B hours × ~$22/hour usage-weighted labor cost ≈ $550B/year`

The worker count is anchored to Gartner's older projection of [1.14B knowledge workers by 2023](https://www.gartner.com/en/newsroom/press-releases/09-24-2019-gartner-says-worldwide-social-software-and-collaboration-revenue-to-nearly-double-by-2023), used here only as an order-of-magnitude reference rather than a current census. The ~50% adjustment for lower average usage outside the United States, the ~40% context share, and the ~$22/hour global usage-weighted labor cost are model assumptions. They are the largest sources of uncertainty.

The ~40% context share is not a result reported by any single study. It is a modeling judgment informed by three kinds of evidence: METR's [screen-recorded study of experienced developers using AI tools](https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/); a small, nonrepresentative dataset of public ChatGPT conversations in which the [median user message was 15 words and the mean was 86](https://www.semrush.com/news/251916-user-strategies-and-insights-from-real-chatgpt-conversations/), indicating a long tail of much larger inputs; and OpenAI/NBER message-level research finding that [Writing represented about 40% of work-related ChatGPT messages and that roughly two-thirds of Writing messages modified user-supplied text](https://www.nber.org/papers/w34255). These observations support the existence of substantial context-supply work, but they do not directly measure its share of interaction time.

### Bottom-up cross-check

The same [OpenAI/NBER study](https://www.nber.org/papers/w34255) estimated 18B ChatGPT messages per week by July 2025 and classified 27% of June 2025 messages as work-related. Extending that observed ChatGPT volume to other providers and enterprise systems produces a modeled order of magnitude of ~1T work-related AI messages per year. At an assumed ~85 seconds of context-supply effort per message, that is ~24B human hours—close to the top-down estimate. The ~1T messages and ~85 seconds are extrapolations, not directly observed statistics, so this is a reasonableness check rather than independent measurement.

### Model-spend allocation and ratio

The token-side estimate starts with a modeled ~$110B annualized industry revenue pool. Public anchor points include the [2026 Stanford AI Index](https://hai.stanford.edu/assets/files/ai_index_report_2026_chapter_4_economy.pdf), which compiles directional revenue estimates for leading AI companies and cautions that their reliability varies, and Anthropic's May 2026 statement that its run-rate revenue had [crossed $47B](https://www.anthropic.com/news/series-h). Applying assumed shares of ~65% for work use and ~55% for the input side gives:

`~$110B × ~65% work share × ~55% input-side share ≈ $40B/year`

This is user spend allocated to input-side model use, not the providers' marginal compute cost. Against the ~$550B labor estimate, the central arithmetic is ~$13.75 of human time per $1 of input-side model spend. Given the uncertainty, **“more than $10” is better supported than a precise ratio**; ~$12–$14 is a reasonable central range.

Together, the central estimates imply roughly $590B/year before rounding. The headline ~$500B deliberately rounds down, but the plausible range is wide because the context-share, global-intensity, wage, message-volume, and model-spend allocations are all assumptions.

### Growth-rate caveat

The latest adoption series does not support treating the total cost as steadily doubling every 18 months. The work-hour share rose from 4.1% in late 2024 to 6.3% in May 2026; if that 18-month change compounded at a constant rate, it would imply a doubling time of roughly 2.4 years. The more recent part of the series slowed further. By contrast, the provider-revenue component is growing much faster: [Epoch AI's compilation and forecasts](https://epoch.ai/data-insights/anthropic-openai-revenue) imply roughly annual doubling or faster for leading model providers, although those figures cover company revenue rather than context-input spending alone. The evidence therefore supports rapid growth, and especially rapid growth on the model-spend side, but not a measured 18-month doubling rate for the combined cost.
