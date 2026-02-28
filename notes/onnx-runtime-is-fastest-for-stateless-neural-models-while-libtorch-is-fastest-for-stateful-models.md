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

The practical implication for murail's neural UGen design: stateless models (feedforward CNNs, TCNs without persistent state) should prefer ONNX Runtime; stateful effects (guitar amp emulation, compressors using LSTM) must use LibTorch or TFLite, with LibTorch preferred for larger models. Engine choice interacts with model architecture in ways that cannot be decided at library selection time — it requires knowing the target model's state requirements and approximate parameter count.

---

Source: [[anira-2024]]

Relevant Notes:
- [[onnx-runtime-does-not-support-stateful-lstm-operations-restricting-it-to-stateless-neural-architectures]] — explains why ONNX is excluded from stateful comparisons
- [[tensorflow-lite-outperforms-libtorch-for-small-cnn-models-but-libtorch-becomes-faster-as-model-size-grows]] — model-size nuance to stateful results
- [[larger-model-input-sizes-improve-per-sample-inference-performance-making-latency-tolerance-a-throughput-lever]] — buffer size is a second axis of performance variation
- [[inference-engines-violate-real-time-principles-on-every-inference-not-just-initial-ones]] — the engine performance ranking correlates with RT violation severity: ONNX Runtime fastest and lightest violations, LibTorch slowest and most invasive

Topics:
- [[ai-ml]]
- [[audio-dsp]]
- [[competing-systems]]
