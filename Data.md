likely need to
1) generate a data hypothesis by collecting all the disparate notes around data processing i've collected
2) implement the data ingestion and cleaning pipeline and monitor it
	1) codify data structure needed for chosen algorithms, codify how to extract from base data structure to algorithm structure for each step, set up all ingestion points and monitor cleanliness

#### disparate notes
- somewhat helpful gemini thread regarding data structure and previous attempts. but need to parse the bs https://gemini.google.com/app/b242920671bf7d32
- how many tokens are common examples of fine tuned models that actually work trained on? how many tokens are frontier models trained on? on what stage? how does LoRA actually impact the amount of needed/useful tokens? how does that change as the underlying model changes?
	- https://thinkingmachines.ai/blog/ probably should review the old ones too
	- quantifying memorization in LLMs, seems very relevant as it relates to the need for synthetic Q/A data. also useful for describing how much content saturates a model before it has to start compressing in order to maintain / improve performance (compression = intelligence)
		- https://arxiv.org/pdf/2505.24832
		- https://x.com/jxmnop/status/1929903028372459909
	- exactly how much human data was initially used to train the RLHF part of chatgpt?
	- how many bits of information is required and how many are produced daily?
- when i open a new tab without typing anything, that will show up to the model, but it wont learn to predict that? in what scenarios is there 'likely' to be a write action and in what scenarios are there not? maybe to solve the suggestion timing issue, the model only gets queried (test time) or predicts (train time) when an input field is focused? since that is a necessary prerequisite for a write action
	- when i delete something in obsidian, i am focusing on a potential input field, but no write action occurs. i mean technically one does, but not with content. hmmm
	- how does 'no recommendation' fit into the framework?
- what happened to rewind? where are the users? what are they doing now?
- (read, app, content) and (write, app, content). obsidian covers some write. the browser history script that fetches some read and write, but some issues flagged by Fable.
- i DO NOT want to build something that requires 'connecting apps'. sounds super annoying.
- https://www.primeintellect.ai/blog/algorithms-layer could be useful for implementation
- https://huggingface.co/learn/llm-course/en/chapter12/3 rubric engineering (like deepseek GRPO) MAY help the model bootstrap faster by learning things like proper syntax before it learns content
	- https://huggingface.co/docs/trl/grpo_trainer
