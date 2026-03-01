---
description: OS calls from the RT thread — including memory allocation — can acquire kernel locks, trigger priority inversion, or cause page faults, all with unbounded execution time
type: claim
evidence: strong
source: "[[dannenberg-bencina-2005-design-patterns-real-time-computer-music]]"
created: 2026-03-01
status: active
---

# audio system OS calls violate real-time constraints through unpredictable lock acquisition and page faults

Dannenberg and Bencina's "Real-Time Memory Management" pattern names the specific failure mechanisms that make OS memory allocation (and OS calls in general) incompatible with real-time audio:

1. **Lock acquisition**: The kernel allocator holds a mutex over the heap. If a non-RT thread holds this mutex, calling `malloc` from an RT thread will block until the lock is released — potentially for an unbounded duration.

2. **Priority inversion**: If a low-priority thread holds the heap lock and the OS does not implement priority inheritance, the RT thread is blocked behind a task it outranks. The scheduler does not resolve this; it makes it worse.

3. **Page faults**: On first access to freshly allocated memory, the OS must map virtual pages to physical pages. This can trigger disk I/O if the swap file is involved, causing multi-millisecond pauses within the RT callback.

These failure modes are probabilistic: allocation *usually* succeeds in bounded time, which is why audio glitches from allocation are intermittent and hard to reproduce in testing. This probabilistic safety is worse than a deterministic failure — it passes tests but breaks in production under load.

The consequence is that real-time audio code must never call the OS for memory. All strategies in the Real-Time Memory Management pattern are workarounds for this single constraint: pre-allocate everything, use free lists, keep per-thread pools, allocate in a non-RT thread and send via a queue.

**Connection to murail:** [[all-murail-program-state-fits-in-a-single-pre-allocated-contiguous-region]] derives from this constraint. The state region Σ is pre-allocated before the first tick precisely because Axiom 12.2 (the resource invariant) forbids heap allocation during TICK. This paper provides the foundational rationale for why that axiom is necessary, not just conventional.

The contrast with [[inference-engines-violate-real-time-principles-on-every-inference-not-just-initial-ones]] is exact: inference engines call `malloc` (and `pthread_mutex_lock`) on every inference, which are precisely the failure modes named here. RadSan confirms the violations; this paper explains why they are violations.

## Connections

- [[all-murail-program-state-fits-in-a-single-pre-allocated-contiguous-region]] -- the substrate's single contiguous region is the correct implementation of "pre-allocate everything"; this claim provides the rationale for why that pre-allocation axiom is necessary
- [[inference-engines-violate-real-time-principles-on-every-inference-not-just-initial-ones]] -- the specific violations RadSan detects (allocation, mutex) are the exact failure modes named here; this paper is the theoretical ground for that empirical finding
- [[the-murail-fast-thread-never-halts-errors-degrade-quality-but-do-not-stop-evaluation]] -- the resource invariant (no allocation, no locks) is the operational content of this claim; the fast thread's output-continuity axiom requires excluding these OS-level operations
- [[real-time-safe-memory-strategies-form-a-spectrum-from-up-front-fixed-allocation-to-incremental-gc]] -- the solution space for avoiding this problem
- [[lock-freedom-guarantees-system-wide-progress-but-not-per-operation-progress]] -- lock-free data structures avoid holding the heap lock; this is why they are RT-safe while mutex-based structures are not
