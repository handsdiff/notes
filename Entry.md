
- https://x.com/mitch_troy/status/2082513195357307158?s=20
- https://x.com/ankrgyl/status/2082565187064811637?s=20
- https://x.com/sonyatweetybird/status/2082549709223436658?s=20
- https://x.com/francoischauba1/status/2082858605477552417?s=46
- https://x.com/river_ai_inc/status/2082973918873415699?s=20
- https://x.com/henrytdowling/status/2082972472010260844?s=20 Twitter following is increasing more than me, how to improve
- https://x.com/jonchu/status/2082988928374894757?s=20
- https://www.11x.ai/case-study/ornn relates to jakub discussion about early outreach and invalidation. Also relates to Kevin yc feedback about emailing not coding. They seem to have done this to determine ICP, and they had something that caught the attention of these players.
- https://x.com/CoreAutoAI/status/2082937120508067938?s=20
- https://x.com/willccbb/status/2083221912998601003?s=20
- https://x.com/AlexiGlad/status/2083230922196107288?s=20
- https://x.com/teortaxesTex/status/2083273714783617202?s=20
- https://x.com/teortaxesTex/status/2083641024442732619?s=20
- https://x.com/SchmidhuberAI/status/2069808010461884539?s=20
- https://x.com/eliebakouch/status/2084272149649355017?s=20
- https://x.com/marksaroufim/status/2084328575466160491?s=20
- https://x.com/henrytdowling/status/2084100456637206900?s=20
- https://x.com/grx_xce/status/2084361692792934488?s=20 how does this make money?
- https://x.com/shawmakesmagic/status/2084372897490248113?s=20
- https://x.com/LanaElys/status/2083945344203657606?s=20
- https://arxiv.org/pdf/2502.19312
- https://x.com/samzliu/status/2084664154766659665?s=20 does this suffice for link indexing the way I wanted for product? How are web chatbot chats parsed?
- Silico from goodfire is public now
- https://mysyke.com/research/the-shape-of-memory-benchmarks
- less wrong Steven Byrnes email
- All trains of thought come back to simply producing a public result
- https://x.com/gakonst/status/2084416414413443403?s=20
- https://arxiv.org/abs/2607.23802
- https://x.com/gakonst/status/2084416414413443403?s=20
- https://x.com/GaryMarcus/status/2084479075926876196?s=20
- https://x.com/JeffDean/status/2085034604172603724?s=20
- https://x.com/PrimeIntellect/status/2085086999267144083?s=20
- https://x.com/tenobrus/status/2025648199898407345?s=20
- still picking up a ton of followers https://x.com/henrytdowling/status/2085111119203430628?s=20
- one of the reasons I moved to judgment is because I think memory doesn’t actually work well due to issues like blast radius or temporal updating
- The notion that judgment distillation is required for multi agent systems might actually be a forcing function
- I think the trust and liability argument is strong but esoteric without examples
- https://x.com/gabriel1/status/2085418582192841147?s=20
- https://x.com/bgurley/status/2085407223824756945?s=20
- https://x.com/chamath/status/2085292687670812833?s=20
- https://x.com/eliebakouch/status/2085548357645152526?s=20
- https://x.com/fjzzq2002/status/2085463523203915962?s=20
- https://substack.com/@gwern/note/c-310947581?r=4r3bqf
- want to confirm I’ve written somewhere about the potential necessity of reasoning to predict rather than raw prediction, perhaps combined with RL with semantic similarity rather than log probs
- Also want to confirm the thinking around how context is searched agentically or fed once, which I think I’ve written about in the ablations
- Helpful to read the prime intellect harness to see how they do context search via Python REPL / PTC to compare, and also the actual purpose / use cases of multi agent system work they released
- My estimation is that multi agent stuff is useless without differing judgment which is why you need to drastically reduce the friction of distilling judgment into weights I.e my vision, but maybe that stems from a poor understanding of MARL leading to wasted development time
- I think you get around its loss of “superhuman capability” intrinsically (whatever that means) that I had issues with before since it can just prompt any model it wants to get that capability the way a human does, so it’s a very specific piece in a broader puzzle
- will need to refresh the intuitions I was building before vacation and also put out the article LBH before meeting tomorrow so I can hit the ground running with data implementation and iteration in a way others could use without me for a week
- I think the focus on a public result stems from the fact that talk is cheap and undifferentiated building is cheap and attention is expensive as AI improves
- Probably relates to the article jakub shared about how LLMs commodify blank approach so thiel approach remains
- https://x.com/tobi/status/2086192833061323111?s=20
- https://x.com/jxmnop/status/2086586918880596406?s=20
- https://x.com/witcheer/status/2086418529008443421?s=20
- 
- probably worth trying coast, https://x.com/shadcn/status/2082519375194763675?s=20 tons of these popping up. orchids a new one too. there was another one i saw i didnt save, it ends with two i's https://x.com/ii_posts/status/2082855223400243634?s=20
	- cotypist too
