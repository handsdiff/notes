 
- https://x.com/pwendell/status/2100299179923067016?s=20
- https://x.com/amasad/status/2100045670845763791?s=20
- https://x.com/VitalikButerin/status/2100388909410885974?s=20
- https://x.com/harshagundal/status/2100044305536889015?s=20
- https://x.com/banteg/status/2100619607648121199?s=20
- Add to post “where does alignment come from?” and how it comes from judgment distillation?
- -> post technical work done, why data cleanup is the core, and how training is REQUIRED to make the product possible (compare against astra latency, memory solutions, etc).
	- missing piece here is compare against reasonably strong memory system?
	- do we need to compare to memory setups to fairly test product usefulness? when talking to people yesterday, no one actually cares about training (thats research marketing), people care about what it solves for them. didnt really have a branding that worked yet. end state was "an agent that lives on your computer, infers your goals, and helps you get there" but helps you get there was vague. "predict your next sentence" "like emails?" "mostly prompts nowadays" was another, but conflates with "an agent you dont have to prompt", which is direct but bad because it not a Full Agent and that makes it seem like it is
- -> establish inbound pipelines and positioning inspired by common prosumer GTM
- -> establish current usability and everything that goes into that
	- theres a ton of work to be done that actually puts this model continually trained and serves it for cheap and fast that im likely underestimating because i havent thought it through properly
	- and that doesnt even include any phase 2 training since its very obvious to me that the humans completion is not actually ground truth. the actual experimental training there comes after product usability
	- and this likely changes the trend lines towards extreme emotional value and reliance
	- if you assume intelligence (sample efficiency) trends up and associated cost trends down, this is the worst the trend line will ever be
	- On a technical level the question is whether there’s enough of a foundation to support productized high emotional value and value creation in real use (need to test on myself)
	- need to continuously get the weights, put them on a gpu, serve them. for all users, which requires handling multi lora on a single GPU setup? not sure if any service providers for this / if it is required manually
- -> post again with phase 2 results / updated phase 1 results, update messaging as needed
- -> do outbound
- -> this should be a months worth of inbound uptime at this point so no hits by then would be roughly invalidating


Could be as simple as: multi agent systems require heterogeneity to create value. heterogeneity in context is not enough. heterogeneity in weights (judgment) lacks data to bootstrap from. our existing workflows provide a dynamic, continuous data resource for this, in fact the only one. the issue is that capturing data, cleaning data, maintaining data pipelines, training, managing compute, managing inference, and generating actual near term economic value creation to sustain development is a herculean effort. so we're fixing that. here are the results. paint the picture of the world without this and the world with this.
	(missing dynamism as a requirement, if it is one)
	one example positioning could be that you give us your raw screen data under a ZDR policy and we do all the work on the backend (data cleaning, training, UX) it takes to serve you an embedded proactive assistant that helps you complete your goals faster, starting with next write prediction workflow automation. people will pay for this if they feel lost without it i.e. its genuinely excellent at inferring what they're doing in real time and helping them.
	- started the brainstorm internally with having a product that simply gives you cleaned computer use data given the raw stream, proven by trainability success on raw vs cleaned data, which may be enough, but maybe not
	- data cleanup as initial product similar to wafer optimizing inference for others before internalizing? "we clean your computer use data for retrieval and training"
	"make the decision i would make" in non verifiable domains (which includes social/multiplayer work). the key is "in non verifiable domains". because otherwise you think "wouldnt i want a better decision?". make the best decision in verifiable domains is what frontier AI does. dynamic domains are a subset of nonverifiable domains. that doesnt feel quite right. also i cant help but feel that coding is not verifiable, so why are there such gains there?
		"It’s reasonable to question whether you need a “base user model” compared to simply training directly on specific tasks for a certain use case or domain (e.g. a user reward model for coding can be much more narrow than a general “base user model”)"
	this solves 'social adaptability' aka putting ourselves into the future agent society that will move 100x faster than we can comprehend or participate in
	"automating thinking" is misaligned with "coupled"?
	i think i wrote somewhere publicly about judgment being a prerequisite for trust + memes about fiduciary, assets/liabilities, etc
	more intelligence makes data more valuable
	
