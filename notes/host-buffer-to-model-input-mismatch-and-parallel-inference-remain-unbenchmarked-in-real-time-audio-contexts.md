---
description: Anira's study explicitly excluded host/model buffer size mismatch and multi-thread parallel inference from benchmarks, leaving two performance gaps consequential for real deployment
type: open-question
evidence: strong
source: [[anira-2024]]
created: 2026-02-28
status: active
---

# Host buffer to model input mismatch and parallel inference remain unbenchmarked in real-time audio contexts

Ackva and Schulz's study establishes strong baselines for single-threaded inference with aligned buffer sizes — the engine ranking documented in [[onnx-runtime-is-fastest-for-stateless-neural-models-while-libtorch-is-fastest-for-stateful-models]] is a product of those controlled conditions — but two deployment scenarios that matter significantly for murail were deliberately excluded to keep the variable space tractable.

**Gap 1: Host buffer / model input size mismatch.** The benchmarks aligned model input size with host buffer size in all conditions. In production, the host audio driver determines buffer size at runtime (typically 64, 128, 256, or 512 samples), while the trained model has a fixed input shape set at training time. Mismatch is the common case, not the edge case. Anira handles this via the Letz algorithm, adding H_adapt latency to collect enough samples before each inference — see [[anira-latency-formula-derives-minimum-required-buffering-from-worst-case-inference-time-and-buffer-size-mismatch]]. But the *performance cost* of H_adapt buffering, and how it interacts with inference time distributions across engines, is unknown. A model trained for 512-sample input running on a host with 128-sample buffers adds H_adapt = 384 samples of buffering delay — plus whatever overhead the alignment logic introduces per callback.

**Gap 2: Parallel inference via multi-threaded ThreadPool.** Anira supports parallel inference for stateless models: multiple ThreadPool threads can run the same model simultaneously, increasing throughput at the cost of more compute resources. The [[static-thread-pool-decouples-neural-inference-from-the-audio-callback-to-ensure-real-time-safety]] description notes this capability but no benchmark characterizes it. For a multi-effect scenario — several neural UGens running concurrently in a murail graph — the parallel inference throughput/latency curve at different thread counts is entirely unmeasured. The static pool design prevents oversubscription, but the optimal thread count for a given model + hardware combination is unknown. Since [[memory-bandwidth-is-the-binding-constraint-for-audio-dsp-parallelism-on-smp-machines]], the throughput/thread curve is architecture-dependent and cannot be predicted analytically — it requires empirical characterization per hardware target. Note also that this gap only applies when [[onnx-runtime-does-not-support-stateful-lstm-operations-restricting-it-to-stateless-neural-architectures]] is not the constraint: parallel ThreadPool inference is exclusively available for stateless models; stateful effects (guitar amp emulation, LSTM-based compressors) cannot share hidden state across threads and are not affected by Gap 2 at all.

Both gaps represent consequential uncertainty for [[larger-model-input-sizes-improve-per-sample-inference-performance-making-latency-tolerance-a-throughput-lever]]: the finding that larger input sizes improve per-sample efficiency was measured without mismatch. Whether that relationship holds — or changes sign — under realistic host/model buffer size divergence is an open question.

---

Source: [[anira-2024]]

Relevant Notes:
- [[anira-latency-formula-derives-minimum-required-buffering-from-worst-case-inference-time-and-buffer-size-mismatch]] — the formula accounts for mismatch, but the performance cost of H_adapt is unstudied
- [[static-thread-pool-decouples-neural-inference-from-the-audio-callback-to-ensure-real-time-safety]] — parallel inference is architecturally supported but not benchmarked
- [[larger-model-input-sizes-improve-per-sample-inference-performance-making-latency-tolerance-a-throughput-lever]] — the buffer size efficiency finding was measured under aligned conditions only
- [[onnx-runtime-is-fastest-for-stateless-neural-models-while-libtorch-is-fastest-for-stateful-models]] — the engine ranking this claim extends; its baselines were measured under the exact controlled conditions these two gaps exclude
- [[memory-bandwidth-is-the-binding-constraint-for-audio-dsp-parallelism-on-smp-machines]] — grounds why optimal thread count for parallel inference cannot be derived statically: SMP bandwidth constraints make the answer hardware-architecture-dependent
- [[onnx-runtime-does-not-support-stateful-lstm-operations-restricting-it-to-stateless-neural-architectures]] — establishes the architectural precondition for Gap 2: parallel ThreadPool inference only applies to stateless models; the gap is scoped to ONNX's domain

Topics:
- [[ai-ml]]
- [[audio-dsp]]
