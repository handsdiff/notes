
- could littlebird benefit from longNAP?
	- they have an agent whose value prop is context. longNAP teaches retrieval reasoning over computer use context.
	- how is littlebird different from normal memory
- custom models is the best wedge for inference. custom data collection interfaces is the best wedge for custom models
- i think agents popping off starting in Q4 2025 increased the data bottleneck (see memory space, mercor ARR). when the data bottleneck is addressed, the bottleneck will shift to reverse data i.e. human understanding. whats better to go after?
- why will littlebird not get eaten by the codex app? why would our intended product not get eaten by the codex app?
	- can the distinction in usefulness between having access to all necessary context and actually predicting next actions be quantified?
- for capturing 'read', we likely want to only include the middle of the screen. unclear when to include and when to exclude. if the user scrolls quickly, we would not want to include that data, for example, since they likely did not actually read the part they scrolled by.
	- in this sense, prediction and augmentation are at odds, because prediction is presumably maximized by maintaining extremely high fidelity to the human data streams, while augmentation, in the vision, involved using the unique capabilities of LLMs (to parse more text) to help progress towards goals faster
	- the implicit assumption is that the data not read by the human is not useful data, even for the AI
	- which rests on the assumption that the human is a better filter for data signal for its context window than an LLM is for its context window. but it does also assume that the human is a better filter for data signal for the LLM's context window, which is a fine assumption imo

- random work
	- find and sign up for events
		- apply for paradigm's frontiers hackathon https://www.paradigm.xyz/frontiers-2026
		- handle mtndao acceptance
		- https://colmweb.org/ conference on language modeling
	- increase branding via twitter banner + personal site + company site
		- i am feeling really really bad about our historic, and current, lack of 'existence' and misunderstanding of social proof dynamics
		- potentially useful for personal blog/website for more legitimacy personally and for company https://x.com/shadcn/status/2075600582518124657?s=20
		- feeling a desire to have a separate website for my blogs. self hosted shows commitment. substack gets swallowed into the platform.
		- https://generalagents.com/ good relative benchmark for quality, interesting description of 'behavior' as a training paradigm that resonates
	- make target market and their growing problem as evidenced by time or money more concrete
	- go through old information to discover anything relevant
	- post blog
	- double email Omar
	- put precursor banner on personal
