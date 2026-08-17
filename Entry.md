
- https://www.anthropic.com/research/multiagent-systems
- https://x.com/max_paperclips/status/2088400890562777312?s=20
	- qwen 3.8 is opus 4.6 intelligence in 27B dense local weights? How does this support or refute directional beliefs that supported the build and thesis and vision direction?
	- do chinchilla scaling laws no longer apply? what are empirical scaling laws actually occurring?
- coreauto interview discussing continual learning that seems intelligent https://x.com/CoreAutoAI/status/2082937120508067938?s=20
- "RL without verifiable rewards" from will brown https://www.youtube.com/watch?v=AQv3qRCG6Gw&t=2s probably worth skimming only 20 mins
- training vid from openai guy https://www.youtube.com/watch?v=r1qZpYAmqmg
	- says that non reasoning, human interactivity post training/RLHF has on the order of 100k data examples, 100k training cost on the order of days, and the bottleneck is data and evals
	- if i do token level cross entropy loss for phase 1, will that delete learned pretraining language abilities? does that same issue apply to RLHF? why or why not?
- My estimation is that multi agent stuff is useless without differing judgment which is why you need to drastically reduce the friction of distilling judgment into weights I.e my vision, but maybe that stems from a poor understanding of MARL leading to wasted development time
- https://huggingface.co/Motif-Technologies/Motif-3 pretraining dataset? base model?
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
- if a dominant method of training models is training multiple models on independent tasks then distilling into a single model, can you have one of the initially trained models be a 'meta learner' that is optimized for quick learning on downstream tasks, and have the final model retain that capability while retaining other capabilities as well? why or why not? is meta learning at odds with 'expertise'?
- what is the human intelligence per watt? what is the human learning signal per flop?
- doing what im building for coding sounds awful and uselessly slow compared to dominant training methods. why? what properties cause this? i think it comes down to 'verifiability', but i think another word for this, or perhaps a broader definition, is needed



- gaining a better intuition for enterprise GTM, its literally like spending money on Ramp. it shows up as credit card charges. getting someone to pay for something usually starts with the individuals at the company paying for something with the company card, like we do. dont have experience with big contracts or know what that means, but it seems like basically people have IT departments that administer products for a team or company
- for all the AI spend that companies are doing now, what were those dollars doing before? salaries? no because hiring doesn't seem to have decreased. increased revenue i.e. the dollars didn't exist before? not necessarily for a lot of teams. where else?
- very simple: should save you a ton of time. i've never paid for an 'enterprise' product that did not feel extremely established like ramp/carta.
- its clear how research is different from starting up. its sometimes wrong to ingest a bunch of inbound with no purpose rather than working for a purpose and then doing research to knock out blockers. 
- what are the requirements necessary to feel like i cant live without the autocomplete? it needs to be correct and fast. it needs to predict what im going to write to a high degree. im unsure if i could get more specific than that. cost. latency. performance. it comes down to whether you can build it or not.
- the technical public aspect of it is showing 'local scaling laws', open sourcing data collection pipeline. could also offer hosted training for enterprises, etc. lot more ideas here i haven't made explicit yet. blocked by getting a result. probably need to clarify the goal. i do want to show we exist and are technical and can do frontier work. i also want to establish positioning / brand that reflects the beliefs that led to the work while offering something that can be downloaded and used. 
	- common references to my beliefs from a few months ago feels crucial to avoid allowing lower magnitude information to negatively impact high magnitude beliefs that seem smaller due to forgetting
	- i think building the app in a way that is easily usable by agents to configure, since realistically everyone will use their agent to interact with it anyways, feels correct
- just staying on track, with the conviction for why, with changing information, for myself is step one. applying this to the team is step two. applying this to the market (public positioning, brand, etc) is step 3. trying to do step 3 makes step 1's foundational cracks (not lack of truth, but lack of consistent belief in why) clear ^
- i think re-writing down why i believe what i believe, from the arc of exploration since march, fresh again would be very helpful, will likely have to do this to some extent during LBH after next
- getting dylan to do alex cdev feels very net positive
- how does introducing a temporal component to the collected data change the qualitative response of normal agents like Codex, vs just telling it that there is a git history? what about comparing it to just the current content? this feels interesting and important to quantify/benchmark, since it may be enough to have this rather than training to predict output.
	- do i care about information to action mapping or do i care about a temporal understanding of past work? the thing about judgment + proactive suggestions is that its qualitatively different UX, so doesn't really feel like you can 'lineage' or MVP your way up to it
	- you dont need a proactive assistant if the goal is reasoning over log history though
- open source data pipeline, offer hosted base models and training to get judgment distilled models on top, promise of accelerating all your computer work. Boundaries around what it’s different from (computer use agents, frontier LLMs). The vector of diff from models top sample to human ending in aggregate points to superhuman performance (last claim is load bearing). Not a concern of replacement since human defines the direction while AI emphasizes it
- pivoting away from crypto/resource allocation hard and that’s causing the cracks
- the integral of technicality + time needs to exceed that of your customers, by definition
- yc ai startups as target, long lake like PE rollups as target, probably more come up if I just brainstorm alongside thesis/how we got here/what I care about writing
- Phase 1 seems like mid training whereas phase 3 seems like post training. Per byrnes phase 2 dpo is usually called rl but more like imitative learning with high bits per sample 

 


as im typing, i think ive lost the plot a bit on what i want predicted. if im typing something, click to the middle to edit it, then go back to the end to continue, the entire thing at the end is a single write event. i dont want multiple write events. i think i was lazy and need to pay more care to actual event demarcation. likely what happened is that i ran into the "type in the middle issue" in some other context and overgeneralized the case



is choosing something technically difficult an attempt to differentiate on skill because of an inability to differentiate on what actually matters, which is customer understanding? differentiating on skill allows you to be vague about the problem, solution, and target market







