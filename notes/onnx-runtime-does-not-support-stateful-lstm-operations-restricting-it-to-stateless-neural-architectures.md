---
description: ONNX Runtime's stateless-by-design architecture cannot retain LSTM state between inference calls, making it incompatible with sequential audio effects that require persistent hidden state
type: property
evidence: strong
source: [[anira-2024]]
created: 2026-02-28
status: active
---

# ONNX Runtime does not support stateful LSTM operations restricting it to stateless neural architectures

ONNX Runtime is architecturally stateless: it does not retain any internal state between consecutive inference calls. Each call is treated as an independent computation from identical initial conditions. For many neural audio architectures this is fine — feedforward CNNs and TCNs (without persistent hidden state) are naturally stateless, and ONNX Runtime handles them efficiently. See [[onnx-runtime-is-fastest-for-stateless-neural-models-while-libtorch-is-fastest-for-stateful-models]].

For stateful audio effects — guitar amp emulation, neural compressors, any model with LSTM layers that must carry state from one audio buffer to the next — this is a fundamental capability boundary, not a performance limitation. A stateful LSTM requires that the hidden state vector (h, c) computed at inference step N is available as input to inference step N+1. ONNX Runtime's stateless model cannot provide this without external state management.

The study acknowledges a workaround: state could be managed externally, passed as explicit input/output tensors on every inference call. This technically makes the model stateless from ONNX's perspective while maintaining functional stateful behavior. However, this approach alters the model graph structure and requires changes to training infrastructure; it was excluded from Ackva and Schulz's study.

The distinction between stateful and stateless LSTM is not merely theoretical. The HNN-11k hybrid model used in the study implements a *stateless* LSTM variant — the hidden state does not carry over between batches — and is therefore fully compatible with ONNX Runtime. This is a design choice at the model architecture level, not an inference engine limitation that can be patched at deployment time.

For murail's neural UGen design, this constraint narrows the decision space: models intended for effects with persistent tonal or dynamic character (amp sims, reverb tails, compressors) must use LibTorch or TensorFlow Lite. ONNX Runtime is appropriate only for models where each audio buffer can be processed independently. The architectural consequence extends beyond engine selection: since [[static-thread-pool-decouples-neural-inference-from-the-audio-callback-to-ensure-real-time-safety]] enables parallel inference only for stateless models (stateful models cannot share hidden state across threads), ONNX's domain is also the only domain where ThreadPool parallelism applies. Stateful model users accept not only slower engines but also forfeit this parallelism advantage. This compounds into the latency budget: stateful effects forced to LibTorch have higher I_max, which per [[anira-latency-formula-derives-minimum-required-buffering-from-worst-case-inference-time-and-buffer-size-mismatch]] increases L_total across all host buffer sizes.

---

Source: [[anira-2024]]

Relevant Notes:
- [[onnx-runtime-is-fastest-for-stateless-neural-models-while-libtorch-is-fastest-for-stateful-models]] — provides context: ONNX excluded from stateful benchmarks for this reason
- [[tensorflow-lite-outperforms-libtorch-for-small-cnn-models-but-libtorch-becomes-faster-as-model-size-grows]] — for stateful models where ONNX is ruled out, this nuance applies

Topics:
- [[ai-ml]]
- [[audio-dsp]]
- [[competing-systems]]
