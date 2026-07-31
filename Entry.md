
- https://x.com/mitch_troy/status/2082513195357307158?s=20
- https://x.com/ankrgyl/status/2082565187064811637?s=20
- https://x.com/sonyatweetybird/status/2082549709223436658?s=20
- https://x.com/francoischauba1/status/2082858605477552417?s=46
- https://x.com/river_ai_inc/status/2082973918873415699?s=20
- https://x.com/henrytdowling/status/2082972472010260844?s=20 Twitter following is increasing more than me, how to improve
- https://x.com/jonchu/status/2082988928374894757?s=20
- https://www.11x.ai/case-study/ornn relates to jakub discussion about early outreach and invalidation. Also relates to Kevin yc feedback about emailing not coding. They seem to have done this to determine ICP, and they had something that caught the attention of these players.
- https://x.com/CoreAutoAI/status/2082937120508067938?s=20
- 
- probably worth trying coast, https://x.com/shadcn/status/2082519375194763675?s=20 tons of these popping up. orchids a new one too. there was another one i saw i didnt save, it ends with two i's https://x.com/ii_posts/status/2082855223400243634?s=20
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

some mixed personal/work todos in my notes app

One conclusion from jakub convo was that if anyones cobbling together something like screenpipe (all solutions are bad even just for this) with something like prime intellect or applied compute, they’d be the closest target

Alex now onboard with data??

Follow up with Caleb Jonah and zile for more events even in SF and also kevin 

https://www.ycrootaccess.com/p/multi-gpu-kernels-intelligence-per

https://www.youtube.com/watch?v=r1qZpYAmqmg
- course from guy who does training at openai says that non reasoning, human interactivity post training/RLHF has on the order of 100k data examples, 100k training cost on the order of days, and the bottleneck is data and evals
- if i do token level cross entropy loss for phase 1, will that delete learned pretraining language abilities? does that same issue apply to RLHF? why or why not?

good tweet https://x.com/andrewho03/status/2082786931419812338

probably makes sense to partner with labs like prime intellect. handle the data collection and structuring side and work with them to train and serve the models. bootstrapping / rev share that eventually is handled by owning the customer (the data source)