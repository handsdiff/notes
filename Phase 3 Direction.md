# Phase 3 Direction: Model-Based Assistance over Increasing Horizons

**Status:** Directional extension to [[Paper]]. This note isolates the multi-step planning, simulation, and execution ideas that are outside the Phase 1 and Phase 2 method.

Phase 3 extends the one-step proposal-and-correction loop into bounded model-based assistance. Its primary objective is to improve the outcome of the human–assistant system relative to unaided work, not to replace the person with a policy that acts unilaterally. At a decision point, the system simulates several short action trajectories, shows their predicted results and uncertainty, and lets the person select, edit, reject, or ask for clarification. A selected plan authorizes guarded execution in the real computer environment. The resulting transitions, interventions, and outcomes then supervise the next dynamics and planning updates.

## 1. Relationship to assistance games

The intended interaction is structurally an assistance game. Human and assistant actions alter a shared environment; the assistant is uncertain about the person's objective; human actions and corrections provide information; and useful assistant actions may either advance the task or reduce uncertainty. Cooperative inverse reinforcement learning formalizes this structure as a partial-information game with a shared reward known to the human but initially hidden from the assistant [3]. AssistanceZero demonstrates a scalable instance in which a planner predicts human actions and beliefs over reward parameters while assisting in a complex Minecraft environment [4].

The proposed system should be described as **assistance-game-inspired**, not as a literal instantiation of either framework. Here the person is assumed to know or be able to express the active goal, but that goal may not be available to the system as a formal reward parameter or machine-verifiable payoff. The person's policy can be suboptimal, goals can vary across tasks, the action space is open-ended, and the Phase 2 policy ratio is only a dense local proxy rather than an observed shared payoff. Phase 3 must therefore maintain uncertainty, measure actual outcomes, and preserve human authority rather than claiming to inherit the optimality or incentive guarantees of a classical assistance game.

## 2. Separation of model roles

The following operational roles should remain conceptually distinct even if an implementation shares encoders or base weights:

1. **Personalized action prior.** The current canonical policy $\pi_d$ proposes actions near the person's learned behavioral and coactive distribution. It supplies search priors and candidate representations; it is not by itself a world model.
2. **Human-response model.** Phase 2 BC already trains the canonical model to predict the person's next action from augmented contexts $(h,Z^R)$. Phase 3 may use that conditional directly or fork a versioned response-specific copy $H_\omega$ so planner gradients do not silently redefine the behavioral estimator.
3. **World-dynamics model.** An action-conditioned model $\widehat T_\phi$ predicts computer and artifact transitions. It models application state separately from the person's response whenever the data permits that factorization.
4. **Trajectory planner.** A policy or search procedure $q_\psi$ proposes joint futures from the action prior, response model, dynamics model, tool constraints, and sandbox.
5. **Trajectory scorer.** A model $V_\xi$ or direct planner objective learns from explicit plan selections, edits, execution interventions, and delayed outcomes. The Phase 2 preference-shaped action score initializes local comparisons but is not assumed to be this trajectory value or the global goal reward.

This separation is motivated by the useful distinction between learning a model of human behavior and training an agent to collaborate with it [1]. It also makes failures attributable: a bad forecast can arise from dynamics error, human-response error, value error, search error, or an unsafe execution layer rather than from one undifferentiated model.

## 3. World-dynamics learning and sandbox grounding

Let $x_t$ denote a structured observation of the computer environment and let $a_t^H$, $a_t^A$, and $e_t$ denote human actions, assistant actions, and observed exogenous events. The initial high-confidence dynamics objective is action-conditioned next-state likelihood:

$$
\mathcal{L}_{\mathrm{dyn}}(\phi)
=
-\mathbb{E}_{\mathcal{D}_{\mathrm{dyn}}}
\left[
\sum_t
\log \widehat T_\phi
\left(
x_{t+1}\mid x_{\leq t},a_t^H,a_t^A,e_t
\right)
\right].
$$

