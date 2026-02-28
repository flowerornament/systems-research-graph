---
description: Decomposing the latent representation into f0, loudness, and a residual timbre vector -- rather than a single unstructured embedding -- lets each dimension vary without affecting the others, enabling extrapolation beyond training data
type: claim
evidence: strong
source: [[ddsp-2020]]
created: 2026-02-28
status: active
---

# disentangled synthesis latents enable pitch loudness and timbre control independent of each other

Standard autoencoders map input to an unstructured latent vector z, which must implicitly encode all factors of variation (pitch, loudness, timbre, room acoustics). Varying z changes all factors simultaneously in an unpredictable way. Interpolation between two latents produces entangled, uncontrollable changes across all perceptual dimensions.

DDSP uses a structured, factorized latent tuple (f0(t), l(t), z(t)):
- **f0(t):** fundamental frequency trajectory, extracted by a pretrained CREPE pitch detector (supervised) or a jointly-trained ResNet (unsupervised). Fed directly to the additive synthesizer -- not passed through the decoder -- because it has structural meaning independent of the training dataset.
- **l(t):** loudness trajectory, extracted via A-weighted power spectrum + log scaling. Also extracted from audio, not predicted.
- **z(t):** 16-dimensional residual encoding of timbre information beyond pitch and loudness, extracted via MFCC -> GRU encoder.

**What disentanglement enables:**
1. **Independent interpolation:** Change f0 while holding l and z constant -- pitch changes, timbre and loudness do not. Quantitative metrics confirm this (Table C.2 in the paper: F0 L1 is stable across loudness and z interpolations).
2. **Extrapolation beyond training distribution:** f0 is fed directly to the synthesizer, not through the decoder network. The decoder only predicts harmonic distributions and noise spectra. This means f0 can be shifted outside the training range (e.g., down an octave) and the synthesizer generates coherent audio at the new pitch. The decoder's outputs remain well-conditioned because they are bounded by the nearby training distribution. The same does not apply if pitch were entangled in z: the decoder would produce unrealistic output at out-of-distribution z values.
3. **Timbre transfer:** Extract f0 and l from a source audio (voice), apply them to a DDSP model trained on a different instrument (violin). Because f0 and l are structurally disentangled, the timbre of the source does not contaminate the reconstruction.

**Connection to inductive biases:** The disentanglement is not learned through adversarial training or variational inference -- it is enforced architecturally by routing f0 and l through extraction pipelines and passing them directly to the synthesizer. Strong inductive biases make disentanglement an architectural property rather than a statistical emergence.

**Murail implication:** A neural UGen in murail that uses this architecture would expose f0, loudness, and timbre as separate control ports. This maps naturally to murail's graph model: separate input signals drive separate control paths. The key design decision is whether f0 passes through the decoder or bypasses it -- DDSP's answer is bypass, because f0 has synthesizer-level structural meaning. This contrasts with a design where the decoder is trusted to correctly use f0 conditioning internally.

Extends [[harmonic-oscillator-amplitude-factorization-separates-loudness-control-from-spectral-shape]], which is the synthesizer-side factorization corresponding to this latent-space factorization. See [[differentiable-dsp-components-make-classical-synthesis-knowledge-available-as-structural-priors-for-neural-networks]] for why architectural enforcement of disentanglement is more reliable than statistical emergence.

---

Topics:
- [[ai-ml]]
