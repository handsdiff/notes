- **need to keep putting out good articles and publicizing thoughts**
	- **whatever you're doing needs to be done publicly. also some clear direction / call to action we can help people with, to at least open up inbound
	- implement papers, tweet about it, write good blog posts, create nice repos
- have starred events here [[Relevant Events]] get legitimacy visible then outreach to talk, also sam from stash

- - new LBH: Come up with a new algorithms plan based on updated information, or invalidate plan further. If failed to invalidate, describe chosen algorithms and their loss functions compared to the non chosen algorithms. By Thursday.
- expected LBHs after
  - build ingestion and implement structure on data by monday after.
  - writeup on data structure and goal, different algorithms considered for this purpose, which ones make the most sense, which ones are different although they seem similar at a high level. by thursday after
  - generate toy example comparing SFT vs ICL vs memory solutions VS different randomly selected amounts of context. by thursday after.
  - writeup and publish. by monday after.
  - update toy example with newly ingested data. by monday after.
  - writeup and publish again. by thursday after.
  - outreach to algorithms invalidators (ai engineer shortlist, neolab devs). by monday after. (~5.5 weeks)

CURRENT 
- reviewing algorithm space to attempt invalidation of chosen algos and loss functions, keep alternatives and on the ground pitfalls/tricks top of mind while working. keep in mind that we're still testing weight space vs prompt space at first, since unclear what actually makes sense as what stages (i.e. evals)
	- as i go through the algos I will likely get a better and better implicit understanding of necessary data construction, which i can start to codify during the process. probably should codify the 'full' suite, and then start with a portion/subset of it for the experimentation, if it i have it available
	- some AI data structure suggestions in [[Experiment Plan]] as well from codex
	- and notes here [[Entry#^527840]] [[Entry#^15beb6]] [[Entry#^b73256]]
	- lots of relevant training examples and advice in [[Interaction]], was going to keep copy pasting but theres too many instances
- codify data structure needed for chosen algorithms, codify how to extract from base data structure to algorithm structure for each step, set up all ingestion points and monitor cleanliness

LATER
- discussion of actual data structure, and related algorithms/algorithms considered at different stages. plus the visualizations on existing data quantities.
- actually build experiment and write it up and publish [[Experiment Plan#^f4fead]]