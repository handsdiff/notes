
1. https://x.com/willccbb/status/2068210850700353537?s=20
2. https://x.com/sethkarten/status/2068011592877502534?s=20
3. https://x.com/jsuarez/status/2068025057755197638?s=20
4. https://x.com/dwarkesh_sp/status/2068019716849815869?s=20
5. even if frontier LLMs are programmable in theory, that doesnt mean you know how to program them. you would still need to specify a reward model somehow (perhaps some other system, even another AI, determines the best way to prompt/program the main AI)
6. https://x.com/teortaxesTex/status/2067872311030550634?s=20
7. https://arxiv.org/abs/2606.06492 Code2lora
8. https://arxiv.org/abs/2606.13473 Example of singleton outcome
9. https://x.com/ShashwatGoel7/status/2067954502435480050?s=20
10. overnight weight updating? instead of overnight consolidation? anthropic would be checking whether its possible to just incorporate everyones preferences into a singleton LLM, 'programmed' by KV
11. Some strand between economics around setting up compute with how inference actually works with how to productize models for end user
12. A good continual learning system will tease out orders of magnitude more context from its users and be orders of magnitude more retentive
13. Guy can’t use HL wallet tracker 
14. We probably need to get more specific on the economies of scale I think our (my) current understanding is poor. Like if a Blackwell rack has 72 GPUs, and anthropic has 10 of those, and I have one. Is it that I can serve 1/10th of the customers at the same cost, or is it that we can serve the same amount of customers but i have to charge 10x the price for the same profit? If it’s both, then there will always be a wedge for lower scale providers with fewer GPUs that can serve fewer customers with the same or lower pricing. Additionally a frontier open source model increases the ROI on compute for everyone else besides the people with better models, chipping away at economies of scale.
15. Meta is a data labeling org now? Twitter tweets about it
16. https://x.com/jonchu/status/2063295773169910001?s=20 good startup advice as I consider markets
17. https://thealliance.ai/projects/tapestry
18. https://x.com/castformai
	1. https://arxiv.org/abs/2606.15532v1 emotional intelligence bench
