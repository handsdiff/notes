likely need to
1) implement the data ingestion and cleaning pipeline and monitor it
	1) codify data structure needed for chosen algorithms, codify how to extract from base data structure to algorithm structure for each step, set up all ingestion points and monitor cleanliness

#### disparate notes
- one window can be selected while im scrolling another window
- scrolling too fast should not be counted as read
- how many tokens are common examples of fine tuned models that actually work trained on? how many tokens are frontier models trained on? on what stage? how does LoRA actually impact the amount of needed/useful tokens? how does that change as the underlying model changes?
	- https://thinkingmachines.ai/blog/ probably should review the old ones too
	- quantifying memorization in LLMs, seems very relevant as it relates to the need for synthetic Q/A data. also useful for describing how much content saturates a model before it has to start compressing in order to maintain / improve performance (compression = intelligence)
		- https://arxiv.org/pdf/2505.24832
		- https://x.com/jxmnop/status/1929903028372459909
	- exactly how much human data was initially used to train the RLHF part of chatgpt?
	- how many bits of information is required and how many are produced daily?
	- its likely actually important to answer this question because it will help determine the optimal number of weights to encode the given dataset
	- any work out there that quantifies the context size of an adult human brain? how does this context size relate to 'reasoning to retrieve'?
	- one of the questions, related to Data notes, seems to be how much 'data' do i produce, or more specifically how much data signifies a single distribution, and how many weights are necessary, assuming some average LLM architecture, learn that data, according to papers like Kaplan and Chinchilla
- i wonder whether you need the data to be literally temporally interleaved to predict well. like i pause a youtube video, write down thoughts, play the youtube video. etc. its incorrect to put the entire transcript in when the page is first visited, since the goal is to most closely simulate how my brain works. the actual construction of the dataset is literally 90% of the work here. will take trial and error. may be worth thinking how to improve it
	- if im watching a youtube video for example, i suspect the best data structure would be the transcript of the part i watched as <read, browser, youtube, transcript chunk> then <write, obsidian, entry, written note>.
- might help with data ingestion, seemingly open source/self hosted granola https://github.com/Zackriya-Solutions/meetily
	- https://github.com/ExistentialAudio/BlackHole
- data discussion https://gemini.google.com/app/434faa2eae499b25 for our work
- i think in some sense, if there isnt enough data, that implies a better interaction surface like [[Product]]. if there is enough data, a better interaction surface may still be necessary, but may not be the most important thing vs market visibility and positioning
- context details
	- big question for data codification is whether you give a tool call to fetch the content of a web page rather than the content itself during training. how does that change the state and action space? does it more clearly separate the action space of the agent from the state space of the environment? are there two environments?
		- lots of good information that seems relevant in this guys feed https://x.com/oneill_c
		- essentially follows the lines of 'reasoned retrieval'. you RL the agent to use tools to figure out what information it needs. related to the below point as well
	- how do harnesses actually handle context and content fetching? if it fetches a website that has 10M tokens, what does it do? or if it runs a terminal command that has 2M tokens worth of lines, what does it do? there must be context management logic? is it basic sliding window? compression? (longNAP implementation likely sheds some light on this)
		- answered here https://gemini.google.com/app/ffa1c56253618253. for search, basically fetches initial segment of predefined length, saving rest to a local sandbox file that supports pagination or grep for future tool calls. for commands, fetches head and tail of predefined lengths, saving full to a local sandbox file that supports grep
		- context management logic basically involves summarizing history when context gets too close to limit, saving last N turns for consistency

#### more formal notes
- iteration plan
	- for the data, i likely need to do my normal work, then have a separate window that is not tracked that logs the read/write stream. and i need to confirm over the course of a day or two that its a high fidelity representation of my actual inputs and outputs. 
	- tentative data plan is set up a debugging app thats always on my screen, not tracked, and that maps with highest fidelity what i read and write into an event stream. should properly demarcate i.e. put consolidate stream into events, should include full links for eventual 'full' data not just 'view' data, and should include timestamps which may not necessarily be trained on but turn based vs time based is a big open question
