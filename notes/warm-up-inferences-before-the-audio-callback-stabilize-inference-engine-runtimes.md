---
description: Initial inference iterations are significantly slower for specific engine/model combinations; running warm-up inferences before audio start reduces runtime variance and RT violation frequency
type: pattern
evidence: strong
source: [[anira-2024]]
created: 2026-02-28
status: active
---

# Warm-up inferences before the audio callback stabilize inference engine runtimes

Inference engines exhibit elevated runtimes during their first few iterations. Ackva and Schulz's linear mixed effects analysis of the iteration predictor quantifies which combinations are affected and by how much.

**LibTorch** shows the most pronounced effect: significantly higher runtime-per-sample (RpS) for initial iterations across all models (p < 0.0001). For CNN-29k specifically, the first 9 iterations produce significantly elevated RpS before stabilizing. **TensorFlow Lite** shows significantly elevated initial RpS only for CNN-29k; other models show a tendency toward decrease without reaching statistical significance. This model-size selectivity in warm-up behavior is consistent with [[tensorflow-lite-outperforms-libtorch-for-small-cnn-models-but-libtorch-becomes-faster-as-model-size-grows]]: TFLite has lower fixed overhead at small model sizes (where per-inference compute is short), so the warm-up effect only manifests when the per-inference workload is large enough for cold-start costs to dominate. **ONNX Runtime** shows inconsistent behavior: HNN-11k decreases over time, but CNN-29k shows alternating (not monotonically decreasing) RpS values.

The runtime elevation correlates directly with real-time violations: the same engine/model combinations that are slowest at startup also produce the most violations — see [[inference-engines-violate-real-time-principles-on-every-inference-not-just-initial-ones]]. The practical conclusion from the authors: running warm-up inferences before opening the audio callback reduces the probability of deadline misses during the first seconds of operation.

Anira encodes this recommendation as first-class configuration: InferenceConfig includes a `warm_up` parameter (integer number of warm-up inferences to run at startup, default = 0). Setting this to a nonzero value delays audio start slightly but delivers more predictable runtime behavior once the callback begins processing.

An important distinction: warm-up addresses runtime variance, not real-time safety violations per se. Even a fully warmed-up engine still allocates memory on each inference call. Warm-up reduces the magnitude and frequency of deadline-critical outliers; [[static-thread-pool-decouples-neural-inference-from-the-audio-callback-to-ensure-real-time-safety]] is the mechanism that prevents those operations from ever reaching the audio thread.

Accurate worst-case inference time measurement for the [[anira-latency-formula-derives-minimum-required-buffering-from-worst-case-inference-time-and-buffer-size-mismatch]] should be conducted post-warmup to avoid inflating I_max with cold-start outliers.

---

Source: [[anira-2024]]

Relevant Notes:
- [[inference-engines-violate-real-time-principles-on-every-inference-not-just-initial-ones]] — warm-up reduces violation frequency but doesn't eliminate violations
- [[static-thread-pool-decouples-neural-inference-from-the-audio-callback-to-ensure-real-time-safety]] — architectural mechanism that contains violations away from the audio thread
- [[anira-latency-formula-derives-minimum-required-buffering-from-worst-case-inference-time-and-buffer-size-mismatch]] — I_max benchmarking should run post-warmup
- [[onnx-runtime-is-fastest-for-stateless-neural-models-while-libtorch-is-fastest-for-stateful-models]] — the performance ranking that this claim qualifies: the ranking reflects stabilized (post-warmup) runtimes; LibTorch's pronounced warm-up effect is the largest distorting factor before stabilization
- [[tensorflow-lite-outperforms-libtorch-for-small-cnn-models-but-libtorch-becomes-faster-as-model-size-grows]] — TFLite's warm-up effect appearing only at CNN-29k (not smaller models) is the same model-size dependency that the size comparison documents; warm-up selectivity and steady-state performance ordering share the same underlying mechanism

Topics:
- [[ai-ml]]
- [[audio-dsp]]
