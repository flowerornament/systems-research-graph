---
description: Gradient flow through a modular synthesizer is highly unstable in practice, validating evolutionary/population-based methods over backpropagation for synthesizer programming
type: claim
evidence: moderate
source: [[cherep-2024-text-to-audio-synthesizer]]
created: 2026-02-28
status: active
---

# differentiable synthesizer gradients are unstable making gradient-free optimization the practical choice

Cherep et al. report that during initial CTAG experiments, "the gradients of our differentiable synthesizer" were "highly unstable," hindering optimization even after mitigation attempts. This led to adopting gradient-free evolutionary strategies (specifically LES -- Learned Evolution Strategies) which achieved substantially better results.

The instability likely arises from the non-smooth nature of synthesizer signal flow: audio-rate oscillators, clipping functions, boolean gates, and envelope step functions all produce gradient discontinuities or saturation regions. DDSP (Engel et al., 2020) addresses similar issues through careful architectural choices (harmonic oscillators, noise filter models) that admit smooth gradients. A general modular synthesizer with arbitrary routing lacks these constraints.

The practical implication is that **gradient information in general synthesizer architectures is not reliable** as an optimization signal. Ablation results confirm: LES significantly outperforms CMA-ES, PSO, and simpler baselines within 300 iterations, and gradient-based approaches were abandoned entirely.

This is relevant to murail's design: if murail wants to support synthesis-by-optimization as a workflow (tuning synthesis graph parameters from a target specification), the optimization loop should be designed around gradient-free methods unless the synthesis architecture is specifically constructed to admit smooth gradients. DDSP-style architectures (harmonic oscillators, filtered noise) are the known path to gradient stability.

Contrasts with the motivation for differentiable signal processing generally -- the DDSP paper demonstrates via [[differentiable-dsp-components-make-classical-synthesis-knowledge-available-as-structural-priors-for-neural-networks]] that carefully chosen synthesis architectures (harmonic oscillators, filtered noise) can maintain gradient stability. The key difference is that DDSP constrains synthesis to architectures with smooth gradient landscapes; a general modular synthesizer with arbitrary routing makes no such guarantee.