- wait WRITE_DELAY (perhaps 3) seconds after a keyboard entry and READ_DELAY (perhaps 1 second) mouse movement or mouse scroll or mouse click, then take a SNAPSHOT
	- actual values will need to be tuned through iteration of the demo app displaying stored data
	- the purpose of the delay is to reduce noise associated with backspacing, typos, etc while writing. the downside is missing critical actions, since per the deduplication, we'll essentially be looking for diffs from the previous state which may be lost depending on the use case
	- some nitpicks for data construction ^527840
		- need to handle copy / paste actions from different apps into obsidian to not mistake that for user typing
		- need to handle moving a cursor in between sentences across notes or anywhere else typing is occurring, editing, deletion, typos, etc
		- git across my entire computer wherever im writing? it nicely handles breaking down actions into chunks, whereas raw keystrokes have a ton of noise around moving cursors, backspacing, typos, etc. hmmm.
	- if you scroll too fast to read then it shouldnt be marked as a read. this is probably handled by waiting READ_DELAY seconds to scroll
- a SNAPSHOT takes the text that the user is likely *actually* looking at, rather than the full screen, to best simulate actual inbound information
	- will be informed by actual implementation, but should probably start with ignoring unselected/unfocused windows, unless it's a video, but perhaps for v0.1 we ignore video.
	- should take the 'middle' of the screen as much as possible, maybe like 30% borders from the left, right, and 50% from the bottom
	- should ensure overlapping data is completely removed before storing as an event, specifically the content
	- ignoring audio and video for now since transcription feels trivial relative
	- if i click into my obsidian to type something, am i now reading the set of text around where im typing?
- collection surfaces will be informed by actual implementation, but likely covers codex app, browser use, obsidian
- the text from a SNAPSHOT is converted into a DATA STRUCTURE. this can likely be heavily optimized, so we want to start from something that contains more information than necessary that is able to then be filtered, so the simplest is likely json
	- needs to handle reading something then scrolling back up to reread it, which i would probably include again. this is different from the deduplication which is more for successive events containing the same data while i spend time reading it. but maybe we shouldnt even de-dup that, since that implies more of an impression on my thinking? if you incorporate that with time, it implies that connections are possibly being made
- the json likely has time, read/write boolean field, author/source field, destination field (only for write, type is union of apps, each app has its own set of fields for example obsidian has a file path while browser likely just demarcates between search and ai chat), link optional field, content field, where the content should likely be markdown
	- readability and trafilatura are tools to convert html to markdown
- if you do delay based event demarcation and within a delay you write multiple events, you would need to then separate out those events
- start with remote LLM and data storage to avoid storage issues and allow for seamless larger model ablations
- start with sampling the model to predict a write action after a text field of any kind is focused, outside of the model itself. this also naively but perhaps well enough solves the issue of 'when' to suggest/sample/intervene. further work can attempt to internalize timing into the model, which becomes more of a self aware assistance game rather than simple behavior cloning
	- when i delete something in obsidian, i am focusing on a potential input field, but no write action occurs. i mean technically one does, but not with content. hmmm
	- how does 'no recommendation' fit into the framework?
- one way to frame the data construction question is what level of 'noise' is acceptable? for instance i probably want to exclude clicking around obsidian to copy paste something, but probably want to include when i write down a long train of thought, but would that mess up the dataset construction since its no longer cleanly autoregressive?


#### initial plan

Build and deploy sensors from scratch, then iterate from what they actually expose rather than predefining the final data structure.

**North star:** qualitative temporal fidelity of snapshots—capturing, as closely as possible, what information was available to the human and what the human produced, in the correct causal order.

**Loop:** deploy the smallest useful sensor → inspect its raw snapshots during real work → compare them with the actual inbound/outbound experience → fix the sensor or snapshotting → repeat. Use relevance to next-write prediction as a practical proxy.

### implementation issues

