---
description: Stage 1 trains encoder+decoder with spectral loss for representation quality; Stage 2 freezes the encoder and adversarially fine-tunes only the decoder for synthesis quality
type: pattern
evidence: strong
source: [[rave-2021]]
created: 2026-02-28
status: active
---

# two-stage VAE training separates representation quality from synthesis quality

Training a full VAE end-to-end with an adversarial loss entangles two distinct objectives: (1) the encoder learning a compact, meaningful latent space, and (2) the decoder generating perceptually high-quality audio. These objectives conflict because adversarial losses applied through the encoder incentivize it to encode distribution-matching information rather than semantic structure, inflating the effective dimensionality of the latent space.

RAVE's solution is temporal separation: Stage 1 trains encoder + decoder with a spectral reconstruction loss (multi-scale STFT amplitude distance) until the representation has converged. Stage 2 freezes the encoder and trains only the decoder with adversarial and feature matching objectives. The frozen encoder means the latent space topology established in Stage 1 is preserved -- the decoder is asked to learn a better acoustic realization of the existing representation, not to restructure what the encoder encodes.

This pattern generalizes beyond audio: any generative model architecture where representation compactness and output quality are both valued should consider staged training with encoder freezing. The contrast with Larsen et al. (2015) -- which applies adversarial loss through the encoder -- is the controlled experiment establishing necessity.

Connects to [[freezing-the-encoder-during-adversarial-fine-tuning-is-necessary-to-preserve-a-compact-latent-representation]] which formalizes why this separation is required, not just beneficial.

---

Topics:
- [[ai-ml]]
