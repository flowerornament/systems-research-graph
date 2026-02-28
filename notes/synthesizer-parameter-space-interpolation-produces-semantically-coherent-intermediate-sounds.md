---
description: Linear interpolation between two CTAG parameter vectors yields intermediate sounds that transition coherently in acoustic and semantic properties, unlike neural latent space interpolation
type: claim
evidence: moderate
source: [[cherep-2024-text-to-audio-synthesizer]]
created: 2026-02-28
status: active
---

# synthesizer parameter space interpolation produces semantically coherent intermediate sounds

CTAG demonstrates three interpolation sequences: "Spray" to "Machine gun", "Train horn" to "Chainsaw", and "Train wagon" to "Engine revving." Linear interpolation between parameter vectors (all 78 parameters) at three intermediate steps produces spectrograms that show systematic acoustic transitions -- noise bursts gradually acquiring periodic structure in the first sequence, horizontal frequency bands gradually gaining harmonic complexity in the second.

The paper frames this as a property of interpretable parameter spaces: "Our method provides a fixed set of parameters that possess this property -- a salient distinction from contemporary models equipped with high-dimensional latent spaces."

Two observations:

1. **Why this works:** Each synthesizer parameter maps directly to a physical synthesis property (attack time, LFO rate, oscillator frequency). Linear blending of these properties produces predictable acoustic effects. There is no equivalent guarantee in a neural latent space, where interpolation may pass through degenerate regions.

2. **Limitation (implied):** The semantic coherence of intermediate sounds depends on the two endpoints being acoustically compatible. Interpolating between spectrally dissimilar sounds (e.g., pure tone and white noise) will produce transitions that are not themselves semantically meaningful classes -- they are just intermediate acoustic configurations.

For murail: this establishes that modular synthesis parameter vectors form a meaningful interpolation space, which has implications for morphing synthesis, parameter automation, and time-varying sound design. A synthesis graph whose parameters are addressable (not encapsulated inside neural models) enables this class of operation. This extends the argument in [[synthesis-by-optimization-produces-an-interpretable-parameter-space-that-neural-synthesis-cannot-offer]].