The exact observation loss may combine structured-state prediction, latent consistency, reconstruction, or perceptual terms depending on the application. Those choices are not fixed here. Dreamer 4 provides a relevant precedent for learning a fast action-conditioned world model from offline video and action data, then training behavior through simulated experience inside that model [5]. The analogy is architectural rather than complete: Dreamer 4 has a single controlling agent and a machine-observed environment reward, whereas Phase 3 has an assistant that is uncertain about a human-known personalized objective and must interact with the human.

The Phase 1 and Phase 2 event stream already contains many observed transitions, but only under the historical human and deployed-assistant policies. Before/after state snapshots, joint action attribution, exogenous events, and environment-instance identifiers must therefore remain reconstructable. Passive traces do not identify the result of arbitrary untried actions. A computer-use sandbox supplies safer counterfactual action coverage and provides a grounding environment for validating imagined rollouts.

The initial simulator should be hybrid. Structured APIs, document diffs, accessibility trees, DOM state, files, and application snapshots are preferred to pixel-only prediction when available. The learned model performs cheap broad search; promising branches are re-executed in isolated sandbox clones; only selected and authorized plans cross into the production environment. A sandbox can faithfully test many local computer transitions but cannot simulate a person's future response, another person's reaction, or an irreversible external side effect. Such boundaries require uncertainty, abstention, or a real-world approval checkpoint.

## 4. Trajectory proposals and user feedback

At horizon $H$, let a displayed trajectory bundle contain assistant actions, any modeled human checkpoints, simulated states, and a predicted result:

$$
\tau_i^{(H)}
=
\left(
a_{i,1:H}^A,
\widehat a_{i,1:H}^H,
\widehat x_{i,1:H}
\right).
$$

Null human actions are allowed when a plan is intended to execute without intermediate interaction. The system generates several diverse bundles, validates promising ones in the sandbox where possible, and displays the exact actions, predicted result, uncertainty, simulator version, and approval boundaries. The person can select one, edit it, reject all, or request clarification. The exact displayed bundle is part of the feedback record: selecting an attractive forecast is not evidence that the person would prefer an incorrectly simulated real outcome.

A selection creates a trajectory-level comparison $\tau^+\succ\tau_i^-$ among the bundles actually displayed. It should not automatically create a winner label for every individual step. A proposal may be valuable because of its combined outcome even if an isolated step appears unnecessary, and an execution intervention may localize a failure to only one prefix. Edits, aborts, rollback requests, simulator disagreements, and observed final outcomes are retained as distinct feedback types rather than collapsed into one binary label.

## 5. Directional trajectory objectives

The high-confidence requirement is to learn from complete displayed trajectories rather than sum the Phase 2 action score as though it were already a return. The person's global goal reward exists, but the Phase 2 score is not yet an estimator of that full return. Different rollouts visit different contexts, so the arbitrary context terms in the Phase 2 log-ratio do not cancel across paths. The ratio also reflects both BC and preference gradients and is calibrated only near collected one-step comparisons. It may guide same-state pruning, proposal initialization, or short search, but

$$
\sum_{k=1}^{H}
\widehat r_{d,u}^{(\mathrm{step})}(h_k,a_k)
$$

is not specified as the Phase 3 trajectory reward.

Two initial trajectory estimators are reasonable. If the planner defines a tractable probability over serialized trajectory bundles, selected and unselected plans can extend the rolling-reference IPO construction [2]. Define

$$
\Delta_\psi^\tau
=
\log\frac{q_\psi(\tau^+\mid x,u)}{q_{\mathrm{ref}}(\tau^+\mid x,u)}
-
\log\frac{q_\psi(\tau^-\mid x,u)}{q_{\mathrm{ref}}(\tau^-\mid x,u)},
$$

and optimize

$$
\mathcal{L}_{\mathrm{traj\text{-}IPO}}(\psi)
=
\mathbb{E}
\left[
\left(
\Delta_\psi^\tau-\frac{1}{2\beta_H}
\right)^2
\right],
$$

where the reference and $\beta_H$ are versioned by horizon. If planning relies on search rather than a normalized trajectory policy, a separate scorer can instead use the pairwise objective below, following the trajectory-segment preference-learning precedent of Christiano et al. [6]:

$$
\mathcal{L}_{V}(\xi)
=
-\mathbb{E}
\left[
\log\sigma
\left(
V_\xi(x,u,\tau^+)-V_\xi(x,u,\tau^-)
\right)
\right].
$$

