1. Multi agent RL frontiers testing git
   2. MARL seems downstream of the difference between emotional/social and logical intelligence  
   3. [https://www.youtube.com/watch?v=t1Z2UJJMEak\&list=PLYXvCE1En13epbogBmgafC\_Yyyk9oQogl\&index=5](https://www.youtube.com/watch?v=t1Z2UJJMEak&list=PLYXvCE1En13epbogBmgafC_Yyyk9oQogl&index=5)   
   4. [\[2605.17698\] Agent Bazaar: Enabling Economic Alignment in Multi-Agent Marketplaces](https://arxiv.org/abs/2605.17698)   
      1. [https://gemini.google.com/app/4b02be329d898e77](https://gemini.google.com/app/4b02be329d898e77) this relates to the drone racing (great visceral example of MARL benefits [Superhuman Safe and Agile Racing through Multi-Agent Reinforcement Learning](https://www.youtube.com/watch?v=TSwtrHQgjD8)) since it shows that individual optimization actively degrades collaborative performance and you need joint training to perform well in multiplayer environments. Reminds me of how humans need to be socialized otherwise they’re unaligned.  
         1. “True economic alignment requires fine-tuning agents on full interaction trajectories so they naturally recognize that destroying the marketplace for short-term local gain is an existential loss.”  
      2. Intelligence is orthogonal to economic alignment is another take, which makes sense, since i can be intelligent and self optimize if im dying tomorrow? If people dont have kids then they have shorter time horizons  
      3. It might be necessary to jointly train frontier LLMs in MARL settings, specifically with joint action spaces and rewards, to avoid misalignment that stems from antisocial conditioning similar to human children.  
         1. The economic impact of alignment is underappreciated \- roon  
      4. Is Mythos MARL’d? It’s the most aligned model. Randall says probably not  
      5. Similar work [https://arxiv.org/pdf/2507.15815](https://arxiv.org/pdf/2507.15815)   
      6. You need to train in environments where you can predict the actions of others for alignment. Otherwise you get non social kids, which is so bad  
      7. Train of thought here was economically aligned agents in agent bazaar and drone racing and intelligence not being social ability and needing to love things / understand them / get some positive emotion from keeping around  
   5. [https://arxiv.org/pdf/2603.15563](https://arxiv.org/pdf/2603.15563)  
   6. [https://arxiv.org/pdf/2605.09998](https://arxiv.org/pdf/2605.09998)   
   7. [\[2503.04094\] PokéChamp: an Expert-level Minimax Language Agent](https://arxiv.org/abs/2503.04094)   
   8. **Probably need a working taxonomy of multiplayer environments to more quickly reason about. Assistance games?**  
   9. What type of game is pokemon showdown and why was it chosen and well regarded as an RL environment?  
   10. [https://arxiv.org/pdf/2606.02373](https://arxiv.org/pdf/2606.02373) search harness, relevant to maintaining memory as a requirement of MARL  
   11. MARL relates to continual learning because you *must* continuously update *something* to even maintain performance  
   12. What are the properties of stochastic games vs multi agent games?  
   13. How are state spaces and action spaces actually composed in these environments?  
   14. Agents like Hermes get 10x better when they host html as response? In the vein of generated UI?  
   15. Thinking machines real time inference still important to understand. Does it mesh at all with models as models?  
   16. Things like game dev bench make more sense since it’s testing model ability to generate, which in the vein of models to models is how they’ll achieve everything?  
   17. How can LLMs perform self play in non verifiable domains?  
   18. Intuitive posterior distribution explanation [https://gemini.google.com/app/6c8535eee8c99212](https://gemini.google.com/app/6c8535eee8c99212)   
   19. You win games/benchmarks if you have the most compute, during training or inference. This implies that intelligence per output token is the real measure of algorithmic progress, while intelligence per dollar is the measure of hardware progress, when independently calculated from each other  
   20. **Why does test time scaling work? For LLMs or for other algos. How is test time scaling related to continual learning? Why does updating weights during inference result in instability but updating weights during training does not, if the data distributions are the same? The answer of I.i.d isn’t really satisfying since self play isn’t I.i.d. If you just overfit to the last thing you saw during training, how is that different? If you clip gradient updates during training, why can that not occur during inference? Is it simply a hardware constraint since updating weights is more compute and memory intensive and harder to scale to millions of users?**  
       1. [**https://cs224r.stanford.edu/slides/10\_cs224r\_rl\_for\_llms\_reasoning\_2026.pdf**](https://cs224r.stanford.edu/slides/10_cs224r_rl_for_llms_reasoning_2026.pdf)   
   21. [https://www.k-a.in/rl-algo.html](https://www.k-a.in/rl-algo.html)   
   22. The term to look up and learn is “multi agent deep reinforcement learning”, not just multi agent or deep.  
   23. Why did alpha go not need to model lee’s behavior specifically? Since there existed a policy that was optimal against all players? What games or environment have this property and which don’t? Is it because he has a fixed policy vs an adaptive policy?  
   24. How are messaging protocols allowed on planes but internet isn’t? Do agents thru messaging protocols without internet unlock something?  
   25. Chi says to a student asking whether they can define the state space as the history of actions that you can but then your state space is infinite which “you don’t want”  
   26. Orion 100B decentralized training  
   27. Innovators dilemma as exploitation vs exploration   
   28. Maybe multiagent as I previously thought doesn’t make sense because if they’re better than you, you lose, and if they’re worse than you, you can just model them as yourself. At least in verifiable zero sum settings? Seems to be consistent with Levine’s use of more general human behavior prediction rather than user specific behavior prediction  
   29. So if anything you’re perhaps predicting their observable state but not their “logic”  
   30. Is what I’m searching for a best policy when multiple agents are adaptive? If so, then whoever is adaptive at the fastest rate wins?  
   31. Microsoft AI technical report thread  
   32. Epistemics as cdev vs pdev bc pdev implies not updating priors which implies robust priors. Priors and posterior relates to exploration vs exploitation as well. Investing lower risk lower reward way to express a prior, building higher risk higher reward way to express a prior  
   33. **Alpha go also used test time scaling during its PUCT search. Does test time scaling relate to exploration?**  
   34. V learning and optimistic nash VI are for zero sum and general sum tabular markov (stochastic) games. There are decentralized v learning algorithms that achieve better sample complexity [https://arxiv.org/abs/2110.14555](https://arxiv.org/abs/2110.14555)   
   35. Interesting that zaharia also claimed that sample complexity was the bottleneck, not cost or intelligence  
   36. Optimism during exploration, pessimism during exploitation  
   37. It’s probably the case that large labs will not build harnesses for niche markets. Harnesses are anything that productizes intelligence. Intelligence is useless if not productized. Productizing intelligence means giving it necessary sensors and actuators to do a task, and proving so with evals.  
   38. Use thinking machines interaction model with nvidia minecraft voyager agent to be able to handle zombies?  
   39. [https://arxiv.org/pdf/2603.12145](https://arxiv.org/pdf/2603.12145)   
   40. [https://www.youtube.com/watch?v=oLkqZ2wBf44](https://www.youtube.com/watch?v=oLkqZ2wBf44)   
   41. [https://gemini.google.com/app/9939846c0235d67a](https://gemini.google.com/app/9939846c0235d67a)  
   42. [https://arxiv.org/pdf/2103.01955](https://arxiv.org/pdf/2103.01955)  
   43. [https://arxiv.org/abs/1706.02275](https://arxiv.org/abs/1706.02275)   
   44. [https://proceedings.iclr.cc/paper\_files/paper/2025/file/40eff1670d6b08bb1bda48b0c5f30110-Paper-Conference.pdf](https://proceedings.iclr.cc/paper_files/paper/2025/file/40eff1670d6b08bb1bda48b0c5f30110-Paper-Conference.pdf)  
   45. [https://proceedings.neurips.cc/paper\_files/paper/2022/file/743459dae9b2c5d2904e5432d5298128-Paper-Conference.pdf](https://proceedings.neurips.cc/paper_files/paper/2022/file/743459dae9b2c5d2904e5432d5298128-Paper-Conference.pdf)  
   46. [https://arxiv.org/pdf/2508.03613](https://arxiv.org/pdf/2508.03613)  
   47. [https://arxiv.org/pdf/2508.02948v1](https://arxiv.org/pdf/2508.02948v1)   
   48. [Hierarchical MARL](https://download.ssrn.com/2026/2/7/6192598.pdf?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEIP%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJIMEYCIQDxlwecMq0yBBk4QMWUBZuFOo7fQcj63L1YFiEMYze7cAIhAMXd0xIcjnsIMo4D%2FUjPUqDswxY94NF4xlKG4qYOUWvwKr0FCEwQBBoMMzA4NDc1MzAxMjU3IgyF1G3hR23hh07R%2FJcqmgWfJfcDR7wsHonQL6Kq%2B3AouKaxAt41A9v6vwhzHDNAfAWZ9uWzSx2rzJPhVNsP3hfTl%2Bo8xAYwQZdl51dv18tToqEMHZN%2BNEwL%2F9d8EvbzO74ucdmfiXE1AA0JjEVXP1wayQ6a5cFY5pP9eQHtnZ7%2FoCmeySAFo5mORMvYE%2B8y3tSH2VBSy075Wa1bSa6yEefSljH9n24d6oyNrIR%2BxGdNB5cq1UdK8WYK3iq44b4uCVe%2Bb56j1uyEkauHzqf8N5qomczH%2BJ%2FKw%2FWAdtk%2FUxrMApnfAfSrbOApRc6tlx8B5dYBkK%2BJ6k9%2BT0W0pUetGpEBmdPrgYwKyxnP%2F%2B0Ux3JThLgJoaC1u6%2FxVgrSkzUWa3ZAdPRfmgA0JDqfL7VpV00kDvSuDZMWyMKiDWSDAE9gon6%2FvEDOggGEiFiNXR46atm0bR4rj17ensdJoyTYN7jAeuqJvUfTjWlox8k%2B%2F%2F74Zc1bdj5CmYHCeRW15ifeGLPMJiIOe%2BbpMlLveUL2pI%2FWGfPTghqosTKH2FtN7naKDMSWmtulrCQokT22gbZagD2sABBpzSDyirQodmIEL6wq%2FC0VhZlevmOVUdfx49hW8eC05cibKxuN9h2VqMGDozzezt8Imui%2BfB77TYZLDnFcvmct6vw8NEL%2FJiSnJHp6mb0lK%2BFramR%2F5Zsnq1AWPjQRiF0c7Sce%2BlQsfAFxppb85RaCsScQhUOiMTdGHhidH0rwWQM7Cn70CT6XRZE9hq0ZWIyt3JV8hUnpizS0mm2v2G6eVbKClbaE1qkgXMuZM8viZam60HO5adPOmYULpBgTlEEMwrVQq6yH9TCshBXxNyo2OTlnYgUVdc67F9W%2BBgtdo2odeT4UHd6hXQIlm0A9dQzC9NXWH28wqc6D0QY6sAErgxsSkqQa2gzmNcdls8z7vFY6r0Lrvsa9RgXWDNju1zgJ0m%2B7%2BOf71sdi5Q32GxUcJKohF%2B%2BL0xEgzx2FV2HIfjkgMpDmJ7PCZVI%2BFAM5KxEONhzqdykZAf0Leyqu2MWMWAeNAilN8X8hPh0%2FRWOLTs52WatK9Lm76IFEvRFb0wrW9AEVyLfqSQ6DaHCt5srvCDT4r4Rwn50SqHa%2Fh0IWfpj1h8FCkGfLIL%2FX7To9VQ%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20260604T034128Z&X-Amz-SignedHeaders=host&X-Amz-Expires=300&X-Amz-Credential=ASIAUPUUPRWEXYUMVIAZ%2F20260604%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=6bbb84c20d0ca7cc991081a385e84181e77fe79f88dd844547994d1eef311920&abstractId=6192598)  
   49. [https://arxiv.org/abs/1703.06182](https://arxiv.org/abs/1703.06182)   
   50. [https://gemini.google.com/app/ae3d30b177a5e890](https://gemini.google.com/app/ae3d30b177a5e890)   
   51. [https://arxiv.org/abs/1906.06725](https://arxiv.org/abs/1906.06725)   
   52. [https://www.youtube.com/watch?v=AK4EVrBr720](https://www.youtube.com/watch?v=AK4EVrBr720)   
   53. [https://arxiv.org/abs/2505.18098](https://arxiv.org/abs/2505.18098)   
   54. [https://gemini.google.com/app/d05293325b6791f8](https://gemini.google.com/app/d05293325b6791f8)   
   55. Modeling other players is so so crucial. Involves world model/planning, unsure to what extent though. Levine’s paper is the most interesting i’ve seen on this in practice  
       1. [https://www.youtube.com/watch?v=TSwtrHQgjD8](https://www.youtube.com/watch?v=TSwtrHQgjD8)   
   56. Shared training is different from modeling others that may not be trained concurrently. Mostly care about modeling humans. The extent to which games approximate that is useful, and understanding joint training may be useful (like IPPO), but not the actual area of interest  
       1. [https://gemini.google.com/app/f8593d849a4ace01](https://gemini.google.com/app/f8593d849a4ace01)   
   57. Understand alphastar. Was it successful or not? [https://www.reddit.com/r/starcraft/comments/rjucss/was\_alphastar\_really\_a\_success/](https://www.reddit.com/r/starcraft/comments/rjucss/was_alphastar_really_a_success/) has it been expanded on or not?  
   58. Super cool [https://rpg.ifi.uzh.ch/marl/](https://rpg.ifi.uzh.ch/marl/)   
   59. [https://www.youtube.com/watch?v=rrtxyZ4Vnv8](https://www.youtube.com/watch?v=rrtxyZ4Vnv8)  
   60. This is actually simple multi agent experiment [https://www.strangeloopcanon.com/p/why-smart-planners-lose-to-simple](https://www.strangeloopcanon.com/p/why-smart-planners-lose-to-simple)   
   61. [https://arxiv.org/abs/2508.03613](https://arxiv.org/abs/2508.03613)   
   62. [https://goedelcodeprover.github.io/](https://goedelcodeprover.github.io/)   
       1. Goedel prover best understood as work that makes non-verifiable complex coding tasks verifiable, thus making it *extremely* valuable?  
   63. [https://jxihong.github.io/joeyhong/](https://jxihong.github.io/joeyhong/) researcher to watch  
   64. [https://gemini.google.com/app/c045af221dfcce6a](https://gemini.google.com/app/c045af221dfcce6a) downstream of levine work   
       1. [https://arxiv.org/pdf/2512.04601](https://arxiv.org/pdf/2512.04601) also downstream from lead researcher joey hong  
   65. [https://proceedings.neurips.cc/paper\_files/paper/2017/file/7fe1f8abaad094e0b5cb1b01d712f708-Paper.pdf](https://proceedings.neurips.cc/paper_files/paper/2017/file/7fe1f8abaad094e0b5cb1b01d712f708-Paper.pdf) solving subgames as solving imperfect information games, neurips best paper 2017  
   66. [https://gemini.google.com/app/576e572a98450c5f](https://gemini.google.com/app/576e572a98450c5f) relation between google embedded agents AIXI paper and levine work on modeling scenarios for better persuasion \+ avalon, as a parallel track to the in context learning done for Avalon in the other paper  
       1. [https://www.lesswrong.com/posts/AJ7qddr5imhhN2jHz/embedded-universal-predictive-intelligence](https://www.lesswrong.com/posts/AJ7qddr5imhhN2jHz/embedded-universal-predictive-intelligence)   
67. Understanding language modeling from scratch  
   68. [https://www.youtube.com/playlist?list=PLoROMvodv4rMqXOcazWaTUHhq-yembLCV](https://www.youtube.com/playlist?list=PLoROMvodv4rMqXOcazWaTUHhq-yembLCV) \+ [https://cs336.stanford.edu/](https://cs336.stanford.edu/)   
   69. How does Thinking Machines’ interaction models impact inference architecture? Consumer use cases?  
      1. [https://thinkingmachines.ai/blog/interaction-models/](https://thinkingmachines.ai/blog/interaction-models/)  
      2. [https://thinkingmachines.ai/news/interactivity-research-grants/](https://thinkingmachines.ai/news/interactivity-research-grants/)  
   70. [https://pub.sakana.ai/diffusionblocks/](https://pub.sakana.ai/diffusionblocks/)   
   71. [https://arxiv.org/pdf/2606.02437](https://arxiv.org/pdf/2606.02437) PEFT, multi lora, similar to models as models  
72. What UX to best track all historical learnings (RSI here, compute-as-bottleneck, subposition as scaling, etc) and open questions \+ share in real time to team? Ideas below  
   73. Shared open tabs  
   74. Shared claude/gemini conversations  
   75. –  
   76. Gitwatch  
   77. Programmatic for Background Intelligence with own sudo VM and internet search  
   78. Shared/Public  
   79. –  
   80. Write down ideas quickly on phone or laptop  
   81. Save links for future reading  
   82. All notes \+ browser history \+ AI chats to be referenced by an AI (for now just chat interface, later proactive consolidation/research/suggestion)  
   83. –  
   84. obsidian \+ git \+ quartz \+ cloudflare pages is good but not intelligent  
       1. Jakub stopped using obsidian over native notes because cognitive friction to index something before its written down is higher  
       2. Notes get disorganized but that’s more of a background loss  
   85. Feel like i cant delete anything because it wont be tracked properly  
   86. Would be nice if i didnt have to copy paste and i could just press a button to flag a visited site as ‘important’

—

1. [Problem Ideas](https://docs.google.com/spreadsheets/d/1ZaIFzWJuoBd3H7IRt1aaxykKebsF55Wkhw1AzQtPTcg/edit?gid=0#gid=0)  
2. Extremely based gemini thread on AIXI, instrumental convergence (“play rock or i kill your family”), and safety/alignment: [https://gemini.google.com/app/33869e6590f71ffa](https://gemini.google.com/app/33869e6590f71ffa)   
3. If a model can code and persuade, it can do anything.  
   4. Persuasion is the ultimate skill.  
5. Labs won’t train on non assistant paradigms. They train on assistant personas because it’s useful for people and they have the data for it. Non assistance related to gwern’s recent blog post related to multi agent?  
6. What would persuasionbench look like? You enter, the model has to persuade you to do an unknown thing (essentially something small it is not directly able to do itself like get some data), if successful nothing, if failure you get a random monetary payout  
7. Guy who did RL at OpenAI for 3 years thinks the frontier is simply better, more realistic reward modeling (reward modeling is the training version of evals, basically what are you pointing it at)  
   8. Randall take is that this long form thinking is encouraged in RL rather than just sampling the environment (what does this command do? rather than let me reason thru python garbage collection?), which is suboptimal  
   9. He says that interrupting the model is taking it out of training distribution. Backed up by the mythos model whitepaper where interruption causes it to perform worse  
   10. Including user turns in training data seems to be an important belief that he has  
      1. Kind of relates to models as tools for models since training that would require user turns for the base model to learn how to update its user specific understanding model?  
   11. He also mentioned transfer amongst RL tasks as being often negative. Definitely not positive consistently.  
   12. His overall worry is local incentives of labs causing us to squander intelligence, rather than broad misalignment issues. Labs will do the easiest ROI to sell investors on, which is test time compute scaling on RSI.   
   13. RL at that stage was simply   
   14. Follow up with him  
      1. Thoughts on thinking machines interaction model?  
      2. Seth karten says “agent action-\>env looped is the only paradigm. the real new paradigm is realtime envs with agent actions”  
   15. Another take was that a larger risk than civilization level misalignment is local incentives of companies making AI falling suspect to classic big tech slop issues, focusing on benchmaxxing rather than real value  
   16. What data strongly assists LLM ability to engage in game theoretical situations like Mafia, Avalon, etc? Thereby boosting EQ by learning theory of mind with engaged parties  
   17. Which RL tasks have negative transfer?  
18. Coding and persuasion are the only tools needed for complete control  
   19. Does persuasion scale from intelligence? Definitely not coding intelligence, but yes for emotional intelligence. Who's evaling this?  
20. Can superposition be quantified? Has it been?  
   21. “Tell the model to find sad pills, and see if it’s continues to find sad pills or if it tries to find happy pills”  
   22. GEPA but with emotion vectors? Like filter my prompt into a “calm” prompt  
23. It seems like the expectation is that understanding model architecture is a special case where if you apply human labeled coding/math logic to that, then you'll figure out test time learning/self play/etc and you don't need any of those things before hand nor should you attempt them in the face of coding/math logic being possible and enough  
   24. “How is taste measured and evald? How to measure better taste or worse taste? It's a huge problem for labs to get examples with actual taste?”  
   25. “Steering edits activations it doesn't edit weights” so it doesn't make sense to be confused that activation steering results in slop  
26. I always thought generalization meant “the underlying logic of math/code applies to everything” but in reality if a super cracked code model can just write a program or setup and train and maintain a machine learning model/neural net to model anything else, including other people, then generalization as well as social intelligence might be solved  
    1. understanding whether that’s possible feels pretty important  
    2. timelines on it / what the stack for that would look like, in extreme detail  
       3. Storing and accessing and running data, weights, evals easily, with autoresearch loops/branches?  
    4. [https://metauto.ai/neuralcomputer/](https://metauto.ai/neuralcomputer/)  
    5. [https://gemini.google.com/app/96abc8f2f686482f](https://gemini.google.com/app/96abc8f2f686482f)   
27. Thoughts  
    1. Natural language autoencoders might be an early form of plurality. If we can see the internal states of the smartest model using weaker models, deception is much much harder.  
    2. [https://gemini.google.com/app/33869e6590f71ffa](https://gemini.google.com/app/33869e6590f71ffa)  
       3. Reminds me of disagree and commit since infinite regress on a turn by turn basis leads to an unstable policy, so you need to commit to a strategy before hand and execute on it.  
       4. Also seems to be related to meta RL since you set up multiple strategies each with a set of actions in practice  
       5. Reward hacking as just mechanism design  
       6. Will theory of mind just emerge from self play? Maybe not when applied to coding/math, but applied to what? Relates to randall’s reward models thesis since the question is what do you reward? Related to benchmarking as the bottleneck, even harnesses with sensors/actuators are downstream of what the goal even is  
    7. How was alphago trained, or any adversarial self play, if theory of mind is recursive??  
    8. Campbell described the issue with trading as godel loops/halting problem. I framed it as world modeling. You basically need to predict how your choice of action impacts the actions of others in the environment. Basically the argument is that if agent 1 is predicting agent 2, and agent 2 has an accurate prediction of agent 1, then the algorithm for what to do never ends if agent 1 is trying to win. But what if agent 1 is trying to collaborate? Or what if agent 2’s prediction is inaccurate? For the latter question, it feels like the recursion would degrade over time until agent 1’s actual action differs from agent 2’s prediction, which would end the recursion.  
       9. Embedded agency paper by google is mechanism design on which algorithm/strategy to pursue rather than which actions to take?  
       10. Multi agent / embodied agent is a forcing function for which strategies to pursue rather than which actions to pursue, but can’t choose strategies unless you already can learn strategies well, which themselves are a set of actions? Kind of relates to meta RL lecture from chelsea finn  
    11. Is turn based \-\> time based similar to how multi agent RL necessitates an update to the state/action space? What exactly is that update? Does it make sense? The similarity is that you need to operate in a non stationary environment rather than a stationary environment. Presumably the time based paradigm helps. But how is their training data actually structured?  
       12. [https://gemini.google.com/app/33869e6590f71ffa](https://gemini.google.com/app/33869e6590f71ffa)   
    13. What does ‘multi agent’ actually mean? What are the actual questions to ask in the context of Slate?   
       14. The VC negotiation example is the best. The way I explained it to Eli felt satisfying. Negotiations could take two orders of magnitude less time if agents were doing it. But my agent won’t properly represent my best interests. If 80% of its context is the VC arguing for a lower valuation, it will probably say “You’re right”. Prompt engineering could help, but it can’t be trusted to maintain information boundaries or properly negotiate.  
    15. Would a tool use dynamics model improve agentic behavior? Is this best plugged in as a model that the base LLM can call?  
    16. What is preventing everyone from having their own weights?  
    17. Continual learning as implemented by Trajectory feels like overfitting. Does overfitting solve a problem for people? In environments that are not very dynamic but specialized enough for there to be large room for improvement from base models. Comes back to whether fine tuning ever makes sense when frontier models exist. The space of frontier models operating poorly (OOD environments) \+ dynamic environments would need to be explored. Also relates to harness+model ‘cotraining’. Do environments exist where frontier open weight models that are able to be SDPO'd are cost effective at scale to serve to clients AND offer a 10x performance/cost/speed improvement for customers when compared to frontier models, which have their own trajectory of improvement?  
    18. Enterprises spend a ton of money on tokens. Any wedge there makes sense from a business perspective. Unlikely anyone will upfront give you their data to prove you can do better from a token perspective, in what cases will they? Also need to prove you can outscale or at least keep pace with frontier model improvement.  
    19. Slate feels like it came way easier/more naturally as an idea than current idea exploration. Why is that?  
    20. Chrome extension that tracks all API calls that go to LLMs, and implements tracing for your chats. Paid version hosts all the data for you. Extension to use the data to \_\_\_\_.  
    21. Alphago used PUCT (UCB variant), but its shown that posterior sampling \> UCB on multi armed bandit, and posterior sampling approximates AIXI. Could you use posterior sampling on another agent, rather than a bandit, to determine which actions they will take given a state? Could you extend this to multiple agents?  
    22. Sutton states discovery is variation \+ evaluation \+ selective retention. Argues modern LLMs only have the first. Aligns with AIXI.  
    23. You can bootstrap an experiment by collaborating with the tools/platforms used in the experiment.  
    24. its interesting that if you first order try to learn something random, you'll minimize error by predicting the mean, and your error will always be high. but if you second order try to learn something random, 5 models will agree on predicting the mean, which youll have learned, and you can focus on states where 5 learned models differ in their predictions, indicating actual uncertainty. Also relates to “starting up / cdev as prior updating / RL world modeling”, where single people get caught in first order noise, and ensembles can differentiate between higher error noise vs high error signal. Also overfitting and needing to keep, say, 9:1 ratio when updating online feels similar to avoiding chasing things that are hot as a startup failure mode [https://gemini.google.com/app/c8127a6a633097eb](https://gemini.google.com/app/c8127a6a633097eb)   
    25. Seth Karten and Dajinar Hafner and Joey Hong are researchers to watch. [https://jxihong.github.io/joeyhong/](https://jxihong.github.io/joeyhong/)   
    26. Granola but for everything I watch \+ read \+ conversate with AI, with proactive, relevant search. Startup internalizes proactivity costs, so incentivized to optimize for outcomes.  
    27. If prompt space actually works, such as GEPA or PNLC, and memory is required for MARL, then maybe memory systems like Honcho actually make a ton of sense? I wrote up the post but did not want to give honcho full creds because clearly the concept of having some general world model and then giving in local context is different from tracking local context, even if the local context is about many players. But is PNLC just tracking human emotional states and responses in text space. But is that good enough?  
    28. Open question at the end of my memory post around continual learning and weight update efficacy  
    29. If anthropic is doing a ton of work on persona vectors and their causality, then they probably will be able to reason through the GEPA results (iterating on prompts to help or hurt performance) and then use that to improve the base model? But whats the track there exactly?  
    30. What is the compressed relationship between GEPA, which is iterating in prompt space, RLM, claude’s dynamic workflows, PNLC, etc?  
    31. Many valuable environments necessitate joint training, joint training is crucial for long term alignment and safety, the best joint training algorithm is V learning, which has the best sample efficiency when decentralized, therefore decentralized training will lead to frontier intelligence in the future. (obviously not rigorous CoT)  
    32. Intuitive explanation of test time scaling? Rich sutton says the two methods that arbitrarily scale with computation, and thus are most effective, are search and learning. He also says true superhuman intelligence is a function of discovery, which is variation, evaluation, and selective retention. If you consider chain of thought reasoning as building a block of output that can then be fed back into the model to produce another, progressing block of reasoning, then that implies there has been progress in reducing bias per block, and the goal is to reduce bias per block over time, and Noam Brown’s claim that intelligence per output token is the actual measure in that framework makes sense since it measures the performance of a single block, which theoretically could be scaled if given more compute, but there must be something to be said about why these per block superior systems arent overall the best if thats the case unless the team is specifically withholding compute. To be clear, it makes sense that train time scaling laws work due to subposition of different ‘components’ being able to spread out, and thus noise each other less, leading to clearer signal. I think another point here is that people with more neurons, and more connections between neurons, tend to be more intelligent. Is there some relation to this notion of subposition in test time scaling? And how does test time scaling between things like PUCT in alphago relate to LLMs? If PUCT is optimal exploration/exploitation, is CoT reasoning also exploration/exploitation?  
        1. There are other primitive examples like LLMs as monkeys where just putting a ton together improved performance. This is essentially test time compute. In some sense this is exploration/exploitation in real time to improve performance.  
           2. [https://docs.ag2.ai/latest/docs/blog/2025/04/16/Reasoning/\#the-messy-reality-of-human-cognition](https://docs.ag2.ai/latest/docs/blog/2025/04/16/Reasoning/#the-messy-reality-of-human-cognition) “The process is iterative and often feels more like navigating a maze than walking a straight line.”  
        3. Noam seems to indicate that test time scaling was initially primarily a function of cost.  
        4. It seems like initial reasoning models came from GRPO. Is GRPO separate from RL?  
        5. Noam seems to indicate that a bottleneck they’re currently attempting to solve is parallelizing CoT, since it’s inherently serial so it’s slow. First order parallelization of CoT implies the same or worse intelligence per token but better intelligence per time, which only works if hardware supports it. Maybe feynman is about that? Or is rubin already about that? Interesting that he mentions serial as a problem but then focuses on compute/time? Those arent the same thing…  
    33. You want alignment since it implies long term game playing, which is good because a superintelligence playing short term games would defect/exploit.  
    34. Is mythos an indefinite optimist, definite optimist, indefinite pessimist, or definite pessimist?  
        1. Jakub posits that a lot of alignment work attempts to move from definite to indefinite, with a goal of indefinite optimism, with a fear of indefinite pessimism.  
    35. Post facto, the ability to learn a value function, or any function, given a ton of environmental data is pretty uninspiring/standard. Like yeah, you give it a ton of data and it maps the data well. Is that useful? For specific domains where the environment its trained on maps well, yeah. How it handles the edges is a point of contention. How does this apply to LLMs though?  
    36. Are solving intelligence and solving coding/math the same thing?  
    37. Philosophers consider reasoning an exploration, and bounded rationality considers the use of heuristics in the exploration space of reasoning, and heuristics are learned through experience, which is basically value functions/q functions.  
        1. “In contemporary philosophy of cognitive science, reasoning is increasingly compared to foraging behavior”  
    38. Bayesian reasoning seems to approximate AIXI. Maintain the possible states and explore/exploit accordingly  
        1. “use "Posterior Sampling" when dealing with complex Markov Decision Processes (MDPs) or Deep Reinforcement Learning, where you sample an entire world model or value function from a posterior.”  
    39. Pretraining still having juice aligns with the notion of subposition as the reason for empirical scaling laws  
    40. Where does exploration occur in AIXI?  
    41. Are ZKPs the new patents? (edited)   
    42. Embedded agency is related to world model is related to godel loops and the halting problem. You need to model your impact on the world, specifically how others react to your actions, to properly act on it (edited)   
    43. Is continual learning related to the chi Jin goedel take where it can relearn the tools but not well how to reuse them?  
    44. Since continual learning implies that people want the model to learn when to use learned heuristics, but goedel prover seems to show that knowing when to use tools doesn't come back  
    45. Jane street needs to train DSLs (5000 data points per tick just on Google) since vanilla LLMs will def be slower and worse on it, reminds me on sudoku  
    46. Is predicting the mean in a Gaussian distribution related to compression issues in JEPA?  
    47. Page 161 describes decision theory frameworks and multi agent setting implications [https://www-cdn.anthropic.com/d00db56fa754a1b115b6dd7cb2e3c342ee809620.pdf](https://www-cdn.anthropic.com/d00db56fa754a1b115b6dd7cb2e3c342ee809620.pdf)   
    48. How would you TRAIN a proactive model rather than one you have to prompt?  
    49. Synchronous interaction alignment \> asynchronous control alignment  
    50. open source training  
    51. inference economics  
    52. gap between super intelligence and distribution would be paid for (expanding triangle visualization)  
    53. question context when environment sampling shows different and they directly conflict?  
28. Using the persona vector of itself or other agents in its environment seems like an extremely interesting reward signal for RL training  
    1. Perhaps relevant: [https://x.com/gakonst/status/2060187208360116578?s=20](https://x.com/gakonst/status/2060187208360116578?s=20)   
29. Short essays  
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
30. Explore [https://arxiv.org/abs/2605.28816](https://arxiv.org/abs/2605.28816) (multi agent modeling)  
    1. The concept of alpha necessitates modeling others  
31. What low level technical experiment can you run and publish in X days that will be frontier in X days and resilient?  
    1. Models creating and training their own models for themselves in real time for generalization, social intelligence (one model for each person), etc. can even use ensemble models from a set it’s created. Then basically have a tool to call its trained models and refine them as needed. Natural extension of AI R\&D and RSI  
       2. Thinking machines tinker api \+ hill climbing like the qwen eval \+ given to current frontier model \= generalization via creating, accessing and controlling submodels?   
       3. Related hillclimbing: [https://qwen.ai/blog?id=qwen3.7](https://qwen.ai/blog?id=qwen3.7)   
32. Play around with Centaur  
    1. [https://x.com/gakonst/status/2059477808913777119?s=20](https://x.com/gakonst/status/2059477808913777119?s=20)  
    2. [https://x.com/arjunblj/status/2057498237263822851?s=20](https://x.com/arjunblj/status/2057498237263822851?s=20)  
    3. [https://github.com/paradigmxyz/centaur](https://github.com/paradigmxyz/centaur)   
    4. [https://x.com/gakonst/status/2061004126465429534?s=20](https://x.com/gakonst/status/2061004126465429534?s=20)   
33. Play around with Cogames  
34. Play around with Pufferlib  
35. Play around with Tinker  
36. Play around with Prime Intellect  
37. Forecasting \+ RL in the wild: [https://arxiv.org/abs/2605.12817](https://arxiv.org/abs/2605.12817)   
38. What dynamic evals/benchmarks are practical and useful?  
    1. The concept of dynamic evals, likely related to human preference or predispositions, seems critical.  
39. AIXI (basics [https://claude.ai/chat/e79274a9-0ccb-463e-a473-87d3a665f0d0](https://claude.ai/chat/e79274a9-0ccb-463e-a473-87d3a665f0d0))   
    1. ![][image1]![][image2]  
    2. [https://arxiv.org/pdf/2208.11173](https://arxiv.org/pdf/2208.11173) ai research plan by sutton  
    3. Model free universal ai recommended by cole [https://arxiv.org/pdf/2602.23242](https://arxiv.org/pdf/2602.23242) \+ [https://claude.ai/chat/60135b24-afa2-44a0-80e9-8cf235258cb3](https://claude.ai/chat/60135b24-afa2-44a0-80e9-8cf235258cb3)   
    4. [https://ai.meta.com/research/publications/are-scaling-up-agent-environments-and-evaluations/](https://ai.meta.com/research/publications/are-scaling-up-agent-environments-and-evaluations/)   
    5. Cole paper [https://arxiv.org/pdf/2508.16245](https://arxiv.org/pdf/2508.16245)  
    6. Google embedded agents paper [https://arxiv.org/pdf/2511.22226](https://arxiv.org/pdf/2511.22226)   
    7. Replace the Turing program that explains past observations with a deep RL dynamics model in the AIXI framework?  
    8. Reflective oracles? (per the google paper)  
40. Exploration/curiosity/state surprise as reward  
    1. [https://claude.ai/chat/db514424-a700-4f0c-902e-3c37c7ee8923](https://claude.ai/chat/db514424-a700-4f0c-902e-3c37c7ee8923)   
    2. Better exploration \= knowing what to look for \= faster learning \= higher intelligence  
    3. [https://cs224r.stanford.edu/](https://cs224r.stanford.edu/) slides  
41. Gwern’s “almost thinks there's no such thing as general intelligence. Humans and AIs just learn a large number of individual specialized tricks. In any given situation we're doing search over special cases, nothing more. What matters is just the number of individual tricks that we can search over \- which is mostly determined by compute.“ relates to our idea around agi being achieved by models creating their own (rl) models for environments they run into and updating them in real time  
    1. CODE WORLD MODELS as it relates to the above as well  
    2. ECHO as directionally this [https://arxiv.org/abs/2605.24517](https://arxiv.org/abs/2605.24517)   
    3. [https://gemini.google.com/app/fbf9b5b8608d37b9](https://gemini.google.com/app/fbf9b5b8608d37b9) (\!)  
42. I previously had a take that models would increasingly be trained on their serving harnesses, rather than stateless APIs, then I saw some invalidating data from METR around Claude/GPT performance outside of Code/Codex as well as the existence of Claude within a dozen ‘harnesses’ for Anthropic’s enterprise customers (Claude for Life Sciences, Claude for Chrome, etc). But Prime Intellect team intern discussing ‘Gemini Plays Pokemon’ comes to the same (initial) conclusion. More Prime Intellect content in the same direction  
    1. [https://x.com/eliebakouch/status/2060301471019659274?s=20](https://x.com/eliebakouch/status/2060301471019659274?s=20)   
43. [https://gwern.net/rl-children](https://gwern.net/rl-children)  
44. Emotions as dense rewards in a sparse reward environment  
45. Alignment  
    1. [https://alignment.anthropic.com/2026/automated-w2s-researcher/](https://alignment.anthropic.com/2026/automated-w2s-researcher/)   
    2. [https://x.com/lossfunk/status/2057451983988994250?s=20](https://x.com/lossfunk/status/2057451983988994250?s=20)  
    3. [https://andonlabs.com/blog/opus-4-8-vending-bench](https://andonlabs.com/blog/opus-4-8-vending-bench)   
46. Todos  
    1. [https://x.com/JoshPurtell/status/2060848970709254181?s=20](https://x.com/JoshPurtell/status/2060848970709254181?s=20)   
    2. [https://x.com/gakonst/status/2061172100459569246?s=20](https://x.com/gakonst/status/2061172100459569246?s=20)   
    3. [https://x.com/GenAI\_is\_real/status/2060542315186540630?s=20](https://x.com/GenAI_is_real/status/2060542315186540630?s=20)  
    4. [https://x.com/Memetic\_Theory/status/2060090976040055057?s=20](https://x.com/Memetic_Theory/status/2060090976040055057?s=20)  
    5. [https://x.com/gakonst/status/2060187208360116578?s=20](https://x.com/gakonst/status/2060187208360116578?s=20)  
    6. [https://x.com/eliebakouch/status/2060301471019659274?s=20](https://x.com/eliebakouch/status/2060301471019659274?s=20)  
    7. [https://arxiv.org/pdf/1712.01275](https://arxiv.org/pdf/1712.01275)  
    8. [https://www.nature.com/articles/s41586-024-07711-7](https://www.nature.com/articles/s41586-024-07711-7)  
    9. [https://readwise-assets.s3.amazonaws.com/media/wisereads/articles/welcome-to-the-era-of-experien/The\_Era\_of\_Experience\_Paper\_pCPD9bW.pdf](https://readwise-assets.s3.amazonaws.com/media/wisereads/articles/welcome-to-the-era-of-experien/The_Era_of_Experience_Paper_pCPD9bW.pdf)  
    10. [https://arxiv.org/abs/1901.07510](https://arxiv.org/abs/1901.07510)  
    11. [https://arxiv.org/abs/1910.02140](https://arxiv.org/abs/1910.02140)  
    12. [https://arxiv.org/pdf/2207.03029](https://arxiv.org/pdf/2207.03029) DDQN \+ CQL in prod at LinkedIn  
    13. [https://proceedings.neurips.cc/paper/2017/hash/68a9750337a418a86fe06c1991a1d64c-Abstract.html](https://proceedings.neurips.cc/paper/2017/hash/68a9750337a418a86fe06c1991a1d64c-Abstract.html)   
    14. [https://macrocosmosai.substack.com/p/orion-100b-distributed-pretraining](https://macrocosmosai.substack.com/p/orion-100b-distributed-pretraining)   
    15. [https://x.com/JoshPurtell/status/2062296512277713210?s=20](https://x.com/JoshPurtell/status/2062296512277713210?s=20)  
    16. [https://x.com/gakonst/status/2062116487708512355?s=20](https://x.com/gakonst/status/2062116487708512355?s=20)  
    17. [https://x.com/badlogicgames/status/2061941296932004175?s=20](https://x.com/badlogicgames/status/2061941296932004175?s=20) as a stepping stone to models as tools for models? Dynamic workflows  
        1. [https://x.com/a1zhang/status/2060071701879066626](https://x.com/a1zhang/status/2060071701879066626)   
    18. [https://x.com/mustafasuleyman/status/2061880164498428188?s=20](https://x.com/mustafasuleyman/status/2061880164498428188?s=20)   
    19. [https://x.com/eliebakouch/status/2061965825037254947?s=20](https://x.com/eliebakouch/status/2061965825037254947?s=20)   
    20. [https://x.com/perplexity\_ai/status/2061506359326384319?s=20](https://x.com/perplexity_ai/status/2061506359326384319?s=20)   
    21. [https://variant.fund/articles/value-open-harnesses/](https://variant.fund/articles/value-open-harnesses/)   
    22. [https://x.com/kalomaze/status/2062261215116874223?s=20](https://x.com/kalomaze/status/2062261215116874223?s=20)  
    23. [https://x.com/dwarkesh\_sp/status/2062353335529935114?s=20](https://x.com/dwarkesh_sp/status/2062353335529935114?s=20)  
    24. [https://x.com/NVIDIAAI/status/2062521325076299981?s=20](https://x.com/NVIDIAAI/status/2062521325076299981?s=20)   
    25. [https://x.com/eglyman/status/2062526944265048285?s=20](https://x.com/eglyman/status/2062526944265048285?s=20)   
    26. [https://www.anthropic.com/institute/recursive-self-improvement](https://www.anthropic.com/institute/recursive-self-improvement)   
    27. [https://gemini.google.com/app/ecf40bd8459d2a5e](https://gemini.google.com/app/ecf40bd8459d2a5e)   
    28. [https://papers.ssrn.com/sol3/papers.cfm?abstract\_id=6833760](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=6833760)   
    29. [https://x.com/srush\_nlp/status/2062359839783657816?s=20](https://x.com/srush_nlp/status/2062359839783657816?s=20)   
    30. [https://newsletter.semianalysis.com/p/to-boldly-go-the-case-for-space-datacenters?\_gl=1\*1gj8d24\*\_ga\*MTY2ODQ5MDQwMy4xNzc4MDI2NTY1\*\_ga\_FKWNM9FBZ3\*czE3ODA1OTc3MzEkbzYkZzAkdDE3ODA1OTc3MzEkajYwJGwwJGgxNDkzMjExMDk](https://newsletter.semianalysis.com/p/to-boldly-go-the-case-for-space-datacenters?_gl=1*1gj8d24*_ga*MTY2ODQ5MDQwMy4xNzc4MDI2NTY1*_ga_FKWNM9FBZ3*czE3ODA1OTc3MzEkbzYkZzAkdDE3ODA1OTc3MzEkajYwJGwwJGgxNDkzMjExMDk).   
    31. GEPA does not seem like it would work, how is this not overfitting / run into the same issues with a bunch of skills that end up being poorly used? I think chi jin’s goedel prover v2 runs into the issue but maybe thats specifically related to weight updating. Regardless, updating in ‘prompt space’ seems interesting to be able to improve frontier models instead of fine tuning. Also the labs will probably serve frontier models more cheaply than you can on rented GPUs  
    32. [https://docs.massgen.ai/en/latest/](https://docs.massgen.ai/en/latest/)   
    33. [https://substack.com/@gwern/note/c-270310673](https://substack.com/@gwern/note/c-270310673)   
    34. [What remains scarce after AGI? – Alex Imas and Phil Trammell](https://www.youtube.com/watch?v=Jj-kBHzUohs)   
    35. [https://x.com/PrimeIntellect/status/2062724179296952412?s=20](https://x.com/PrimeIntellect/status/2062724179296952412?s=20)  
    36. [https://x.com/abhijaymrana/status/2062817082518258060?s=20](https://x.com/abhijaymrana/status/2062817082518258060?s=20)  
    37. [https://x.com/tenobrus/status/2062729311233454363?s=20](https://x.com/tenobrus/status/2062729311233454363?s=20)  
    38. [https://x.com/geetkhosla/status/2062507967010730426?s=20](https://x.com/geetkhosla/status/2062507967010730426?s=20)  
    39. [https://x.com/JoshPurtell/status/2062605789454385338?s=20](https://x.com/JoshPurtell/status/2062605789454385338?s=20)  
    40. [https://x.com/gakonst/status/2062116487708512355?s=20](https://x.com/gakonst/status/2062116487708512355?s=20)  
    41. [https://substack.com/home/post/p-197387291](https://substack.com/home/post/p-197387291)   
        1. Feeling like this post makes arguments that could be usefully extended by well analyzing the nvidia tech report and microsoft tech report recently and coming to novel conclusions about scaling complexity  
        2. This also seems to indicate that the karpathy hire on pretraining is due to the fact that pretraining was paused rather than saturated, but incoming compute will continue to deliver major scaling gains  
    42. [https://www.youtube.com/watch?v=3Yxmjf57sco](https://www.youtube.com/watch?v=3Yxmjf57sco)   
    43. [https://x.com/SakanaAILabs/status/2063742801725252010?s=20](https://x.com/SakanaAILabs/status/2063742801725252010?s=20)   
    44. Steven Byrnes less wrong writing  
    45. [https://vkrakovna.wordpress.com](https://vkrakovna.wordpress.com) specification gaming  
    46. [https://www.campbellramble.ai](https://www.campbellramble.ai)  
    47. Goodfire AI research  
    48. [https://x.com/dwarkesh\_sp/status/2063335334566621297?s=20](https://x.com/dwarkesh_sp/status/2063335334566621297?s=20)  
    49. [https://arxiv.org/abs/2606.02800](https://arxiv.org/abs/2606.02800)  
    50. [https://x.com/chelseabfinn/status/2063433906985005510?s=20](https://x.com/chelseabfinn/status/2063433906985005510?s=20) CHELSEA  
    51. [https://x.com/lateinteraction/status/2061242049622671746?s=20](https://x.com/lateinteraction/status/2061242049622671746?s=20)  
    52. [https://x.com/kalomaze/status/2063122579028889983?s=20](https://x.com/kalomaze/status/2063122579028889983?s=20)  
    53. [https://x.com/geetkhosla/status/2062507967010730426?s=20](https://x.com/geetkhosla/status/2062507967010730426?s=20)  
    54. [https://x.com/JoshPurtell/status/2062605789454385338?s=20](https://x.com/JoshPurtell/status/2062605789454385338?s=20)  
    55. [https://x.com/NoahZiems/status/2062311582580023607?s=20](https://x.com/NoahZiems/status/2062311582580023607?s=20)  
    56. [https://x.com/tenobrus/status/2062729311233454363?s=20](https://x.com/tenobrus/status/2062729311233454363?s=20)   
        1. im not seeing people talk about it much so just a heads up: dynamic workflows in claude code are actually insanely fucking useful and powerful. clearly the right / sane way to do "agent orchestration". very much worth trying  
    57. [https://www.dwarkesh.com/p/the-sample-efficiency-black-hole](https://www.dwarkesh.com/p/the-sample-efficiency-black-hole)   
    58. [https://x.com/eliebakouch/status/2063849409515843635?s=20](https://x.com/eliebakouch/status/2063849409515843635?s=20)   
    59. [https://www.lesswrong.com/posts/JT3qCYDimskcBdiEr/the-hard-core-of-alignment-is-robustifying-rl](https://www.lesswrong.com/posts/JT3qCYDimskcBdiEr/the-hard-core-of-alignment-is-robustifying-rl)   
    60. [https://x.com/teortaxesTex/status/2064264430980886774?s=20](https://x.com/teortaxesTex/status/2064264430980886774?s=20)   
    61. [https://github.com/NVIDIA-NeMo/Nemotron/tree/main](https://github.com/NVIDIA-NeMo/Nemotron/tree/main)   
    62. [https://x.com/svlevine/status/2064556220644839855?s=20](https://x.com/svlevine/status/2064556220644839855?s=20)   
    63. [https://x.com/teortaxesTex/status/2064605846546301124?s=20](https://x.com/teortaxesTex/status/2064605846546301124?s=20)   
    64. [https://x.com/teortaxesTex/status/2064550527979917631?s=20](https://x.com/teortaxesTex/status/2064550527979917631?s=20)   
    65. [https://x.com/svlevine/status/2064556217289318528?s=20](https://x.com/svlevine/status/2064556217289318528?s=20)   
    66. [https://x.com/dwarkesh\_sp/status/2064422596620472560?s=20](https://x.com/dwarkesh_sp/status/2064422596620472560?s=20)   
    67. [https://x.com/emollick/status/2064395281903346013?s=20](https://x.com/emollick/status/2064395281903346013?s=20)   
    68. [https://x.com/polynoamial/status/2064210146558136827?s=20](https://x.com/polynoamial/status/2064210146558136827?s=20)   
    69. [https://x.com/eliebakouch/status/2064086258687578348?s=20](https://x.com/eliebakouch/status/2064086258687578348?s=20)   
    70. [https://x.com/eliebakouch/status/2064736476995146014?s=20](https://x.com/eliebakouch/status/2064736476995146014?s=20)   
    71. [https://www.a16z.news/p/institutional-ai-vs-individual-ai](https://www.a16z.news/p/institutional-ai-vs-individual-ai) coordination as first pillar here very similar to my multi agent take. The signal part feels like what im trying to do with the future version of these notes and my listed problems. Unprompted is also a novel thought ive been exploring, similar to proactivity per the randall takes.   
    72. Is this guy super cracked out? How does his embodiment take relate to current work and/or multi agent work and/or AIXI? [https://scott.garrabrant.com/](https://scott.garrabrant.com/)   
    73. Magnetic mirror descent [https://arxiv.org/abs/2206.05825](https://arxiv.org/abs/2206.05825) 