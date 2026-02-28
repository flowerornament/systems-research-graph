---
description: RAVE achieves MOS 3.01 vs NSynth's 2.68 using a fully parallel decoder at 17.6M parameters vs NSynth's 64.7M, showing that parallelism and quality are not in tension when adversarial objectives replace likelihood-based loss
type: claim
evidence: strong
source: [[rave-2021]]
created: 2026-02-28
status: active
---

# parallel non-autoregressive audio decoders match autoregressive quality when combined with adversarial training

The historical tradeoff in audio synthesis was stark: autoregressive models (WaveNet, NSynth) achieved high perceptual quality but were computationally prohibitive; parallel models (SING) were fast but poor quality. RAVE demonstrates that this tradeoff is an artifact of loss function choice rather than an architectural necessity.

NSynth (WaveNet-based, autoregressive, 64.7M parameters, 13 days training) achieves MOS 2.68. RAVE (parallel decoder, adversarial loss, 17.6M parameters, 7 days training) achieves MOS 3.01. SING (parallel, spectral distance loss only, 80.8M parameters) achieves MOS 1.15. The comparison isolates the adversarial objective as the key variable: SING and RAVE are both parallel, but SING uses spectral distance alone while RAVE adds adversarial fine-tuning.

The adversarial discriminator provides a learned perceptual metric that captures audio quality dimensions the spectral distance cannot. Feature matching loss (L1 distance between discriminator feature maps of real and synthesized audio) provides additional perceptual grounding without the instability of discriminator-only training.

For murail neural UGens: this is the empirical justification for using GAN-based training rather than reconstruction-only training when quality matters. The two-stage separation ([[two-stage-vae-training-separates-representation-quality-from-synthesis-quality]]) preserves the representation while the adversarial stage lifts the quality.

This contradicts no existing claims but provides evidence for [[ddsp-autoencoder-achieves-high-fidelity-synthesis-without-autoregressive-or-adversarial-losses]] by showing an alternative route to high quality (adversarial parallel) vs DDSP's route (DSP inductive biases without adversarial).

---

Topics:
- [[ai-ml]]
