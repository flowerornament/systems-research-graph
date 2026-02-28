---
description: Linear mixed effects analysis across CNN and hybrid models finds ONNX Runtime consistently fastest for stateless inference; stateful LSTM favors LibTorch over TFLite on average
type: claim
evidence: strong
source: [[anira-2024]]
created: 2026-02-28
status: active
---

# ONNX Runtime is fastest for stateless neural models while LibTorch is fastest for stateful models

Choosing an inference engine for a neural audio application is not a single decision — it depends on whether the model architecture requires stateful operation. Ackva and Schulz's benchmarking study quantifies this split using linear mixed effects models across two datasets.

**Stateless models (LMM-I, CNN-29k and HNN-11k):** ONNX Runtime consistently outperforms both LibTorch and TensorFlow Lite. All comparisons reach statistical significance (p < 0.0001), with the one exception of ONNX vs TFLite for HNN-11k (p = 0.045). The performance ordering is: Bypass > ONNX Runtime > LibTorch > TensorFlow Lite.

**Stateful models (LMM-II):** ONNX Runtime is excluded from this comparison because it does not support stateful LSTM operations — see [[onnx-runtime-does-not-support-stateful-lstm-operations-restricting-it-to-stateless-neural-architectures]]. Between LibTorch and TensorFlow Lite, LibTorch outperforms TFLite on average across RNN-2k, CNN-29k, and HNN-11k. However, the model-by-model results are inconsistent: TFLite is slower for CNN-29k and RNN-2k but faster for HNN-11k. This inconsistency motivates a follow-up study (LMM-III) showing that engine-model interaction depends on model size — see [[tensorflow-lite-outperforms-libtorch-for-small-cnn-models-but-libtorch-becomes-faster-as-model-size-grows]].

The practical implication for murail's neural UGen design: stateless models (feedforward CNNs, TCNs without persistent state) should prefer ONNX Runtime; stateful effects (guitar amp emulation, compressors using LSTM) must use LibTorch or TFLite, with LibTorch preferred for larger models. Engine choice interacts with model architecture in ways that cannot be decided at library selection time — it requires knowing the target model's state requirements and approximate parameter count. For DDSP-style architectures, [[dsp-inductive-biases-reduce-model-size-by-encoding-prior-knowledge-about-periodic-audio]] places most models well below the 1k-parameter crossover where TFLite's advantage over LibTorch applies, making ONNX Runtime (stateless) or TFLite (if stateful components exist) the default engine choices for this entire model family without needing per-model benchmarking.

The performance ranking reported here assumes stabilized runtimes. Because [[warm-up-inferences-before-the-audio-callback-stabilize-inference-engine-runtimes]], the ranking only reflects steady-state behavior after initial iterations; pre-warmup, LibTorch in particular shows significantly elevated runtimes that could invert relative comparisons. Engine selection for murail UGens should be validated on post-warmup data.

Engine choice is also a lever in [[anira-latency-formula-derives-minimum-required-buffering-from-worst-case-inference-time-and-buffer-size-mismatch]]: selecting ONNX Runtime for a stateless model directly reduces I_max, which reduces the minimum achievable L_total across all host buffer sizes. This makes engine selection a first-class design decision in latency budget planning, not merely a throughput optimization.

For stateless models where ONNX Runtime's speed advantage applies, [[static-thread-pool-decouples-neural-inference-from-the-audio-callback-to-ensure-real-time-safety]] enables parallel inference: multiple ThreadPool threads can run the stateless model concurrently. Stateful models (forced to LibTorch) cannot share hidden state across threads and cannot benefit from this parallelism. The stateless/stateful split thus has architectural consequences beyond raw inference speed.

---

Source: [[anira-2024]]

Relevant Notes:
- [[onnx-runtime-does-not-support-stateful-lstm-operations-restricting-it-to-stateless-neural-architectures]] — explains why ONNX is excluded from stateful comparisons
- [[tensorflow-lite-outperforms-libtorch-for-small-cnn-models-but-libtorch-becomes-faster-as-model-size-grows]] — model-size nuance to stateful results
- [[larger-model-input-sizes-improve-per-sample-inference-performance-making-latency-tolerance-a-throughput-lever]] — buffer size is a second axis of performance variation
- [[inference-engines-violate-real-time-principles-on-every-inference-not-just-initial-ones]] — the engine performance ranking correlates with RT violation severity: ONNX Runtime fastest and lightest violations, LibTorch slowest and most invasive
- [[warm-up-inferences-before-the-audio-callback-stabilize-inference-engine-runtimes]] — the ranking assumes post-warmup runtimes; pre-warmup behavior, especially LibTorch's elevated initial RpS, could distort comparisons
- [[anira-latency-formula-derives-minimum-required-buffering-from-worst-case-inference-time-and-buffer-size-mismatch]] — engine selection is a lever on I_max: ONNX Runtime's speed advantage directly reduces L_total for stateless models
- [[static-thread-pool-decouples-neural-inference-from-the-audio-callback-to-ensure-real-time-safety]] — stateless models (ONNX's domain) can exploit parallel inference across ThreadPool threads; stateful models (LibTorch) cannot share hidden state and lose this parallelism advantage
- [[dsp-inductive-biases-reduce-model-size-by-encoding-prior-knowledge-about-periodic-audio]] — DDSP-style models (sub-1M parameters) fall below the size crossover where TFLite outperforms LibTorch, making ONNX Runtime or TFLite the default engine for this model family
- [[host-buffer-to-model-input-mismatch-and-parallel-inference-remain-unbenchmarked-in-real-time-audio-contexts]] — this engine ranking was established under aligned buffer conditions; the mismatch case and parallel inference performance remain unstudied and could modify relative rankings

Topics:
- [[ai-ml]]
- [[audio-dsp]]
- [[competing-systems]]
