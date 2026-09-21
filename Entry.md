
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

- Email Jessy Lin about work
- should never predict paste

- frontier model is too slow to even consider accuracy well
- trying to juice more out of training
- testing the app but its with opus so its like what am i even doing. the accuracy is useless but its honestly mostly a timing issue so that requires thinking.

- pilot is slow but sometimes the speed is fine if i could get a sense of accuracy
- sampling timing needs work
- accuracy isnt good enough
- i cant really make the frontier model faster so the only path forward seems to be making the trained model more accurate
- was having perplexity blowups which seems to result from OOD forcing
- attempting a variant of OPSD + SFT where i get the model to produce the right intent with privileged information then SFT from the base content with no special info to its privileged-conditioned completion

- im out of astra and fable, any other frontier models are terrible, but i dont want to pay per token with the personalized model since i think the harness is slop
- out of fable now too

prices should be used to equate GTM bottleneck to product bottleneck.
