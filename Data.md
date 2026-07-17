likely need to 
1) go through and clean up Entry, separate things that should be handled during backlog/minor work push, to enable step 2 below
2) generate a data hypothesis by collecting all the disparate notes around data processing i've collected
3) review the data structures from relevant similar papers like I did for algorithms to determine which is worth implementing
4) implement the data ingestion and cleaning pipeline and monitor it
	1) codify data structure needed for chosen algorithms, codify how to extract from base data structure to algorithm structure for each step, set up all ingestion points and monitor cleanliness

disparate notes:
- [[Experiment Plan]]
- some nitpicks for data construction ^527840
	- need to handle copy / paste actions from different apps into obsidian to not mistake that for user typing
	- need to handle moving a cursor in between sentences across notes or anywhere else typing is occurring, editing, deletion, typos, etc
	- git across my entire computer wherever im writing? it nicely handles breaking down actions into chunks, whereas raw keystrokes have a ton of noise around moving cursors, backspacing, typos, etc. hmmm.
	- does defining actions as time steps like this make sense (i.e. git commit after x seconds of no action as natural 'states')? how does it relate to thinking machines focus on 'time based' chunking of data? worth exploring. time based vs turn based. they have an SGLang PR that I should review. 
		- still such a banger https://thinkingmachines.ai/blog/interaction-models/. every source they city resonates ^15beb6
		- "with a wider release later this year"
		- personal models / interaction models / proactive models + local data exposure will collect tacit knowledge orders of magnitude more than systems that take a prompt and work for hours
	- maybe the lack of this work publicly is simply that the data production + data cleaning combination is too high of a hill to climb?
- [[Interaction#^f5c205]]
- [[Interaction]] overall
- https://arxiv.org/pdf/2309.12170 older RNN predicting mouse/keyboard data
- https://x.com/screenpipe/status/2077045452579778664?s=20
	- it might be in a gemini chat, at the very least in browser history, but there was an old screenpipe PR that cleaned up screenpipe data for training. i think it was for retrieval so maybe it was whatever, but im surprised i did not note it down
- ways to think about data from Levine https://x.com/svlevine/status/2075721405929508942?s=20
- https://github.com/experientiallabs/world-model-harness (yc, seems to be productized data cleaning)
- tension between improving data collection vs experimenting with algorithms to make it useful. need both long term pending ongoing discovery. my current load bearing has been phrased as algorithms, but maybe thats because i already write down thoughts, and the additional work there doesn't feel like i learn anything besides if i write down more thoughts, which would require actually measuring usage rate. the ai could easily do this, pending how the actual git commitments work (is it actually when i stop typing, or just every 10 mins). but iterating on the algorithms will act as a forcing function for what type of data is needed and how it should be structured, which probably makes it more useful as a load bearing
- "possible experiment / toy example to have the git history of notes, randomly remove increasing portions of it, in-context prompt frontier and/or weight space update a smaller LLM, rank predictions based on personal expected usefulness/predictive ability (perhaps just pairwise), establish trend line if any. compare across differing frontier models and/or differing small/local LLMs. do this online to collect more data on how it evolves over time"
- https://www.markovstudios.com/data_samples/writing-and-research yc startup computer use data sample. is this actually what computer use data looks like?
	- come to think of it, how would I actually codify the action space for next thought prediction? would the action space be infinite if the action consists of the full thought rather than tokens? if tokens how exactly would start/stop tags work?
	- minecraft dreamer v4 seems to directly relate to computer use in terms of algorithms that could be useful to apply to non minecraft scenarios
- (2) the structure of the data required to actually implement a predictive algorithm likely requires context into what im seeing, not just what im outputting. its unclear how to best structure the data to predict outputs, but at the very least i'd likely need surrounding context which probably very simply takes the form of browser history with proper auths. what are the best existing tools and/or custom solutions for this?
- i suspect the data should interleave write actions (content, app) with read actions (content, app). obsidian (+ ai chats, search) are most of write. the browser history is most of read. but i only want the model to predict what i write, not what i read. and i dont want to trade off intelligence, since the point is superhuman
- somewhat helpful gemini thread regarding data structure and previous attempts. but need to parse the bs https://gemini.google.com/app/b242920671bf7d32 
- what should the data structure be for training on an open source model, if the goal is to predict 'writes' (obsidian note, browser search, message to ai chatbot) given previous reads and writes (browser history, ai chatbot answers, previous notes)
- (read, app, content) and (write, app, content). obsidian covers some write. the browser history script that fetches some read and write, but some issues flagged by Fable
- super relevant analysis of algorithms, compared to prompt space, and data tricks/tips needed to juice performance at least in that specific domain https://thinkingmachines.ai/news/learning-to-replicate-expert-judgment-in-financial-tasks/ 
	- is it cheaper to update weights continuously or update prompts continuously? actually feels like weights? since querying prompts on a frontier model is super expensive? 