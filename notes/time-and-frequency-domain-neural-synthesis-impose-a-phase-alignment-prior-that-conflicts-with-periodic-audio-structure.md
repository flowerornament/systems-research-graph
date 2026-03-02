---
description: Strided convolution and STFT models generate overlapping wave packets, forcing them to learn phase alignment across all frequencies--a bias that works against audio's natural oscillatory structure
type: claim
evidence: strong
source: [[ddsp-2020]]
created: 2026-02-28
status: active
---

# time and frequency domain neural synthesis impose a phase-alignment prior that conflicts with periodic audio structure

Strided convolution models (SING, MCNN, WaveGAN) generate audio as overlapping frames with a fixed hop size. Because audio oscillates at many frequencies, each with a period different from the frame size, the model must precisely align waveforms across frame boundaries for every frequency it generates. This alignment task is not inherent to the audio signal -- it is an artifact of the frame representation. The model wastes capacity learning to manage phase across frame boundaries rather than learning timbral content.

Fourier-based models (Tacotron, GANSynth) compound this with spectral leakage: when a sinusoid's frequency does not align exactly with an STFT bin, multiple neighboring bins must contribute to represent a single pure tone. The magnitude spectrogram is a smoothed, smeared representation of the underlying oscillation.

Autoregressive models (WaveNet, SampleRNN, WaveRNN) avoid the frame-alignment problem by generating sample-by-sample, but pay a different cost: they generate three perceptually identical waveforms (differing only in harmonic phase offset) with three distinct loss values, because the L1 waveform difference is non-zero even when the sounds are indistinguishable. This adds data-hungry inefficiency -- the model must learn from arbitrary phase configurations that contribute equally to the prior.

The fundamental mismatch is between the representation's natural structure (aligned wave packets or Fourier coefficients) and audio's natural structure (phase-coherent oscillation at harmonically related frequencies). DDSP addresses this by using oscillators that generate phase-coherent sinusoids directly, making the representation's prior match the signal's prior.

**Murail implication:** When designing the audio graph IR, oscillator nodes that track instantaneous phase (rather than generating fixed-size frame outputs) align with the signal's physics. A differentiable harmonic oscillator UGen in murail would not suffer from this mismatch -- it generates continuous phase trajectories parameterized by frequency, not windowed wave packets. This is why the [[harmonic-oscillator-amplitude-factorization-separates-loudness-control-from-spectral-shape]] design makes sense as a native abstraction.

Contrasts with [[synthesis-graph-construction-is-a-regular-program-not-a-domain-specific-declaration]]: McCartney's primitive IR also works at the level of individual arithmetic operations on samples, which sidesteps frame-level alignment issues. Related to [[signal-shape-as-a-type-level-property-enables-compile-time-buffer-allocation-and-vectorization]], where phase coherence over time is implicitly a property of the signal's shape contract.

---

Topics:
- [[ai-ml]]
- [[audio-dsp]]
