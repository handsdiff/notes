
- how easy is it to benchmark the performance giving astra or some other frontier model the context but also tools to search over the entire corpus of history? i.e. the reasoning becomes more 'agentic'. right now astra seems to be reasoning 'blind' i.e. pure thinking, no ability to iterate between posterior updates and new bits of information. basically the intentions of the training vision but benchmarked on existing frontier model
	- the ideal though is doing this but introducing some concept of learning/improvement over time. what might this look like? hmm.
	- 
- hmm should i benchmark astra low on the dataset, then use that for live? might be pareto. could save credits depending on how its reasoning plays out

Todo
- while data collection continues, establish usability baseline with astra in live product. may require pipeline compression, but can probably get away with being lax if resultant accuracy over time matches historical
- Usability
	- suggestion display UX, sampling timing decision, destination choice decision
	- data capture updates
	- data construction pipeline compression for live usage that mimics training
	- overnight training, hosting, serving

Opens
- Independent calcs of inference numbers. Why not profitable, what’s the vector with scale, if it’s for sure possible, slam GTM don’t be profitable
- Deep understanding of how inference works, how hardware works
- Recognize if no vectors or poor understanding or edge then allocate time differently
- how is it like a market? are market analogies valid?

alex
- gpu vs instance
- margins with a node?
- parallel forward passes defines an 'instance'? why does GPU scale not push margins then? prefill vs decode disaggregation
- instance is not tensor or pipeline parallelized
- 