- directly relevant - practical
	- https://arxiv.org/pdf/2510.19488v1 labels unlabeled video data with their actions, for future training. seems like deepmind's genie also does this
	- phase 2 requires only showing samples when confidence exceeds some threshold, likely requires fine tuning
	- https://arxiv.org/abs/2606.03979 memory consolidation during sleep cycles
	- https://edge-bench.org/ continual learning benchmark
	- meme on whats necessary for selling data https://x.com/distributionat/status/2075253365983068181?s=20
	- how many tokens are common examples of fine tuned models that actually work trained on? how many tokens are frontier models trained on? on what stage? how does LoRA actually impact the amount of needed/useful tokens? how does that change as the underlying model changes?
		- https://thinkingmachines.ai/blog/ probably should review the old ones too
	- is it bs to predict next thoughts/actions? why or why not? there is likely some description that is not bullshit for a given workflow, but would need to write it down. the workflow would likely be research/learning. more concretely? is it next token prediction on what/where i type? is it a bit less granular, a semantic action of writing down a note or looking something up or talking to an AI, given a specific platform?
	- https://www.nature.com/articles/s41586-024-07711-7 loss of plasticity in deep continual learning
	- you likely need what im viewing on the screen to well learn what thoughts ill write down or what ill lookup or what ill ask the claude/codex/gemini website/app (i.e. what ill do next)
	- https://epoch.ai/publications/earthborne-rangers-benchmark continual learning benchmark
	- who are the biggest screenpipe users? is anyone running prospective learning or reward inference algorithms on their data?
		- https://github.com/screenpipe/screenpipe
		- littlebird, dayflow, superhuman go, timescroll
	- what happened to rewind? where are the users? what are they doing now?
	- (read, app, content) and (write, app, content). obsidian covers some write. the browser history script that fetches some read and write, but some issues flagged by Fable.
	- https://www.zyphra.com/our-work/plasticity-loss-in-continual-learning
	- https://www.youtube.com/watch?v=r1qZpYAmqmg LLM training by post training lead at openai
	- https://www.primeintellect.ai/blog/algorithms-layer
	- old thought dump
		- next token prediction on what i write down into the obsidian vault, with the data being the latest typing actions from the obsidian vault.
		- i suspect it will be so terrible as to not even try because it does not know what im reading
		- this seems to be approximating what is in my head
		- what is in my head can likely be approximated by what i've just written and what i've just read
		- i'd like a model that can well predict what I am going to write down, and where I'll write it, based on what i've just written down/am writing and what i've just read/am reading
		- this leads to perhaps giving context as whatever text is on the screen, and the output is the next word?
		- this resembles pretraining? can you do online gradient descent that updates weights after each word, since that acts as signal (prediction vs outcome).
		- the issue becomes that my actions don't only involve 'normal' writing output. they also involve deleting, moving the cursor to edit something, copy pasting content. and this would likely confuse a model
		- additionally, per the vision, i would not want the 'recommendations' to be next words, i'd want them to be next 'thoughts'. however thoughts are a subset of actions. since thought is just the action of writing down a sentence until a pause. copy paste is another action. delete and edit are other actions
		- it does feel like being able to learn how i map what im seeing to what i do is a prerequisite to inferring my reward, which is a prerequisite to superhuman recommendation/suggestion or even action in some parallel OS where things could be simulated
		- my comfortability with focusing simply on this mapping depends on the truthfulness around this understanding being a prerequisite to reward inference. that should be resolved first.
		- it seems like the initial mapping is a contextual bandit problem? how do those problems differ from next token prediction?
		- what i want is the model to be able to suggest what/where to type next to maximize my terminal cumulative rewards
			- needs to infer my goal (infer rewards)
				- but does it? initial reward for it is behavior cloning, to learn state dynamics? am I part of the environment its learning to model?
			- needs to understand state dynamics
			- makes sense if it gets rewards when its suggestion is accepted (akin to contextual bandit recommender systems used in social media/ecommerce)
	- https://huggingface.co/learn/llm-course/en/chapter12/3
	- predictive computer use from tsinghua https://github.com/tsinghua-fib-lab/FingerTip-20K
	- the visualization of robot trying to push the L into position properly where it just tries a bunch of actions, then takes the top 20% based on the rewards, then samples from that, etc, until it can do the task, feels useful, but needs DPO rather than codified rewards? 
		- is this hopeless? is it way too slow to collect data to optimize properly? or does LoRA for this actually not need many samples?
	- https://huggingface.co/docs/trl/grpo_trainer
	- https://x.com/albustime/status/2073986970653515817?s=20 description of what common LLM terms mean
	- alternative framework to consider
		- i.e. the better framework is that the model is learning its environment, which primarily involves interacting with me, and it needs to understand me. its recommendations are actions in a state transition system. states are given reward when its recommendations are accepted. to be able to learn a good policy here, it will need to be able to predict my actions first as practical bootstrapping? kind of like alphago training on expert data before doing MCTS self play? is MCTS impossible here? its tough for the environment as a whole, but it can do MCTS on interactions with ME once it has modeled me as a 'player' in its environment whose actions mostly determine the state transitions? that seems interesting, albeit a bit unclear
		- in that case, its recommendations would be actions that it is aware impact my state transitions, and its goal would be to take actions that I accept for it to get reward? but since the rewards are manual it would be extremely slow to learn. could it actually learn at all in an online way? it might be able to learn phase 1 easily enough since theres no reward labeling, but unsure about phase 2 learning goals.
	- data half life experiment. does data actually expire?
	- codify how much progress frontier models are making on in context learning for my self prediction, compare that to increasing random dropout for training on gpt oss 120B?
	- quantifying memorization in LLMs, seems very relevant as it relates to the need for synthetic Q/A data
		- https://arxiv.org/pdf/2505.24832
		- https://x.com/jxmnop/status/1929903028372459909
	- new algorithms in [[Algorithms]], plus just how the relevant algorithms like longNAP structure data
	- very informative and critical reward inference discussion with papers foundational from dragan that i havent come across otherwise https://gemini.google.com/app/4f984ce16e37337a
	- "so we have phase 1 which is supervised fine tuning / behavior cloning with cross entropy loss. autoregressive model with a causal mask. given a history of read/writes, what is the next write? can replace read/write with action, the dataset still needs to be codified as likely the next step, but thats the high level plan, and it is worth experimenting with frontier LLMs, old LLMs, and cheap OS models to see how they perform/react to different amounts of data
	- we have phase 2 which uses top K sampling from the model from phase 1 to turn into recommendations that can be chosen. each recommendation, choice, or lack thereof runs through online DPO to optimize further. phase 1 acts as a prior that bootstraps phase 2. top K sampling acts as hard negative mining, producing a model that learns well."
	- exactly how much human data was initially used to train the RLHF part of chatgpt?
	- does my intended SFT approach (autoregressive train on next action prediction i.e. causal mask) violate i.i.d. data assumptions? does shopify's generative recommender have the same issue? what do those assumptions actually mean in practice? do all online or continual learning setups violate this? how does this relate to the practice of storing rollouts in a buffer that you then sample from? does that essentially fix i.i.d. for continual learning scenarios?
		- https://gemini.google.com/app/9de51346992f5bae wild stuff
	- might help with data ingestion, seemingly open source/self hosted granola https://github.com/Zackriya-Solutions/meetily
	- big question for data codification is whether you give a tool call to fetch the content of a web page rather than the content itself during training. how does that change the state and action space? does it more clearly separate the action space of the agent from the state space of the environment? are there two environments?
	- "There is a strict hierarchy of ML research. Optimizers Objectives Architectures Data Even among data works, there is a hierarchy: Synthetic data Data mixtures Filtering Preprocessing Adding new data sources (Of course, real world impact does not align with the hierarchy)."
	- good for contextualizing the phases of work needed. separating data steps between adding new sources, preprocessing, and filtering feels correct. data mixtures make much more sense after better understanding i.i.d. assumptions and their implications.
	- an understanding of i.i.d. feels crucial. the traditional assumption is static distributions with independent samples. autoregressive architectures like transformers shift the i.i.d. assumptions from the token level to the data source level, which feels weird, but seems to empirically work, although they need to do really intelligent data mixing to ensure gradient descent is performed over average baselines rather than overoptimizing for a single thing. im only starting to internalize this but i suspect it explains a lot of downstream behavior (catastrophic forgetting, for example)
	- continual learning fundamentally seems like an i.i.d. data issue i.e. breaking the i.i.d assumption
	- relevant for data construction [[Interaction#^f5c205]] ^b73256
	- how does 'no recommendation' fit into the framework?
	- training for 'agentic' use implies training on top of pretraining that is different from instruction following to elicit question -> answer behavior. its also not quite RLVR since most agentic tasks dont have a verifiable answer outside of the individual's preference, and it's now relatively easily to optimize for compiled code
		- where is 'agentic' data coming from? is they are coming from existing traces, where are the preferred answers/trajectories coming from?
		- how does this relate to token level preferences vs action level preferences?
	- i wonder whether you need the data to be literally temporally interleaved to predict well. like i pause a youtube video, write down thoughts, play the youtube video. etc. its incorrect to put the entire transcript in when the page is first visited, since the goal is to most closely simulate how my brain works. the actual construction of the dataset is literally 90% of the work here. will take trial and error. may be worth thinking how to improve it
		- if im watching a youtube video for example, i suspect the best data structure would be the transcript of the part i watched as <read, browser, youtube, transcript chunk> then <write, obsidian, entry, written note>.
	- how do harnesses actually handle context and content fetching? if it fetches a website that has 10M tokens, what does it do? or if it runs a terminal command that has 2M tokens worth of lines, what does it do? there must be context management logic? is it basic sliding window? compression? (longNAP implementation likely sheds some light on this)
	- do pretrained model weights exist and open sourced? like before RLHF or RLVR?
	- there is an openai 2023 paper in lecture 18 of cs224r that shows model confidence is much less calibrated after PPO post training than after pre training. how is this data even collected? the pre train model should not be able to do question answer formats, no?
		- the inability to self model uncertainty is brought up as an issue with human AI interaction/collaboration
		- its unclear how 'uncertainty' even natively exists in the model? maybe the probability of the 'winning' token directly? im sure someone has researched this. relates to the dragan waymo interview
	- going back to the youtube interleaved data example, even when im reading a paper we would want the content i actually read to be shown before i type a note, not the entire paper. this seems very difficult to collect properly and perhaps prohibitive for good learning.
	- one way to frame the data construction question is what level of 'noise' is acceptable? for instance i probably want to exclude clicking around obsidian to copy paste something, but probably want to include when i write down a long train of thought, but would that mess up the dataset construction since its no longer cleanly autoregressive?
	- the use of git as a natural boundary likely helps but thats not really 'next token' or 'next action' prediction if multiple 'actions' were taken in a commit, one or more of which involves adding a word to the middle of some old note.
	- what even is a context window? like whats the intuitive understanding of it? this feels important to grok. i wont be able to intuitively understand ICL vs SFT without this.
		- seems like the manual decision as to what amount of data is given as input during the pretraining? or is it mid/post training? likely both?
		- what determines the input/output sizes of the dataset during pretraining?
	- is OPD/OPSD the goated algorithm since you literally just tell the agent what to fix? and then during batched training it increases the probability of the desired tokens from the prompt before when the fix was stated? i wonder if anyone has done this / people are doing it
	- data discussion https://gemini.google.com/app/434faa2eae499b25 for our work
	- this has a nice framework for data structure, even though i disagree / am confused about some of his main desires https://gwern.net/guardian-angel#ux
	- i suspect for phase 1 the goal will be to learn token level structure before it can learn action level content. you might get a loss discontinuity (via early flatlining before more data shows improved loss due to content learning beginning)
	- does a natural language specified preference / goal improve phase 2? seems trivial but apparently giving 'hints' i.e. natural language direction makes OPSD work. strict OPD i have a better understanding of after the thinking machines article and that is def different
		- most IRL assumes that the agent trajectories are maximizing the true reward instead of some lossy approximation of the reward. if the demonstrator itself is attempting to learn the policy by which to achieve its reward, what are the actual algorithms for this, if at all?
		- this relates to the desire for 'superhuman' performance, which may/may not conflict, i'd have to be explicit about it, with the multi agent goals
		- how does this relate to the take that maybe the goal will appear in context because as an organizing method, local goals are written down
	- data cleaning likely needs to ensure formatting is skipped, duplicates are handled, and for phase 2 if the agent doesn't have any reasonably confident completions, it shows nothing
	- is it possible for reasoning to fit into the next write prediction? is this desired? worth testing in [[Phase 1 Details]]? something to be explicitly trained?
	- should read data be text or html? pros/cons?
- discusses research similar to longNAP https://claude.ai/chat/d3de1f6d-cd67-404b-a93a-936b3a662d7e
	- the most interesting related paper which I put into algorithms uses something called LifeTrace for collecting data, takes snapshots at 1 Hz (can we track keyboard usage and snapshot during a pause, like it occurs in git in this obsidian?)
	- another one frames 'when to assist' as when its high likelihood that the "user would turn to an AI assistant right now" which is interesting
- text > screenshots, tons of practical issues from related players around 
- practically need text PII scrub






- # directly relevant - vision
	- there is a tension between human preference as the only possible reward signal and the sutton argument that environmental rewards are the only ground truth data for real superintelligence
	- https://x.com/willdepue/status/2074178395462848800 "stargate for data"
		- "data generating surfaces (interactions) matter more than human-generated data / hand-curated RL environments"
		- [[Product]] could be described as a renewable data source in the energy/fossil fuel analogy. it 100% requires a better interaction application, perhaps along the lines of what i've described
	- set of takes
		- perhaps what comes next after 90% cost reductions for rote tasking like info extraction is model ability to model employees like meta is doing?
		- One thing that stands out is that it’s very practical to lower costs for enterprises
		- It’s a bit less practical but still valuable to make something they spend time on easier rather than make something they spend money on cheaper
		- When do humans want to be replaced and when do they not? For example I want to derive meaning from delivering value to others but I don’t want to spend all day extracting information from pdfs. 
		- I’m willing to let a model do my coding for me but it cannot decide what coding I would consider worth doing. Would I want it to? Probably yes, if it helped me achieve my goals faster. But how practical is that?
	- The dynamic, fresh context also applies to judgment/feedback. Not just context (inputs)
	- Is wisdom more truthful reward functions?
	- “Artificial wisdom” sounds way more implausible than artificial intelligence
		- Feels related to “what to do” not “how to do it”
	- artificial wisdom as a reward model choice where artificial intelligence is slamming an existing reward model without question
	- is this just 'horizontal' org memory scaling but more (perhaps unnecessarily) complex?
	- is collecting agent traces sufficient if 80% of write actions are chatbot interactions? could this be an ablation in [[Paper]]?
	- https://centaur.run/ how does vision compare and contrast? what evidence, or if no evidence, beliefs support current direction over this? how to collect evidence asap for critical assumptions?
		- "for tempo team to start adding Centaur on external channels with our partners to accelerate how we do customer support - I think this will be huge, as it lets you tap in its whole brain w/ fine grained perms vs having to have many bots etc"
	- https://nusomi.com/
	- perhaps the similarity to omar's research is bearish due to lack of grounded practicality on growing enterprise time/money tasking
	- people think. people share what they think with others. sharing improves others thinking. this happens slowly. is basically one version of a practical thesis. whats a very specific workflow? 
	- discussion with jakub yielded the distinction between nondeterministic reward functions and deterministic reward functions. simpler demarcation is human vs not.
	- one tension seems to be that the end goal is for the model to prove it fully understands me (via prediction from increased legible context) so that it can eventually expand the work i do directly, outside of me prompting it to do so. i doubt this behavior arises naturally, and would need to be directly trained. does super good prediction eventually result in 'agency'? probably if the outputs involve actions not just thoughts. but i'd want it to eventually do things I could not do reasonably, thats the whole point, like index a ton of data or do a ton of messaging with others agents. would it do that if it learns to just follow my actions without taking into account its unique capabilities?
	- a lot of continual learning/memory rhetoric seems to be "what did i do?" "how can i do better?" rather than "what did the human do?" "what will the human do next?". the latter is much more like a recommendation system but for actions rather than content? is this an actual distinction?
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
	- One way to describe this local vision feels like “neomemory” bc it’s similar to what “memory” systems do today but pointed at prediction?
	- seems equivalent to predicting behavior or increased legibility. didnt feel the need to increase legibility for 'big data' social media algos. maybe because they didnt care about capturing me, or i didn't benefit, or it was knowingly misaligned, but likely probably because i just *couldnt*. i'm not able to put generative thoughts into twitter. (unless maybe they edit the feed based on what you post too, which would make a lot of sense, but havent heard anything about this)
	- seems so obvious that theres a gap of just having an end to end product that pipes all computer context + serves personalized predictions to solve inferenced local and global goals?
	- **having full context visibility -> predicting what i will do -> doing something to help me get there feels pretty intrinsically valuable. the relation to knowledge sharing perhaps is confusing because its a different axis along the lines of the data elicitation and enterprise customer adoption pigeon holing. but the reason for the assistants would be to use the human models for multiplayer rollouts. does that hold up? does that cause it to be too long of a winding road to a specific problem? theres definitely conflation in the intended problems to be addressed**
	- essentially actual experimentation to bolster algorithmic belief for a product for data legibilization, recognize that if you dont have a ton of personal data (unclear where the reward model part comes in) then you will be in a lot of pain in the next few years (assumes RSI/AGI)
	- as i think more, the core distinction seems to be training a model to predict how my brain works during my workday. based on inbound, what is my outbound? 
		- the stance, which needs to be deeply analyzed, is that this matters because (1) self prediction is enough of a value prop by itself (2) prediction is a prerequisite for inferring rewards (3) prediction, inferring rewards, and the data collection associated with both is a prerequisite for a superhuman system pursuing my goals for me.
			- the 3rd will likely come to fruition as computer use expertise in base models advances. the blocker for this will be understanding how separate environmental agents react to your actions. this is the tie in to classic MARL, legible motion planning, etc
		- if all these are true, then the brass tacks come down to what inbound to collect and what outbound to collect, how to structure it so that prediction can show results, how to structure it so that reward inference can show results, and how to structure it for eventual superhuman rollouts towards my goals. the first is most important. 
		- the tension now is whether to optimize the data for prediction, or whether to keep the end in mind and optimize some meta layer that different types of datasets can be constructed from... i suspect the latter is better, pending some concreteness on what future algorithms are. i do have a basic sense so maybe it makes sense to go out and verify now how they differ from frontier elsewhere
	- proactive, prospective
	- again, obsidian with link enrichment, auto git with good commit msgs, multi device sync, messaging connectors for easy note taking might be enough. i find myself not deleting stuff because the search is more difficult (ai latency vs app search latency). which is annoying
		- and bitcoin timestamping because i want it.
		- not having link enrichment / search over the link content is super annoying, i cant find a gemini chat i had where i was learning about how obsidian handles markdown into its own block language or something. found it from gemini search, its also a couple bullet points above https://gemini.google.com/app/581ea6b83f49a55a
		- related to the idea that the algorithms and toy examples are to prove that using different tools 'legibilizing thought process of knowledge work' is worth it. and the features necessary to make the legibilization a smooth experience are separate from the algorithms necessary to turn it into something useful
		- the data construction from the 'raw' process work is the keystone/capstone
		- the problem with frequent git is that the local size of the git folder becomes massive, i assume there are solutions to this somewhere, but perhaps not?
	- what data is more valuable when shared?
	- bit of an old hot take. i think enterprise models will look like each employee having their own agent that is tuned to them, and the models are allowed to conversate to collaborate and improve rewards, instead of a monolithic model that everyone shares. personal computing with networking, not timeshared computing. 
	- are frontier LLMs already implicitly inferring my rewards when I give it iterative feedback in a claude code or codex session? whats the diff?
	- honcho's blog is quartz?? https://plasticlabs.ai/blog/posts/Memory-as-Reasoning they also discuss memory as prediction
		- similar tweet https://x.com/ashwingop/status/2069807820846063932
	- phrased during conversation as a tool that would elicit different behavior of legibilizing process of thinking in between computer interactions. that behavior doesn't exist as much today since the tool being used 'computer' doesn't really benefit from it. the tools of the future will ('local models')
	- vision post from roon "the world vision of open weights models running themselves, self replicating, training new versions of themselves (at least the kind of behavioral modifications that won't require massive compute scale), is really not very far away". my read is that 'training on what' i.e. useless without granular data
	- if my team each has one, then you can actually simulate N step rollouts that are accurate?
	- i think my hope for phase 2 is that the model can learn the abstract 'thought'/'motivation' i have/or 'connection' I make in my brain, then that loss-ily gets put into my computer, and 'recommend' a better described version of it
	- proactive, background, interactive. why is there not an agent tailored to me answering these questions in a way i would answer them on the order of hours or days, but in minutes?
	- phase 2 is intended to open up 'move 37' like capabilities
	- feel more resolute about the problem of converting personal computer use data into something that can be used to predict actions is deep. equivalent to refining oil to put into a machine that does something useful
	- https://arxiv.org/pdf/2203.02155 first sentence of the abstract "Making language models bigger does not inherently make them better at following a user’s intent" banger
	- good thesis piece [[Interaction#^4c96d9]] but thinking about it more, i think there are a few problems/solutions being conflated that need to be separated
	- instruction following training seems explicitly different from action completion training that im considering. instruction following needs to literally be baked into token completion: https://www.youtube.com/watch?v=XKLGuwvSKvI&list=PLoROMvodv4rPwxE0ONYRa_itZFdaKCylL&index=10
		- makes a good point that as models drift from supervised policy, their expectation of value increasingly diverges from actual value. (slide at end of lecture)
	- answering a thought or question i type into notes is VERY different from completing my next action / thought. it could connect IF the action is a good prompt to a chatbot, and the agent is able to query the chatbot and return the response in a separate computer, basically messaging it for me on my behalf the way i would. hmmm
	- why do i want a model to predict me? dont i want a model to improve me? some self-doubt thoughts. the line of thinking from there though was that it needs my reward model, i cant specify it outside of my actions, my actions therefore need to be maximally legible. the toy example is to establish whether increased legibility improves ability to predict, which i need to tie into ability to understand and raise the ceiling on the reward function. also should clarify somewhere how it ties into multi agent systems and the thesis of ai per employee as the enterprise use case rather than a 'company agent' if that's the stated direction
	- yup https://thinkingmachines.ai/blog/the-future-worth-building-is-human/
	- context elicitation -> data processing -> continual SFT -> implicit reward from recsys -> envsim rollouts for discovery (MAS)
	- ^ stems from coordination as the thing i care about from crypto
	- i have tension between open sourcing all data and keeping browser history private. i would likely be fine with public browser history if it was properly scrubbed
	- do i develop a model of each LLM such that it becomes more useful to me? for example even though kimi k3 came out, i dont really have a desire to try it since it isnt so clearly better at a use case for me. there are various reasons behind that. for fable on web, its not clearly more intelligent. for gemini, i have more certainty about what im getting with gemini since i have a sense of how it answers. for the chatgpt app, its easier to access my notes (very similar to why i switched from claude web to claude code, since it more easily accessed my codebase)
		- this leads me to think there may be a similarity where i want something well built, that is smart, that immediately has access to my thinking history, as a possible value prop. again there are many value props being conflated and i need to recognize that and separate them as an initial go forward step
	- there seems to be a tension between two seemingly mutually exclusive goals
		- creating an extremely good human model, that can then be used to simulate the user to enable prospective learning, multi agent settings, assistance games, better personalized search and rec, etc
		- creating an extremely good centaur model, which optimizes for the envisioned product directly by recognizing the model is making suggestions and optimizing for the combined output
		- it seems like the more truthful analysis is that the centaur model is an example of prospective learning downstream of the good human model? clearly the human model is the first step, and the vision just needs to be plausible, exciting, valuable, and I need strong belief in it. but the vision does not matter if the early experiments indicate lack of productizability
	- the limit to the extent of rollouts is probably whatever I can quickly understand. another tension here that needs to be identified and a path chosen is replacement vs augmentation. if my human model is doing rollouts and taking actions, thats full replacement. even if it reports back what its doing, its not ME doing it. i guess this is just management though, which doesnt count as replacement. hmmm. to be more nuanced its replacing one task for another higher leverage task. but its pretty well established that some people like being individual contributors rather than managers
	- There seems to be a common thread between (1) why multi agent systems (2) how true user modeling is required since it only works when context and mind function differ (3) the research discussing how imitation learning is a prerequisite for multi agent research, that I’m just discovering from Micah’s work
	- the story i told jakub regarding the verifiable loops -> nonverifiable loops for primary AI tasking makes more sense to me since I think most enterprise AI dollars go to nonverifiable tasks than verifiable tasks ('tokenmaxxing'). im surprised inference net has revenue given they focus on rote tasking, since i would not expect enterprises to actually spend much money on that. maybe i overestimate how smart enterprises are and as a result the problems they actually face. like i would never think spending 100k per month on data extraction would be a reality. this suggests i need to be simpler and more practical with problem formulation. its worth verifying what 'nonverifiable' tasking is.


there seems to be a very core distinction between training a model that is purely a human predictor, then training a generally capable model that optimizes with it (a la assistance games) vs training a single model by instilling human predictive capabilities into a generally capable model. its unclear which is better or which im doing, at least from a theoretical/framework perspective. its obvious i am training a model that uses preference data such that the centaur outperforms the demonstrator alone. which implies a single model. in some sense this model would be 'human+' not just human.

the colloquial explanation would be that it learns implicit, yet uncertain (to prevent reward hacking) goals from predicting me well. then can use the implicit reward to perform rollouts that increase it over some baseline, which reminds me of GRPO where one rollout is performed by the human. the problem that stands out is
- cant you just tell it the local goal?? why do you need a predictor?
- if you tell it the local goal, cant it already assist proactively?
- i guess you'd want to train it to understand the local goal well given the history of actions. but i dont want the UX to be showing an understood goal to the user. but maybe it should be? since a proactive suggestion implies a good understanding of the goal + a good understanding of how to accelerate that goal, which im assuming can be initially built as a human predictor, which i think is a fair characterization, but is harder / multi step, but is better UX. hmm
- i think this notion that goals will be implicit from good prediction likely only happens at scale. it comes back to why a predictor is desired at all


Beginning to wonder whether the tightest bottleneck is not human to AI data/reward transfer but AI to human understanding transfer. Or maybe the case that improving the former makes the latter that much more painful
	html over markdown improve the latter? reminds me of doublezero founder tweet discussing how to better coordinate agents, devs, and non devs

currently thinking through how a currently unidentified target market, that im proxing to myself and my team, actually uses computers/AI.
	lots of prompting (60-80%?)
	search into browser (do i actually even do this anymore? if i do, am i just looking at the AI summary?)
	coding
	taking notes
	messaging others
	social media output

data vs rewards
human understanding vs AI understanding
how to RLHF html visuals? how to personalize them?
how impactful is local data? (relates to local data laws experiment)
how many bits of information is required and how many are produced daily?


'superhuman model performance' is incompatible with an augmentation value proposition, as opposed to a replacement value proposition. augmentation's goal is superhuman system/centaur performance, which is the goal of any tool.

i was trying to force in DPO/IPO as an attempt to create an implicit reward model that could be used for actual rollouts. this is overly complex and reduces the likelihood of a successful phase 1. this is informed by the characterization of a centaur model as just one implementation of a human model. clearly a human model is useful for this. is it useful for other things?
	a discriminator model that learns the diff between the human action given history and the model action given history, which results in an implicit reward function from logprob diffs the same way RLHF/DPO does (pending the optimality of the human)
		i have since learned this is basically GAIL
	a world model to determine observations from actions that could result in 2 step rollout 'samples' instead of 1 step rollout samples, compressing user next action BC learning with theoretically improved per step decision making, which would become way more plausible with other phase 1 models interacting with each other, and is less plausible for super high entropy browser search, code runs a la ECHO (but ECHO could be used), social media output
	long chat that highlighted this https://chatgpt.com/c/6a5e760b-e110-83ea-9610-b0031962916e (discriminator diff measures model surprise which measures learning)

is RL fundamentally replacing? am i searching for augmentative RL?
	