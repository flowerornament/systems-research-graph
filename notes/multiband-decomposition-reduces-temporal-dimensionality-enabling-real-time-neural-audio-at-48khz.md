---
description: PQMF 16-band decomposition reduces 48kHz sequences to 3kHz sub-bands (16x), enabling viable CNN receptive fields and delivering a 25x synthesis speedup to 985kHz CPU throughput in RAVE
type: claim
evidence: strong
source: [[rave-2021]]
created: 2026-02-28
status: active
---

# multiband decomposition reduces temporal dimensionality enabling real-time neural audio at 48kHz

Modeling raw audio waveforms at 48kHz requires operating on sequences 3x longer than 16kHz sequences with equivalent duration. For convolutional networks, expanded receptive field at higher sample rates demands either more layers (higher compute) or larger kernels (more parameters). The PQMF (Pseudo Quadrature Mirror Filter) approach sidesteps this: a 16-band decomposition splits the 48kHz signal into 16 sub-signals each at 3kHz. The CNN operates on shorter 3kHz sequences and still captures 48kHz-relevant structure through the filter bank's frequency decomposition.

The empirical result is a 25x speedup over RAVE without multiband: CPU synthesis jumps from 38kHz to 985kHz (Table 2). This is what makes "20x faster than real-time at 48kHz on CPU" achievable. Without multiband, RAVE without multiband reaches only 38kHz synthesis speed -- below real-time for 48kHz content.

The PQMF decomposition is an orthogonal basis (cosine modulations of a low-pass prototype filter), meaning reconstruction requires only applying the temporally-flipped filter bank. The near-perfect-reconstruction property (aliasing cancellation between neighboring sub-bands via Kaiser window optimization) means the round-trip is not lossless but is perceptually transparent.

For murail: if neural UGens targeting 48kHz are in scope, multiband decomposition at the UGen boundary is likely required for real-time feasibility. This is a DSP technique, not an ML technique -- it belongs in the signal conditioning layer, not the model architecture itself.

Extends [[autoregressive-synthesis-prevents-real-time-audio-generation-at-usable-sample-rates]] by showing the orthogonal bandwidth reduction strategy. Complements [[larger-model-input-sizes-improve-per-sample-inference-performance-making-latency-tolerance-a-throughput-lever]] as a parallel technique: multiband reduces the dimensionality of what enters the model; larger input sizes amortize fixed overhead over more samples. Both compose and neither requires the other.

---

Topics:
- [[ai-ml]]
- [[audio-dsp]]
