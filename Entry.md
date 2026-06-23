
1. seems to be a big question around whether further frontier model improvements actually move the needle for my workflows, or a market's workflows, and why or why not? this is what labs seem to be solving for with all their 'RL envs'
2. how can it be true that smaller models will get better over time as large models are distilled into them either directly (unknown mechanism) or indirectly (via algorithm knowledge diffusion) while also that larger models will get better over time for the same reason? if large models will always be better than small models, but both improve, does the gap increase or decrease? in the long term, is this a problem for frontier model creators if they don't expand product offerings? how does this impact arguments around centralization that Jakub seems to be making? if its a time frame distinction, then whats the time frame for each? we should be able to visualize it like rolling waves, no? 
	1. inspired from this https://arxiv.org/pdf/2606.16140
2. how does GDP > money printing = deflation in the sense that AI causes GDP increases that surpass money printing? the US wouldnt allow deflation and would print more, no? but then do what with that money? if they printed money to plow into data centers what would the granular flow of dollars (rights and obligations) even look like
3. marketplace between GPU racks and intelligence use cases, enabled by algorithms and data
4. Theory of mind seems different from actually predicting what someone else will do and taking advantage of that in a competitive environment
5. https://www.youtube.com/watch?v=GwSl1OH1i4w
6. Seem to have lost the tab with the list of thiel quotes, i think shared by richard ngo
7. Is memory a mapping of prior activations to environmental observations?
8. https://x.com/jsuarez/status/2067272190702256340?s=20
9. https://github.com/siyuan-note/siyuan And logseq
10. Most people probably don’t/can’t have their internal monologue publicized? Need to sample the environment
11. It’s incredibly stupid, especially from the outside looking in, to try to build a startup and not talk to anyone 
12. What would a successful future you change about you today
13. https://x.com/elonmusk/status/2068369665647108524?s=20
14. The people that call glm 5.2 an inflection point and assume people will use that over closed source frontier are implicitly saying that frontier model diff to closed source increasingly drifts from actual use cases. There is also some compute argument here that is upstream of the pricing argument that might be necessary to articulate to make the above claim since the above claim feels a bit off in practice 
15. https://x.com/willccbb/status/2068210850700353537?s=20
16. https://x.com/sethkarten/status/2068011592877502534?s=20
17. https://x.com/jsuarez/status/2068025057755197638?s=20
18. https://x.com/dwarkesh_sp/status/2068019716849815869?s=20
19. even if frontier LLMs are programmable in theory, that doesnt mean you know how to program them. you would still need to specify a reward model somehow (perhaps some other system, even another AI, determines the best way to prompt/program the main AI)
20. https://x.com/teortaxesTex/status/2067872311030550634?s=20
21. https://arxiv.org/abs/2606.06492 Code2lora
22. https://arxiv.org/abs/2606.13473 Example of singleton outcome
23. https://x.com/ShashwatGoel7/status/2067954502435480050?s=20
24. overnight weight updating? instead of overnight consolidation? anthropic would be checking whether its possible to just incorporate everyones preferences into a singleton LLM, 'programmed' by KV
25. Some strand between economics around setting up compute with how inference actually works with how to productize models for end user
26. A good continual learning system will tease out orders of magnitude more context from its users and be orders of magnitude more retentive
27. Guy can’t use HL wallet tracker 
28. We probably need to get more specific on the economies of scale I think our (my) current understanding is poor. Like if a Blackwell rack has 72 GPUs, and anthropic has 10 of those, and I have one. Is it that I can serve 1/10th of the customers at the same cost, or is it that we can serve the same amount of customers but i have to charge 10x the price for the same profit? If it’s both, then there will always be a wedge for lower scale providers with fewer GPUs that can serve fewer customers with the same or lower pricing. Additionally a frontier open source model increases the ROI on compute for everyone else besides the people with better models, chipping away at economies of scale.
	1. not sure this was answered by jakub at latest meeting
