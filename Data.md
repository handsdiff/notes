likely need to 
1) generate a data hypothesis by collecting all the disparate notes around data processing i've collected
2) review the data structures from relevant similar papers like I did for algorithms to determine which is worth implementing
3) implement the data ingestion and cleaning pipeline and monitor it

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
	- 