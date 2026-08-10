
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
	- if you combine some ideas from prime intellect's python REPL / PTC recursivity in the sliding window vs context retrieval ablation, and its slow, you might be able to use OPD to convert that to a smaller model with the same performance and lower latency
- Helpful to read the prime intellect harness to see how they do context search via Python REPL / PTC to compare, and also the actual purpose / use cases of multi agent system work they released
- My estimation is that multi agent stuff is useless without differing judgment which is why you need to drastically reduce the friction of distilling judgment into weights I.e my vision, but maybe that stems from a poor understanding of MARL leading to wasted development time
- I think you get around its loss of “superhuman capability” intrinsically (whatever that means) that I had issues with before since it can just prompt any model it wants to get that capability the way a human does, so it’s a very specific piece in a broader puzzle
- will need to refresh the intuitions I was building before vacation and also put out the article LBH before meeting tomorrow so I can hit the ground running with data implementation and iteration in a way others could use without me for a week
- I think the focus on a public result stems from the fact that talk is cheap and undifferentiated building is cheap and attention is expensive as AI improves
- Probably relates to the article jakub shared about how LLMs commodify blank approach so thiel approach remains
- https://x.com/tobi/status/2086192833061323111?s=20
- https://x.com/jxmnop/status/2086586918880596406?s=20
- https://x.com/witcheer/status/2086418529008443421?s=20
- probably worth trying coast, https://x.com/shadcn/status/2082519375194763675?s=20 tons of these popping up. orchids a new one too. there was another one i saw i didnt save, it ends with two i's https://x.com/ii_posts/status/2082855223400243634?s=20
	- cotypist too https://cotypist.app/
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
- do any data providers like scale/surge/mercor/handshake sell pretraining data? or just RL data
- https://x.com/teodorio/status/2082791256833323010?s=20
- contains pre training data set? https://x.com/eliebakouch/status/2086833600360521852?s=20
- target market? https://x.com/himanshustwts/status/2086704020337602733?s=20
- https://x.com/irl_danB/status/2086798648306704886?s=20
- https://www.trycaret.com/
- https://x.com/gakonst/status/2086846192701640817?s=20
- https://x.com/shadcn/status/2086737201723764847?s=20
- https://x.com/river_ai_inc/status/2086903810216386802?s=20
- 

https://www.youtube.com/watch?v=r1qZpYAmqmg
- course from guy who does training at openai says that non reasoning, human interactivity post training/RLHF has on the order of 100k data examples, 100k training cost on the order of days, and the bottleneck is data and evals
- if i do token level cross entropy loss for phase 1, will that delete learned pretraining language abilities? does that same issue apply to RLHF? why or why not?

why not just tell the computer use agent your goals? why require it to 'infer' your goals from your context?
- one difference is tightly coupled vs long running
- another might be proactive vs reactive

can't properly distribute without a kernel to rally around. people use the term 'reason to exist', 'mission', 'vision', etc but more internalized its just something to point to when thinking about or referencing the entity. otherwise the entity doesn't exist. it comes from a 'feeling' perspective.

does the terminal state of such a product require combining individual models to improve the initial state of new models? by taking the data from individual models to train the 'base model'? is that not just what big labs are doing?

what highly value creative workflows become much cheaper or faster with judgment infused weights?

one way to frame the conclusion of thesis is that the only way to specify rewards properly is via imitative -> comparative learning. but the less naive step after may just be rubrics.

if a dominant method of training models is training multiple models on independent tasks then distilling into a single model, can you have one of the initially trained models be a 'meta learner' that is optimized for quick learning on downstream tasks, and have the final model retain that capability while retaining other capabilities as well? why or why not? is meta learning at odds with 'expertise'?

is next action prediction a forcing function for solving memory rather than solving goal and reward inference? it basically learns what to pay attention to given the full history of logs
- from shopify ceo, state = memo(f(log))

does the implementation of prime intellect's harness provide a blueprint for the meta optimization required for self improvement towards next action prediction? is this 'training'? the weights arent being updated but the retrieval algorithm would be, ideally forced through iterations given the reward signal (whether thats some token level next action prediction or cosine sim score)

thesis has a ton of good work but it feels a bit weird since its unclear how the described solution solves the time giving context. the way it would is that the next action predictor learns how to manipulate the log history, therefore never needing explicit context? memory solutions solve a similar problem. which implies that the forcing function is learned log attention rather than goal inference. i guess thats a more specific description of learning response to stimulus, so it would make sense in that vein

you dont need a proactive assistant if the goal is reasoning over log history though

one way to describe the true problem being solved is extracting reward signal from human behavior

prime intellect-like python REPL PTC might overfit to the data set. but if you just have a literal shitton of 'hardcoded rules', with some forcing function for less code + readable code, maybe thats fine? kind of reminds me of a AIXI optimal agent keeping all potential environments in its head and acting on whatever prior is most likely

the counterargument would be that hardcoded lost to weights long term, but can weights learn how to optimally retrieve/reason, if the context window is limited? to what extent is 'working memory' and 'memory retrieval' two separate systems in the brain? there is definitely some 'tool' being used in the brain implicitly when i read something (to connect to something else, because it 'reminds' me of something prior) which i also can somewhat 'call' explicitly if im trying really hard to remember something and then i remember it

the other way it connects, referencing above, is that it if most of my typing now and increasingly in the future is to give information to another agent to complete some task, then this learned next action predictor learns how to do that. does this increase leverage in the same way that people viewed number of employees as a status symbol for leverage? the thing about humans is that they require convincing and can opt out, whereas agents are tools without sovereignty (everything is a tool so not to be taken personally, basically give an input, have some expectation of an output, get an output, not really clear nor care how it works, has speed and cost and reliability properties)

proactive is a nice narrative until you realize the cost is 10x higher than reactive

its not 10x higher if its judgment and context retrieval is akin to the user though. not akin though, more like knows what i actually want rather than what im trying to express. which is basically where phase 2 comes in, which phase 1 bootstraps. and in theory phase 2 bootstraps phase 3 in the same way that pretraining bootstraps RLVR

what is the human intelligence per watt? what is the human learning signal per flop?

maybe retrieval is optimized to compare to pure weight optimization? obviously can combine the two as well. just need to start somewhere. can one be developed independent of the other? 

one way to think about the data collection is that it defines how to separate signal from noise in the data? since im attempting to focus on things i actually read/write rather than full history? or do i want to give full history, would that improve ability to predict next action? should i start calling it next content to properly differentiate? and also when i copy paste data into obsidian, is that a way of filtering signal from noise for the model? (in the vein of signal to noise handling per sutton's description of his work)

being good at the specific thing of converting stimulus to response, rather than attempting to maintain question answering or frontier level intelligence, since that ability can be gotten from just calling/prompting those models, invalidates the prior beliefs around superhuman intelligence doing everything for you, just aligned, and i havent fully thought through this yet

character write -> event write -> screen read -> screen crop -> interleave

is it working here