19. https://river.ai/ how does this relate to my blog?
20. https://x.com/oneill_c/status/2067673179536208062?s=20
21. https://x.com/perplexity_ai/status/2067642139014742348?s=20
22. https://x.com/sheriyuo/status/2067514445488947366?s=20
23. [https://x.com/lossfunk/status/2067589548759261531?s=20](https://x.com/lossfunk/status/2067589548759261531?s=20)
24. [https://x.com/jsuarez/status/2067272190702256340?s=20](https://x.com/jsuarez/status/2067272190702256340?s=20)
25. https://x.com/satyanadella/status/2066182223213293753
26. https://arxiv.org/pdf/2405.17713 AI Alignment with Changing and Influenceable Reward Functions Dragan 2024
	1. an example given here is if someone is trying to lose weight, should the model optimize for losing weight even if they get higher short term reward for eating candy? if the model says no candy the user might be mad. if the model says candy the user might be mad. not sure how they reconcile but the way i'd reconcile is always optimizing for long term rewards, and choosing short term rewards to the extent by which they increase intrinsic motivation to continue pursuing long term rewards.
	2. probably relates to research around intrinsic motivation / laziness in models. there is likely an actual term for this in human psychology
	3. https://people.eecs.berkeley.edu/~anca/publications.html worth exploring. lots of relevant information
	4. https://claude.ai/chat/90f6570c-41ea-4cd4-8e2e-f54ef8df4197
	5. https://claude.ai/chat/8d0ee16d-491f-4f94-b416-626b7c42b745
	6. https://gemini.google.com/app/f44fe68a684ec176
		1. seems to relate to [[AIXI]] since the agent manages a set of possible 'true' reward functions and adopts a policy based on its observations + coupled with its environment a la MUPI if the fear of persuading the human to change to make its own job easier is well founded
		2. git history as the history over which the agent learns in the [[PDEV]] sense feels directionally correct but overall lacking in context (what i read, what i see, what i conversate, etc)
	7. https://gemini.google.com/app/f44fe68a684ec176 early part of this topic. it eventually degrades
27. https://arxiv.org/pdf/2408.16984 interesting paper that seems, from the abstract, to conclude anthropic's approach is superior, but then says that this leads to pluralism?
28. if its unclear what is latent in an LLM, then GEPA is the best way of figuring out whats latent?
	1. definitely feels wasteful to have to spend a ton of tokens figuring out what the state of the computer even is, rather than just using it, especially since its expensive
29. https://jacobxli.com/blog/2026/machine-studying/ seems very relevant to continual learning, possibly good benchmark
30. https://arxiv.org/pdf/2606.16475 persuasion bench. ai outperforms humans, even on charity raising
31. https://gemini.google.com/app/d3409327dab2a45f explanation for PNLC https://arxiv.org/abs/2505.18098 vs NLAC
	1. can you apply the step from PNLC -> NLAC to PPI? think i had a claude chat somewhere about this. the take seemed to be yes its possible since LLMs are fundamentally the same structure as the GRUs that were tested. again also seems related to SDPO
32. is NLAC similar to continual/interactive learning if you replace the critic with a human? starting to feel like this vague idea doesn't actually make sense because what are you even learning/predicting?
33. how to deal with states that truthfully reward the user but the user doesn't recognize as such? this is probably the basis for sycophancy. probably similar to P vs NP. i can verify that i like something after i have it but i cannot tell you or codify it before hand.
34. are RL rollouts equivalent to 'predicting the environment and predicting your own actions'? i dont see what the difference is. at least for single model rollouts not self play. https://claude.ai/chat/2c9bd8d1-5bb3-452b-9090-faaf8efd1ae7
35. **described update to jakub as MARL -> epistemic integrity / prompt injection resistance / embedded agency AND/OR CIRL / interaction models / assistance games, with RSI asterisk looming over everything. is that comprehensive?** 
	1. **his take was that epistemics is often grounded in human feeling/intuition which consolidates it with the latter point**
36. i think its robust to believe that RSI will not be able to improve epistemic integrity over an existing out of the box product, if it existed, since the potential weight updating required to self improve would be too costly even for a superintelligence? 
37. https://arxiv.org/abs/2601.20802 how does SDPO relate to interactive / continuous inverse learning? seems relevant
38. epistemic integrity feels necessary for actually improving priors + discovering truth which feels necessary for collective intelligence to be value creative over singleton intelligence. otherwise as sutton puts it youre missing the selective retention part of variation and evaluation. although not sure why its not just variation and selection
39. is china's open source culture an example of 'commodifying your complement'? i.e. they commodify algorithms because they likely win on compute longer term. by that analog anthropic should want to commodify compute but they can't really.
40. if its written by AI, expect only AI to read it. if only AI is reading it, why write it without AI? feels pretty easy to tell the difference between something made for agents (AEO) and something made for humans (non-average voice)
41. arena.ai is similar to LM arena except for frontend design. what was the GTM there? dynamic, real use evals still feel crucial. even better if they proxy things people would pay for
42. https://x.com/JoshPurtell/status/2066967185818345674?s=20
43. https://x.com/SemiAnalysis_/status/2066941079920791760?s=20
44. https://www.forethought.org/research/will-ai-r-and-d-automation-cause-a-software-intelligence-explosion#bringing-it-all-together
45. https://arxiv.org/abs/2506.14863 intelligence explosion estimates around ai population growth
46. it doesnt seem like obsidian will build what i want [[PDEV]] since their core value prop involves privacy, whereas i want public by default + cloud AI analyzing everything/always on
47. its easier to share progress, and therefore make progress, if investment is permissionless. relates to RPGF, but that seems a bit too idealistic.
48. how is epistemic integrity benchmarked in LLMs, if at all? the success of collective intelligence and non singleton outcomes is downstream of this.
	1. games like avalon are a subset of epistemic integrity
	2. "(e) Group alignment: How can AGI groups be effectively steered (either explicitly, or implicitly via, e.g., mechanism design for markets)? How can they be hardened and self-correct against epistemic hijacking and the spread of falsehoods, hallucinations & self-delusions? (f) How to ensure epistemic resilience and recoverability in asymmetric-intelligence collectives (e.g., mixed human-ASI collectives)?" from agi to asi paper
	3. seems like the transition from taking context at face value vs taking context as an update into a prior is the difference, but what does that look like in practice? for example if a data point comes in and the probability of that data point is low, we would need to update our priors but not completely. and there is a difference between environmental sampling and collaborative opinion (lossy). trust forms when collaborative opinion updates the world model/prior towards environmental truth over time. trust is individualized reputation.
	4. studybench feels like an example of an assistance game
49. agency arises when reward signal is peer approval in humans? how to set a dynamic reward signal of peer approval in LLMs? relates to CIRL. perhaps relates to (non)assistant training paradigm
50. probably need to go through these (recent papers by ECHO author) https://arxiv.org/search/cs?searchtype=author&query=Shrivastava,+V
51. https://www.mdpi.com/1099-4300/28/6/596 genewein and hutter explore the extent to which LLMs approximate AIXI and what the specific challenges are https://gemini.google.com/app/e5723b735ee76668
	1. seemingly a gap between append only agent turn logs as some vague 'memory' solution vs use as a formal interleaved dataset where the agent can learn causal loops, which opens up multi agent systems which opens up collective intelligence. again, ECHO seems to be the first version of this
	2. prospective learning vs retrospective learning?
	3. but when agents do next token prediction that's considered an 'action', no? whats the actual difference
52. if LLM generalization is on a spectrum, then viable products of the future are downstream of being correct about the extent to which generalization occurs
53. current understanding todos in browser: multi agent cooperating thru ICL, CIRL, AGI to ASI, MUPI/RUI, gwern GA, POMDP lectures
	1. https://gemini.google.com/app/eef345df5e5d14eb
		1. ^ how do epistemic utility measurements [[Google Pi Team#^b203be]] relate to the framing of the 'incentive to ask' as the unsolved core
	2. "Wrapping a mathematical POMDP solver around a 70B+ parameter Large Language Model is computationally impossible with current techniques." ??
	3. "not by maintaining a dynamic Bayesian belief distribution over a hidden vector $\theta$, but by frozen reward modeling or Direct Preference Optimization. The empirical simplicity and scalability of RLHF bypassed the need to compute complex, game-theoretic joint policies." ok but we're past that now
	4. is the context of an LLM functionally a bayesian belief state in a POMDP? and the problem perhaps with that framework is that it does not maintain multiple 'contexts' with their own probabilities of being right/useful? and this is externalized to memory solutions like Hindsight and benchmarked with stuff like BEAM? but [[Google Pi Team#^b203be]] describes differences between epistemic agents and what BEAM measures, which essentially comes down to dynamism imo. relates back to dynamic evals seemingly, but personalized perhaps [[Ideas#^7afff1]]
	5. CIRL also seems to be related to the 'proactive' framework Randall kept mentioning. [[Experiments#^605490]], at least the part where it interjects to learn. do existing LLMs and memory handle this already?
54. Polymarket vs Kalshi seems similar to protocol vs platform
55. https://x.com/teortaxesTex/status/2065962301195178212?s=20
56. https://x.com/JoshPurtell/status/2065989651752464486?s=20
57. https://x.com/kalomaze/status/2065498921443438928?s=20
58. [https://x.com/badlogicgames/status/2061941296932004175?s=20](https://x.com/badlogicgames/status/2061941296932004175?s=20) as a stepping stone to models as tools for models? Dynamic workflows  
    1. [https://x.com/a1zhang/status/2060071701879066626](https://x.com/a1zhang/status/2060071701879066626)   
59. [https://x.com/mustafasuleyman/status/2061880164498428188?s=20](https://x.com/mustafasuleyman/status/2061880164498428188?s=20)   
60. [https://x.com/eliebakouch/status/2061965825037254947?s=20](https://x.com/eliebakouch/status/2061965825037254947?s=20)   
61. [https://x.com/perplexity\_ai/status/2061506359326384319?s=20](https://x.com/perplexity_ai/status/2061506359326384319?s=20)   
62. [https://variant.fund/articles/value-open-harnesses/](https://variant.fund/articles/value-open-harnesses/)   
63. [https://x.com/kalomaze/status/2062261215116874223?s=20](https://x.com/kalomaze/status/2062261215116874223?s=20)  
64. [https://x.com/dwarkesh\_sp/status/2062353335529935114?s=20](https://x.com/dwarkesh_sp/status/2062353335529935114?s=20)  
65. [https://x.com/NVIDIAAI/status/2062521325076299981?s=20](https://x.com/NVIDIAAI/status/2062521325076299981?s=20)   
66. [https://x.com/eglyman/status/2062526944265048285?s=20](https://x.com/eglyman/status/2062526944265048285?s=20)   
67. [https://gemini.google.com/app/ecf40bd8459d2a5e](https://gemini.google.com/app/ecf40bd8459d2a5e)   
68. [https://papers.ssrn.com/sol3/papers.cfm?abstract\_id=6833760](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=6833760)   
69. [https://x.com/srush\_nlp/status/2062359839783657816?s=20](https://x.com/srush_nlp/status/2062359839783657816?s=20)   
70. [https://newsletter.semianalysis.com/p/to-boldly-go-the-case-for-space-datacenters?\_gl=1\*1gj8d24\*\_ga\*MTY2ODQ5MDQwMy4xNzc4MDI2NTY1\*\_ga\_FKWNM9FBZ3\*czE3ODA1OTc3MzEkbzYkZzAkdDE3ODA1OTc3MzEkajYwJGwwJGgxNDkzMjExMDk](https://newsletter.semianalysis.com/p/to-boldly-go-the-case-for-space-datacenters?_gl=1*1gj8d24*_ga*MTY2ODQ5MDQwMy4xNzc4MDI2NTY1*_ga_FKWNM9FBZ3*czE3ODA1OTc3MzEkbzYkZzAkdDE3ODA1OTc3MzEkajYwJGwwJGgxNDkzMjExMDk).   
71. GEPA does not seem like it would work, how is this not overfitting / run into the same issues with a bunch of skills that end up being poorly used? I think chi jin’s goedel prover v2 runs into the issue but maybe thats specifically related to weight updating. Regardless, updating in ‘prompt space’ seems interesting to be able to improve frontier models instead of fine tuning. Also the labs will probably serve frontier models more cheaply than you can on rented GPUs  
72. [https://docs.massgen.ai/en/latest/](https://docs.massgen.ai/en/latest/)   
73. [https://substack.com/@gwern/note/c-270310673](https://substack.com/@gwern/note/c-270310673)   
74. [What remains scarce after AGI? – Alex Imas and Phil Trammell](https://www.youtube.com/watch?v=Jj-kBHzUohs)   
75. [https://x.com/PrimeIntellect/status/2062724179296952412?s=20](https://x.com/PrimeIntellect/status/2062724179296952412?s=20)  
76. [https://x.com/abhijaymrana/status/2062817082518258060?s=20](https://x.com/abhijaymrana/status/2062817082518258060?s=20)  
77. [https://x.com/tenobrus/status/2062729311233454363?s=20](https://x.com/tenobrus/status/2062729311233454363?s=20)  
78. [https://x.com/geetkhosla/status/2062507967010730426?s=20](https://x.com/geetkhosla/status/2062507967010730426?s=20)  
79. [https://x.com/JoshPurtell/status/2062605789454385338?s=20](https://x.com/JoshPurtell/status/2062605789454385338?s=20)  
80. [https://x.com/gakonst/status/2062116487708512355?s=20](https://x.com/gakonst/status/2062116487708512355?s=20)  
81. [https://substack.com/home/post/p-197387291](https://substack.com/home/post/p-197387291)   
    1. Feeling like this post makes arguments that could be usefully extended by well analyzing the nvidia tech report and microsoft tech report recently and coming to novel conclusions about scaling complexity  
    2. This also seems to indicate that the karpathy hire on pretraining is due to the fact that pretraining was paused rather than saturated, but incoming compute will continue to deliver major scaling gains  
82. [https://www.youtube.com/watch?v=3Yxmjf57sco](https://www.youtube.com/watch?v=3Yxmjf57sco)   
83. Steven Byrnes less wrong writing  
84. [https://vkrakovna.wordpress.com](https://vkrakovna.wordpress.com) specification gaming  
85. [https://www.campbellramble.ai](https://www.campbellramble.ai)  
86. Goodfire AI research  
87. [https://x.com/dwarkesh\_sp/status/2063335334566621297?s=20](https://x.com/dwarkesh_sp/status/2063335334566621297?s=20)  
88. [https://arxiv.org/abs/2606.02800](https://arxiv.org/abs/2606.02800)  
89. [https://x.com/chelseabfinn/status/2063433906985005510?s=20](https://x.com/chelseabfinn/status/2063433906985005510?s=20) CHELSEA  
90. [https://x.com/lateinteraction/status/2061242049622671746?s=20](https://x.com/lateinteraction/status/2061242049622671746?s=20)  
91. [https://x.com/kalomaze/status/2063122579028889983?s=20](https://x.com/kalomaze/status/2063122579028889983?s=20)  
92. [https://x.com/geetkhosla/status/2062507967010730426?s=20](https://x.com/geetkhosla/status/2062507967010730426?s=20)  
93. [https://x.com/JoshPurtell/status/2062605789454385338?s=20](https://x.com/JoshPurtell/status/2062605789454385338?s=20)  
94. [https://x.com/NoahZiems/status/2062311582580023607?s=20](https://x.com/NoahZiems/status/2062311582580023607?s=20)  
95. [https://x.com/tenobrus/status/2062729311233454363?s=20](https://x.com/tenobrus/status/2062729311233454363?s=20)   
    1. im not seeing people talk about it much so just a heads up: dynamic workflows in claude code are actually insanely fucking useful and powerful. clearly the right / sane way to do "agent orchestration". very much worth trying  
96. [https://www.dwarkesh.com/p/the-sample-efficiency-black-hole](https://www.dwarkesh.com/p/the-sample-efficiency-black-hole)   
97. [https://x.com/eliebakouch/status/2063849409515843635?s=20](https://x.com/eliebakouch/status/2063849409515843635?s=20)   
98. [https://www.lesswrong.com/posts/JT3qCYDimskcBdiEr/the-hard-core-of-alignment-is-robustifying-rl](https://www.lesswrong.com/posts/JT3qCYDimskcBdiEr/the-hard-core-of-alignment-is-robustifying-rl)   
99. [https://x.com/teortaxesTex/status/2064264430980886774?s=20](https://x.com/teortaxesTex/status/2064264430980886774?s=20)   
100. [https://github.com/NVIDIA-NeMo/Nemotron/tree/main](https://github.com/NVIDIA-NeMo/Nemotron/tree/main)   
101. [https://x.com/teortaxesTex/status/2064605846546301124?s=20](https://x.com/teortaxesTex/status/2064605846546301124?s=20)   
102. [https://x.com/teortaxesTex/status/2064550527979917631?s=20](https://x.com/teortaxesTex/status/2064550527979917631?s=20)   
103. [https://x.com/svlevine/status/2064556217289318528?s=20](https://x.com/svlevine/status/2064556217289318528?s=20)   
104. [https://x.com/dwarkesh\_sp/status/2064422596620472560?s=20](https://x.com/dwarkesh_sp/status/2064422596620472560?s=20)   
105. [https://x.com/emollick/status/2064395281903346013?s=20](https://x.com/emollick/status/2064395281903346013?s=20)   
106. [https://x.com/polynoamial/status/2064210146558136827?s=20](https://x.com/polynoamial/status/2064210146558136827?s=20)   
107. [https://x.com/eliebakouch/status/2064086258687578348?s=20](https://x.com/eliebakouch/status/2064086258687578348?s=20)   
108. [https://x.com/eliebakouch/status/2064736476995146014?s=20](https://x.com/eliebakouch/status/2064736476995146014?s=20)   
109. [https://www.a16z.news/p/institutional-ai-vs-individual-ai](https://www.a16z.news/p/institutional-ai-vs-individual-ai) coordination as first pillar here very similar to my multi agent take. The signal part feels like what im trying to do with the future version of these notes and my listed problems. Unprompted is also a novel thought ive been exploring, similar to proactivity per the randall takes.   
110. Is this guy super cracked out? How does his embodiment take relate to current work and/or multi agent work and/or AIXI? [https://scott.garrabrant.com/](https://scott.garrabrant.com/)   
111. Magnetic mirror descent [https://arxiv.org/abs/2206.05825](https://arxiv.org/abs/2206.05825) 
112. [https://gwern.net/rl-children](https://gwern.net/rl-children)  
113. https://x.com/RyanPGreenblatt/status/2065185280295100481?s=20
114. https://x.com/emollick/status/2065200484613296269?s=20
115. https://x.com/robinhanson/status/2065122280875946014?s=20
116. https://x.com/jjacky/status/2064767118118117491?s=20
117. https://substack.com/@gwern/note/c-266997559?r=4r3bqf&utm_medium=ios&utm_source=notes-share-action
118. https://arxiv.org/pdf/2603.10476
119. https://arxiv.org/pdf/2604.09855
120. https://arxiv.org/pdf/2606.13681 
121. https://x.com/chelseabfinn/status/2065559130929291630?s=20 CHELSEA
122. https://arxiv.org/abs/1709.04326 LOLA
92.
123. https://openreview.net/pdf?id=fh8EYKFKns