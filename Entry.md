
- https://www.anthropic.com/research/multiagent-systems
- https://x.com/max_paperclips/status/2088400890562777312?s=20
	- qwen 3.8 is opus 4.6 intelligence in 27B dense local weights? How does this support or refute directional beliefs that supported the build and thesis and vision direction?
	- do chinchilla scaling laws no longer apply? what are empirical scaling laws actually occurring?
- coreauto interview discussing continual learning that seems intelligent https://x.com/CoreAutoAI/status/2082937120508067938?s=20
- "RL without verifiable rewards" from will brown https://www.youtube.com/watch?v=AQv3qRCG6Gw&t=2s probably worth skimming only 20 mins
- https://x.com/grx_xce/status/2084361692792934488?s=20 how does this make money?
- My estimation is that multi agent stuff is useless without differing judgment which is why you need to drastically reduce the friction of distilling judgment into weights I.e my vision, but maybe that stems from a poor understanding of MARL leading to wasted development time
- https://huggingface.co/Motif-Technologies/Motif-3 pretraining dataset? base model?

- gaining a better intuition for enterprise GTM, its literally like spending money on Ramp. it shows up as credit card charges. getting someone to pay for something usually starts with the individuals at the company paying for something with the company card, like we do. dont have experience with big contracts or know what that means, but it seems like basically people have IT departments that administer products for a team or company
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
- open source data pipeline, offer hosted base models and training to get judgment distilled models on top, promise of accelerating all your computer work. Boundaries around what it’s different from (computer use agents, frontier LLMs). The vector of diff from models top sample to human ending in aggregate points to superhuman performance (last claim is load bearing). Not a concern of replacement since human defines the direction while AI emphasizes it
- pivoting away from crypto/resource allocation hard and that’s causing the cracks
- the integral of technicality + time needs to exceed that of your customers, by definition
- yc ai startups as target, long lake like PE rollups as target, probably more come up if I just brainstorm alongside thesis/how we got here/what I care about writing
- Phase 1 seems like mid training whereas phase 3 seems like post training. Per byrnes phase 2 dpo is usually called rl but more like imitative learning with high bits per sample 

- https://x.com/river_ai_inc/status/2086903810216386802?s=20
- focusing on next content prediction because it’s a forcing function for data collection quality, judgment distillation, goal inference, and memory algorithms, and it enables intelligent autocomplete, proactive goal oriented assistance, robust user simulation, and multi agent systems
- seems extremely relevant to discussions around context windows / retrieval vs judgment etc 
	- https://arxiv.org/pdf/2605.23668v2 "a key step towards proactive interaction is next query prediction" should study the data construction and method used for actually implementing the 'dynamic memory' but from an initial skim it just seems like a scratchpad that the LLM can use...
	- going from roughly 40 to roughly 44 score is pretty weak no? went through the training method but havent combed through the datasets or construction yet
- https://tullie.ai/blog/titans-neural-memory
- https://x.com/eliebakouch/status/2087179305474298162?s=20
- 

https://www.youtube.com/watch?v=r1qZpYAmqmg
- course from guy who does training at openai says that non reasoning, human interactivity post training/RLHF has on the order of 100k data examples, 100k training cost on the order of days, and the bottleneck is data and evals
- if i do token level cross entropy loss for phase 1, will that delete learned pretraining language abilities? does that same issue apply to RLHF? why or why not?

why not just tell the computer use agent your goals? why require it to 'infer' your goals from your context?
- one difference is tightly coupled vs long running
- another might be proactive vs reactive

can't properly distribute without a kernel to rally around. people use the term 'reason to exist', 'mission', 'vision', etc but more internalized its just something to point to when thinking about or referencing the entity. otherwise the entity doesn't exist. it comes from a 'feeling' perspective.

does the terminal state of such a product require combining individual models to improve the initial state of new models? by taking the data from individual models to train the 'base model'? is that not just what big labs are doing?

what highly value creative workflows become much cheaper or faster with judgment infused weights?

one way to frame the conclusion of thesis is that the only way to specify rewards properly is via imitative -> comparative learning. but the less naive step after may just be rubrics.

if a dominant method of training models is training multiple models on independent tasks then distilling into a single model, can you have one of the initially trained models be a 'meta learner' that is optimized for quick learning on downstream tasks, and have the final model retain that capability while retaining other capabilities as well? why or why not? is meta learning at odds with 'expertise'?

