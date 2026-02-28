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

For murail's neural UGen design, this introduces a third dimension to engine selection alongside architecture type and state requirements. A lightweight embedded-friendly model (~1k parameters) for a simple spectral shaper should prefer TFLite or ONNX Runtime over LibTorch — and since [[dsp-inductive-biases-reduce-model-size-by-encoding-prior-knowledge-about-periodic-audio]] shows that DDSP-style architectures produce sub-1M parameter models (Tiny variant: 0.24M), DDSP-backed neural UGens fall squarely in TFLite's advantageous range. A full-size audio effect model (~30k parameters) should use ONNX Runtime and can use LibTorch but should avoid TFLite. The crossing point around 15k parameters should be empirically verified for the specific target hardware.

Model size is one of two independent per-inference performance levers identified in the anira study. The other — [[larger-model-input-sizes-improve-per-sample-inference-performance-making-latency-tolerance-a-throughput-lever]] — shows that input buffer size also significantly affects per-sample cost. These two axes compose: a small DDSP model (~1k params) processed with a large input buffer on TFLite or ONNX Runtime would benefit from both the favorable engine ordering documented here and the amortization effect documented there. In murail's shape-driven dispatch model, both dimensions are visible at compile time: parameter count determines model complexity while input shape determines buffer sizing, and [[dsp-and-ml-are-structurally-identical-under-shape-driven-dispatch-in-the-murail-calculus]] shows that the substrate treats these as the same dispatch problem at different shape scales.

---

Source: [[anira-2024]]

Relevant Notes:
- [[onnx-runtime-is-fastest-for-stateless-neural-models-while-libtorch-is-fastest-for-stateful-models]] — this claim adds model-size nuance to the stateless results
- [[onnx-runtime-does-not-support-stateful-lstm-operations-restricting-it-to-stateless-neural-architectures]] — for stateful models where ONNX is excluded, this size-dependent ordering applies
- [[warm-up-inferences-before-the-audio-callback-stabilize-inference-engine-runtimes]] — TFLite's warm-up effect appearing only at CNN-29k (not smaller models) manifests the same size-dependent mechanism this claim identifies: TFLite's cold-start costs are only significant when per-inference workload is large
- [[dsp-inductive-biases-reduce-model-size-by-encoding-prior-knowledge-about-periodic-audio]] — grounds the small-model scenario in murail practice: DDSP-style architectures produce sub-1M parameter networks, placing them in TFLite's favorable range and making TFLite (or ONNX) the correct engine default for DDSP-backed neural UGens

Topics:
- [[ai-ml]]
- [[audio-dsp]]
- [[competing-systems]]
