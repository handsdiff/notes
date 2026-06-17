
1. are RL rollouts equivalent to 'predicting the environment and predicting your own actions'? i dont see what the difference is. at least for single model rollouts not self play
2. described to jakub as MARL -> epistemic integrity / prompt injection resistance / embedded agency AND/OR CIRL / interaction models / assistance games, with RSI asterisk looming over everything. is that comprehensive? 
	1. his take was that epistemics is often grounded in human feeling/intuition which relates it to the latter point
2. i think its robust to believe that RSI will not be able to improve epistemic integrity over an existing out of the box product, if it existed, since the potential weight updating required to self improve would be too costly even for a superintelligence? 
3. https://arxiv.org/abs/2601.20802 how does SDPO relate to interactive / continuous inverse learning? seems relevant
4. epistemic integrity feels necessary for actually improving priors + discovering truth which feels necessary for collective intelligence to be value creative over singleton intelligence. otherwise as sutton puts it youre missing the selective retention part of variation and evaluation. although not sure why its not just variation and selection
5. is china's open source culture an example of 'commodifying your complement'? i.e. they commodify algorithms because they likely win on compute longer term. by that analog anthropic should want to commodify compute but they can't really.
6. if its written by AI, expect only AI to read it. if only AI is reading it, why write it without AI? feels pretty easy to tell the difference between something made for agents (AEO) and something made for humans (non-average voice)
7. arena.ai is similar to LM arena except for frontend design. what was the GTM there? dynamic, real use evals still feel crucial. even better if they proxy things people would pay for
8. https://x.com/JoshPurtell/status/2066967185818345674?s=20
9. https://x.com/SemiAnalysis_/status/2066941079920791760?s=20
10. https://www.forethought.org/research/will-ai-r-and-d-automation-cause-a-software-intelligence-explosion#bringing-it-all-together
11. https://arxiv.org/abs/2506.14863 intelligence explosion estimates around ai population growth
12. it doesnt seem like obsidian will build what i want [[PDEV]] since their core value prop involves privacy, whereas i want public by default + cloud AI analyzing everything/always on
13. its easier to share progress, and therefore make progress, if investment is permissionless. relates to RPGF, but that seems a bit too idealistic.
14. how is epistemic integrity benchmarked in LLMs, if at all? the success of collective intelligence and non singleton outcomes is downstream of this.
	1. games like avalon are a subset of epistemic integrity
	2. "(e) Group alignment: How can AGI groups be effectively steered (either explicitly, or implicitly via, e.g., mechanism design for markets)? How can they be hardened and self-correct against epistemic hijacking and the spread of falsehoods, hallucinations & self-delusions? (f) How to ensure epistemic resilience and recoverability in asymmetric-intelligence collectives (e.g., mixed human-ASI collectives)?" from agi to asi paper
	3. seems like the transition from taking context at face value vs taking context as an update into a prior is the difference, but what does that look like in practice? for example if a data point comes in and the probability of that data point is low, we would need to update our priors but not completely. and there is a difference between environmental sampling and collaborative opinion (lossy). trust forms when collaborative opinion updates the world model/prior towards environmental truth over time. trust is individualized reputation.
15. agency arises when reward signal is peer approval in humans? how to set a dynamic reward signal of peer approval in LLMs? relates to CIRL. perhaps relates to (non)assistant training paradigm
16. probably need to go through these (recent papers by ECHO author) https://arxiv.org/search/cs?searchtype=author&query=Shrivastava,+V
17. https://www.mdpi.com/1099-4300/28/6/596 genewein and hutter explore the extent to which LLMs approximate AIXI and what the specific challenges are https://gemini.google.com/app/e5723b735ee76668
	1. seemingly a gap between append only agent turn logs as some vague 'memory' solution vs use as a formal interleaved dataset where the agent can learn causal loops, which opens up multi agent systems which opens up collective intelligence. again, ECHO seems to be the first version of this
	2. prospective learning vs retrospective learning?
	3. but when agents do next token prediction that's considered an 'action', no? whats the actual difference