is next action prediction a forcing function for solving memory rather than solving goal and reward inference? it basically learns what to pay attention to given the full history of logs
- from shopify ceo, state = memo(f(log))

does the implementation of prime intellect's harness provide a blueprint for the meta optimization required for self improvement towards next action prediction? is this 'training'? the weights arent being updated but the retrieval algorithm would be, ideally forced through iterations given the reward signal (whether thats some token level next action prediction or cosine sim score)

thesis has a ton of good work but it feels a bit weird since its unclear how the described solution solves the time giving context. the way it would is that the next action predictor learns how to manipulate the log history, therefore never needing explicit context? memory solutions solve a similar problem. which implies that the forcing function is learned log attention rather than goal inference. i guess thats a more specific description of learning response to stimulus, so it would make sense in that vein

you dont need a proactive assistant if the goal is reasoning over log history though

one way to describe the true problem being solved is extracting reward signal from human behavior

prime intellect-like python REPL PTC might overfit to the data set. but if you just have a literal shitton of 'hardcoded rules', with some forcing function for less code + readable code, maybe thats fine? kind of reminds me of a AIXI optimal agent keeping all potential environments in its head and acting on whatever prior is most likely

the counterargument would be that hardcoded lost to weights long term, but can weights learn how to optimally retrieve/reason, if the context window is limited? to what extent is 'working memory' and 'memory retrieval' two separate systems in the brain? there is definitely some 'tool' being used in the brain implicitly when i read something (to connect to something else, because it 'reminds' me of something prior) which i also can somewhat 'call' explicitly if im trying really hard to remember something and then i remember it

the other way it connects, referencing above, is that it if most of my typing now and increasingly in the future is to give information to another agent to complete some task, then this learned next action predictor learns how to do that. does this increase leverage in the same way that people viewed number of employees as a status symbol for leverage? the thing about humans is that they require convincing and can opt out, whereas agents are tools without sovereignty (everything is a tool so not to be taken personally, basically give an input, have some expectation of an output, get an output, not really clear nor care how it works, has speed and cost and reliability properties)

proactive is a nice narrative until you realize the cost is 10x higher than reactive

its not 10x higher if its judgment and context retrieval is akin to the user though. not akin though, more like knows what i actually want rather than what im trying to express. which is basically where phase 2 comes in, which phase 1 bootstraps. and in theory phase 2 bootstraps phase 3 in the same way that pretraining bootstraps RLVR

what is the human intelligence per watt? what is the human learning signal per flop?

maybe retrieval is optimized to compare to pure weight optimization? obviously can combine the two as well. just need to start somewhere. can one be developed independent of the other? 

