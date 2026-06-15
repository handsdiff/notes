 1. How does Thinking Machines’ interaction models impact inference architecture? Consumer use cases?  
    1. [https://thinkingmachines.ai/blog/interaction-models/](https://thinkingmachines.ai/blog/interaction-models/)  
    2. [https://thinkingmachines.ai/news/interactivity-research-grants/](https://thinkingmachines.ai/news/interactivity-research-grants/)  
2. do interaction models solve theory of mind for the given interactor? what does the data for interaction models look like?
3. need interaction because too dynamic and complex to statically hardcode preferences
4. https://arxiv.org/abs/1606.03137 CIRL https://gemini.google.com/app/bb201e6013c0056c
5. what is the relation between interaction and MARL? how does that relation explain karten's take that "realtime envs with agent actions" is the new paradigm? seemingly relates to 'prospective learning' which relates to 'dynamic preferences'
6. it does feel like predicting behavior of user you are engaging with would be drastically economically beneficial for modern labs. are they not doing reward modeling on simply predicting what the user says? like the conversation version of echo? they must no? try it as [[Experiments]]?
7. i defined an interaction model to jakub as a model that optimizes for a dynamic reward that is clear when hit but hard to codify before hand. so in some sense the model learns a function approximation of the reward model of its user in some ways superior to the user (it cannot necessarily produce ground truth but it may predict superhuman-ly)