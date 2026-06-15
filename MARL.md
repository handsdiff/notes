1. Summarizing the rl children blog would illuminate similarities and differences in thinking that would help with the framing of the issues with the multiplayer agents and why MARL is interesting. Basically the agents couldn’t represent me, which gwern dives into, and I was focused on marl as a way to address the representation issue [[Interaction]]
	1. interaction + MARL relates to collaboration vs competition
	2. Gwern agrees that all input going in as a single context makes multiplayer impossible since there’s no privileged or differing response type
2. MARL seems downstream of the difference between emotional/social and logical intelligence  
3. [\[2605.17698\] Agent Bazaar: Enabling Economic Alignment in Multi-Agent Marketplaces](https://arxiv.org/abs/2605.17698)  
    1. [https://gemini.google.com/app/4b02be329d898e77](https://gemini.google.com/app/4b02be329d898e77) this relates to the drone racing (great visceral example of MARL benefits [Superhuman Safe and Agile Racing through Multi-Agent Reinforcement Learning](https://www.youtube.com/watch?v=TSwtrHQgjD8)) since it shows that individual optimization actively degrades collaborative performance and you need joint training to perform well in multiplayer environments. Reminds me of how humans need to be socialized otherwise they’re unaligned.  
        1. “True economic alignment requires fine-tuning agents on full interaction trajectories so they naturally recognize that destroying the marketplace for short-term local gain is an existential loss.”  
    2. Intelligence is orthogonal to economic alignment is another take, which makes sense, since i can be intelligent and self optimize if im dying tomorrow? If people dont have kids then they have shorter time horizons  
    3. It might be necessary to jointly train frontier LLMs in MARL settings, specifically with joint action spaces and rewards, to avoid misalignment that stems from antisocial conditioning similar to human children.  
        1. The economic impact of alignment is underappreciated \- roon  
    4. Is Mythos MARL’d? It’s the most aligned model. Randall says probably not  
    5. Similar work [https://arxiv.org/pdf/2507.15815](https://arxiv.org/pdf/2507.15815)   
    6. You need to train in environments where you can predict the actions of others for alignment. Otherwise you get non social kids, which is so bad  
    7. Train of thought here was economically aligned agents in agent bazaar and drone racing and intelligence not being social ability and needing to love things / understand them / get some positive emotion from keeping around  
4. [https://arxiv.org/pdf/2603.15563](https://arxiv.org/pdf/2603.15563)  
5. [https://arxiv.org/pdf/2605.09998](https://arxiv.org/pdf/2605.09998)   
6. [\[2503.04094\] PokéChamp: an Expert-level Minimax Language Agent](https://arxiv.org/abs/2503.04094)   
7. **Probably need a working taxonomy of multiplayer environments to more quickly reason about. Assistance games?**  
8. What type of game is pokemon showdown and why was it chosen and well regarded as an RL environment?  
9. [https://arxiv.org/pdf/2606.02373](https://arxiv.org/pdf/2606.02373) search harness, relevant to maintaining memory as a requirement of MARL  
10. MARL relates to continual learning because you *must* continuously update *something* to even maintain performance  
11. What are the properties of stochastic games vs multi agent games?  
12. How are state spaces and action spaces actually composed in these environments?  
13. Agents like Hermes get 10x better when they host html as response? In the vein of generated UI?  
14. Thinking machines real time inference still important to understand. Does it mesh at all with models as models?  
15. Things like game dev bench make more sense since it’s testing model ability to generate, which in the vein of models to models is how they’ll achieve everything?  
16. How can LLMs perform self play in non verifiable domains?  
17. Intuitive posterior distribution explanation [https://gemini.google.com/app/6c8535eee8c99212](https://gemini.google.com/app/6c8535eee8c99212)   
18. You win games/benchmarks if you have the most compute, during training or inference. This implies that intelligence per output token is the real measure of algorithmic progress, while intelligence per dollar is the measure of hardware progress, when independently calculated from each other  
19. **Why does test time scaling work? For LLMs or for other algos. How is test time scaling related to continual learning? Why does updating weights during inference result in instability but updating weights during training does not, if the data distributions are the same? The answer of I.i.d isn’t really satisfying since self play isn’t I.i.d. If you just overfit to the last thing you saw during training, how is that different? If you clip gradient updates during training, why can that not occur during inference? Is it simply a hardware constraint since updating weights is more compute and memory intensive and harder to scale to millions of users?**  
    1. [**https://cs224r.stanford.edu/slides/10\_cs224r\_rl\_for\_llms\_reasoning\_2026.pdf**](https://cs224r.stanford.edu/slides/10_cs224r_rl_for_llms_reasoning_2026.pdf)   
20. [https://www.k-a.in/rl-algo.html](https://www.k-a.in/rl-algo.html)   
21. The term to look up and learn is “multi agent deep reinforcement learning”, not just multi agent or deep.  
22. Why did alpha go not need to model lee’s behavior specifically? Since there existed a policy that was optimal against all players? What games or environment have this property and which don’t? Is it because he has a fixed policy vs an adaptive policy?  
23. How are messaging protocols allowed on planes but internet isn’t? Do agents thru messaging protocols without internet unlock something?  
24. Chi says to a student asking whether they can define the state space as the history of actions that you can but then your state space is infinite which “you don’t want”  
25. Orion 100B decentralized training  
26. Innovators dilemma as exploitation vs exploration   
27. Tesla autopilot doesn’t need MARL since it just has state transition dynamics? When is one needed over the other?
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

67. Guy who did RL at OpenAI for 3 years thinks the frontier is simply better, more realistic reward modeling (reward modeling is the training version of evals, basically what are you pointing it at)  
68. Randall take is that this long form thinking is encouraged in RL rather than just sampling the environment (what does this command do? rather than let me reason thru python garbage collection?), which is suboptimal  
69. He says that interrupting the model is taking it out of training distribution. Backed up by the mythos model whitepaper where interruption causes it to perform worse  
70. Including user turns in training data seems to be an important belief that he has  
    1. Kind of relates to models as tools for models since training that would require user turns for the base model to learn how to update its user specific understanding model?  
71. He also mentioned transfer amongst RL tasks as being often negative. Definitely not positive consistently.  
72. His overall worry is local incentives of labs causing us to squander intelligence, rather than broad misalignment issues. Labs will do the easiest ROI to sell investors on, which is test time compute scaling on RSI.   
73. RL at that stage was simply seeing when coding/math tasks failed, properly assigning rewards to what people wanted, do that in a loop. very simple.
74. Follow up with him  
    1. Thoughts on thinking machines interaction model?  
    2. Seth karten says “agent action-\>env looped is the only paradigm. the real new paradigm is realtime envs with agent actions”  
75. Another take was that a larger risk than civilization level misalignment is local incentives of companies making AI falling suspect to classic big tech slop issues, focusing on benchmaxxing rather than real value  
76. What data strongly assists LLM ability to engage in game theoretical situations like Mafia, Avalon, etc? Thereby boosting EQ by learning theory of mind with engaged parties  
77. Which RL tasks have negative transfer? 
78. what is social intelligence, in an aloof sense? seemingly, predicting the internal state and/or actions of others, conditioned on your action or the actions of others or the environment
79. social animals developed agency since reward signals were based on peer approval? how does societal us vs them relate to the issues with my writing around cooperative messaging vs competitive winning in marl?
80. Can LLMs reason through imperfect information games? Can they just code up a solution? Is the ability to out of the box code up a solution what should be benchmarked? Is the ability to natively reason about it the benchmark instead? 

