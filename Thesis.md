
# Outline

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

**For every \$1 spent on tokens reading context, ~\$13 of human time went into producing it.** Businesses pay people to gather information, decide what matters, translate it into prompts, and correct work produced without it. The value of this wasted time is on track to hit **$1T by next year**, doubling every 2 years.

Full, relevant context for these superintelligent systems is lacking today, and people attempt to work around it in varying ways. Manually written prompts and in context memory solutions are a lossy serialization of a user's knowledge, environment, goals, and preferences. More capable models increase the return on this context, so people respond by spending increasing amounts of time curating it. 

Agents are increasingly becoming persistent actors on our behalf. As they accrue assets and, more importantly, initiate liabilities on our behalf, full context is a fundamental necessity. However, it's insufficient by itself. Two people can observe the same information and take different actions because context does not contain the decision rule that converts information into judgment. An agent acting for a person needs a model that can genuinely simulate how one would respond to a given situation.

Our belief is that daily computer use produces the raw material for such a model. People read articles and documents, write notes, prompt LLMs, receive messages, inspect model outputs, browse, etc for hours each day. The set of these interactions constitutes a comprehensive overview of their work, and can be cleaned and processed into a temporally interleaved language-based event stream of inbound read information and outbound write actions, with no workflow changes or manual labeling required. Formal next action prediction is the forcing function for learning this conversion. A system that can predict what someone will write, search, edit, or ask next has learned how their current context interacts with the goals organizing their work, rather than stated preferences or a lossy description of past events.

The development path starts with prediction and can be initially improved via suggestion. Behavior cloning turns the read-write stream into a model of how the person acts, conditioned on inbound information. Then, sampling that model produces possible next actions, shown as suggestions to the user. The person's continued work supplies a preferred continuation that may be influenced by or even chosen from the suggestions, and is recognized as the best option against the alternatives. Pairwise preference optimization against these hard negatives teaches the system more robust goal directed behavior. In all cases, zero separate labeling workflows are required from the human.

Critically, this creates a "human+" augmentative system rather than a human replacement model. Model suggestions improve human performance via preference optimization, and human performance uplifts model performance via behavior cloning, resulting in **positive recursive mutual improvement**. True replacement implies agents accrue assets and take on liabilities separate from their initiating human, which will not be the case. The agent *you* spin up produces assets *you* control and work that *you* are liable for. **The valuable system is therefore one that increases a person's leverage while remaining continuously coupled to the context, goals, and judgment of the person bearing the consequences**. It requires no repeated briefing before it becomes useful. It already understands the moving edge of the work and steps in when its capabilities can accelerate it.

The same construction changes coordination. Organizations do not think with one mind. Their intelligence comes from many people holding different information, pursuing partially different goals, and updating one another through slow, lossy communication. A single company agent collapses those differences, leading to brittle output. A human model for every participant preserves them, while allowing each person's context and judgment to participate in far more interactions than the person could attend themselves. Those models can exchange information, learn to predict one another, and search for outcomes their humans recognize as progress.

Today, a person is present in only as many decisions as they have time to understand and move forward. In an agentic economy, that becomes extinction by bandwidth. A human model is how a person's context, goals, and judgment remain present at silicon speed. Billions of them coordinating would result in the next scale of collective intelligence.

## Appendix

