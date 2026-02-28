---
description: RadSan testing shows persistent RT violations (malloc, mutex, sleep) in LibTorch, TFLite, and ONNX Runtime across all models and all inference counts — not just startup
type: contradiction
evidence: strong
source: [[anira-2024]]
created: 2026-02-28
status: active
---

# Inference engines violate real-time principles on every inference not just initial ones

A common assumption in real-time audio development is that inference engine overhead is front-loaded: pay the initialization cost once, and subsequent inferences are safe. Ackva and Schulz's RadSan testing directly contradicts this. Across LibTorch, TensorFlow Lite, and ONNX Runtime — and across all three model architectures (CNN-29k, HNN-11k, RNN-2k) — real-time violations persist throughout the entire inference lifetime. The graphs never reach zero.

The violations differ by engine and model. LibTorch produces the highest violation counts, using malloc, free, calloc, pthread_mutex_lock, and pthread_rwlock_rdlock; CNN-29k additionally uses sleep and fopen during initial inferences. TensorFlow Lite is exclusively memory operations (malloc, free, aligned_alloc), with RNN-2k showing consistently high violations across all iterations. ONNX Runtime uses malloc, free, and posix_memalign; HNN-11k shows consistently intensive memory activity while CNN-29k produces fewer violations. The violation severity gradient — LibTorch most invasive (mutex, rwlock, sleep), TFLite memory-only, ONNX Runtime lightest — mirrors the performance ranking established in [[onnx-runtime-is-fastest-for-stateless-neural-models-while-libtorch-is-fastest-for-stateful-models]]: the same engine whose violations reach deeper into the OS tends to be slower.

This contradicts Stefani et al. 2022 [12], which reported that engines "consistently ensure real-time safety after the initial inference." Ackva and Schulz attribute the discrepancy to methodology: Stefani used a Xenomai Cobalt hard-RT kernel rather than intercepting system library calls directly. The hard-RT kernel's scheduler may suppress observable violations rather than eliminating them.

The implication for audio software architecture is direct: no current mainstream inference engine can run in an audio callback without real-time violations. The only RT-safe approach is architectural separation — see [[static-thread-pool-decouples-neural-inference-from-the-audio-callback-to-ensure-real-time-safety]], which is anira's solution. This mirrors the broader lesson from [[supercollider-client-server-architecture-moved-the-scripting-language-out-of-the-real-time-audio-thread]]: non-RT code must be moved off the audio thread entirely, not merely warmed up.

Critically, [[warm-up-inferences-before-the-audio-callback-stabilize-inference-engine-runtimes]] remains valid but addresses a different problem: warm-up reduces *runtime variance*, not RT violations. Even a warmed-up engine still allocates memory on every inference call.

---

Source: [[anira-2024]]

Relevant Notes:
- [[static-thread-pool-decouples-neural-inference-from-the-audio-callback-to-ensure-real-time-safety]] — anira's architectural response to this problem
- [[supercollider-client-server-architecture-moved-the-scripting-language-out-of-the-real-time-audio-thread]] — same root constraint (non-RT code in RT context), earlier solution
- [[warm-up-inferences-before-the-audio-callback-stabilize-inference-engine-runtimes]] — addresses runtime variance rather than violations per se
- [[onnx-runtime-is-fastest-for-stateless-neural-models-while-libtorch-is-fastest-for-stateful-models]] — violation severity gradient mirrors performance ranking across engines

Topics:
- [[ai-ml]]
- [[audio-dsp]]