These are alternative starting estimators, not requirements to optimize both losses. Direct trajectory IPO is natural when planner log-probabilities are meaningful; a separate scorer is natural for reranking heterogeneous search outputs and incorporating explicit outcomes. Neither estimator by itself solves causal assistance evaluation. Randomized no-plan or alternative-slate holdouts and downstream outcome measurements remain necessary to establish that the system improves the human–assistant process rather than merely predicting which generated plan will be selected.

## 6. Horizon curriculum and bounded execution

Phase 3 begins at the already observed one-step boundary and expands to $H=2,3,\ldots$ only after passing horizon-specific gates. At minimum, those gates measure:

- dynamics calibration and uncertainty over the full rollout;
- agreement between learned-model predictions and sandbox transitions;
- agreement between sandbox predictions and authorized production outcomes;
- plan selection, editing, rejection, intervention, abort, and rollback rates;
- downstream assistance quality relative to no-plan or shorter-horizon controls; and
- safety, reversibility, tool permission, and support-coverage checks.

The intended loop is:

```text
procedure RUN_PHASE3_ASSISTANCE_CYCLE(
    current_state x, horizon H, action_prior pi_d,
    response_model H_omega, dynamics T_phi,
    planner q_psi, trajectory_scorer V_xi, sandbox
):
    imagined <- PLAN_DIVERSE_TRAJECTORIES(
        x,
        horizon=H,
        prior=pi_d,
        response_model=H_omega,
        dynamics=T_phi,
        scorer=V_xi
    )

    verified <- SANDBOX_VALIDATE_PROMISING_BRANCHES(imagined, sandbox)
    displayed <- SHOW_ACTIONS_RESULTS_UNCERTAINTY_AND_BOUNDARIES(verified)
    response <- WAIT_FOR_SELECT_EDIT_REJECT_OR_CLARIFY(displayed)
    STORE_EXACT_DISPLAY_AND_RESPONSE(displayed, response)

    if response selects or edits a plan:
        plan <- APPLY_USER_EDITS_AND_REVALIDATE(response.plan, sandbox)
        trace <- GUARDED_EXECUTE_WITH_CHECKPOINTS(plan)
        STORE_PREDICTED_AND_ACTUAL_TRANSITIONS(trace)

    BUILD_WHOLE_TRAJECTORY_PREFERENCES(displayed, response)
    ASYNCHRONOUSLY_UPDATE_DYNAMICS_RESPONSE_VALUE_AND_PLANNER_MODELS()

    if PASSES_HORIZON_EXPANSION_GATES(H):
        authorize experiments at horizon H + 1
```

This pseudocode fixes the information and authority flow, not the final planning optimizer. Search may later use sampling, beam search, Monte Carlo tree search, model-predictive control, actor–critic learning in imagination, or hybrids. The choice depends on simulator fidelity, action branching, reward identifiability, and compute. Regardless of optimizer, learned-model rollouts do not authorize real side effects: sandbox validation, user selection, typed permissions, checkpoints, and rollback remain separate execution-layer requirements.

## References

[1] M. Carroll et al. [*On the Utility of Learning about Humans for Human-AI Coordination*](https://arxiv.org/abs/1910.05789). 2019.

[2] M. G. Azar et al. [*A General Theoretical Paradigm to Understand Learning from Human Preferences*](https://arxiv.org/abs/2310.12036). 2023.

[3] D. Hadfield-Menell, A. Dragan, P. Abbeel, and S. Russell. [*Cooperative Inverse Reinforcement Learning*](https://arxiv.org/abs/1606.03137). 2016.

[4] C. Laidlaw et al. [*AssistanceZero: Scalably Solving Assistance Games*](https://arxiv.org/abs/2504.07091). 2025.

[5] D. Hafner, W. Yan, and T. Lillicrap. [*Training Agents Inside of Scalable World Models*](https://arxiv.org/abs/2509.24527). 2025.

[6] P. F. Christiano et al. [*Deep Reinforcement Learning from Human Preferences*](https://arxiv.org/abs/1706.03741). 2017.

