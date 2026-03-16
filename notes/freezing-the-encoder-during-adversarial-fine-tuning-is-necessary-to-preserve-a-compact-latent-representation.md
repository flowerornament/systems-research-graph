---
description: Applying adversarial loss through the encoder inflates latent dimensionality from 24 to 60+; encoder freezing during GAN fine-tuning is required, not optional, for compact latent representations
type: property
evidence: strong
source: [[rave-2021]]
created: 2026-02-28
status: active
---

# freezing the encoder during adversarial fine-tuning is necessary to preserve a compact latent representation

Appendix E of RAVE provides the controlled experiment: two identical RAVE models trained on the Strings dataset, one with the encoder frozen during adversarial Stage 2, one with the encoder trained to minimize the feature matching loss (as in Larsen et al. 2015). At f=0.99, the frozen-encoder model uses ~24 latent dimensions; the trained-encoder model expands toward 60+ dimensions over the adversarial training phase, and the dimensionality continues growing rather than stabilizing.

The mechanism is straightforward: the feature matching loss measures distance in the discriminator's learned feature space. Training the encoder to minimize this distance causes it to encode discriminator-relevant information (perceptual texture, fine spectral detail) that was previously handled by the decoder. This enriches the encoder's representation but at the cost of compactness -- the encoder becomes a more complex, less analysable function.

For murail's neural UGen work: if the goal is a latent space that can be manipulated, interpolated, or used as a control surface for generative composition, encoder freezing during adversarial training is a hard design constraint, not a preference. The compact representation is what enables latent space navigation.

This claim is the mechanistic backing for [[two-stage-vae-training-separates-representation-quality-from-synthesis-quality]].

---

Topics:
- [[ai-ml]]
