---
description: Scalar f ∈ [0,1] controls deployment-time compactness by projecting z onto the top-f singular value subspace; f=0.99 gives 24/128 active dims with negligible quality loss on the strings dataset
type: property
evidence: strong
source: [[rave-2021]]
created: 2026-02-28
status: active
---

# the fidelity parameter trades latent compactness against reconstruction accuracy without retraining

Once RAVE's post-training SVD analysis has computed the singular value spectrum of Z', any fidelity level f ∈ [0,1] can be applied at inference time. The low-rank projection reduces z to r_f dimensions, concatenates prior noise for the remaining dimensions, and reconstructs to full dimensionality for the decoder. This is a zero-cost operation at inference: no retraining, no architectural change.

This means the compactness-fidelity tradeoff is a deployment decision, not a training decision. A single trained model can serve multiple use cases: f=0.99 for high-fidelity reconstruction, f=0.80 for a compact control surface with 3-4 dimensions that a musician can perform with. The low-fidelity reconstructions lose speaker identity and phonemic detail but preserve coarse structure (Figure 3).

The mechanism is mathematically clean: dimensions projected out are replaced with noise sampled from the prior, so the decoder always receives a full-dimensional latent with the correct marginal distribution. The reconstruction "filling in" the dropped dimensions is not a failure but the model's prior about what typical audio looks like.

For murail: neural UGens could expose fidelity as a runtime parameter -- trading output quality for latent controllability dynamically. This is particularly relevant for live performance contexts where a musician wants a 2-3 dimensional control surface over timbre, not 24 dimensions.

Follows directly from [[post-training-svd-on-mode-means-identifies-effective-latent-dimensionality-of-a-vae]].

---

Topics:
- [[ai-ml]]
