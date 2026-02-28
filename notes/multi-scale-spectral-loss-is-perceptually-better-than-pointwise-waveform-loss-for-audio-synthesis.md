---
description: Summing L1 magnitude spectrogram differences at multiple FFT scales (64 to 2048) aligns the training signal with perceptual quality, avoiding the problem where perceptually identical waveforms have high pointwise loss
type: property
evidence: strong
source: [[ddsp-2020]]
created: 2026-02-28
status: active
---

# multi-scale spectral loss is perceptually better than pointwise waveform loss for audio synthesis

Pointwise loss on raw waveforms (e.g., L1 sample distance) is a poor training objective for audio synthesis because human auditory perception is not sensitive to absolute waveform shape. Two waveforms that differ only in the phase offsets of their harmonics are perceptually identical yet have large pointwise differences. Autoregressive models trained on waveform loss must waste capacity learning to generate audio consistent in phase with arbitrary target phases.

DDSP uses a multi-scale spectral loss that operates in the frequency domain instead:

```
L_i = ||S_i - S_hat_i||_1 + alpha * ||log(S_i) - log(S_hat_i)||_1
```

Where S_i and S_hat_i are the magnitude (not complex) spectrograms of the original and synthesized audio computed with FFT size i. The total loss sums L_i over FFT sizes {2048, 1024, 512, 256, 128, 64} with 75% STFT overlap. Using alpha=1.0 the linear term penalizes absolute magnitude differences; the log term penalizes relative magnitude differences, which corresponds to loudness perception (roughly logarithmic in intensity).

**Why multiple scales:** Different FFT sizes provide different time-frequency resolution trade-offs.
- Large FFT sizes (2048): high frequency resolution, low time resolution -- good for distinguishing nearby pitches
- Small FFT sizes (64): high time resolution, low frequency resolution -- good for capturing transients and attack envelopes

Summing across scales ensures the loss is sensitive to both fine pitch structure and temporal dynamics simultaneously.

**Magnitude-only:** Using magnitude spectrograms discards phase information, which is the correct choice since the target phase is arbitrary for most audio synthesis tasks. The model is free to generate any phase consistent with the desired magnitude spectrum.

**Murail/neural UGen implication:** When implementing offline training pipelines for neural UGens in murail, this loss function is the appropriate training objective. It is computable from the audio graph's output buffers without requiring sample-accurate waveform matching. The independence from phase also means that even if murail's oscillator generates slightly different phases than the target, the training signal remains well-calibrated.

Contrasts with autoregressive models where pointwise waveform loss is the only option (since the model generates one sample at a time). See [[ddsp-autoencoder-achieves-high-fidelity-synthesis-without-autoregressive-or-adversarial-losses]] for the implication: this loss, combined with DDSP components, is sufficient for high-fidelity audio -- no discriminator or autoregressive teacher-forcing needed.

---

Topics:
- [[ai-ml]]