The ~\$600B figure is an estimate of the annual global cost to businesses of actively supplying work context to generative AI. The May 2026 [Generative AI Adoption Tracker](https://www.genaiadoptiontracker.com/) reports that 45.2% of employed U.S. respondents used generative AI for work and that it occupied 6.3% of total U.S. work hours; the nationally representative survey's methodology and earlier waves are described by the [Harvard Project on Workforce](https://pw.hks.harvard.edu/post/the-generative-ai-adoption-tracker) and [NBER](https://www.nber.org/papers/w32966). The central model is ~1B knowledge workers (an order-of-magnitude anchor based on Gartner's dated [1.14B projection](https://www.gartner.com/en/newsroom/press-releases/09-24-2019-gartner-says-worldwide-social-software-and-collaboration-revenue-to-nearly-double-by-2023)) × ~2,000 hours/year × 6.3% AI-use share × ~40% context-supply share × ~50% adjustment for lower global usage ≈ 25B hours; at an assumed usage-weighted ~\$22/hour, that is ~\$550B/year. The 40% share is a modeling judgment—not a measured result—informed by [METR's screen-recorded developer study](https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/), a public-chat dataset with a [15-word median but 86-word mean user message](https://www.semrush.com/news/251916-user-strategies-and-insights-from-real-chatgpt-conversations/), and [OpenAI/NBER message research](https://www.nber.org/papers/w34255), which also estimated 18B ChatGPT messages/week and 27% work usage; extrapolating across providers to ~1T work messages/year at an assumed ~85 seconds of context effort gives ~24B hours, a modeled cross-check rather than independent measurement. On the token side, a modeled ~\$110B annualized industry revenue pool—anchored by the [2026 Stanford AI Index](https://hai.stanford.edu/assets/files/ai_index_report_2026_chapter_4_economy.pdf) and Anthropic's [>\$47B run rate](https://www.anthropic.com/news/series-h)—multiplied by assumed 65% work and 55% input shares yields ~\$40B/year of user spend allocated to input-side use. Together that is ~\$590B, rounded to ~\$600B, and ~\$13.75 of human time per input-side dollar. The observed work-hour share rose from 4.1% in late 2024 to 6.3% in May 2026, implying roughly 2.3 years to double; [Epoch AI](https://epoch.ai/data-insights/anthropic-openai-revenue) suggests the provider-revenue component is doubling roughly annually or faster.

# Misc Notes

- some tension between articulated thesis of next action prediction and the practical data generation surface value props described in [[Product]]. yes, having a better informational source could improve next action prediction. is it worth the buildout? is the local value prop this better interaction surface, or next action prediction, or data collection and cleaning from existing surfaces?
	- https://x.com/willdepue/status/2074178395462848800 "stargate for data"
		- "data generating surfaces (interactions) matter more than human-generated data / hand-curated RL environments"
		- [[Product]] could be described as a renewable data source in the energy/fossil fuel analogy. it 100% requires a better interaction application, perhaps along the lines of what i've described
	- data + compute + algorithms for life autocomplete (predicting thoughts) (team understood it as predicting prompts) (team biggest concern is amount of data necessary to feel value)
		- algorithms have 10-11 figures of annual research spend by the smartest minds on earth
		- compute you can buy
		- (nondeterministic, temporal) data is impossible to buy
		- therefore you need to be producing granular context
		- the best form of granular context in a computer use setting is writing down your thoughts, since that has the most predictive power on next thought/action vs just scraping computer use
		- argument that if you don't do this you'll be left behind as algos get superintelligent
		- (also relates to frontier models differing in reward models from you)
		- that leads to [[Product]]
		- definitionally, a model is superintelligent compared to me if it has the ability to predict my actions well (and i cannot predict its actions?)
	- again, obsidian with link enrichment, auto git with good commit msgs, multi device sync, messaging connectors for easy note taking might be enough. i find myself not deleting stuff because the search is more difficult (ai latency vs app search latency). which is annoying
		- and bitcoin timestamping because i want it.
		- not having link enrichment / search over the link content is super annoying, i cant find a gemini chat i had where i was learning about how obsidian handles markdown into its own block language or something. found it from gemini search, its also a couple bullet points above https://gemini.google.com/app/581ea6b83f49a55a
		- related to the idea that the algorithms and toy examples are to prove that using different tools 'legibilizing thought process of knowledge work' is worth it. and the features necessary to make the legibilization a smooth experience are separate from the algorithms necessary to turn it into something useful
		- the data construction from the 'raw' process work is the keystone/capstone
		- the problem with frequent git is that the local size of the git folder becomes massive, i assume there are solutions to this somewhere, but perhaps not?
	- custom models is the best wedge for inference. custom data collection interfaces is the best wedge for custom models
- did not mention the tension between human preference as the only true reward signal and environmental rewards as the only true reward signal. likely resolution is that in a society, human preference data = environmental rewards.
	- discussion with jakub yielded the distinction between nondeterministic reward functions and deterministic reward functions. simpler demarcation is human vs not.
- The dynamic, fresh context also applies to judgment/feedback/reward inference. Not just context (inputs)
- artificial wisdom
	- Is wisdom more truthful reward functions?
	- “Artificial wisdom” sounds way more implausible than artificial intelligence
		- Feels related to “what to do” not “how to do it”
	- artificial wisdom as a reward model choice where artificial intelligence is slamming an existing reward model without question
- practical notes
	- people think. people share what they think with others. sharing improves others thinking. this happens slowly. is basically one version of a practical thesis.
	- bit of an old hot take. i think enterprise models will look like each employee having their own agent that is tuned to them, and the models are allowed to conversate to collaborate and improve rewards, instead of a monolithic model that everyone shares. personal computing with networking, not timeshared computing. 
	- currently thinking through how a currently unidentified target market, that im proxing to myself and my team, actually uses computers/AI.
		- lots of prompting (60-80%?)
		- search into browser (do i actually even do this anymore? if i do, am i just looking at the AI summary?)
		- coding
		- taking notes
		- messaging others
		- social media output
	- others startups/small teams are probably most interested in this, specifically people in startups who are not coding a lot
	- if they aren't coding, they're doing research, talking to people via messages or calls, or exploring to find relevant people to talk to, or engaging in marketing via writing or social media
	- who has the deepest pain of not having a next action predictor? this might be someone who spends a lot of time or money on similar solutions
	- actually thats not true theres plenty of people who feel the lack of context issue
	- if youre solving lack of context because you do the best job of cleaning the data in a way that AIs can reason well over, which is essentially memory (even the memory people seem to be doing token space vs weight space discussions), then there are definitely teams that use those memory solutions
	- but chatgpt and claude are getting much better at handling memory / compression etc
	- but also I, and im assuming others, use multiple providers and have to juggle context across all of them
	- one articulation could be the time spent giving context to an LLM prompt, whether that be a chatbot or agent, either upfront or after the fact when you realize its giving you an answer that lacks context. this has definitely increased exponentially and is nonzero. the perhaps hot take may be that as intelligence per dollar continues to go exponential, the lack of context increases in pain, not decreases. that feels robust. for who? whoever is hypothetically most retained. i'd probably choose small (<20), technical teams since thats who i am most familiar with
	- important to keep in mind that reduced loss is not the goal, felt value delivery is
	- "Anthropic’s latest survey found that experienced workers particularly emphasize judgment, contextual awareness, situational reasoning, trust, and management as capabilities AI still lacks. [Anthropic Economic Index](https://www.anthropic.com/research/economic-index-june-2026-report)"
- human understanding vs AI understanding
	- how to RLHF html visuals? how to personalize them?
- indeterminism
	- it may be just a context game. the actual value prop is processing and cleaning all the work data (a la screenpipe (not sure why littlebird seems to be targeting consumers, but seems more focused on text only suggestions)). the technical skill to turn that into models and a suggestion application might be down the line rather than the main value prop
	- The value prop of next action prediction alone would be that it speeds up work so you can get more done
	- Probably would want to capture audio with outbound / inbound labels like granola, which is apparently why limitless pivoted as well
	- Very simply, next action prediction during work speeds you up, if it works. It doesn’t work if models are too stupid. It works if models increasingly improve. Slate made a similar bet but it didn’t work because the models didn’t improve fast enough but realistically because there just wasn’t demand for a repeatable valuable use case
	- Next prompt prediction could be a very repeatable value prop that is more specific if have enough data, also called out by cofounders
	- I.e. speeds you up, speeds your team up
	- just getting the event stream correct as temporally interleaved read/write seems like the most useful part of the stack
	- that formulation implies a context collector is the main value prop, which i think it is. applying algorithms to next action prediction + an application for suggestions differs though because its proactive rather than a promptable thing that has context
	- open core where software is open source but the hosted version to not worry about hardware, local llms, retraining, etc is closed source? or just full closed source? soc 2 compliance?
	- probably would open source the data cleaning pipeline. then iterate on algorithms + applications to make it useful, although people could make it useful as they see fit. that seems most value creative.
	- the indeterminate part of the stack that is likely to last longer is the data pipeline. the algorithms and suggestion application less so
- pushing further
	- predicting multiple actions instead of one action seems similar to trying to get to goals faster but it requires a world model. for example if a model is going to predict a prompt i type in, and it 'knows' im going to need a follow up prompt to actually get what i want, it should recommend the fixed prompt before hand. unclear whether it can do this from the BC and IPO formulation, which is why i was gunning so hard for the reward inference, but then the conversation around local explicit goals being written down made it unclear whether it could do that when those exist
	- it would be great to be more clear about how next action prediction could lead to next N action prediction, i.e. instead of suggesting collecting a piece of context to give to a model, then collecting another piece of context, etc, just generate the entire prompt better and faster than i would have written it.
	- still a tension between behavior cloning and superhuman performance. since the original goal was to implicitly detect goal and then suggest something / take some action to get me there faster