then for positioning: problems this deep manifest in today's practical workflows. spending time giving agents context, direction, evaluation, and waiting for their responses (basically what people do all day now). (exacerbated by dynamism?) at first such a solution would improve the piloting of these agents by more rapidly collecting context and converting it into a high taste prompt that reflects what you, in a slower and higher effort way, would do. eventually, the user model gets good enough to infer your goals and start suggesting things that you would be happy to do that you wouldn't have thought of (unbounding rationality, removing yourself as the bottleneck). then, frontier models could work with your user model to complete tasking together before presenting it to you. finally, a single agent could both distill your judgment and also apply it in a way thats faster/smarter to achieve your goals. (proactive intervention due to prospective learning from user model). every step builds upon the prior step, so a single full frontier agent would still continually update based on the data you generate continuously. probably go with the narrative that we need to charge high prices to fund getting this into the world, per the prior paragraph. its altruistic and virtuous to pay us to support this effort.
	(goal inference is missing. its what connects humans self awareness of suboptimal judgment to something that can truly achieve our goals for us faster than we can. i.e SFT vs DPO) (lossy expression of actions towards a goal vs goal itself)
	data collection vs full product
	DPO in phase 2 as a potential solution to the issue around not being a perfect demonstrator, but needs to be quantified (rejection sampling)
	staying coupled vs autopiloting things
	most writing will be to agents in the limit
	open questions as to whether tightly looped SFT is superior to DPO, per the notes in [[Publication]]? again and again, we need some way of 'superhuman' performance elicitation given that the human demonstrator initially being SFTd is suboptimal, and current attempts to sprinkle frontier models onto the dataset pre training will not be sufficient long term imo. the chatgpt thread where i asked it to find inconsistencies flags these.

