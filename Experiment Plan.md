
Motivation

Most value is created through navigation of social dynamics, coordination of resources, etc. AI systems are unable to interact in multiplayer environments where different players have different sets of goals and contexts since they lack the ability to make choices for themselves. There is an argument that singleton outcomes will allow AI systems to supersede the need for sociality, but limited context windows likely result in collective intelligence outweighing single intelligence in any reasonable timeframe, assuming multi-agent systems are solvable.

The best way to bring about useful collective intelligence is for each individual to have a AI system that adopts their goals and reward functions, but pursues them with the superhuman traits that models currently have and will continue to have. "Local AI systems" that adopt these personal reward functions and act superintelligently towards them do not exist yet. Truly personal AI requires granular data on the individual, algorithms that can infer rewards and model environment dynamics, and distributed compute. Data is the most valuable part of the stack since personal, nondeterministic, and fresh context is orders of magnitude more scarce than compute and algorithms.

Phases

The general steps required towards this outcome are prediction, recommendation, and agency. More specifically, we will first train a model that can predict how my brain works: what do I input into my computer given the history of what I read? If successful, we will display the model's predictions as recommendations to the user and allow the user to accept them or not. This behavior will act as more concrete reward signal / preference optimization. Finally, once the model is well able to understand how the individual thinks and verifiably move it locally forward via helpful recommendation, we will provide the model an environment that allows it to rollout its predicted actions across n+1 steps to reason about the impact of its actions on longer term outcomes, present those to the user, and determine whether its understanding of the users longer term preferences is correct.

For Step 1, we'll start with something very small, that is unlikely to yield results due to how small it is, but will help codify the fundamentals for future work. We will use the Obsidian note history to predict the next action in Obsidian, whether that be a word inserted, deleted, or edited.  

For Step 2, we will likely need to increase the amount of visible 'read' data, but we can still focus on prediction of Obsidian note typing. This will check whether increased data increases the ability for our model to perform, showing that the data has signal. There may be risks with model expressivity conflating results here. It's also unclear how to structure the full context of what's written. all in context or fetch based? i dont think giving browsing history content to a data set for fine tuning makes much sense.

For Step 3, we will expand the prediction to involve actions taken on apps other than Obsidian. This might involve browser search and prompts to AI chatbots on the web. This will inform the extent to which the data has signal, and associated increased data collection might also help performance.

These 3 steps constitute the 'prediction' phase of the work. All of them likely use standard cross entropy loss at a token level. Pending their results, we would move onto recommendation, which would use the model from the prior steps to start exposing its predictions. This bridges the initial behavior cloning to eventual superhuman performance. Top K model predictions are displayed. If one is chosen over others, or if all are ignored, then DPO is used to implicitly capture the reward of those state transitions. The implication is that a good nondeterministic predictor might expose actions that I would not immediately think of, but I could reason about being genuinely useful. Another way to think about this is that the initial prediction lacks counterfactuals. Recommendation allows a decent predictor to come up with its own counterfactuals to better learn the true goals. For example if a relatively dumb predictor recommends typing in 'x.com' in the browser a lot, and I continually reject that as a recommendation, it will steer away from that. It allows more active control of the model's learning rather than passive cloning. As DPO, or some Bradley Terry loss, is deployed over time for this purpose, the model acts as a second brain that increases useful variation of ideas at any given moment. The biggest gap at this point is environmental evaluation, which needs to be thought through.

It's clear that using human preference optimization to achieve superhuman performance is a false expectation. However, once there are a plethora of models that can truly deeply understand their user by their proven ability to map inbound to outbound, only then are they able to engage in social 'simulation' with the models of others and work through novel solutions based on their own goals and contexts. This will provide the environmental feedback necessary for human performance. The deterministic simulation of computer/app use I assume will be handled by the rest of the industry as time goes on, rather than be a bottleneck here.

The biggest gaps right now are 
	actual codification of the initial phases, specifically dataset construction and loss function, to determine gaps
	review of algorithms from others to see how it relates to my hypotheses. for example prospective learning [[AIXI#^6680d0]] in a multi agent environment https://gemini.google.com/app/9cecb25fc4daff93 might be the better way to frame the interaction in the context of multi agent systems rather than brain modeling, or they might be one in the same?
	how does DPO differ from recsys like contextual bandits https://gemini.google.com/app/34e424feaeb8374a
	how does the influence of DPO on the state dynamics influence learning, and is it still valid
	what is the actual path to environmental evaluation and selective retention, the remaining steps to superintelligence after variation
	from a thesis perspective, what are the other issues with collective intelligence (first paragraph)

Phase 1 Loss Function (this section written by codex for nice formatting)

The default loss for Phase 1 is supervised next-action / next-write prediction loss, i.e. behavioral cloning with token-level cross entropy.

Each training example can be represented as:

$$x_t = \text{context before action } t$$

where the context might include recent notes, diffs, browser reads, AI chats, timestamps, app state, and other available inbound context.

$$y_t = \text{the next write/action actually taken}$$

where the target might be an appended bullet, search query, AI prompt, edit operation, or other outbound action.

The Phase 1 objective is:

$$\mathcal{L}_{\text{Phase 1}}(\theta) = -\mathbb{E}_{(x_t, y_t) \sim \mathcal{D}} \left[\log \pi_\theta(y_t \mid x_t)\right]$$

In plain English: given the prior context, maximize the probability assigned to the action actually taken.

If the target action is text, this becomes ordinary token-level cross entropy:

$$\mathcal{L}_{\text{NTP}}(\theta) = -\sum_{i=1}^{n}\log \pi_\theta(y_{t,i} \mid x_t, y_{t,<i})$$

So if the target action is writing a bullet like "maybe DPO reward inference should not block self-prediction", the model is trained to predict each next token of that action conditioned on the context before it was written.

The more important design choice is not the loss function, but the target representation. Possible target choices:

- next token
- next sentence / bullet
- next write event
- next semantic action
- structured action, e.g. `{app: "obsidian", file: "Entry.md", operation: "append_bullet", content: "..."}`

For this use case, a reasonable structured version is:

$$\mathcal{L}_{\text{Phase 1}} = \lambda_a CE(a_t, \hat{a}_t) + \lambda_l CE(l_t, \hat{l}_t) + \lambda_c CE(c_t, \hat{c}_t)$$

where:

- $$a_t$$ is the action type, e.g. write, search, prompt, edit, copy, delete
- $$l_t$$ is the location, e.g. app, file, block, URL, chat
- $$c_t$$ is the content payload

The simplest toy version should be:

Given the previous git history of `Entry.md`, predict the next added line or bullet. The loss is token-level cross entropy on the actual next added text.

Clean summary: Phase 1 loss = behavioral cloning / supervised fine-tuning loss = negative log likelihood of the actual next action, usually token-level cross entropy over the next write.