29. Meta is a data labeling org now? Twitter tweets about it
30. https://x.com/jonchu/status/2063295773169910001?s=20 good startup advice as I consider markets
31. https://thealliance.ai/projects/tapestry
32. https://x.com/castformai
	1. https://arxiv.org/abs/2606.15532v1 emotional intelligence bench
33. https://river.ai/ how does this relate to my blog?
34. https://x.com/oneill_c/status/2067673179536208062?s=20
35. https://x.com/perplexity_ai/status/2067642139014742348?s=20
36. https://x.com/sheriyuo/status/2067514445488947366?s=20
37. [https://x.com/lossfunk/status/2067589548759261531?s=20](https://x.com/lossfunk/status/2067589548759261531?s=20)
38. [https://x.com/jsuarez/status/2067272190702256340?s=20](https://x.com/jsuarez/status/2067272190702256340?s=20)
39. https://x.com/satyanadella/status/2066182223213293753
40. https://arxiv.org/pdf/2405.17713 AI Alignment with Changing and Influenceable Reward Functions Dragan 2024
	1. an example given here is if someone is trying to lose weight, should the model optimize for losing weight even if they get higher short term reward for eating candy? if the model says no candy the user might be mad. if the model says candy the user might be mad. not sure how they reconcile but the way i'd reconcile is always optimizing for long term rewards, and choosing short term rewards to the extent by which they increase intrinsic motivation to continue pursuing long term rewards.
	2. probably relates to research around intrinsic motivation / laziness in models. there is likely an actual term for this in human psychology
	3. https://people.eecs.berkeley.edu/~anca/publications.html worth exploring. lots of relevant information
	4. https://claude.ai/chat/90f6570c-41ea-4cd4-8e2e-f54ef8df4197
	5. https://claude.ai/chat/8d0ee16d-491f-4f94-b416-626b7c42b745
	6. https://gemini.google.com/app/f44fe68a684ec176
		1. seems to relate to [[AIXI]] since the agent manages a set of possible 'true' reward functions and adopts a policy based on its observations + coupled with its environment a la MUPI if the fear of persuading the human to change to make its own job easier is well founded
		2. git history as the history over which the agent learns in the [[PDEV]] sense feels directionally correct but overall lacking in context (what i read, what i see, what i conversate, etc)
	7. https://gemini.google.com/app/f44fe68a684ec176 early part of this topic. it eventually degrades
41. https://arxiv.org/pdf/2408.16984 interesting paper that seems, from the abstract, to conclude anthropic's approach is superior, but then says that this leads to pluralism?
42. if its unclear what is latent in an LLM, then GEPA is the best way of figuring out whats latent?
	1. definitely feels wasteful to have to spend a ton of tokens figuring out what the state of the computer even is, rather than just using it, especially since its expensive
43. https://jacobxli.com/blog/2026/machine-studying/ seems very relevant to continual learning, possibly good benchmark
44. https://arxiv.org/pdf/2606.16475 persuasion bench. ai outperforms humans, even on charity raising
45. https://gemini.google.com/app/d3409327dab2a45f explanation for PNLC https://arxiv.org/abs/2505.18098 vs NLAC
	1. can you apply the step from PNLC -> NLAC to PPI? think i had a claude chat somewhere about this. the take seemed to be yes its possible since LLMs are fundamentally the same structure as the GRUs that were tested. again also seems related to SDPO
46. is NLAC similar to continual/interactive learning if you replace the critic with a human? starting to feel like this vague idea doesn't actually make sense because what are you even learning/predicting?
47. how to deal with states that truthfully reward the user but the user doesn't recognize as such? this is probably the basis for sycophancy. probably similar to P vs NP. i can verify that i like something after i have it but i cannot tell you or codify it before hand.
48. are RL rollouts equivalent to 'predicting the environment and predicting your own actions'? i dont see what the difference is. at least for single model rollouts not self play. https://claude.ai/chat/2c9bd8d1-5bb3-452b-9090-faaf8efd1ae7
49. **described update to jakub as MARL -> epistemic integrity / prompt injection resistance / embedded agency AND/OR CIRL / interaction models / assistance games, with RSI asterisk looming over everything. is that comprehensive?** 
	1. **his take was that epistemics is often grounded in human feeling/intuition which consolidates it with the latter point**
50. i think its robust to believe that RSI will not be able to improve epistemic integrity over an existing out of the box product, if it existed, since the potential weight updating required to self improve would be too costly even for a superintelligence? 
51. https://arxiv.org/abs/2601.20802 how does SDPO relate to interactive / continuous inverse learning? seems relevant
52. epistemic integrity feels necessary for actually improving priors + discovering truth which feels necessary for collective intelligence to be value creative over singleton intelligence. otherwise as sutton puts it youre missing the selective retention part of variation and evaluation. although not sure why its not just variation and selection
53. is china's open source culture an example of 'commodifying your complement'? i.e. they commodify algorithms because they likely win on compute longer term. by that analog anthropic should want to commodify compute but they can't really.
54. if its written by AI, expect only AI to read it. if only AI is reading it, why write it without AI? feels pretty easy to tell the difference between something made for agents (AEO) and something made for humans (non-average voice)
55. arena.ai is similar to LM arena except for frontend design. what was the GTM there? dynamic, real use evals still feel crucial. even better if they proxy things people would pay for
56. https://x.com/JoshPurtell/status/2066967185818345674?s=20
57. https://x.com/SemiAnalysis_/status/2066941079920791760?s=20
58. https://www.forethought.org/research/will-ai-r-and-d-automation-cause-a-software-intelligence-explosion#bringing-it-all-together
59. https://arxiv.org/abs/2506.14863 intelligence explosion estimates around ai population growth
60. it doesnt seem like obsidian will build what i want [[PDEV]] since their core value prop involves privacy, whereas i want public by default + cloud AI analyzing everything/always on
61. its easier to share progress, and therefore make progress, if investment is permissionless. relates to RPGF, but that seems a bit too idealistic.
62. how is epistemic integrity benchmarked in LLMs, if at all? the success of collective intelligence and non singleton outcomes is downstream of this.
	1. games like avalon are a subset of epistemic integrity
	2. "(e) Group alignment: How can AGI groups be effectively steered (either explicitly, or implicitly via, e.g., mechanism design for markets)? How can they be hardened and self-correct against epistemic hijacking and the spread of falsehoods, hallucinations & self-delusions? (f) How to ensure epistemic resilience and recoverability in asymmetric-intelligence collectives (e.g., mixed human-ASI collectives)?" from agi to asi paper
	3. seems like the transition from taking context at face value vs taking context as an update into a prior is the difference, but what does that look like in practice? for example if a data point comes in and the probability of that data point is low, we would need to update our priors but not completely. and there is a difference between environmental sampling and collaborative opinion (lossy). trust forms when collaborative opinion updates the world model/prior towards environmental truth over time. trust is individualized reputation.
	4. studybench feels like an example of an assistance game
63. agency arises when reward signal is peer approval in humans? how to set a dynamic reward signal of peer approval in LLMs? relates to CIRL. perhaps relates to (non)assistant training paradigm
64. probably need to go through these (recent papers by ECHO author) https://arxiv.org/search/cs?searchtype=author&query=Shrivastava,+V
65. https://www.mdpi.com/1099-4300/28/6/596 genewein and hutter explore the extent to which LLMs approximate AIXI and what the specific challenges are https://gemini.google.com/app/e5723b735ee76668
	1. seemingly a gap between append only agent turn logs as some vague 'memory' solution vs use as a formal interleaved dataset where the agent can learn causal loops, which opens up multi agent systems which opens up collective intelligence. again, ECHO seems to be the first version of this
	2. prospective learning vs retrospective learning?
	3. but when agents do next token prediction that's considered an 'action', no? whats the actual difference
66. if LLM generalization is on a spectrum, then viable products of the future are downstream of being correct about the extent to which generalization occurs
67. current understanding todos in browser: multi agent cooperating thru ICL, CIRL, AGI to ASI, MUPI/RUI, gwern GA, POMDP lectures
	1. https://gemini.google.com/app/eef345df5e5d14eb
		1. ^ how do epistemic utility measurements [[Google Pi Team#^b203be]] relate to the framing of the 'incentive to ask' as the unsolved core
	2. "Wrapping a mathematical POMDP solver around a 70B+ parameter Large Language Model is computationally impossible with current techniques." ??
	3. "not by maintaining a dynamic Bayesian belief distribution over a hidden vector $\theta$, but by frozen reward modeling or Direct Preference Optimization. The empirical simplicity and scalability of RLHF bypassed the need to compute complex, game-theoretic joint policies." ok but we're past that now
	4. is the context of an LLM functionally a bayesian belief state in a POMDP? and the problem perhaps with that framework is that it does not maintain multiple 'contexts' with their own probabilities of being right/useful? and this is externalized to memory solutions like Hindsight and benchmarked with stuff like BEAM? but [[Google Pi Team#^b203be]] describes differences between epistemic agents and what BEAM measures, which essentially comes down to dynamism imo. relates back to dynamic evals seemingly, but personalized perhaps [[Ideas#^7afff1]]
	5. CIRL also seems to be related to the 'proactive' framework Randall kept mentioning. [[Experiments#^605490]], at least the part where it interjects to learn. do existing LLMs and memory handle this already?
68. Polymarket vs Kalshi seems similar to protocol vs platform
69. https://x.com/teortaxesTex/status/2065962301195178212?s=20
70. https://x.com/JoshPurtell/status/2065989651752464486?s=20
71. https://x.com/kalomaze/status/2065498921443438928?s=20
72. [https://x.com/badlogicgames/status/2061941296932004175?s=20](https://x.com/badlogicgames/status/2061941296932004175?s=20) as a stepping stone to models as tools for models? Dynamic workflows  
    1. [https://x.com/a1zhang/status/2060071701879066626](https://x.com/a1zhang/status/2060071701879066626)   
73. [https://x.com/mustafasuleyman/status/2061880164498428188?s=20](https://x.com/mustafasuleyman/status/2061880164498428188?s=20)   
74. [https://x.com/eliebakouch/status/2061965825037254947?s=20](https://x.com/eliebakouch/status/2061965825037254947?s=20)   
75. [https://x.com/perplexity\_ai/status/2061506359326384319?s=20](https://x.com/perplexity_ai/status/2061506359326384319?s=20)   
76. [https://variant.fund/articles/value-open-harnesses/](https://variant.fund/articles/value-open-harnesses/)   
77. [https://x.com/kalomaze/status/2062261215116874223?s=20](https://x.com/kalomaze/status/2062261215116874223?s=20)  
78. [https://x.com/dwarkesh\_sp/status/2062353335529935114?s=20](https://x.com/dwarkesh_sp/status/2062353335529935114?s=20)  
79. [https://x.com/NVIDIAAI/status/2062521325076299981?s=20](https://x.com/NVIDIAAI/status/2062521325076299981?s=20)   
80. [https://x.com/eglyman/status/2062526944265048285?s=20](https://x.com/eglyman/status/2062526944265048285?s=20)   
81. [https://gemini.google.com/app/ecf40bd8459d2a5e](https://gemini.google.com/app/ecf40bd8459d2a5e)   
82. [https://papers.ssrn.com/sol3/papers.cfm?abstract\_id=6833760](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=6833760)   
83. [https://x.com/srush\_nlp/status/2062359839783657816?s=20](https://x.com/srush_nlp/status/2062359839783657816?s=20)   
84. [https://newsletter.semianalysis.com/p/to-boldly-go-the-case-for-space-datacenters?\_gl=1\*1gj8d24\*\_ga\*MTY2ODQ5MDQwMy4xNzc4MDI2NTY1\*\_ga\_FKWNM9FBZ3\*czE3ODA1OTc3MzEkbzYkZzAkdDE3ODA1OTc3MzEkajYwJGwwJGgxNDkzMjExMDk](https://newsletter.semianalysis.com/p/to-boldly-go-the-case-for-space-datacenters?_gl=1*1gj8d24*_ga*MTY2ODQ5MDQwMy4xNzc4MDI2NTY1*_ga_FKWNM9FBZ3*czE3ODA1OTc3MzEkbzYkZzAkdDE3ODA1OTc3MzEkajYwJGwwJGgxNDkzMjExMDk).   
85. GEPA does not seem like it would work, how is this not overfitting / run into the same issues with a bunch of skills that end up being poorly used? I think chi jin’s goedel prover v2 runs into the issue but maybe thats specifically related to weight updating. Regardless, updating in ‘prompt space’ seems interesting to be able to improve frontier models instead of fine tuning. Also the labs will probably serve frontier models more cheaply than you can on rented GPUs  
86. [https://docs.massgen.ai/en/latest/](https://docs.massgen.ai/en/latest/)   
87. [https://substack.com/@gwern/note/c-270310673](https://substack.com/@gwern/note/c-270310673)   
88. [What remains scarce after AGI? – Alex Imas and Phil Trammell](https://www.youtube.com/watch?v=Jj-kBHzUohs)   
89. [https://x.com/PrimeIntellect/status/2062724179296952412?s=20](https://x.com/PrimeIntellect/status/2062724179296952412?s=20)  
90. [https://x.com/abhijaymrana/status/2062817082518258060?s=20](https://x.com/abhijaymrana/status/2062817082518258060?s=20)  
91. [https://x.com/tenobrus/status/2062729311233454363?s=20](https://x.com/tenobrus/status/2062729311233454363?s=20)  
92. [https://x.com/geetkhosla/status/2062507967010730426?s=20](https://x.com/geetkhosla/status/2062507967010730426?s=20)  
93. [https://x.com/JoshPurtell/status/2062605789454385338?s=20](https://x.com/JoshPurtell/status/2062605789454385338?s=20)  
94. [https://x.com/gakonst/status/2062116487708512355?s=20](https://x.com/gakonst/status/2062116487708512355?s=20)  
95. [https://substack.com/home/post/p-197387291](https://substack.com/home/post/p-197387291)   
    1. Feeling like this post makes arguments that could be usefully extended by well analyzing the nvidia tech report and microsoft tech report recently and coming to novel conclusions about scaling complexity  
    2. This also seems to indicate that the karpathy hire on pretraining is due to the fact that pretraining was paused rather than saturated, but incoming compute will continue to deliver major scaling gains  
96. [https://www.youtube.com/watch?v=3Yxmjf57sco](https://www.youtube.com/watch?v=3Yxmjf57sco)   
97. Steven Byrnes less wrong writing  
98. [https://vkrakovna.wordpress.com](https://vkrakovna.wordpress.com) specification gaming  
99. [https://www.campbellramble.ai](https://www.campbellramble.ai)  
100. Goodfire AI research  
101. [https://x.com/dwarkesh\_sp/status/2063335334566621297?s=20](https://x.com/dwarkesh_sp/status/2063335334566621297?s=20)  
102. [https://arxiv.org/abs/2606.02800](https://arxiv.org/abs/2606.02800)  
103. [https://x.com/chelseabfinn/status/2063433906985005510?s=20](https://x.com/chelseabfinn/status/2063433906985005510?s=20) CHELSEA  
104. [https://x.com/lateinteraction/status/2061242049622671746?s=20](https://x.com/lateinteraction/status/2061242049622671746?s=20)  
105. [https://x.com/kalomaze/status/2063122579028889983?s=20](https://x.com/kalomaze/status/2063122579028889983?s=20)  
106. [https://x.com/geetkhosla/status/2062507967010730426?s=20](https://x.com/geetkhosla/status/2062507967010730426?s=20)  
107. [https://x.com/JoshPurtell/status/2062605789454385338?s=20](https://x.com/JoshPurtell/status/2062605789454385338?s=20)  
108. [https://x.com/NoahZiems/status/2062311582580023607?s=20](https://x.com/NoahZiems/status/2062311582580023607?s=20)  
109. [https://x.com/tenobrus/status/2062729311233454363?s=20](https://x.com/tenobrus/status/2062729311233454363?s=20)   
    1. im not seeing people talk about it much so just a heads up: dynamic workflows in claude code are actually insanely fucking useful and powerful. clearly the right / sane way to do "agent orchestration". very much worth trying  
110. [https://www.dwarkesh.com/p/the-sample-efficiency-black-hole](https://www.dwarkesh.com/p/the-sample-efficiency-black-hole)   
111. [https://x.com/eliebakouch/status/2063849409515843635?s=20](https://x.com/eliebakouch/status/2063849409515843635?s=20)   
112. [https://www.lesswrong.com/posts/JT3qCYDimskcBdiEr/the-hard-core-of-alignment-is-robustifying-rl](https://www.lesswrong.com/posts/JT3qCYDimskcBdiEr/the-hard-core-of-alignment-is-robustifying-rl)   
113. [https://x.com/teortaxesTex/status/2064264430980886774?s=20](https://x.com/teortaxesTex/status/2064264430980886774?s=20)   
114. [https://github.com/NVIDIA-NeMo/Nemotron/tree/main](https://github.com/NVIDIA-NeMo/Nemotron/tree/main)   
115. [https://x.com/teortaxesTex/status/2064605846546301124?s=20](https://x.com/teortaxesTex/status/2064605846546301124?s=20)   
116. [https://x.com/teortaxesTex/status/2064550527979917631?s=20](https://x.com/teortaxesTex/status/2064550527979917631?s=20)   
117. [https://x.com/svlevine/status/2064556217289318528?s=20](https://x.com/svlevine/status/2064556217289318528?s=20)   
118. [https://x.com/dwarkesh\_sp/status/2064422596620472560?s=20](https://x.com/dwarkesh_sp/status/2064422596620472560?s=20)   
119. [https://x.com/emollick/status/2064395281903346013?s=20](https://x.com/emollick/status/2064395281903346013?s=20)   
120. [https://x.com/polynoamial/status/2064210146558136827?s=20](https://x.com/polynoamial/status/2064210146558136827?s=20)   
121. [https://x.com/eliebakouch/status/2064086258687578348?s=20](https://x.com/eliebakouch/status/2064086258687578348?s=20)   
122. [https://x.com/eliebakouch/status/2064736476995146014?s=20](https://x.com/eliebakouch/status/2064736476995146014?s=20)   
123. [https://www.a16z.news/p/institutional-ai-vs-individual-ai](https://www.a16z.news/p/institutional-ai-vs-individual-ai) coordination as first pillar here very similar to my multi agent take. The signal part feels like what im trying to do with the future version of these notes and my listed problems. Unprompted is also a novel thought ive been exploring, similar to proactivity per the randall takes.   
124. Is this guy super cracked out? How does his embodiment take relate to current work and/or multi agent work and/or AIXI? [https://scott.garrabrant.com/](https://scott.garrabrant.com/)   
125. Magnetic mirror descent [https://arxiv.org/abs/2206.05825](https://arxiv.org/abs/2206.05825) 
126. [https://gwern.net/rl-children](https://gwern.net/rl-children)  
127. https://x.com/RyanPGreenblatt/status/2065185280295100481?s=20
128. https://x.com/emollick/status/2065200484613296269?s=20
129. https://x.com/robinhanson/status/2065122280875946014?s=20
130. https://x.com/jjacky/status/2064767118118117491?s=20
131. https://substack.com/@gwern/note/c-266997559?r=4r3bqf&utm_medium=ios&utm_source=notes-share-action
132. https://arxiv.org/pdf/2603.10476
133. https://arxiv.org/pdf/2604.09855
134. https://arxiv.org/pdf/2606.13681 
135. https://x.com/chelseabfinn/status/2065559130929291630?s=20 CHELSEA
136. https://arxiv.org/abs/1709.04326 LOLA
92.
137. https://openreview.net/pdf?id=fh8EYKFKns