skill post is technical researchers and positioning / messaging is for target market, ideally enterprise? still havent decided enterprise or prosumer. which one would relate more deeply to problem? the stated problem is more of a meta problem, and the actual problem could be both prosumer or enterprise imo. basically coupled agents for 80% of work (decision making, sociality) and frontier agents or task specific fine tunes for 20% of work (silo'd execution).

give users (researchers?) api access to their latest model? seems like the people that might be most interested in using are the people building it for themselves? i.e. the usermodels discord and their friends and colleagues? or omar shaikh friends/colleagues? aka the stanford NLP lab, thinking machines, etc

to get myself using the product i should probably just start with astra! that saves a ton of time while still getting usability results calibrated a bit better

RSI on what task? still need to define the hill to climb. cleaning up the data leakage is crucial towards leveraging smarter and smarter models, since otherwise there are tons of capture gaps.

---

- per noam brown, math stands out not only because its verifiable, but because its bottlenecked by thinking. relates to the core auto guy's take on kicking a soccer ball vs doing math. maybe this is what is meant by "grindable"?
- what does the linear graph of data vs loss look like? what about the log linear graph of data vs loss? are there more direct ways to get loss vs accuracy relationships? or data vs accuracy relationships? jward's takes are very practical which is grounding
	- more deeply understanding what jward's messaging reveals about his thinking is likely very useful to frame discussion tomorrow. lots of interesting points that resonate with my thinking. maybe write down notes for each internalized message from him
- you might actually need the full product i.e. real time suggestions to improve the slope of learning, once you get to some decent accuracy threshold. because once you start accepting suggestions verbatim, then the grader needs to do less work to match 'same intent but said better' since its from the model already, and the training is now on the more direct completion rather than the best human effort completion, which should over time distill pure judgment. so SFT on this is probably more than fine to start. (seems like PTC + reasoning might still be useful since it isnt mutually exclusive)
	- writing it out, this is thesis post ideas restated

jward msgs
- "Very interested in getting to the point where the user model outperforms the zero-shot frontier models"
	- yep this is the thesis
- "what latent point in time context would be helpful to give the model so it could better predict the decision I'd make"
	- yep, my thoughts around using this data set up as a forcing function for allowing models to just cook on the history of data and figure out their own primitives, whether thats novel retrieval algorithms or new ways of composing existing ones. dont care if its 'overfitting' if it improves performance on the task.
	- basically objective could be CE or semantic similarity, but context instead of simple sliding window could be PTC/RLM, more akin to longnap.
	- would love to try this but expensive and there seems to be lower hanging fruit
- "the path forward for hill climbing pivotal decisions is more like data aug or more like RL" + "presenting the decisions made to the model in a more extracted/standardized format"
	- yeah ive allowed flexibility in grading for now to support this but tons of open questions on how to best use this data on the path from decision repro -> superhuman performance with goal inference as the hopeful bridge
- "aiming for decision-repro rather than going superhuman"
- "eager to see steady hill climbing"
- "my top feedback things on the doc:
	- it would be ideal to have an exec summary or abstract that communicates the results. (Its a bit tricky since its a blend of position paper and results paper, but getting the takeaway results closer to the top is good). Right now from a quick read it seems like the main quantitative result is the 1/1000th cost of models writing compared to people. But that's not actually your main claim.
	- it would be ideal to have 1-2 concrete examples of the predictions made and the grading.
	- It would be ideal to have some more evidence for the claim of linear scaling of performance. Usually performance scaling is loosely log-linear. I.e. you need exponential increases in data/compute for linear improvements in downstream task performance."



--- 

slides
- im not a PhD, i dont have good training intuitions for LLMs. but i know some things. i did RL research and sold a machine learning application in college. i know high quality data is the foundation.
- came at current work from lots of different angles
	- personal alignment / reward functions. claude/codex are given direction by someone else.
	- im the bottleneck to working faster. hard to process all inbound info.
	- multi agent systems mode collapse
	- continual learning? RSI? on what?
	- really excited to be able to collaborate with you all
- task construction/training -> capture all read / write, SFT on writes conditioned on prior information. since its continual data, train on block A, evaluate on next block B, then train on block B from checkpoint A to evaluate on block C, etc. can vary how you specify a block. start with token level cross entropy on writes. vision is some sort of intent based similarity that allows for superhuman outputs with agent led context construction, perhaps rejection sampled against human continuations for better training performance.
- data capture. going to be a bit of a retrospective since its hard to exactly recall my cognitive state at each moment, but theres basically 4 fps screen capture, keyboard and mouse tracking, 1s read/write capture delays. app whitelisting. then we go through a complicated process combining scripts with ai assisted review with the goal of 
	- capturing attention via mouse position + pane selection
	- OCR
	- removing tons of duplicate reads. cleaning up OCR issues (screenshot boundaries)
	- handling dynamically produced context (ai chats)
	- consolidating micro writes (human process of input vs input)
	- managing causality of read/writes, when to keep writes split, etc
	- basically longest write that happens with no new inbound information, and adjacent reads dont have any duplicate info
	- attempt to closely match my attention, how i process data, what information im ingesting, and the end state of my ingestion and processing and assembling, not the messy interface between ingesting info (scrolling) and writing (edits, typos, changing screens)
	- very empirical. i set up something, then look at the data and consider whether 1) it well matches how i viewed my read/write during that time and 2) its clean enough to see training signal
	- i do think that data is the main bottleneck to work here, since the more data i have, the more i can extract signal from it via various algorithmic tricks which frontier models can help with
- results
- primarily need to establish slope of data/params to substantive accuracy along with usable accuracy rate
- im currently hooking this system up into something usable during my day, to start collecting data on what levels of accuracy feel genuinely wowed
- this will establish baseline timelines for when this could be a daily driver for me. growing intelligence per dollar and improved time on best utilizing this data should only make this better. there really are so many things that can be tried on top of a worthwhile problem to solve + clean data
- extremely exciting to me for a model to be able to frontrun my thoughts! lots of downstream implications that i've written about in various places but can always talk about that stuff later.