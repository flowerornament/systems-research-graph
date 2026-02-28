---
description: Anira's InferenceManager submits work to a shared static ThreadPool so the audio callback never touches inference engine code, verified by RadSan showing zero violations
type: decision
evidence: strong
source: [[anira-2024]]
created: 2026-02-28
status: active
---

# Static thread pool decouples neural inference from the audio callback to ensure real-time safety

Because [[inference-engines-violate-real-time-principles-on-every-inference-not-just-initial-ones]], the only viable path to a real-time-safe neural audio pipeline is architectural: inference must never execute inside the audio callback. Anira's response is a static ThreadPool shared across all InferenceManager instances.

The static design solves a specific oversubscription problem. If each InferenceManager created its own high-priority inference threads, deploying multiple concurrent neural effects on the same hardware would spawn threads far exceeding the available hardware thread count. The shared static pool prevents this by design — threads are created once at process initialization and reused. This is the thread pool sizing discipline that [[memory-bandwidth-is-the-binding-constraint-for-audio-dsp-parallelism-on-smp-machines]] makes concrete: on shared-memory hardware, aggressive thread proliferation contends for the same memory bus, so conservative pool sizing is not a caution but a performance constraint.

Two synchronization strategies are available, trading real-time strictness against latency. The **atomics path** uses std::atomic and binary/counting semaphores exclusively: no syscalls, no blocking, fully compliant with the strictest real-time constraints. The **semaphore path** allows std::counting_semaphore::try_acquire_until in the audio callback, introducing controlled blocking that allows the callback to receive inference results sooner — reducing latency at the cost of minor syscalls. Which strategy to use depends on whether the target platform tolerates semaphore waits in the audio thread.

For stateless models, the ThreadPool enables parallel inference: multiple threads can run the same model concurrently, processing more samples per callback period. This creates a throughput scaling axis orthogonal to single-inference optimization. The parallel case is architecturally supported but not yet benchmarked; see [[host-buffer-to-model-input-mismatch-and-parallel-inference-remain-unbenchmarked-in-real-time-audio-contexts]]. Since [[onnx-runtime-does-not-support-stateful-lstm-operations-restricting-it-to-stateless-neural-architectures]], ONNX's domain is precisely the only domain where this parallelism is available; stateful models, which must use LibTorch, cannot share hidden state across threads and forfeit this architectural advantage entirely.

RadSan testing of anira's own process method confirms zero real-time violations — the callback submits work and collects results without any of the memory allocation, mutex contention, or file I/O that the underlying engines produce internally. The thread pool isolates these violations architecturally; [[warm-up-inferences-before-the-audio-callback-stabilize-inference-engine-runtimes]] addresses a complementary concern by reducing the magnitude and variance of violations within the pool threads, which matters for accurate I_max estimation but does not affect RT safety.

The broader pattern — moving non-RT execution to background threads with a defined handoff mechanism — appears in [[supercollider-client-server-architecture-moved-the-scripting-language-out-of-the-real-time-audio-thread]] (OSC message handoff) and [[compile-and-swap-preserves-audio-continuity-during-recompilation]] (atomic pointer swap). Anira's atomic path is implemented using the same class of primitives discussed in [[existing-hardware-cas-primitives-suffice-for-practical-lock-free-data-structures]]. The decision to make the thread pool static and shared — rather than per-instance — is the kind of foundational architectural choice that [[core-audio-low-latency-performance-traces-to-an-architectural-insight-made-at-the-projects-inception]] argues determines long-term performance: getting the thread model right at inception avoids oversubscription problems that cannot be resolved by optimization later.

---

Source: [[anira-2024]]

Relevant Notes:
- [[inference-engines-violate-real-time-principles-on-every-inference-not-just-initial-ones]] — motivates this architectural decision
- [[supercollider-client-server-architecture-moved-the-scripting-language-out-of-the-real-time-audio-thread]] — parallel strategy: separate process instead of background thread pool
- [[compile-and-swap-preserves-audio-continuity-during-recompilation]] — uses background thread + atomic swap pattern
- [[existing-hardware-cas-primitives-suffice-for-practical-lock-free-data-structures]] — anira's atomic sync path uses CAS-level primitives
- [[host-buffer-to-model-input-mismatch-and-parallel-inference-remain-unbenchmarked-in-real-time-audio-contexts]] — parallel inference capacity not yet measured
- [[anira-latency-formula-derives-minimum-required-buffering-from-worst-case-inference-time-and-buffer-size-mismatch]] — InferenceManager also computes required buffering
- [[onnx-runtime-does-not-support-stateful-lstm-operations-restricting-it-to-stateless-neural-architectures]] — defines why parallel inference is exclusive to ONNX's domain: stateful models cannot share hidden state across threads, making the ThreadPool parallelism axis unavailable to them
- [[memory-bandwidth-is-the-binding-constraint-for-audio-dsp-parallelism-on-smp-machines]] — grounds the static pool's conservative sizing: thread proliferation competes for shared memory bus, making oversubscription a performance regression not just a resource issue
- [[send-and-sync-are-thread-independence-of-ownership-and-sharing-predicates]] — a Rust implementation of this architecture requires inference nodes submitted to the pool to satisfy Send; this claim formally characterizes what that safety requirement means

Topics:
- [[ai-ml]]
- [[audio-dsp]]
- [[concurrent-systems]]
