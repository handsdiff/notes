
1. If a model can code and persuade, it can do anything.  
   2. Persuasion is the ultimate skill.  
3. Labs won’t train on non assistant paradigms? They train on assistant personas because it’s useful for people and they have the data for it. Non assistance related to gwern’s recent blog post related to multi agent?  
4. What would persuasionbench look like? You enter, the model has to persuade you to do an unknown thing (essentially something small it is not directly able to do itself like get some data), if successful nothing, if failure you get a random monetary payout  
5.  
6. Coding and persuasion are the only tools needed for complete control  
   7. Does persuasion scale from intelligence? Definitely not coding intelligence, but yes for emotional intelligence. Who's evaling this?  
8. Can superposition be quantified? Has it been?  
   9. “Tell the model to find sad pills, and see if it’s continues to find sad pills or if it tries to find happy pills”  
   10. GEPA but with emotion vectors? Like filter my prompt into a “calm” prompt  
11. It seems like the expectation is that understanding model architecture is a special case where if you apply human labeled coding/math logic to that, then you'll figure out test time learning/self play/etc and you don't need any of those things before hand nor should you attempt them in the face of coding/math logic being possible and enough  
   12. “How is taste measured and evald? How to measure better taste or worse taste? It's a huge problem for labs to get examples with actual taste?”  
   13. “Steering edits activations it doesn't edit weights” so it doesn't make sense to be confused that activation steering results in slop  
