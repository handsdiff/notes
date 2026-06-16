 1. How does Thinking Machines’ interaction models impact inference architecture? Consumer use cases?  
    1. [https://thinkingmachines.ai/blog/interaction-models/](https://thinkingmachines.ai/blog/interaction-models/)  
    2. [https://thinkingmachines.ai/news/interactivity-research-grants/](https://thinkingmachines.ai/news/interactivity-research-grants/)  
2. do interaction models solve theory of mind for the given interactor? what does the data for interaction models look like?
	1. theory of mind according to blaise is modeling other minds. modeling your own mind is consciousness according to blaise [[Thoughts#^963ac3]]
3. need interaction because too dynamic and complex to statically hardcode preferences
4. https://arxiv.org/abs/1606.03137 CIRL https://gemini.google.com/app/bb201e6013c0056c ^2bff57
5. what is the relation between interaction and MARL? how does that relation explain karten's take that "realtime envs with agent actions" is the new paradigm? seemingly relates to 'prospective learning' which relates to 'dynamic preferences'
	1. prospective vs retrospective learning??
6. it does feel like predicting behavior of user you are engaging with would be drastically economically beneficial for modern labs. are they not doing reward modeling on simply predicting what the user says? like the conversation version of echo? they must no? try it as [[Experiments]]?
7. i defined an interaction model to jakub as a model that optimizes for a dynamic reward that is clear when hit but hard to codify before hand. so in some sense the model learns a function approximation of the reward model of its user in some ways superior to the user (it cannot necessarily produce ground truth but it may predict superhuman-ly)
8. conceptually, it makes sense to prove that you can find a local or global minimum on a static loss function because trying to find a local or global minimum on a dynamic loss function (which theoretically is what continual learning is)
9. Corrigibility might be a overlapping set of interaction
10. https://arxiv.org/pdf/2307.15217 https://cassidylaidlaw.github.io/minecraft-building-assistance-game/ assistance games from head of AI safety at deepmind
11. probably need an intuitive understading of POMDPs
12. slow response times make it much much harder for "interaction" to occur
13. https://arxiv.org/pdf/2606.03237 another paper as a call for cooperation paradigms during training. considered solipsistic. referenced in "from agi to asi"
14. agi to asi paper called it 'interactive learning'