1. Short essays  
    1. exploratory multiplayer persona vector ideas  
    2. models as tools for models  
        3. How can fixed state vectors handle new actors in the environment? Does the pointer analogy make sense? (per discussion leading to models-as-tools-for-models)  
        4. Frontier models probably won’t be trained on specific environments. If further performance requires predicting the consequences of your actions on the environment and/or predicting the behavior of others (if other behavior is mapped in the state space (state space dynamism question)), then will frontier models lag models optimized for domain-specific environment prediction?  
        5. Or will models as models just take this over, even if it is true.  
        6. This is in the vein of code-as-generalization, which requires evals and compute  
    7. starting up / cdev as prior updating / RL world modeling  
    8. eval \+ sensors \+ actuators being? new software network effects  
    9. Turn levine’s paper and explanation into a blog post, perhaps code up an experiment as well if it doesnt exist already?   
        10. [https://www.youtube.com/watch?v=AK4EVrBr720](https://www.youtube.com/watch?v=AK4EVrBr720)   
        11. [https://arxiv.org/abs/2505.18098](https://arxiv.org/abs/2505.18098)   
        12. Follow up from other researcher: [https://arxiv.org/abs/2512.04601](https://arxiv.org/abs/2512.04601)   
    13. [https://gemini.google.com/app/2e7b447ca45202f4](https://gemini.google.com/app/2e7b447ca45202f4) explain how the work here (avalon) is just approximating AIXI by maintaining expected distributions over the actions of others, how it relates to Levine’s work (also modeling expected distributions over actions of others, but more broadly), how it potentially relates to models as tools for models (model distributions in micromodel space not context space, but not weight space either), how it relates to the data/reward bottleneck as explained by randall (where would the data for that to occur come from). More generally, all of this is supervised learning, which opposes self-play, but even self-play needs rewards)  
        14. [https://arxiv.org/pdf/2502.09053](https://arxiv.org/pdf/2502.09053) 	