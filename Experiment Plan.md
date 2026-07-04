
Motivation

Most value is created through navigation of social dynamics, coordination of resources, etc. AI systems are unable to interact in multiplayer environments where different players have different sets of goals and contexts since they lack the ability to make choices for themselves. There is an argument that singleton outcomes will allow AI systems to supersede the need for sociality, but limited context windows likely result in collective intelligence outweighing single intelligence in any reasonable timeframe, assuming multi-agent systems are solvable.

The best way to bring about useful collective intelligence is for each individual to have a AI system that adopts their goals and reward functions, but pursues them with the superhuman traits that models currently have and will continue to have. "Local AI systems" that adopt these personal reward functions and act superintelligently towards them do not exist yet. Truly personal AI requires granular data on the individual, algorithms that can infer rewards and model environment dynamics, and distributed compute. Data is the most valuable part of the stack since personal, nondeterministic, and fresh context is orders of magnitude more scarce than compute and algorithms.

Phases

The general steps required towards this outcome are prediction, recommendation, and agency. More specifically, we will first train a model that can predict how my brain works: what do I input into my computer given the history of what I read? If successful, we will display the model's predictions as recommendations to the user and allow the user to accept them or not. This behavior will act as more concrete reward signal / preference optimization. Finally, once the model is well able to understand how the individual thinks and verifiably move it locally forward via helpful recommendation, we will provide the model an environment that allows it to rollout its predicted actions across n+1 steps to reason about the impact of its actions on longer term outcomes, present those to the user, and determine whether its understanding of the users longer term preferences is correct.

For Step 1, we'll start with something very small, that is unlikely to yield results due to how small it is, but will help codify the fundamentals for future work. We will use the Obsidian note history to predict the next action in Obsidian, whether that be a word inserted, deleted, or edited.  

For Step 2, we will likely need to increase the amount of visible 'read' data, but we can still focus on prediction of Obsidian note typing. This will check whether increased data increases the ability for our model to perform, showing that the data has signal. There may be risks with model expressivity conflating results here. It's also unclear how to structure the full context of what's written 

For Step 3, we will expand the prediction to involve actions taken on apps other than Obsidian. This might involve browser search and prompts to AI chatbots on the web. This will inform the extent to which the data has signal, and associated increased data collection might also help performance.

These 3 steps constitute the 'prediction' phase of the work. Pending their results, we would move onto recommendation, which would use the model from the prior steps to start exposing its predictions. This bridges the initial behavior cloning to eventual superhuman performance. Top K model predictions are displayed. If one is chosen over others, or if all are ignored, then DPO is used to implicitly capture the reward of those state transitions. The implication is that a good nondeterministic predictor might expose actions that I would not immediately think of, but I could reason about being genuinely useful. As DPO, or some Bradley Terry loss, is deployed over time for this purpose, the model acts as a second brain that increases useful variation of ideas at any given moment. The biggest gap at this point is environmental evaluation, which needs to be thought through.

The biggest gaps right now are 
	actual codification of the initial phases to determine gaps. what the data looks like is still super foundational and a prerequisite for all algorithms
	review of algorithms from others to see how it relates to my hypotheses
	how does DPO differ from recsys like contextual bandits
	how does the influence of DPO on the state dynamics influence learning
	what is the actual path to environmental evaluation and selective retention, the remaining steps to superintelligence after variation
	from a thesis perspective, what are the other issues with collective intelligence

