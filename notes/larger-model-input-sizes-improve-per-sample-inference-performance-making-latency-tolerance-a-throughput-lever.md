---
description: Larger inference buffer sizes significantly reduce per-sample inference time across all engines, creating a design lever where applications trading latency for throughput gain measurable efficiency
type: claim
evidence: strong
source: [[anira-2024]]
created: 2026-02-28
status: active
---

# Larger model input sizes improve per-sample inference performance making latency tolerance a throughput lever

Inference overhead is not fixed per sample — it decreases as more samples are processed per inference call. Ackva and Schulz's LMM-I analysis shows that almost all adjacent buffer size pairs produce highly significant runtime-per-sample reductions as buffer size increases (p < 0.0001), consistent across ONNX Runtime, LibTorch, and TensorFlow Lite. The effect is most pronounced at the low end (64–512 samples) and attenuates at larger sizes.

The practical implication: an application that can tolerate higher latency can batch more audio samples into each inference call and pay less per sample in processing time. The authors conclude directly: "for applications with less stringent latency requirements, the use of a larger model input size is advisable."

This creates a design axis specific to the latency budget. In anira's architecture, model input size is fixed at compile time via InferenceConfig.model_input_shape. When model input size exceeds the host buffer size, anira buffers incoming audio until the model's minimum input is accumulated — adding H_adapt to the total latency (see [[anira-latency-formula-derives-minimum-required-buffering-from-worst-case-inference-time-and-buffer-size-mismatch]]). This is not purely a performance improvement but a performance-latency trade-off: accepting larger H_adapt to get better per-sample inference efficiency. The throughput lever only exists for architectures that have latency tolerance to trade — [[autoregressive-synthesis-prevents-real-time-audio-generation-at-usable-sample-rates]] establishes why autoregressive models consume the entire latency budget before any such lever can be applied, making this design axis exclusive to parallel architectures.

A real-time audio effect plugin with 10 ms latency tolerance at 48 kHz has ~480 samples of budget. A plugin requiring sub-millisecond latency has ~48. The former can use substantially larger model inputs with proportionally lower per-sample cost. This means latency budget is itself a model architecture constraint — teams designing neural audio effects should consider the target latency requirement before fixing the model's input shape.

The benchmark study deliberately aligned model input size with host buffer size to isolate this variable cleanly. The performance behavior under mismatch — where H_adapt > 0 — remains an open measurement gap documented in [[host-buffer-to-model-input-mismatch-and-parallel-inference-remain-unbenchmarked-in-real-time-audio-contexts]].

This throughput lever is one of several strategies for reducing per-sample neural computation cost. [[multiband-decomposition-reduces-temporal-dimensionality-enabling-real-time-neural-audio-at-48khz]] addresses the same problem orthogonally: instead of amortizing fixed inference overhead across more samples, it reduces the dimensionality of each sample so fewer operations are required per sequence. Where multiband decomposition operates at the input representation level, input size optimization operates at the inference scheduling level — both compose and neither requires the other.

---

Source: [[anira-2024]]

Relevant Notes:
- [[anira-latency-formula-derives-minimum-required-buffering-from-worst-case-inference-time-and-buffer-size-mismatch]] — H_adapt increases with model input/host size mismatch; this claim feeds directly into the formula's H_adapt term
- [[host-buffer-to-model-input-mismatch-and-parallel-inference-remain-unbenchmarked-in-real-time-audio-contexts]] — the mismatch scenario is the key unstudied case; the throughput finding may change sign under realistic misaligned conditions
- [[onnx-runtime-is-fastest-for-stateless-neural-models-while-libtorch-is-fastest-for-stateful-models]] — engine choice is a second axis of performance variation alongside buffer size; these two levers are independent and composable
- [[autoregressive-synthesis-prevents-real-time-audio-generation-at-usable-sample-rates]] — contextualizes why the latency tolerance lever only exists for parallel architectures: autoregressive I_max consumes the entire budget before tolerance can be traded for throughput
- [[multiband-decomposition-reduces-temporal-dimensionality-enabling-real-time-neural-audio-at-48khz]] — parallel strategy operating at the input representation level rather than the inference scheduling level; both reduce per-sample neural computation cost and compose

Topics:
- [[ai-ml]]
- [[audio-dsp]]
