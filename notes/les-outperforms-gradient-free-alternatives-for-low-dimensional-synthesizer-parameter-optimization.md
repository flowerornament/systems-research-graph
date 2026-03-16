---
description: Learned Evolution Strategies (LES) significantly outperforms CMA-ES, PSO, DES, and random search for CTAG's 78-dimensional parameter optimization within a 300-iteration budget
type: claim
evidence: moderate
source: [[cherep-2024-text-to-audio-synthesizer]]
created: 2026-02-28
status: active
---

# LES outperforms gradient-free alternatives for low-dimensional synthesizer parameter optimization

CTAG's ablation study tested six gradient-free optimization algorithms: LES (Learned Evolution Strategies), CMA-ES, DES, SimpleGA, RandomSearch, and PSO. All hyperparameters were tuned via Bayesian optimization on ESC-10. LES significantly outperformed alternatives on both CLAP maximization curves and downstream classifier accuracy within 300 iterations.

Key observations:
- LES is a meta-learned evolution strategy (Lange et al., 2023), trained via meta-black-box optimization to discover attention-based update rules
- The advantage is most pronounced at lower iteration counts, suggesting LES makes better use of limited evaluations
- CMA-ES (the standard baseline for continuous black-box optimization) is competitive but clearly second-place
- Random search is surprisingly competitive against PSO and SimpleGA at this dimensionality, consistent with known results showing evolutionary methods need careful hyperparameter tuning to beat search

The practical implication: for synthesis-by-optimization problems in the range of 18-130 parameters (the architectures tested), LES with tuned hyperparameters is the recommended choice. The hyperparameter tuning itself is feasible (50 trials, no privileged information required) and can be amortized across a prompt set.

For murail: if implementing a synthesis-from-description capability, the optimization backend should implement LES or CMA-ES rather than gradient descent. The dimensionality of murail's synthesis graph parameters will likely be in the same range (tens to low hundreds), making this directly applicable. This extends [[differentiable-synthesizer-gradients-are-unstable-making-gradient-free-optimization-the-practical-choice]] with specific algorithm selection guidance.
