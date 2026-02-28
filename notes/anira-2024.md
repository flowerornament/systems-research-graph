---
description: Ackva & Schulz (TU Berlin, 2025): C++ library for safe neural network inference in real-time audio callbacks via static thread pool decoupling
type: source
created: 2026-02-28
---

# anira-2024

**Full title:** ANIRA: An Architecture for Neural Network Inference in Real-Time Audio Applications
**Authors:** Valentin Ackva, Fares Schulz (Audio Communication Group, TU Berlin)
**Venue:** arXiv:2506.12665v1 [cs.SD], Jun 2025
**Original source:** `/Users/morgan/code/murail/.design/references/papers/anira-2024.pdf`

## Summary

Ackva and Schulz present anira, a cross-platform C++ library that solves the fundamental incompatibility between neural network inference engines (ONNX Runtime, LibTorch, TensorFlow Lite) and real-time audio requirements. All three engines violate real-time principles (malloc, mutex, sleep) on every inference — not just initial ones. Anira decouples inference to a static thread pool, handles host buffer / model input size mismatches via the Letz algorithm, calculates minimum required latency formally, and provides built-in benchmarking. The paper includes a benchmarking study across three architectures (CNN/TCN, RNN/LSTM, hybrid), three systems, and eight buffer sizes, analyzed with linear mixed effects models.

## Key Contributions

- Static thread pool architecture eliminating real-time violations in the audio callback
- Formal latency formula (Equations 1 and 2) for minimum required buffering
- Dual synchronization strategies: atomics (strict RT-safe) vs. semaphores (lower latency, minor syscalls)
- Standardized benchmarking infrastructure enabling cross-engine, cross-system comparisons
- Statistical finding: ONNX Runtime fastest for stateless; LibTorch fastest for stateful

## Claims Extracted

- [[inference-engines-violate-real-time-principles-on-every-inference-not-just-initial-ones]]
- [[static-thread-pool-decouples-neural-inference-from-the-audio-callback-to-ensure-real-time-safety]]
- [[anira-latency-formula-derives-minimum-required-buffering-from-worst-case-inference-time-and-buffer-size-mismatch]]
- [[onnx-runtime-is-fastest-for-stateless-neural-models-while-libtorch-is-fastest-for-stateful-models]]
- [[warm-up-inferences-before-the-audio-callback-stabilize-inference-engine-runtimes]]
- [[larger-model-input-sizes-improve-per-sample-inference-performance-making-latency-tolerance-a-throughput-lever]]
- [[onnx-runtime-does-not-support-stateful-lstm-operations-restricting-it-to-stateless-neural-architectures]]
- [[host-buffer-to-model-input-mismatch-and-parallel-inference-remain-unbenchmarked-in-real-time-audio-contexts]]
- [[tensorflow-lite-outperforms-libtorch-for-small-cnn-models-but-libtorch-becomes-faster-as-model-size-grows]]

---

Topics:
- [[ai-ml]]
- [[audio-dsp]]
- [[competing-systems]]
