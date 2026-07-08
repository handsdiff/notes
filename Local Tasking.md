- **need to keep putting out good articles and publicizing thoughts**
	- **whatever you're doing needs to be done publicly. also some clear direction / call to action we can help people with, to at least open up inbound
	- implement papers, tweet about it, write good blog posts, create nice repos
- have starred events here [[Relevant Events]] get legitimacy visible then outreach to talk, also sam from stash

new LBH: Build ingestion and implement structure on the necessary data by Thursday, with understanding of related algorithms and chosen algorithms. Output would be the data itself and a clear explanation of how to use it for intended algorithms.
  - this is because the ‘product’ involves low friction collection, automated data cleaning, and applied algorithms. attempting to establish confidence that this is possible enough, and concrete enough, to be a foundation for outreach to adjacent markets and adjacent developers
expected LBHs after (increasingly less confidence): writeup, experiment, writeup, peer outreach, market outreach
  - writeup on data structure and goal, different algorithms considered for this purpose, which ones make the most sense, which ones are different although they seem similar at a high level. btwn monday after and thursday after (1-1.5 weeks from today)
  - generate toy example establishing ‘local scaling laws’ and publish. btwn monday and thursday after (3-3.5 weeks from today)
  - outreach to algorithms invalidators (ai engineer shortlist, neolab devs). btwn monday and thursday after (4-4.5 weeks from today)

prior: "Build ingestion and implement structure on the necessary data by Thursday, with understanding of related algorithms and chosen algorithms. Output would be the data itself and a clear explanation of how to use it for intended algorithms."
new: "Understand the algorithm space and choose relevant, usable ones by Thursday, with a clear explanation of the data structure required for each algorithm and considerations of data content/signal to start with/test"
- actual ingestion and implementation of proposed data structure will be time consuming. i might still get it done and will try by thursday but i suspect not.

CURRENT 
- reviewing algorithm space to attempt invalidation of chosen algos and loss functions, keep alternatives and on the ground pitfalls/tricks top of mind while working. keep in mind that we're still testing weight space vs prompt space at first, since unclear what actually makes sense as what stages (i.e. evals)
	- as i go through the algos I will likely get a better and better implicit understanding of necessary data construction, which i can start to codify during the process. probably should codify the 'full' suite, and then start with a portion/subset of it for the experimentation, if it i have it available
	- some AI data structure suggestions in [[Experiment Plan]] as well from codex
	- and notes here [[Entry#^527840]] [[Entry#^15beb6]] [[Entry#^b73256]]
- codify data structure needed for chosen algorithms, codify how to extract from base data structure to algorithm structure for each step, set up all ingestion points and monitor cleanliness

LATER
- discussion of actual data structure, and related algorithms/algorithms considered at different stages. plus the visualizations on existing data quantities.
- actually build experiment and write it up and publish [[Experiment Plan#^f4fead]]