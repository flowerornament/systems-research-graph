---
description: Predicting frequency-domain transfer functions converted via IDFT rather than raw convolution layers produces linear-phase FIR filters that are interpretable, phase-distortion-free, and time-varying
type: pattern
evidence: strong
source: [[ddsp-2020]]
created: 2026-02-28
status: active
---

# frequency sampling method converts network outputs into interpretable linear-phase fir filters

Standard convolutional neural network layers are mathematically equivalent to linear time-invariant FIR (LTI-FIR) filters, but they do not guarantee interpretable or perceptually desirable properties. In particular, unconstrained learned convolutions can produce phase distortion (non-linear phase response), which is perceptually undesirable for audio and makes the filter's behavior opaque.

DDSP's frequency sampling method instead trains the network to predict frequency-domain transfer functions H_l -- one per output frame -- and recovers the impulse response as h_l = IDFT(H_l). Key steps:

1. **Window the impulse response:** Apply a Hann window (size 257 in experiments) to H_l before treating it as a filter. Without windowing, the implicit rectangular window creates ringing artifacts. The window controls the time-frequency resolution trade-off.
2. **Zero-phase form:** Shift the IR to symmetric (zero-phase) form before windowing, then revert to causal form before applying the filter. This ensures the resulting filter has linear phase -- no phase distortion.
3. **Overlap-add application:** Divide audio into non-overlapping frames, perform frame-wise convolution via frequency-domain multiplication (Y_l = H_l * X_l), then overlap-add the results. Scales as O(n log n) rather than O(n^2) for long filters.

The result is a **time-varying FIR filter** (LTV-FIR) -- the frequency response changes frame-by-frame as the network predicts different transfer functions. This is more expressive than a fixed LTI filter, covers any linear filtering effect including time-varying EQ, formant filtering, and spectral shaping.

**Interpretability advantage:** Because the network predicts H_l directly in the frequency domain, one can inspect what filter the network chose at each moment. This is not possible with raw convolutional layer weights.

**Murail implication:** This pattern is directly applicable as a UGen design for learned or parameterized filters in murail. A "spectral filter UGen" could accept a frame-rate frequency-domain specification and apply it via overlap-add. The pattern also shows how to bridge between frame-rate control signals (from a neural network operating at ~250 frames/sec) and sample-rate audio processing -- a bridging problem murail must solve for all control-rate to audio-rate conversions.

Related to [[sample-accurate-triggering-in-block-based-audio-requires-splitting-render-blocks-into-sub-block-execution-lambdas]]: both involve the challenge of bridging frame-rate control signals to sample-rate audio processing, though DDSP handles it at a different level (filter design rather than event scheduling). Extends [[signal-shape-as-a-type-level-property-enables-compile-time-buffer-allocation-and-vectorization]] by showing that the frequency-domain shape of a filter can be a first-class type constraint.

---

Topics:
- [[ai-ml]]
- [[audio-dsp]]
