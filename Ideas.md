1. cursor for obsidian that recommends backlinks? ^8c0496
2. ECHO trained a model to predict the output of terminal commands and it improved performance on some benchmark.
	1. the google paper says the model should predict itself as well. could we train the agent to predict its own actions in this context? what would that even mean/look like? isn't it already predicting next token?
	2. could we apply echo but to the chat history of a specific user (myself)? what would that look like? how would you benchmark?
	3. was cursor already predicting the user?
	4. does doing this for enterprises need to happen before doing it for individual users since higher willingness to pay? but what does 'doing this for enterprises' really mean?
3. If a model can code and persuade, it can do anything.  
    1. Persuasion is the ultimate skill.  
4. Labs won’t train on non assistant paradigms? They train on assistant personas because it’s useful for people and they have the data for it. Non assistance related to gwern’s recent blog post related to multi agent?  
5. **What would persuasionbench look like?** You enter, the model has to persuade you to do an unknown thing (essentially something small it is not directly able to do itself like get some data), if successful nothing, if failure you get a random monetary payout  
6. Coding and persuasion are the only tools needed for complete control  
    1. Does persuasion scale from intelligence? Definitely not coding intelligence, but yes for emotional intelligence. Who's evaling this?  
7. Can superposition be quantified? Has it been?  
    1. “Tell the model to find sad pills, and see if it’s continues to find sad pills or if it tries to find happy pills”  
    2. GEPA but with emotion vectors? Like filter my prompt into a “calm” prompt  
8. It seems like the expectation is that understanding model architecture is a special case where if you apply human labeled coding/math logic to that, then you'll figure out test time learning/self play/etc and you don't need any of those things before hand nor should you attempt them in the face of coding/math logic being possible and enough  
    1. “How is taste measured and evald? How to measure better taste or worse taste? It's a huge problem for labs to get examples with actual taste?”  
    2. “Steering edits activations it doesn't edit weights” so it doesn't make sense to be confused that activation steering results in slop  
9. I always thought generalization meant “the underlying logic of math/code applies to everything” but in reality if a super cracked code model can just write a program or setup and train and maintain a machine learning model/neural net to model anything else, including other people, then generalization as well as social intelligence might be solved  
    1. understanding whether that’s possible feels pretty important  
    2. timelines on it / what the stack for that would look like, in extreme detail  
        1. Storing and accessing and running data, weights, evals easily, with autoresearch loops/branches?  
    3. [https://metauto.ai/neuralcomputer/](https://metauto.ai/neuralcomputer/)  
    4. [https://gemini.google.com/app/96abc8f2f686482f](https://gemini.google.com/app/96abc8f2f686482f)   
10. Using the persona vector of itself or other agents in its environment seems like an extremely interesting reward signal for RL training  
    1. Perhaps relevant: [https://x.com/gakonst/status/2060187208360116578?s=20](https://x.com/gakonst/status/2060187208360116578?s=20)   
11. Exploration/curiosity/state surprise as reward  
    1. [https://claude.ai/chat/db514424-a700-4f0c-902e-3c37c7ee8923](https://claude.ai/chat/db514424-a700-4f0c-902e-3c37c7ee8923)   
    2. Better exploration \= knowing what to look for \= faster learning \= higher intelligence  
    3. [https://cs224r.stanford.edu/](https://cs224r.stanford.edu/) slides  
12. What dynamic evals/benchmarks are practical and useful?  
    1. The concept of dynamic evals, likely related to human preference or predispositions, seems critical.   ^7afff1
13. Emotions as dense rewards in a sparse reward environment 
14. does GEPA as a CIRL implementation work? to learn the preferred prompt over time? [[Interaction#^2bff57]]
15. prompt inform an agent to predict the response from its environments (whether its a tool call, user input, etc) not just its turns, and see if it performs better? basically ECHO but for more than just terminal commands? what is ECHO's actual architecture, base model, quirks, and pitfalls? 
	1. are these just inference time rollouts?