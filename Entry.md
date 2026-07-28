
- context details
	- big question for data codification is whether you give a tool call to fetch the content of a web page rather than the content itself during training. how does that change the state and action space? does it more clearly separate the action space of the agent from the state space of the environment? are there two environments?
		- lots of good information that seems relevant in this guys feed https://x.com/oneill_c
	- how do harnesses actually handle context and content fetching? if it fetches a website that has 10M tokens, what does it do? or if it runs a terminal command that has 2M tokens worth of lines, what does it do? there must be context management logic? is it basic sliding window? compression? (longNAP implementation likely sheds some light on this)
- there is an openai 2023 paper in lecture 18 of cs224r that shows model confidence is much less calibrated after PPO post training than after pre training. how is this data even collected? the pre train model should not be able to do question answer formats, no?
	- the inability to self model uncertainty is brought up as an issue with human AI interaction/collaboration
	- its unclear how 'uncertainty' even natively exists in the model? maybe the probability of the 'winning' token directly? im sure someone has researched this. relates to the dragan waymo interview
- https://web.stanford.edu/class/cs329x/

big blocking question right now is related to the above context details point, why longNAP learned reasoning for retrieval, how e2e-ttt consolidates information, online convex optimization algos, how other memory startups handle it, the continual learning research for the X account above, token efficiency of retrieval, etc, all pointing to a better understanding of how context is managed / trained, and how that surface bumps into the intended surface of the prefixed sliding window default choice. i.e. how to actually use the collected data

it feels like honcho, and a ton of memory startups, are focused on taking the work the agent does, and the user feedback that is sent to those traces, and then updating the agents actions. feels like the natural conclusion of this idea is the agent following the human's actions? in terms of more frequent feedback and the ability to do what the humans wants. but on the other hand its different because the agent is bottlenecked by what the human is doing. but even within that it could be fine because that agent is learning to prompt other agents to do work, so perhaps its 'cooperatively useful'

in terms of my training i likely need a perspective on how fact retrieval 