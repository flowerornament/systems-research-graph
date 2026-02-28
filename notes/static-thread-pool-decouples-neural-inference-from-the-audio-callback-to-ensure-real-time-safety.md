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

The static design solves a specific oversubscription problem. If each InferenceManager created its own high-priority inference threads, deploying multiple concurrent neural effects on the same hardware would spawn threads far exceeding the available hardware thread count. The shared static pool prevents this by design — threads are created once at process initialization and reused.

Two synchronization strategies are available, trading real-time strictness against latency. The **atomics path** uses std::atomic and binary/counting semaphores exclusively: no syscalls, no blocking, fully compliant with the strictest real-time constraints. The **semaphore path** allows std::counting_semaphore::try_acquire_until in the audio callback, introducing controlled blocking that allows the callback to receive inference results sooner — reducing latency at the cost of minor syscalls. Which strategy to use depends on whether the target platform tolerates semaphore waits in the audio thread.

For stateless models, the ThreadPool enables parallel inference: multiple threads can run the same model concurrently, processing more samples per callback period. This creates a throughput scaling axis orthogonal to single-inference optimization. The parallel case is architecturally supported but not yet benchmarked; see [[host-buffer-to-model-input-mismatch-and-parallel-inference-remain-unbenchmarked-in-real-time-audio-contexts]].

RadSan testing of anira's own process method confirms zero real-time violations — the callback submits work and collects results without any of the memory allocation, mutex contention, or file I/O that the underlying engines produce internally.

The broader pattern — moving non-RT execution to background threads with a defined handoff mechanism — appears in [[supercollider-client-server-architecture-moved-the-scripting-language-out-of-the-real-time-audio-thread]] (OSC message handoff) and [[compile-and-swap-preserves-audio-continuity-during-recompilation]] (atomic pointer swap). Anira's atomic path is implemented using the same class of primitives discussed in [[existing-hardware-cas-primitives-suffice-for-practical-lock-free-data-structures]].

---

Source: [[anira-2024]]

Relevant Notes:
- [[inference-engines-violate-real-time-principles-on-every-inference-not-just-initial-ones]] — motivates this architectural decision
- [[supercollider-client-server-architecture-moved-the-scripting-language-out-of-the-real-time-audio-thread]] — parallel strategy: separate process instead of background thread pool
- [[compile-and-swap-preserves-audio-continuity-during-recompilation]] — uses background thread + atomic swap pattern
- [[existing-hardware-cas-primitives-suffice-for-practical-lock-free-data-structures]] — anira's atomic sync path uses CAS-level primitives
- [[host-buffer-to-model-input-mismatch-and-parallel-inference-remain-unbenchmarked-in-real-time-audio-contexts]] — parallel inference capacity not yet measured
- [[anira-latency-formula-derives-minimum-required-buffering-from-worst-case-inference-time-and-buffer-size-mismatch]] — InferenceManager also computes required buffering

Topics:
- [[ai-ml]]
- [[audio-dsp]]
- [[concurrent-systems]]
