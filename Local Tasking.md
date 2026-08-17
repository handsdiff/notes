- **need to keep putting out good articles and publicizing thoughts**
	- **whatever you're doing needs to be done publicly. also some clear direction / call to action we can help people with, to at least open up inbound
	- implement papers, tweet about it, write good blog posts, create nice repos
- have starred events here [[Relevant Events]] get legitimacy visible then outreach to talk, also sam from stash
- increase branding via twitter banner + personal site + company site
	- i am feeling really really bad about our historic, and current, lack of 'existence' and misunderstanding of social proof dynamics
	- potentially useful for personal blog/website for more legitimacy personally and for company https://x.com/shadcn/status/2075600582518124657?s=20
	- feeling a desire to have a separate website for my blogs. self hosted shows commitment. substack gets swallowed into the platform.
	- many cracked people have personal sites

- prev LBH: Publish an article describing the concrete differences in data collection required when the explicit purpose is prediction rather than retrieval. The focus is on the practicalities of data capture as discovered from the previous LBH. By Wednesday.
    - this was invalidated, since the concrete differences in data collection were not properly uncovered from making the plan
    - had to implement an initial version (which differed from the plan since i ran into practical implementation issues). this uncovered things i felt confident enough to make public. then posted the article.
    - so this LBH invalidated, next one was that implementing an initial version would uncover concrete differences that i could publish, which failed to invalidate
- new LBH: By Tuesday I will have a version of the data pipeline whose collected data I am willing to either train on or give to a closed source model to test in context prediction.
    - event demarcation issues
    - loss masking issues
        - metadata
        - copy pasted content
    - cursor position state issues
- likely after: implement training that is high fidelity towards sampling
- likely after: publish initial writeup + author public content + implement new landing page with pricing and CTA and call booking ability
	- the technical public aspect of it is showing 'local scaling laws', open sourcing data collection pipeline. could also offer hosted training for enterprises, etc. lot more ideas here i haven't made explicit yet. blocked by getting a result. probably need to clarify the goal. i do want to show we exist and are technical and can do frontier work. i also want to establish positioning / brand that reflects the beliefs that led to the work while offering something that can be downloaded and used. 
		- common references to my beliefs from a few months ago feels crucial to avoid allowing lower magnitude information to negatively impact high magnitude beliefs that seem smaller due to forgetting
		- i think building the app in a way that is easily usable by agents to configure, since realistically everyone will use their agent to interact with it anyways, feels correct
	- just staying on track, with the conviction for why, with changing information, for myself is step one. applying this to the team is step two. applying this to the market (public positioning, brand, etc) is step 3. trying to do step 3 makes step 1's foundational cracks (not lack of truth, but lack of consistent belief in why) clear ^
	- i think re-writing down why i believe what i believe, from the arc of exploration since march, fresh again would be very helpful, will likely have to do this to some extent during LBH after next

CURRENT
- DONE [[Phase 1]] and [[Phase 2]], distilled from [[Algorithms]], step 1 is being concrete about the loss functions and algorithms used for phase 1, and concrete about which loss functions and algorithms could reasonably result in demonstrator outperformance for phase 2 from an assistance perspective rather than replacement perspective.
- DONE [[Phase 3]], distilled from [[Algorithms]], step 2 is directionally discussing phase 3 goals, without necessarily being concrete about the intended algorithms and loss functions
- DONE [[Phase 1]] and [[Phase 2]], distilled from [[Algorithms]], step 3 is enriching step 1 with all the plausible ways it could go wrong, and expected next steps required in those failure modes
- DONE [[Phase 1#1.2 Assumptions and claim boundaries]] step 4 is rank the assumptions required for phase 1 to show frontier performance in order of importance to final goal
- DONE [[Data]] step 5 is determining what data to collect for phase 1 and 2, and how to clean it for phase 1
- DONE step 6 is enriching step 5 with all the plausible ways the data could be misconfigured, and expected next steps in those failure modes
- DONE step 7 is publishing this plan publicly as a blog post, for legitimacy/legibility purposes
- IN PROGRESS step 8 is implementing the hypothesized data collection

LATER
- step 10 is implement the experiment
- step 11 is publish the experiment
