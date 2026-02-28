---
description: Anira's study explicitly excluded host/model buffer size mismatch and multi-thread parallel inference from benchmarks, leaving two performance gaps consequential for real deployment
type: open-question
evidence: strong
source: [[anira-2024]]
created: 2026-02-28
status: active
---

# Host buffer to model input mismatch and parallel inference remain unbenchmarked in real-time audio contexts

Ackva and Schulz's study establishes strong baselines for single-threaded inference with aligned buffer sizes, but two deployment scenarios that matter significantly for murail were deliberately excluded to keep the variable space tractable.

**Gap 1: Host buffer / model input size mismatch.** The benchmarks aligned model input size with host buffer size in all conditions. In production, the host audio driver determines buffer size at runtime (typically 64, 128, 256, or 512 samples), while the trained model has a fixed input shape set at training time. Mismatch is the common case, not the edge case. Anira handles this via the Letz algorithm, adding H_adapt latency to collect enough samples before each inference — see [[anira-latency-formula-derives-minimum-required-buffering-from-worst-case-inference-time-and-buffer-size-mismatch]]. But the *performance cost* of H_adapt buffering, and how it interacts with inference time distributions across engines, is unknown. A model trained for 512-sample input running on a host with 128-sample buffers adds H_adapt = 384 samples of buffering delay — plus whatever overhead the alignment logic introduces per callback.

**Gap 2: Parallel inference via multi-threaded ThreadPool.** Anira supports parallel inference for stateless models: multiple ThreadPool threads can run the same model simultaneously, increasing throughput at the cost of more compute resources. The [[static-thread-pool-decouples-neural-inference-from-the-audio-callback-to-ensure-real-time-safety]] description notes this capability but no benchmark characterizes it. For a multi-effect scenario — several neural UGens running concurrently in a murail graph — the parallel inference throughput/latency curve at different thread counts is entirely unmeasured. The static pool design prevents oversubscription, but the optimal thread count for a given model + hardware combination is unknown.

Both gaps represent consequential uncertainty for [[larger-model-input-sizes-improve-per-sample-inference-performance-making-latency-tolerance-a-throughput-lever]]: the finding that larger input sizes improve per-sample efficiency was measured without mismatch. Whether that relationship holds — or changes sign — under realistic host/model buffer size divergence is an open question.

---

Source: [[anira-2024]]

Relevant Notes:
- [[anira-latency-formula-derives-minimum-required-buffering-from-worst-case-inference-time-and-buffer-size-mismatch]] — the formula accounts for mismatch, but the performance cost of H_adapt is unstudied
- [[static-thread-pool-decouples-neural-inference-from-the-audio-callback-to-ensure-real-time-safety]] — parallel inference is architecturally supported but not benchmarked
- [[larger-model-input-sizes-improve-per-sample-inference-performance-making-latency-tolerance-a-throughput-lever]] — the buffer size efficiency finding was measured under aligned conditions only

Topics:
- [[ai-ml]]
- [[audio-dsp]]
