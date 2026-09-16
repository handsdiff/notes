 
- Maybe conclusion is enough signal to post publicly set up inbound and positioning and keep alternating between public writing and posting and further technical work in the manner I was before vacation (more writing frequency). On a technical level the question is whether there’s enough of a foundation to support productized high emotional value and value creation in real use (need to test on myself). Open question is the visions staying power so need to reaffirm roots. Also the framework of addressing the root problem, with felt problems being downstream of the root problem and should not be addressed thinking it’s the core problem being solved, is useful in the context of relating embedded agent to time delivering context and goal specification and review (which people now seem to call alignment and make references about how it’s the best business decision). Will brown tweet is def somewhat relevant: "do the sorts of things reasonable humans would do if our brains were faster and less error-prone and had more working memory"

- one example positioning could be that you give us your raw screen data under a ZDR policy and we do all the work on the backend (data cleaning, training, UX) it takes to serve you an embedded proactive assistant that helps you complete your goals faster, starting with next write prediction workflow automation. people will pay for this if they feel lost without it i.e. its genuinely excellent at inferring what they're doing in real time and helping them.
	- started the brainstorm internally with having a product that simply gives you cleaned computer use data given the raw stream, proven by trainability success on raw vs cleaned data, which may be enough, but maybe not
- "intelligent approve for me"
- "make the decision i would make" in non verifiable domains (which includes social/multiplayer work). the key is "in non verifiable domains". because otherwise you think "wouldnt i want a better decision?". make the best decision in verifiable domains is what frontier AI does.
- "unbounded rationality"
- "i also like to say that we will know when proactivity is solved when we dont need to manually ask chatgpt anymore i think in the short term this will look like us hitting yes/no to the models prompting us instead"
	- similar to "interrupt handler instead of scheduler" tweet from gakonst
- https://bryanhpchiang.craft.me/Z2kCWLrfEPF66r

- -> post technical work done, why data cleanup is the core, and how training is REQUIRED to make the product possible (compare against astra latency, memory solutions, etc). inspired by issues explaining it yesterday and how flexing the solution feels dumb as fuck
	- whats blocking here is deciding which 'problem' to start from that correctly identifies the core work we're doing. it exists, that's why we're doing it, but needs to be clearer
	- similarly, who is the audience? technical researchers for post, enterprises for inbound? does the divergence matter? probably not
- -> establish inbound pipelines and positioning inspired by wafer's enterprise GTM or more common prosumer GTM
- -> establish current usability and everything that goes into that
	- theres a ton of work to be done that actually puts this model continually trained and serves it for cheap and fast that im likely underestimating because i havent thought it through properly
	- and that doesnt even include any phase 2 training since its very obvious to me that the humans completion is not actually ground truth
	- and this likely changes the trend lines towards extreme emotional value and reliance
	- if you assume intelligence (sample efficiency) trends up and associated cost trends down, this is the worst the trend line will ever be
- -> post again with phase 2 results / updated phase 1 results, update messaging as needed
- -> do outbound
- -> this should be a months worth of inbound uptime at this point so no hits by then would be roughly invalidating

- multi agent systems needing diversity in both information (inputs) and judgment (response to inputs)
	- is judgment distillation the most direct way to help solve heterarchical agent coordination?
- judgment distillation
- forcing function for good memory
	- learning the fact vs retrieval ability when necessary (this is also judgment)
- judgment is literally the use of information to achieve some desired goal (intermediate step is producing the 'right' action given bounded rationality)
- workflow automation
- data collection vs full product
- DPO in phase 2 as a potential solution to the issue around not being a perfect demonstrator, but needs to be quantified (rejection sampling)
- staying coupled vs autopiloting things


- maintaining a fast high quality data pipeline that scales even with phase 2 DPO is a huge effort that is critical

- we need to separate the technical report and the inbound positioning and messaging. maybe the ordering is wrong. draft inbound positioning and messaging first rather than technical report first.
	- do we need to compare to memory setups to fairly test product usefulness? when talking to people yesterday, no one actually cares about training (thats research marketing), people care about what it solves for them. didnt really have a branding that worked yet. end state was "an agent that lives on your computer, infers your goals, and helps you get there" but helps you get there was vague. "predict your next sentence" "like emails?" "mostly prompts nowadays" was another, but conflates with "an agent you dont have to prompt", which is direct but bad because it not a Full Agent and that makes it seem like it is
	- ^^ this is a messaging issue since memory comparison only matters to see if training is not worth it, not to be mentioned in the report which should focus on skill flexing. but if the problem is judgment then memory literally doesn't help.

- how can you have continual weight updating if its an extreme challenge to even support new base models and hardware as it comes out? i guess multi Lora is the solution?


Could be as simple as: multi agent systems require heterogeneity to create value. heterogeneity in context is not enough. heterogeneity in weights (judgment) lacks data to bootstrap from. our existing workflows provide a dynamic, continuous data resource for this, in fact the only one. the issue is that capturing data, cleaning data, maintaining data pipelines, training, managing compute, managing inference, and generating actual near term economic value creation to sustain development is a herculean effort. so we're fixing that. here are the results. paint the picture of the world without this and the world with this.
	(missing dynamism as a requirement, if it is one)

then for positioning: problems this deep manifest in today's practical workflows. spending time giving agents context, direction, evaluation, and waiting for their responses (basically what people do all day now). at first such a solution would improve the piloting of these agents in a coupled format, before combining both human judgment with the unique benefits of models (faster, smarter) to do this tasking for us. probably go with the narrative that we need to charge high prices to fund getting this into the world, per the prior paragraph. its altruistic and virtuous to pay us to support this effort.
	(goal inference is missing. its what connects humans self awareness of suboptimal judgment to something that can truly achieve our goals for us faster than we can. i.e SFT vs DPO)