---
description: RT memory management options range from preallocated free lists (fully static) through per-thread pools and non-RT allocation to incremental GC (dynamic but bounded)
type: pattern
evidence: strong
source: "[[dannenberg-bencina-2005-design-patterns-real-time-computer-music]]"
created: 2026-03-01
status: active
---

# real-time safe memory strategies form a spectrum from up-front fixed allocation to incremental GC

Dannenberg and Bencina enumerate five strategies for RT-safe memory management, which form a spectrum by how statically the allocation behavior must be known:

1. **Fixed up-front allocation with a free list**: The maximum number of required objects is known at startup. A preallocated array is maintained as a linked free list. Allocation is O(1) and never calls the OS. Deallocation returns to the free list. Requires knowing the upper bound (e.g., maximum synthesizer polyphony).

2. **Size-segregated free lists**: Free lists indexed by size class rather than object type. More general — objects of different types but similar sizes share a pool. SuperCollider's zone allocator uses this pattern.

3. **Per-thread memory pools**: A large preallocated block is managed by a custom allocator within a single thread context. Avoids locks (per-thread, never shared), never calls the OS. The allocation algorithm's time complexity must be evaluated separately — a naive first-fit scan has O(n) worst case, which may not be acceptable.

4. **Allocate in a non-RT context**: No allocation in the RT thread at all. Objects are allocated in an NRT thread and sent to the RT thread via a lock-free queue. The RT thread only receives pointers. The NRT thread owns the allocation lifetime.

5. **Incremental garbage collection**: A garbage collector designed for RT contexts that bounds its pause time by interrupting collection work if its time budget is exceeded. SuperCollider Language and Serpent use this approach.

**Which strategy is appropriate** depends on how well allocation behavior is understood, whether a generalized allocator is needed, and how objects are shared across threads. Real systems combine multiple strategies: fixed allocation for voice counts, per-thread pools for intermediate buffers, NRT allocation for large objects, free lists for short-lived small objects.

**Murail uses strategy 1 (up-front fixed)** taken to its logical extreme: [[all-murail-program-state-fits-in-a-single-pre-allocated-contiguous-region]]. The compile-time layout formula makes the state region size fully determined before any tick fires. This is possible because murail has a compilation step that resolves cardinalities, shapes, and depths — making "knowing the upper bound" a compiler obligation rather than a programmer obligation.

The NRT allocation strategy (4) appears in murail's compile-and-swap model: new programs are compiled in the NRT thread and swapped into the fast thread via an atomic pointer, not via RT-side allocation. See [[atomic-swap-enables-program-updates-at-tick-granularity-without-output-gaps]].

## Connections

- [[all-murail-program-state-fits-in-a-single-pre-allocated-contiguous-region]] -- murail implements strategy 1 at the whole-program level: the state region is the single preallocated pool containing all state
- [[audio-system-os-calls-violate-real-time-constraints-through-unpredictable-lock-acquisition-and-page-faults]] -- this spectrum of strategies exists to avoid the OS allocator failure modes named in that claim
- [[atomic-swap-enables-program-updates-at-tick-granularity-without-output-gaps]] -- the compile-and-swap mechanism is an instance of strategy 4: NRT thread allocates, RT thread receives a pointer via atomic swap
- [[variable-delay-requires-a-compile-time-declared-maximum-enabling-static-ring-buffer-allocation]] -- compile-time-declared D_max is what makes fixed allocation tractable for delay lines; without it, ring buffer size cannot be pre-determined
- [[anira-latency-formula-derives-minimum-required-buffering-from-worst-case-inference-time-and-buffer-size-mismatch]] -- anira's pre-computed buffer sizing applies strategy 1 to neural inference buffers: the required buffer count is determined statically from I_max and buffer size