- https://www.youtube.com/watch?v=0VLAoVGf_74 welch labs vid on MLA
	- if you train on each data point in a continual learning setting, or like e2e-ttt, then you cant use a KV cache? since the key and value for each token is different after each generation? i guess that conflates token generation with data points?
	- MLA projects the tokens into a learned latent space, then runs attention on them. the KV cache is largely reduced since you now need to store the latent conversion matrix instead, and linear algebra allows you to combine the QK multiplication up front and the V multiplication with the output matrix at the end, to produce the output of the head. each head still computes its own weights, which contributes to high performance
	- this video helps me understand schmidhuber's 'fast and slow' weights better, since QK in basic attention basically learn how to apply importance to V, so QK is fast weights and V is slow weights
	- with a KV cache, flops are linear with respect to context, but it caused memory to be quadratic
- do i care about information to action mapping or do i care about a temporal understanding of past work? the thing about judgment + proactive suggestions is that its qualitatively different UX, so doesn't really feel like you can 'lineage' or MVP your way up to it
- how can data providers show that current frontier models perform poorly on their data without sending that data to the frontier model provider, therefore giving up the content for free? TEEs and open weight comparisons
- if the best ai engineers strain infra by coming up with new implementations that infra people need to then figure out how to best support, they must not be using the infra, no? since it does not support them. what lower level framework are they using?
- https://www.youtube.com/watch?v=wjZofJX0v4M basic 3b1b transformers explanation since its always helpful to re-understand the basics
	- in the LLM scenario, the weights are being tuned, from any data that backprop flows through, to increase the quality of the attention paid to prior tokens for the purposes of better predicting what comes next
	- 'generalization' as a vague concept feels impossible. regret minimization feels like a much more robust framework. since if you're in a new domain you will have to learn.
	- for the purposes of mimicking my behavior, the 'learning' feels less about the domains shifting and more about whether my judgment shifts or not. it doesnt feel like my judgment shifts that fast, so a model that is sufficiently parametrized should be able to learn it
- any work out there that quantifies the context size of an adult human brain? how does this context size relate to 'reasoning to retrieve'?
- one of the questions, related to Data notes, seems to be how much 'data' do i produce, or more specifically how much data signifies a single distribution, and how many weights are necessary, assuming some average LLM architecture, learn that data, according to papers like Kaplan and Chinchilla
- using LLMs to essentially do continuous hyperparameter search feels useful and also rote at the same time
- speed and cost matter
- 
**currently going through some foundational videos to get a better intuition for how the data should be collected and structured, since that determines everything downstream**
- 
- do any data providers like scale/surge/mercor/handshake sell pretraining data? or just RL data
- https://x.com/teodorio/status/2082791256833323010?s=20

https://www.ycrootaccess.com/p/multi-gpu-kernels-intelligence-per

https://www.youtube.com/watch?v=r1qZpYAmqmg
- course from guy who does training at openai says that non reasoning, human interactivity post training/RLHF has on the order of 100k data examples, 100k training cost on the order of days, and the bottleneck is data and evals
- if i do token level cross entropy loss for phase 1, will that delete learned pretraining language abilities? does that same issue apply to RLHF? why or why not?


why not just tell the computer use agent your goals? why require it to 'infer' your goals from your context?
- one difference is tightly coupled vs long running
- another might be proactive vs reactive

can't properly distribute without a kernel to rally around. people use the term 'reason to exist', 'mission', 'vision', etc but more internalized its just something to point to when thinking about or referencing the entity. otherwise the entity doesn't exist. it comes from a 'feeling' perspective.

does the terminal state of such a product require combining individual models to improve the initial state of new models? by taking the data from individual models to train the 'base model'? is that not just what big labs are doing?

