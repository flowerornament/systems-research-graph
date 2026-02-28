---
description: LMM-III follow-up study across CNN-1k, CNN-15k, and CNN-29k shows TFLite and LibTorch performance crosses as model size grows, with ONNX Runtime fastest at all sizes
type: claim
evidence: strong
source: [[anira-2024]]
created: 2026-02-28
status: active
---

# TensorFlow Lite outperforms LibTorch for small CNN models but LibTorch becomes faster as model size grows

The stateful benchmark results in LMM-II produced an inconsistency: TFLite was slower than LibTorch for CNN-29k and RNN-2k, but faster for HNN-11k. Ackva and Schulz ran a targeted follow-up study (LMM-III) to isolate why. The answer is model size.

LMM-III compared CNN-1k (931 parameters), CNN-15k (15,300 parameters), and CNN-29k (29,669 parameters) across ONNX Runtime, LibTorch, and TensorFlow Lite (N=108,000 observations). The findings:

- **CNN-29k:** TFLite is significantly inferior to LibTorch (p < 0.0001)
- **CNN-15k:** crossing region — results become inconsistent, no clear winner
- **CNN-1k:** TFLite is no longer significantly different from ONNX Runtime; LibTorch is the slowest

ONNX Runtime is fastest across all CNN sizes in this comparison, maintaining its lead regardless of model complexity. This refines rather than contradicts [[onnx-runtime-is-fastest-for-stateless-neural-models-while-libtorch-is-fastest-for-stateful-models]]: ONNX's advantage over LibTorch remains, but the LibTorch vs TFLite ordering depends on model size.

The mechanism is not explained in the paper, but the likely interpretation: TFLite has lower fixed overhead per inference call, making it relatively efficient for small models where computation time is short. LibTorch's runtime abstractions have higher constant overhead but better computational throughput at scale — paying off as model size and per-inference workload grow.

For murail's neural UGen design, this introduces a third dimension to engine selection alongside architecture type and state requirements. A lightweight embedded-friendly model (~1k parameters) for a simple spectral shaper should prefer TFLite or ONNX Runtime over LibTorch. A full-size audio effect model (~30k parameters) should use ONNX Runtime and can use LibTorch but should avoid TFLite. The crossing point around 15k parameters should be empirically verified for the specific target hardware.

---

Source: [[anira-2024]]

Relevant Notes:
- [[onnx-runtime-is-fastest-for-stateless-neural-models-while-libtorch-is-fastest-for-stateful-models]] — this claim adds model-size nuance to the stateless results
- [[onnx-runtime-does-not-support-stateful-lstm-operations-restricting-it-to-stateless-neural-architectures]] — for stateful models where ONNX is excluded, this size-dependent ordering applies

Topics:
- [[ai-ml]]
- [[audio-dsp]]
- [[competing-systems]]
