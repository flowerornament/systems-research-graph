---
description: Factorizing harmonic amplitudes into a global amplitude envelope times a normalized harmonic distribution decouples the loudness control path from the timbre/spectral-shape control path
type: property
evidence: strong
source: [[ddsp-2020]]
created: 2026-02-28
status: active
---

# harmonic oscillator amplitude factorization separates loudness control from spectral shape

A bank of harmonic sinusoids requires per-harmonic, time-varying amplitudes A_k(n). Directly predicting 100+ independent amplitude trajectories wastes model capacity and produces entangled loudness-timbre control. DDSP introduces a factorization:

```
A_k(n) = A(n) * c_k(n)
```

Where A(n) is a global amplitude scalar controlling loudness (a single time-varying value) and c_k(n) is a normalized distribution over harmonics (sums to 1, all non-negative) controlling spectral shape -- i.e., timbre. The harmonic distribution c(n) determines the brightness and character of the sound independently of how loud it is.

This factorization has both engineering and perceptual motivation:
- **Engineering:** the network predicts one loudness trajectory plus a spectral envelope, rather than 100+ unconstrained amplitude trajectories. The normalization constraint on c(n) prevents the spectral shape and loudness from being conflated.
- **Perceptual:** loudness and timbre are distinct perceptual dimensions. Human hearing separates "how loud is this?" from "what instrument is this?". The factorization aligns the latent space with perceptual structure.
- **Interpolation:** because loudness (A) and spectral shape (c) are separate variables, the model can interpolate each independently. Changing A while holding c fixed changes volume without changing timbre.

The phases φ_0,k (initial phases) can be randomized, fixed, or learned. DDSP fixes them to zero, because neither the multi-scale spectral loss nor human perception is sensitive to absolute harmonic phase offsets -- a key observation that simplifies training.

**Murail implication:** This is a natural UGen abstraction for a harmonic oscillator in murail. The inputs would be: f0 (fundamental frequency), A (global amplitude), c (normalized harmonic distribution vector). This cleanly separates pitch control (f0), dynamics (A), and timbre (c) as independent control signals. These map directly to typical synthesis parameters that a musician or a neural network might want to control independently. The factorization also simplifies parameter ranges: A is a single positive scalar, c is a simplex-constrained vector.

Related to [[channel-format-metadata-encapsulation-enables-audio-graph-reuse-across-channel-configurations]]: both are factorizations that separate orthogonal concerns for cleaner downstream composition. See also [[disentangled-synthesis-latents-enable-pitch-loudness-and-timbre-control-independent-of-each-other]] for the learned representation that makes this factorization useful at inference time.

---

Topics:
- [[ai-ml]]
- [[audio-dsp]]