one way to think about the data collection is that it defines how to separate signal from noise in the data? since im attempting to focus on things i actually read/write rather than full history? or do i want to give full history, would that improve ability to predict next action? should i start calling it next content to properly differentiate? and also when i copy paste data into obsidian, is that a way of filtering signal from noise for the model? (in the vein of signal to noise handling per sutton's description of his work)

being good at the specific thing of converting stimulus to response, rather than attempting to maintain question answering or frontier level intelligence, since that ability can be gotten from just calling/prompting those models, invalidates the prior beliefs around superhuman intelligence doing everything for you, just aligned, and i havent fully thought through this yet

what pushes read/write delay up is the time required to fully form a thought that isnt half baked, and having the ai predict halfway chunks will elicit less 'stimulus response simulation'. what pushes it down is the intuition that super long chunks will be harder for the ai to predict and may combine multiple thought into one, as well as making it higher friction for the human to evaluate and use at test time. unresolved.

kind of hard to do work while also monitoring whether the capture is high fidelity or not because i specifically need to monitor both reads and writes and specifically whether the read is able to well match what i actually ingest

i wonder how it works with youtube videos, it seems like its able to extract text from the video which i was not expecting, but it does not seem to capture subtitles

counting surrounding notes as a read whenever i click into obsidian to type something feels like a lot of noise but maybe the attention mechanism of training will learn to handle it

why do i think that mapping input -> output like myself is necessary? why not just 'company brain' things? do they solve different issues?

are the weights learning 'information attention' when applied to the forcing function of next content prediction? are the issues with event demarcation in next content prediction bad enough that you MUST go to next token prediction at the most granular level? i.e. a keystroke? there's no way that is what is necessary

why is basic memory, i.e. applying algorithms to fetch data, not good enough? you can have a forcing function to learn how to fetch prior history intelligently that may not be next action/token/content prediction? or can you not?

good point made earlier that cursor's early tab completion was not just completing your existing cursor section, it would jump to the next likely cursor location in the codebase!

want to take a better look at stash/honcho to juxtapose it vs my intentions to make the difference clearer. clearly they are trying to use 'sleep time compute' to distill judgment into context. honcho uses human crafted SFT. whats the difference in training data? how does this lead to different solved problems or at the very least different outcomes?
want to revise the article after writing down the very clear and robust differences in data collection, currently at the point of understanding where raw recording COULD reconstruct both recall and judgment, but the existing tools actually focus on recall, thus negatively impacting judgment? but why exactly? causal ordering and event demarcation? and also authorship (reads vs writes)?
want to do all this with the tracking on, but theres tracking issues i want to solve before then. but i want to make these tracking issues known to support the article writing and core differences
can likely use the ai's transcript to extract all the nitpicks i ran into
sam's tweet about the issues people run into when building their own company brains is good because it shows that enterprises are spending time on the problem they are solving. what enterprises are spending time on collecting high fidelity causal data? RL? what about in non verifiable domains?

why exactly do i want judgment vs recall? what does 'intelligence' even mean? that it can perform better judgment on the context than i can? i feel like thats not it. its more that it can do the same thing faster, or some things better, but i likely need to get more concrete about this

proactive assistance ^ because i cant trust the agent to go do something since i have to review its work, kind of like how if you hire someone and you have to monitor them, you havent actually removed any bottlenecks. the counterargument is that frontier models are smarter than you, but if they were smarter than me i would trust them more to proactively do work on my behalf? feels like a bit of a confused argument... because they're increasingly doing work on my behalf, does it need to be proactive? not sure why it initially sounded good but 'proactive' doesn't describe delegation.

the impetus for information -> action was definitely the multi agent systems failing diversity. the line of thinking was that diversity in judgment was needed, not just diversity in context. the issue was that giving solid context to the agent continuously was an issue, which is why the workflow capturing came up. but why not just use screenpipe/coast? thats because ive worked with memory solutions and they're pretty bad at paying attention i.e. separating signal from noise. they dont know WHAT to focus on, leading them to confusion. then the thought was how could you get them to learn what to pay attention to, which led to next write prediction?

doing what im building for coding sounds awful and uselessly slow compared to dominant training methods. why? what properties cause this? i think it comes down to 'verifiability', but i think another word for this, or perhaps a broader definition, is needed



coordinated intelligences decide to communicate when the surprise associated with a failed prediction exceeds a threshold over some period of time, rather than sharing everything that happens. this is due to the finite nature of content windows and energy. ai's may handle this differently. if you aren't at least implicitly tracking your expectation of cooperative action, then you aren't cooperating

couple vision thoughts
- increasingly spend more time thinking out of anything else, since 'labor' is being automated
- increasingly spend more time prompting out of any other type of output, which, since its english, feels learnable as an output

i wonder what latency will be. could probably benchmark by trying to only sample when the data has had historical delays in cursor positioning? probably not though.

as im typing, i think ive lost the plot a bit on what i want predicted. if im typing something, click to the middle to edit it, then go back to the end to continue, the entire thing at the end is a single write event. i dont want multiple write events. i think i was lazy and need to pay more care to actual event demarcation. likely what happened is that i ran into the "type in the middle issue" in some other context and overgeneralized the case

how would an IT department / local AI native engineer easily set this up and monitor it for their team? apparently thats the diff between 100k contracts and 10M contracts

is choosing something technically difficult an attempt to differentiate on skill because of an inability to differentiate on what actually matters, which is customer understanding? differentiating on skill allows you to be vague about the problem, solution, and target market

if everyone is self sufficient and no one transacts, GDP is zero despite everyone having what they need. increased GDP seems to correlate to increased interdependence, which may indicate increased fragility.

for all the AI spend that companies are doing now, what were those dollars doing before? salaries? no because hiring hasn't seem to gone down. increased revenue i.e. they didnt exist before? not necessarily for a lot of teams. where else?

can sample model for prediction when the historical probability of a write (purely quantitative, not learned) that is long is high?