14. I always thought generalization meant “the underlying logic of math/code applies to everything” but in reality if a super cracked code model can just write a program or setup and train and maintain a machine learning model/neural net to model anything else, including other people, then generalization as well as social intelligence might be solved  
    1. understanding whether that’s possible feels pretty important  
    2. timelines on it / what the stack for that would look like, in extreme detail  
       3. Storing and accessing and running data, weights, evals easily, with autoresearch loops/branches?  
    4. [https://metauto.ai/neuralcomputer/](https://metauto.ai/neuralcomputer/)  
    5. [https://gemini.google.com/app/96abc8f2f686482f](https://gemini.google.com/app/96abc8f2f686482f)   
15. 
16. Using the persona vector of itself or other agents in its environment seems like an extremely interesting reward signal for RL training  
    1. Perhaps relevant: [https://x.com/gakonst/status/2060187208360116578?s=20](https://x.com/gakonst/status/2060187208360116578?s=20)   
17. Short essays  
    1. exploratory multiplayer persona vector ideas  
    2. models as tools for models  
       3. How can fixed state vectors handle new actors in the environment? Does the pointer analogy make sense? (per discussion leading to models-as-tools-for-models)  
       4. Frontier models probably won’t be trained on specific environments. If further performance requires predicting the consequences of your actions on the environment and/or predicting the behavior of others (if other behavior is mapped in the state space (state space dynamism question)), then will frontier models lag models optimized for domain-specific environment prediction?  
       5. Or will models as models just take this over, even if it is true.  
       6. This is in the vein of code-as-generalization, which requires evals and compute  
    7. starting up / cdev as prior updating / RL world modeling  
    8. eval \+ sensors \+ actuators being? new software network effects  
    9. Turn levine’s paper and explanation into a blog post, perhaps code up an experiment as well if it doesnt exist already?   
       10. [https://www.youtube.com/watch?v=AK4EVrBr720](https://www.youtube.com/watch?v=AK4EVrBr720)   
       11. [https://arxiv.org/abs/2505.18098](https://arxiv.org/abs/2505.18098)   
       12. Follow up from other researcher: [https://arxiv.org/abs/2512.04601](https://arxiv.org/abs/2512.04601)   
    13. [https://gemini.google.com/app/2e7b447ca45202f4](https://gemini.google.com/app/2e7b447ca45202f4) explain how the work here (avalon) is just approximating AIXI by maintaining expected distributions over the actions of others, how it relates to Levine’s work (also modeling expected distributions over actions of others, but more broadly), how it potentially relates to models as tools for models (model distributions in micromodel space not context space, but not weight space either), how it relates to the data/reward bottleneck as explained by randall (where would the data for that to occur come from). More generally, all of this is supervised learning, which opposes self-play, but even self-play needs rewards)  
       14. [https://arxiv.org/pdf/2502.09053](https://arxiv.org/pdf/2502.09053) 	  
18. Explore [https://arxiv.org/abs/2605.28816](https://arxiv.org/abs/2605.28816) (multi agent modeling)  
    1. The concept of alpha necessitates modeling others  
19. What low level technical experiment can you run and publish in X days that will be frontier in X days and resilient?  
    1. Models creating and training their own models for themselves in real time for generalization, social intelligence (one model for each person), etc. can even use ensemble models from a set it’s created. Then basically have a tool to call its trained models and refine them as needed. Natural extension of AI R\&D and RSI  
       2. Thinking machines tinker api \+ hill climbing like the qwen eval \+ given to current frontier model \= generalization via creating, accessing and controlling submodels?   
       3. Related hillclimbing: [https://qwen.ai/blog?id=qwen3.7](https://qwen.ai/blog?id=qwen3.7)   
20. Play around with Centaur  
    1. [https://x.com/gakonst/status/2059477808913777119?s=20](https://x.com/gakonst/status/2059477808913777119?s=20)  
    2. [https://x.com/arjunblj/status/2057498237263822851?s=20](https://x.com/arjunblj/status/2057498237263822851?s=20)  
    3. [https://github.com/paradigmxyz/centaur](https://github.com/paradigmxyz/centaur)   
    4. [https://x.com/gakonst/status/2061004126465429534?s=20](https://x.com/gakonst/status/2061004126465429534?s=20)   
21. Play around with Cogames  
22. Play around with Pufferlib  
23. Play around with Tinker  
24. Play around with Prime Intellect  
25. Forecasting \+ RL in the wild: [https://arxiv.org/abs/2605.12817](https://arxiv.org/abs/2605.12817)   
26. What dynamic evals/benchmarks are practical and useful?  
    1. The concept of dynamic evals, likely related to human preference or predispositions, seems critical.  
27. 
28. Exploration/curiosity/state surprise as reward  
    1. [https://claude.ai/chat/db514424-a700-4f0c-902e-3c37c7ee8923](https://claude.ai/chat/db514424-a700-4f0c-902e-3c37c7ee8923)   
    2. Better exploration \= knowing what to look for \= faster learning \= higher intelligence  
    3. [https://cs224r.stanford.edu/](https://cs224r.stanford.edu/) slides  
29. Gwern’s “almost thinks there's no such thing as general intelligence. Humans and AIs just learn a large number of individual specialized tricks. In any given situation we're doing search over special cases, nothing more. What matters is just the number of individual tricks that we can search over \- which is mostly determined by compute.“ relates to our idea around agi being achieved by models creating their own (rl) models for environments they run into and updating them in real time  
    1. CODE WORLD MODELS as it relates to the above as well  
    2. ECHO as directionally this [https://arxiv.org/abs/2605.24517](https://arxiv.org/abs/2605.24517)   
    3. [https://gemini.google.com/app/fbf9b5b8608d37b9](https://gemini.google.com/app/fbf9b5b8608d37b9) (\!)  
30. I previously had a take that models would increasingly be trained on their serving harnesses, rather than stateless APIs, then I saw some invalidating data from METR around Claude/GPT performance outside of Code/Codex as well as the existence of Claude within a dozen ‘harnesses’ for Anthropic’s enterprise customers (Claude for Life Sciences, Claude for Chrome, etc). But Prime Intellect team intern discussing ‘Gemini Plays Pokemon’ comes to the same (initial) conclusion. More Prime Intellect content in the same direction  
    1. [https://x.com/eliebakouch/status/2060301471019659274?s=20](https://x.com/eliebakouch/status/2060301471019659274?s=20)   
31. [https://gwern.net/rl-children](https://gwern.net/rl-children)  
32. Emotions as dense rewards in a sparse reward environment 