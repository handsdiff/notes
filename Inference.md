- Understanding language modeling from scratch  
- [https://www.youtube.com/playlist?list=PLoROMvodv4rMqXOcazWaTUHhq-yembLCV](https://www.youtube.com/playlist?list=PLoROMvodv4rMqXOcazWaTUHhq-yembLCV) \+ [https://cs336.stanford.edu/](https://cs336.stanford.edu/)   
- [https://pub.sakana.ai/diffusionblocks/](https://pub.sakana.ai/diffusionblocks/)   
- [https://arxiv.org/pdf/2606.02437](https://arxiv.org/pdf/2606.02437) PEFT, multi lora, similar to models as models  
- https://loniss.com/cambrian-thesis

- useful verifiers for inference serving understanding
	- explain intuitively how thinking machines' interaction model inference differs from typical large scale inference performed by frontier labs
	- why can cerebras chips serve gpt oss 120b 3x faster than any other chip (answered by jakub)
	- how does the design of rubin differ from the design of blackwell? predict what the design of feynman will be
	- how does the current inference paradigm support or inhibit continual learning via weight updates? put another way, if you imagined a frontier model updating its weights based on daily data, would the hardware architecture of inference change? if so, how? if not, why?

- from jakub
	- We probably need to get more specific on the economies of scale I think our (my) current understanding is poor. Like if a Blackwell rack has 72 GPUs, and anthropic has 10 of those, and I have one. Is it that I can serve 1/10th of the customers at the same cost, or is it that we can serve the same amount of customers but i have to charge 10x the price for the same profit? If it’s both, then there will always be a wedge for lower scale providers with fewer GPUs that can serve fewer customers with the same or lower pricing. Additionally a frontier open source model increases the ROI on compute for everyone else besides the people with better models, chipping away at economies of scale.
	- not sure this was answered by jakub at latest meeting