18. if LLM generalization is on a spectrum, then viable products of the future are downstream of being correct about the extent to which generalization occurs
19. current understanding todos in browser: multi agent cooperating thru ICL, CIRL, AGI to ASI, MUPI/RUI, gwern GA, POMDP lectures
	1. https://gemini.google.com/app/eef345df5e5d14eb
		1. ^ how do epistemic utility measurements [[Google Pi Team#^b203be]] relate to the framing of the 'incentive to ask' as the unsolved core
	2. "Wrapping a mathematical POMDP solver around a 70B+ parameter Large Language Model is computationally impossible with current techniques." ??
	3. "not by maintaining a dynamic Bayesian belief distribution over a hidden vector $\theta$, but by frozen reward modeling or Direct Preference Optimization. The empirical simplicity and scalability of RLHF bypassed the need to compute complex, game-theoretic joint policies." ok but we're past that now
	4. is the context of an LLM functionally a bayesian belief state in a POMDP? and the problem perhaps with that framework is that it does not maintain multiple 'contexts' with their own probabilities of being right/useful? and this is externalized to memory solutions like Hindsight and benchmarked with stuff like BEAM? but [[Google Pi Team#^b203be]] describes differences between epistemic agents and what BEAM measures, which essentially comes down to dynamism imo. relates back to dynamic evals seemingly, but personalized perhaps [[Ideas#^7afff1]]
	5. CIRL also seems to be related to the 'proactive' framework Randall kept mentioning. [[Experiments#^605490]], at least the part where it interjects to learn. do existing LLMs and memory handle this already?
20. Polymarket vs Kalshi seems similar to protocol vs platform
21. https://x.com/teortaxesTex/status/2065962301195178212?s=20
22. https://x.com/JoshPurtell/status/2065989651752464486?s=20
23. https://x.com/kalomaze/status/2065498921443438928?s=20
24. [https://x.com/badlogicgames/status/2061941296932004175?s=20](https://x.com/badlogicgames/status/2061941296932004175?s=20) as a stepping stone to models as tools for models? Dynamic workflows  
    1. [https://x.com/a1zhang/status/2060071701879066626](https://x.com/a1zhang/status/2060071701879066626)   
25. [https://x.com/mustafasuleyman/status/2061880164498428188?s=20](https://x.com/mustafasuleyman/status/2061880164498428188?s=20)   
26. [https://x.com/eliebakouch/status/2061965825037254947?s=20](https://x.com/eliebakouch/status/2061965825037254947?s=20)   
27. [https://x.com/perplexity\_ai/status/2061506359326384319?s=20](https://x.com/perplexity_ai/status/2061506359326384319?s=20)   
28. [https://variant.fund/articles/value-open-harnesses/](https://variant.fund/articles/value-open-harnesses/)   
29. [https://x.com/kalomaze/status/2062261215116874223?s=20](https://x.com/kalomaze/status/2062261215116874223?s=20)  
30. [https://x.com/dwarkesh\_sp/status/2062353335529935114?s=20](https://x.com/dwarkesh_sp/status/2062353335529935114?s=20)  
31. [https://x.com/NVIDIAAI/status/2062521325076299981?s=20](https://x.com/NVIDIAAI/status/2062521325076299981?s=20)   
32. [https://x.com/eglyman/status/2062526944265048285?s=20](https://x.com/eglyman/status/2062526944265048285?s=20)   
33. [https://gemini.google.com/app/ecf40bd8459d2a5e](https://gemini.google.com/app/ecf40bd8459d2a5e)   
34. [https://papers.ssrn.com/sol3/papers.cfm?abstract\_id=6833760](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=6833760)   
35. [https://x.com/srush\_nlp/status/2062359839783657816?s=20](https://x.com/srush_nlp/status/2062359839783657816?s=20)   
36. [https://newsletter.semianalysis.com/p/to-boldly-go-the-case-for-space-datacenters?\_gl=1\*1gj8d24\*\_ga\*MTY2ODQ5MDQwMy4xNzc4MDI2NTY1\*\_ga\_FKWNM9FBZ3\*czE3ODA1OTc3MzEkbzYkZzAkdDE3ODA1OTc3MzEkajYwJGwwJGgxNDkzMjExMDk](https://newsletter.semianalysis.com/p/to-boldly-go-the-case-for-space-datacenters?_gl=1*1gj8d24*_ga*MTY2ODQ5MDQwMy4xNzc4MDI2NTY1*_ga_FKWNM9FBZ3*czE3ODA1OTc3MzEkbzYkZzAkdDE3ODA1OTc3MzEkajYwJGwwJGgxNDkzMjExMDk).   
37. GEPA does not seem like it would work, how is this not overfitting / run into the same issues with a bunch of skills that end up being poorly used? I think chi jin’s goedel prover v2 runs into the issue but maybe thats specifically related to weight updating. Regardless, updating in ‘prompt space’ seems interesting to be able to improve frontier models instead of fine tuning. Also the labs will probably serve frontier models more cheaply than you can on rented GPUs  
38. [https://docs.massgen.ai/en/latest/](https://docs.massgen.ai/en/latest/)   
39. [https://substack.com/@gwern/note/c-270310673](https://substack.com/@gwern/note/c-270310673)   
40. [What remains scarce after AGI? – Alex Imas and Phil Trammell](https://www.youtube.com/watch?v=Jj-kBHzUohs)   
41. [https://x.com/PrimeIntellect/status/2062724179296952412?s=20](https://x.com/PrimeIntellect/status/2062724179296952412?s=20)  
42. [https://x.com/abhijaymrana/status/2062817082518258060?s=20](https://x.com/abhijaymrana/status/2062817082518258060?s=20)  
43. [https://x.com/tenobrus/status/2062729311233454363?s=20](https://x.com/tenobrus/status/2062729311233454363?s=20)  
44. [https://x.com/geetkhosla/status/2062507967010730426?s=20](https://x.com/geetkhosla/status/2062507967010730426?s=20)  
45. [https://x.com/JoshPurtell/status/2062605789454385338?s=20](https://x.com/JoshPurtell/status/2062605789454385338?s=20)  
46. [https://x.com/gakonst/status/2062116487708512355?s=20](https://x.com/gakonst/status/2062116487708512355?s=20)  
47. [https://substack.com/home/post/p-197387291](https://substack.com/home/post/p-197387291)   
    1. Feeling like this post makes arguments that could be usefully extended by well analyzing the nvidia tech report and microsoft tech report recently and coming to novel conclusions about scaling complexity  
    2. This also seems to indicate that the karpathy hire on pretraining is due to the fact that pretraining was paused rather than saturated, but incoming compute will continue to deliver major scaling gains  
48. [https://www.youtube.com/watch?v=3Yxmjf57sco](https://www.youtube.com/watch?v=3Yxmjf57sco)   
49. Steven Byrnes less wrong writing  
50. [https://vkrakovna.wordpress.com](https://vkrakovna.wordpress.com) specification gaming  
51. [https://www.campbellramble.ai](https://www.campbellramble.ai)  
52. Goodfire AI research  
53. [https://x.com/dwarkesh\_sp/status/2063335334566621297?s=20](https://x.com/dwarkesh_sp/status/2063335334566621297?s=20)  
54. [https://arxiv.org/abs/2606.02800](https://arxiv.org/abs/2606.02800)  
55. [https://x.com/chelseabfinn/status/2063433906985005510?s=20](https://x.com/chelseabfinn/status/2063433906985005510?s=20) CHELSEA  
56. [https://x.com/lateinteraction/status/2061242049622671746?s=20](https://x.com/lateinteraction/status/2061242049622671746?s=20)  
57. [https://x.com/kalomaze/status/2063122579028889983?s=20](https://x.com/kalomaze/status/2063122579028889983?s=20)  
58. [https://x.com/geetkhosla/status/2062507967010730426?s=20](https://x.com/geetkhosla/status/2062507967010730426?s=20)  
59. [https://x.com/JoshPurtell/status/2062605789454385338?s=20](https://x.com/JoshPurtell/status/2062605789454385338?s=20)  
60. [https://x.com/NoahZiems/status/2062311582580023607?s=20](https://x.com/NoahZiems/status/2062311582580023607?s=20)  
61. [https://x.com/tenobrus/status/2062729311233454363?s=20](https://x.com/tenobrus/status/2062729311233454363?s=20)   
    1. im not seeing people talk about it much so just a heads up: dynamic workflows in claude code are actually insanely fucking useful and powerful. clearly the right / sane way to do "agent orchestration". very much worth trying  
62. [https://www.dwarkesh.com/p/the-sample-efficiency-black-hole](https://www.dwarkesh.com/p/the-sample-efficiency-black-hole)   
63. [https://x.com/eliebakouch/status/2063849409515843635?s=20](https://x.com/eliebakouch/status/2063849409515843635?s=20)   
64. [https://www.lesswrong.com/posts/JT3qCYDimskcBdiEr/the-hard-core-of-alignment-is-robustifying-rl](https://www.lesswrong.com/posts/JT3qCYDimskcBdiEr/the-hard-core-of-alignment-is-robustifying-rl)   
65. [https://x.com/teortaxesTex/status/2064264430980886774?s=20](https://x.com/teortaxesTex/status/2064264430980886774?s=20)   
66. [https://github.com/NVIDIA-NeMo/Nemotron/tree/main](https://github.com/NVIDIA-NeMo/Nemotron/tree/main)   
67. [https://x.com/svlevine/status/2064556220644839855?s=20](https://x.com/svlevine/status/2064556220644839855?s=20)   
68. [https://x.com/teortaxesTex/status/2064605846546301124?s=20](https://x.com/teortaxesTex/status/2064605846546301124?s=20)   
69. [https://x.com/teortaxesTex/status/2064550527979917631?s=20](https://x.com/teortaxesTex/status/2064550527979917631?s=20)   
70. [https://x.com/svlevine/status/2064556217289318528?s=20](https://x.com/svlevine/status/2064556217289318528?s=20)   
71. [https://x.com/dwarkesh\_sp/status/2064422596620472560?s=20](https://x.com/dwarkesh_sp/status/2064422596620472560?s=20)   
72. [https://x.com/emollick/status/2064395281903346013?s=20](https://x.com/emollick/status/2064395281903346013?s=20)   
73. [https://x.com/polynoamial/status/2064210146558136827?s=20](https://x.com/polynoamial/status/2064210146558136827?s=20)   
74. [https://x.com/eliebakouch/status/2064086258687578348?s=20](https://x.com/eliebakouch/status/2064086258687578348?s=20)   
75. [https://x.com/eliebakouch/status/2064736476995146014?s=20](https://x.com/eliebakouch/status/2064736476995146014?s=20)   
76. [https://www.a16z.news/p/institutional-ai-vs-individual-ai](https://www.a16z.news/p/institutional-ai-vs-individual-ai) coordination as first pillar here very similar to my multi agent take. The signal part feels like what im trying to do with the future version of these notes and my listed problems. Unprompted is also a novel thought ive been exploring, similar to proactivity per the randall takes.   
77. Is this guy super cracked out? How does his embodiment take relate to current work and/or multi agent work and/or AIXI? [https://scott.garrabrant.com/](https://scott.garrabrant.com/)   
78. Magnetic mirror descent [https://arxiv.org/abs/2206.05825](https://arxiv.org/abs/2206.05825) 
79. [https://gwern.net/rl-children](https://gwern.net/rl-children)  
80. https://x.com/RyanPGreenblatt/status/2065185280295100481?s=20
81. https://x.com/emollick/status/2065200484613296269?s=20
82. https://x.com/robinhanson/status/2065122280875946014?s=20
83. https://x.com/jjacky/status/2064767118118117491?s=20
84. https://substack.com/@gwern/note/c-266997559?r=4r3bqf&utm_medium=ios&utm_source=notes-share-action
85. https://arxiv.org/pdf/2603.10476
86. https://arxiv.org/pdf/2604.09855
87. https://arxiv.org/pdf/2606.13681 
88. https://x.com/chelseabfinn/status/2065559130929291630?s=20 CHELSEA
89. https://arxiv.org/abs/1709.04326 LOLA
90. are hindsight and honcho history systems for solving POMDPs?
91. https://openreview.net/pdf?id=fh8EYKFKns