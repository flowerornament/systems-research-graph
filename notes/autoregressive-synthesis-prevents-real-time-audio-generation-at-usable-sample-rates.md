---
description: Autoregressive sampling generates each audio sample conditioned on all prior samples, making synthesis speed proportional to sample count; WaveNet peaks at 57Hz on CPU vs 985kHz for parallel models
type: property
evidence: strong
source: [[rave-2021]]
created: 2026-02-28
status: active
---

# autoregressive synthesis prevents real-time audio generation at usable sample rates

The probability factorization p(x) = ∏ p(xₜ | x₁,...,xₜ₋₁) requires generating one sample at a time, in sequence. At 48kHz, this means 48,000 sequential forward passes per second of audio -- an architectural ceiling no hardware optimization can fundamentally overcome. The RAVE benchmark makes this concrete: NSynth (autoregressive WaveNet) achieves 57Hz synthesis speed on GPU, while parallel models like RAVE reach 11.7MHz. The gap is not one of tuning but of architectural category.

The implication for murail's neural UGen design is direct: any neural synthesis node that defers to an autoregressive model cannot participate in a real-time audio graph without a buffer-ahead caching layer that decouples synthesis from the audio callback. The latency cost of that caching layer is computable: [[anira-latency-formula-derives-minimum-required-buffering-from-worst-case-inference-time-and-buffer-size-mismatch]] shows that I_max ≈ 840 samples at 57Hz / 48kHz yields L_total = multiple host buffer periods — an untenable floor for any practical RT effect. The RAVE approach -- learn a compact latent at audio-rate training time, then run a parallel decoder at inference -- is the viable architectural pattern for real-time neural audio precisely because it reduces I_max to a range where L_total remains tolerable.

This property contradicts no existing claims, but contextualizes [[ddsp-autoencoder-achieves-high-fidelity-synthesis-without-autoregressive-or-adversarial-losses]] by explaining what DDSP avoids and why that matters operationally, and extends [[dsp-inductive-biases-reduce-model-size-by-encoding-prior-knowledge-about-periodic-audio]] by showing that architectural (not just size) choices determine RT feasibility. For parallel architectures that do fit within latency budgets, [[larger-model-input-sizes-improve-per-sample-inference-performance-making-latency-tolerance-a-throughput-lever]] documents a further efficiency lever available precisely because latency tolerance exists to be traded.

---

Topics:
- [[ai-ml]]
- [[audio-dsp]]
