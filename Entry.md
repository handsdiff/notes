
- https://attention.inc/
- probably worth trying coast, https://x.com/shadcn/status/2082519375194763675?s=20 tons of these popping up. orchids a new one too. there was another one i saw i didnt save, it ends with two i's
- https://www.youtube.com/watch?v=0VLAoVGf_74 welch labs vid on MLA
	- if you train on each data point in a continual learning setting, or like e2e-ttt, then you cant use a KV cache? since the key and value for each token is different after each generation? i guess that conflates token generation with data points?
	- MLA projects the tokens into a learned latent space, then runs attention on them. the KV cache is largely reduced since you now need to store the latent conversion matrix instead, and linear algebra allows you to combine the QK multiplication up front and the V multiplication with the output matrix at the end, to produce the output of the head. each head still computes its own weights, which contributes to high performance
	- this video helps me understand schmidhuber's 'fast and slow' weights better, since QK in basic attention basically learn how to apply importance to V, so QK is fast weights and V is slow weights
	- with a KV cache, flops are linear with respect to context, but it caused memory to be quadratic
https://x.com/dgt10011/status/2082558594818494916?s=20