---
description: SVD on the posterior mode-mean matrix (not sampled Z) isolates input-correlated dimensions from prior-collapsed ones, revealing the true effective rank of the learned representation post-hoc
type: pattern
evidence: strong
source: [[rave-2021]]
created: 2026-02-28
status: active
---

# post-training SVD on mode means identifies effective latent dimensionality of a VAE

The standard approach to determining latent dimensionality is to set it before training and hope the β-VAE pressure collapses uninformative dimensions. RAVE introduces a post-training analysis that makes this determination explicit.

The key insight is operating on the mode matrix Z' rather than sampled Z. Dimensions that have collapsed to the prior have constant mode values (the prior mean, typically 0); after centering, these become zero columns in Z'. Only dimensions with non-zero values after centering are correlated with the input -- they constitute the informative subspace. Applying SVD to Z' then gives a clean rank estimate via singular value spectrum.

The fidelity parameter f selects rank r_f as the smallest r capturing fraction f of total singular value mass. At f=0.99, a 128-dimensional latent collapses to 24 dimensions (strings) or 16 dimensions (VCTK) with negligible reconstruction quality loss. The informative subspace is then a principled low-dimensional manifold within the higher-dimensional space, not an arbitrary truncation.

For murail: this technique is directly applicable to any scenario where a neural UGen's latent space needs to be exposed as a controllable parameter surface. The post-training SVD tells you how many knobs actually matter.

This is a concrete implementation of the general principle that [[dsp-inductive-biases-reduce-model-size-by-encoding-prior-knowledge-about-periodic-audio]] -- here the bias is structural (the SVD analysis), not parametric.

---

Topics:
- [[ai-ml]]