- https://gemini.google.com/app/26a5dd577dc3bde7 sutton's idbd may be better for continual learning, it just seems to train slower. there are also optimizers other than typical gradient descent that seem to be more efficient for online convex optimization problems
- data structure comp https://github.com/tsinghua-fib-lab/FingerTip-20K
- new algorithms in [[Algorithms]], plus just how the relevant algorithms like longNAP structure data
- going back to the youtube interleaved data example, even when im reading a paper we would want the content i actually read to be shown before i type a note, not the entire paper. this seems very difficult to collect properly and perhaps prohibitive for good learning.
- one way to frame the data construction question is what level of 'noise' is acceptable? for instance i probably want to exclude clicking around obsidian to copy paste something, but probably want to include when i write down a long train of thought, but would that mess up the dataset construction since its no longer cleanly autoregressive?
- the use of git as a natural boundary likely helps but thats not really 'next token' or 'next action' prediction if multiple 'actions' were taken in a commit, one or more of which involves adding a word to the middle of some old note.
- data discussion https://gemini.google.com/app/434faa2eae499b25 for our work
- this has a nice framework for data structure, even though i disagree / am confused about some of his main desires https://gwern.net/guardian-angel#ux
- i suspect for phase 1 the goal will be to learn token level structure before it can learn action level content. you might get a loss discontinuity (via early flatlining before more data shows improved loss due to content learning beginning)
- data cleaning likely needs to ensure formatting is skipped, duplicates are handled, and for phase 2 if the agent doesn't have any reasonably confident completions, it shows nothing
- is it possible for reasoning to fit into the next write prediction? is this desired? worth testing in [[Phase 1#8. Experimental Program]]? something to be explicitly trained?
- should read data be text or html? pros/cons?
- discusses research similar to longNAP https://claude.ai/chat/d3de1f6d-cd67-404b-a93a-936b3a662d7e
	- the most interesting related paper which I put into algorithms uses something called LifeTrace for collecting data, takes snapshots at 1 Hz (can we track keyboard usage and snapshot during a pause, like it occurs in git in this obsidian?)
	- another one frames 'when to assist' as when its high likelihood that the "user would turn to an AI assistant right now" which is interesting
- practically need text PII scrub
- can the distinction in usefulness between having access to all necessary context and actually predicting next actions be quantified? i.e. context vs judgment i.e. the difference in two models having the same context and the weights resulting in different outputs? probably as part of the ablations yes
- forgot where i wrote this but need to collect data by time instead of turn? maybe take the 'snapshot' x secs after action like scroll or mouse movement or keyboard type ends like git does for obsidian
- for the data, i likely need to do my normal work, then have a separate window that is not tracked that logs the read/write stream. and i need to confirm over the course of a day or two that its a high fidelity representation of my actual inputs and outputs. non comprehensive list of things to handle:
	needs to handle reading something then scrolling back up to reread it
	needs to handle having multiple windows across multiple screens open at the same time
- is collecting agent traces sufficient if 80% of write actions are chatbot interactions? could this be an ablation in [[Phase 1]]?
- i wonder whether you need the data to be literally temporally interleaved to predict well. like i pause a youtube video, write down thoughts, play the youtube video. etc. its incorrect to put the entire transcript in when the page is first visited, since the goal is to most closely simulate how my brain works. the actual construction of the dataset is literally 90% of the work here. will take trial and error. may be worth thinking how to improve it
	- if im watching a youtube video for example, i suspect the best data structure would be the transcript of the part i watched as <read, browser, youtube, transcript chunk> then <write, obsidian, entry, written note>.
- might help with data ingestion, seemingly open source/self hosted granola https://github.com/Zackriya-Solutions/meetily
	- https://github.com/ExistentialAudio/BlackHole
- very informative and critical reward inference discussion with papers foundational from dragan that i havent come across otherwise https://gemini.google.com/app/4f984ce16e37337a, includes data structure discussion and examples
- thought dump
	- Taking helpful action rather than mimic action is a core tension since there’s plenty of things i would like but don’t actually do since it’s difficult or high friction. Relates to proactive and prospective learning, as well as embodied intelligence.
	- Does action mimicry lead to action assistance? Depends on reward inference. I’ve laid out one path, should identify and dig deeper if needed on biggest assumptions and unknowns
	- Mimicking leads to thinking around continual learning which may not be the right direction vs taking a helpful action directly, which may devolve into recsys, but maybe it’s something with a set of new properties I need to be more rigorous about
	- The way it DOES map is when I run into an issue and then actually solve it, given the context.
	- If I solve it in a multi step way that relates to previous notes around wanting the model to suggest the N steps required for my goal, or if it can condense it into one step even better, rather than just walk me through the existing steps a bit faster. That’s likely the start of it though
	- Maybe should store all data, and just filter by “in sight/mind” data, since might want to use the additional data later, for the purposes of having flexible data collection. Screenpipe? I guess not screenpipe since that by itself won’t allow me to filter into “in sight”. Need to collect both since “in sight” is an additional “feature flag” while collecting all the data
	- tentative data plan is set up a debugging app thats always on my screen, not tracked, and that maps with highest fidelity what i read and write into an event stream. should properly demarcate i.e. put consolidate stream into events, should include full links for eventual 'full' data not just 'view' data, and should include timestamps which may not necessarily be trained on but turn based vs time based is a big open question
- rubric engineering seems so manual. "i know it when i see it"/reward inference may be better but it involves human in the loop. it comes down to trust architecting. lots of related concepts i think.
- internalizing continual learning
	- what shape of continual learning, from an algorithmic perspective, do I most believe in? How does this impact data collection as a valuable slice, as well as the shape of the data processing?
	- what are the hardware bottlenecks to continual learning? how do compute resources change on a very fundamental level with continual retraining?
	- does my intended SFT approach (autoregressive train on next action prediction i.e. causal mask) violate i.i.d. data assumptions? does shopify's generative recommender have the same issue? what do those assumptions actually mean in practice? do all online or continual learning setups violate this? how does this relate to the practice of storing rollouts in a buffer that you then sample from? does that essentially fix i.i.d. for continual learning scenarios?
		- https://gemini.google.com/app/9de51346992f5bae wild stuff
- problems
	- annoying giving codex obsidian links over and over
	- annoying telling codex it can ssh into desktop, it should now
	- "get xiao wang" but contextless ai doesnt know how, from deepseek founder
- like these concepts as a demo
	- "you can put knowledge in a prompt but you can't put skill in a prompt"
	- tacit knowledge, skills vs information from will brown. weights distilling judgment. visceral example of same context -> different output. 
- prime intellect, inference net, freesolo, unsloth, tinker, self stack as possible training options
- https://github.com/ramp-public/portallib portable lora from ramp, open source code, may be useful
- if you scroll too fast to read then it shouldnt be marked as a read. this is probably handled by waiting 3 seconds to scroll
- if im writing in one window with another window open, is that text being read?
- perhaps useful for the agent chart part of capture [0001-trajectory-format.md](https://github.com/harbor-framework/harbor/blob/main/rfcs/0001-trajectory-format.md) [trajectory-v1.schema.json](https://github.com/letta-ai/trajectory/blob/main/schema/trajectory-v1.schema.json)
- i think in some sense, if there isnt enough data, that implies a better interaction surface like [[Product]]. if there is enough data, a better interaction surface may still be necessary, but may not be the most important thing vs market visibility and positioning
- readability and trafilatura are tools to convert html to markdown
- context details
	- big question for data codification is whether you give a tool call to fetch the content of a web page rather than the content itself during training. how does that change the state and action space? does it more clearly separate the action space of the agent from the state space of the environment? are there two environments?
		- lots of good information that seems relevant in this guys feed https://x.com/oneill_c
		- essentially follows the lines of 'reasoned retrieval'. you RL the agent to use tools to figure out what information it needs. related to the below point as well
	- how do harnesses actually handle context and content fetching? if it fetches a website that has 10M tokens, what does it do? or if it runs a terminal command that has 2M tokens worth of lines, what does it do? there must be context management logic? is it basic sliding window? compression? (longNAP implementation likely sheds some light on this)
		- answered here https://gemini.google.com/app/ffa1c56253618253. for search, basically fetches initial segment of predefined length, saving rest to a local sandbox file that supports pagination or grep for future tool calls. for commands, fetches head and tail of predefined lengths, saving full to a local sandbox file that supports grep
		- context management logic basically involves summarizing history when context gets too close to limit, saving last N turns for consistency
- still unclear whether you need to apply synthetic q/a self study to the data to improve understanding rather than memorization, and how that relates to maintaining support for question answering / chatting, and how that relates to introducing reasoning rather than pure SFT. although these are likely later ablations rather than initial work
- if i click into my obsidian to type something, am i now reading the set of text around where im typing?


#### more formal notes
- wait WRITE_DELAY (perhaps 3) seconds after a keyboard entry and READ_DELAY (perhaps 1 second) mouse movement or mouse scroll or mouse click, then take a SNAPSHOT
	- actual values will need to be tuned through iteration of the demo app displaying stored data
	- the purpose of the delay is to reduce noise associated with backspacing, typos, etc while writing. the downside is missing critical actions, since per the deduplication, we'll essentially be looking for diffs from the previous state which may be lost depending on the use case
	- some nitpicks for data construction ^527840
		- need to handle copy / paste actions from different apps into obsidian to not mistake that for user typing
		- need to handle moving a cursor in between sentences across notes or anywhere else typing is occurring, editing, deletion, typos, etc
		- git across my entire computer wherever im writing? it nicely handles breaking down actions into chunks, whereas raw keystrokes have a ton of noise around moving cursors, backspacing, typos, etc. hmmm.
- a SNAPSHOT takes the text that the user is likely *actually* looking at, rather than the full screen, to best simulate actual inbound information
	- will be informed by actual implementation, but should probably start with ignoring unselected/unfocused windows, unless it's a video, but perhaps for v0.1 we ignore video.
	- should take the 'middle' of the screen as much as possible, maybe like 30% borders from the left, right, and 50% from the bottom
	- should ensure overlapping data is completely removed before storing as an event, specifically the content
- collection surfaces will be informed by actual implementation, but likely covers codex app, browser use, obsidian
- the text from a SNAPSHOT is converted into a DATA STRUCTURE. this can likely be heavily optimized, so we want to start from something that contains more information than necessary that is able to then be filtered, so the simplest is likely json
- the json likely has time, read/write boolean field, author/source field, destination field (only for write, type is union of apps, each app has its own set of fields for example obsidian has a file path while browser likely just demarcates between search and ai chat), link optional field, content field, where the content should likely be markdown
- if you do delay based event demarcation and within a delay you write multiple events, you would need to then separate out those events
- start with remote LLM and data storage to avoid storage issues and allow for seamless larger model ablations
- start with sampling the model to predict a write action after a text field of any kind is focused, outside of the model itself. this also naively but perhaps well enough solves the issue of 'when' to suggest/sample/intervene. further work can attempt to internalize timing into the model, which becomes more of a self aware assistance game rather than simple behavior cloning

#### initial plan

Build and deploy sensors from scratch, then iterate from what they actually expose rather than predefining the final data structure.

**North star:** qualitative temporal fidelity of snapshots—capturing, as closely as possible, what information was available to the human and what the human produced, in the correct causal order.

**Loop:** deploy the smallest useful sensor → inspect its raw snapshots during real work → compare them with the actual inbound/outbound experience → fix the sensor or snapshotting → repeat. Use relevance to next-write prediction as a practical proxy.