- different views have different crop requirements. cannot blanket crop left right by 10% since it cuts off obsidian but allows twitter slop, and vice versa
- extremely overbearing feeling of needing to conform my work to make sure it fits well into the data not the other way around, i think the typing delay doesn't allow for spontaneous thinking so it feels a bit intense
- if i cannot scroll down anymore, thats probably an indication im reading the bottom section of the screen, and we should capture that in the data rather than using the default 50% cutoff
- are these issues with cutoffs for read why people use formal, supported integrations? the problem with the integrations is that they don't capture 'attention', they only capture content. who's to say that I read a specific item or not? not that my method is necessarily capturing that, but it feels closer, and a slack mcp server for instance does not seem like it would be able to capture read properly
- is it possible to do eye tracking without an always on camera?
- the bounding box crop/cutoff leaves fragmented sentences. is there a way to intelligently not do this? then you would need to decide if you want to keep or leave it though, which loops back to the issue around each view having different cropping requirements at different times
- google chrome browser search write uses the full url instead of the search query
- still need to determine 'author' of content, and distinguishing read from what ive just written, or more likely that just gets handled in the soup of training
- pressing enter after a type seems to have issues with collecting the data inserted before the type
- how best to handle copy paste, still an issue
- how best to handle autocomplete from other sources? for example if i type in 'ge < Enter >' into browser search it brings me to gemini. probably just want the model to complete the entire thing. i.e. the model learns to predict navigating to gemini.google.com i.e. the full url
- can extract text from youtube videos but not subtitles? or is that a cropping issue
- ive glossed over 'where' something is being written but it feels like it matters. for example if im editing an article, and the model learns that i often click into a paragraph to make an edit, how will that appear during training? will the model see a confusing mix of sentence completion and sentence editing? another example is that when i click into the title of a substack article, it seems like the model knowing thats a title will help it predict better. if it thinks the entire google chrome app is the same thing, its going to be quite confused about what im typing into gemini vs what im typing into a substack draft...
- i originally think i handled the 'where' thesis by only performing sampling when a text field was focused. i guess the core distinction, which reminds me of cursor, is how to codify the state of the cursor into the context, to give it an understanding of where it is, or is there some other way to solve this problem
- it feels like when there is a large time gap before a write, that indicates thinking may have occurred, which implies good next content prediction would be more useful
- if the next write needs to be conditioned on not only the history of read write, but where the cursor is, is this data captured in training? how would you even define cursor positioning? pixel coordinates are likely a poor candidate? maybe you have to define a sliding window of what's before and after the cursors position? that acts as a hyperparameter?
- wont be able to include terminal data even though i likely want to until the app is separate from showing debugging logs in my terminal, to avoid recursive tracking
- are we capturing backspaces in write events?
- im seeing issues with read/write capture where what i wrote is tracked into read, before the write event completes, which breaks causality. also for the line i wrote above, it was combined in a write event with the line before it, which is wrong since i wrote the line before it way prior.
- regarding copy and paste, we probably want to specifically exclude pasted data from training? or do we want the model to predict the pasted data? it feels more likely that we'd want it to predict the 'paste' action or keyboard movements (cmd V) rather than waste time predicting the content of the paste, since its not actual 'content' written by the user in the sense of distilling judgment
- do we want the model to predict WHERE focus will occur as well? in the context of copy paste it seems interesting, although the UX for it seems impossible besides choosing an app. i guess you could specify the preceding text or input field, but would need to think about it.
	- whats interesting is that cursor, which was made explicit to me yesterday, was not just autocomplete existing cursor, it was where cursor should go next
- the desire to predict where focus will occur next is more obvious when you consider copy paste scenarios
- the problem with copy paste in the context of displaying predictions/samples is that i cant copy paste from the model's suggestion to my work, which would be the flow, without fucking up


current challenges i just addressed but need to test are
- handling cursor position as a necessary input for good content prediction
- masking everything except added content for the purposes of training
- adding EOS tokens in data cleanup

current challenges im addressing are
- handling copy paste. making the call to avoid loss on the pasted output, replacing it with a special paste token like EOS
- handling write diffs. there are still tons of examples where the write demarcation includes previously written text when it should not be.

at the same time i want to put out the article
- i think the draft is decent, need to get more comfy with it as compared to the goals with it from Local Tasking
- mapping whats written to my actual work, i think copy paste comes down to authorship, i think write diffs come down to event demarcation. the work around content prediction seems less of a data capture and more of an application challenge which leaks into how data is collected.
- not 100% confident the list of differences are non overlapping to each other and also comprehensive yet. not sure if i could make explicit why that is. i think it's because the questions from entry are not fully answered yet
- the revision iterations i did for thesis have made it something i can easily reference as very indicative of my thinking, not sure i can say the same for this piece yet
- Probably just need to share the draft with team to see

the capture is currently off as i work through the challenges

want to tell a new agent roughly the following points
- The line before it was combined into the write (cursor biased diffing, concrete examples from coding agent)
- What I wrote was tracked into read before the write
  completed (handled by compiler but still dirties event stream)
- EOS token
- paste handling via paste token and associated loss masking (50% of tokens are pasted tokens in my 3h run 5)
- proper content production masking
- cursor position as defined by semantic surroundings as necessary metadata for actual suggestion
- large deletion bugfixes from run 5
- something about cursor coordinates from the coding agent
- read source attribution (but i think this is minor)
 while cleaning up the article based on the agent feedback
