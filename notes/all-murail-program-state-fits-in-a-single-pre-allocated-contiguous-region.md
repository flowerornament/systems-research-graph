---
description: The state region Σ is a contiguous block of memory whose size is fully determined at compile time; no allocation occurs during tick evaluation
type: property
evidence: strong
source: [[murail-substrate-v3]]
created: 2026-02-28
status: active
---

# all murail program state fits in a single pre-allocated contiguous region

The state region Σ is the single most important implementation invariant in the Murail execution model. It is a contiguous, pre-allocated memory region containing all equation state. Its size is computed at compile time from the layout formula:

`|Σ| = Σ_{n ∈ P} aligned(card(n) × size(n) × depth(n), align(n)) + Σ_{n ∈ P_ext} aligned(S_state(n), align(n))`

Every term is a compile-time constant: cardinality from set expressions, size from shape inference, depth from D_max and interpolation tap count, alignment from dispatch target requirements. The second sum covers extern equations' opaque state buffers.

**Consequences of pre-allocation:**

1. **No allocation on the fast thread.** The resource invariant (Axiom 12.2) forbids heap allocation, locks, I/O, and unbounded-time calls during TICK. Pre-allocated Σ makes this enforceable -- every read and write is an offset into a known region.

2. **Cache locality.** A single contiguous region means equations evaluated in topological order access adjacent memory. This is architecturally significant: the tight RT loop runs with Σ fitting (or nearly fitting) in L1/L2 cache.

3. **Live editing uses double-buffered state.** Two regions exist at runtime: Σ_live (used by the fast thread) and Σ_shadow (being prepared for the next program version). The migration map populates Σ_shadow from Σ_live before the atomic swap (see [[atomic-swap-enables-program-updates-at-tick-granularity-without-output-gaps]]).

4. **Deterministic sizing.** The size is fixed until the next program edit. This enables the compilation phase to verify that Σ fits within available memory before committing.

The state region is the structural foundation that makes the entire real-time guarantee possible. Everything else -- hold slots, smoothing, the tick function, shedding -- operates within its constraints.

## Connections

- Pre-allocation requires compile-time-fixed set cardinalities (see [[set-cardinality-and-tensor-shape-are-orthogonal-dimensions-in-the-murail-calculus]])
- Variable delay needs D_max to be declared at compile time to bound depth(n) (see [[variable-delay-requires-a-compile-time-declared-maximum-enabling-static-ring-buffer-allocation]])
- The no-allocation constraint is the operational content of [[the-murail-fast-thread-never-halts-errors-degrade-quality-but-do-not-stop-evaluation]]
- Live editing works by maintaining two copies of this region (see [[atomic-swap-enables-program-updates-at-tick-granularity-without-output-gaps]])
- [[cache-hierarchical-hardware-makes-linked-lists-slower-than-arrays-for-most-practical-sizes]] explains why contiguous layout matters for cache performance
- [[audio-system-os-calls-violate-real-time-constraints-through-unpredictable-lock-acquisition-and-page-faults]] provides the foundational rationale for why pre-allocation is necessary: OS allocator calls have unbounded latency due to lock acquisition, priority inversion, and page faults
- [[real-time-safe-memory-strategies-form-a-spectrum-from-up-front-fixed-allocation-to-incremental-gc]] places murail's strategy in a design space: the single contiguous region is up-front fixed allocation taken to the whole-program level
