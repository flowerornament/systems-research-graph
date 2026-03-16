---
description: Double-buffered state regions and a swap flag allow the slow thread to prepare a new program while the fast thread runs the old one; the swap fires at a tick boundary with zero output gap
type: property
evidence: strong
source: [[murail-substrate-v3]]
created: 2026-02-28
status: active
---

# atomic swap enables program updates at tick granularity without output gaps

The live editing model (Layer 2) specifies how a running program can be modified without interrupting output. The mechanism is double-buffered state:

- **Σ_live**: the state region currently used by the fast thread
- **Σ_shadow**: being prepared by the slow thread

The swap protocol:
1. Slow thread validates the edit transaction, computes the new program P', layout L', migration map μ, and compiles F'_{r_top}
2. Slow thread populates Σ_shadow from Σ_live via μ (applying gauge transforms where declared)
3. Slow thread prepares any new external data regions
4. Slow thread sets an atomic swap flag
5. Fast thread observes the flag at the next tick boundary (after hold-slot writes, before TICK), atomically exchanges: Σ_live ↔ Σ_shadow, F_{r_top} ↔ F'_{r_top}, external data pointers
6. Fast thread continues with the new program, no pause

Proposition 17.1 establishes correctness: the old program produces the last output of tick t, and the new program produces the first output of tick t+1. Output continuity is preserved.

**This is the formal counterpart of compile-and-swap.** The substrate makes the mechanism precise in a way that informal descriptions of "hot reloading" typically aren't: the swap is atomic at tick granularity, the migration map is a formal specification of state translation, and the tick-boundary ordering ([[tick-boundary-precedence-is-a-substrate-requirement-not-an-implementation-suggestion]]) guarantees the swap happens at a clean boundary.

**Concurrent edits are serialized.** If multiple transactions arrive before a swap completes, they queue in arrival order. A later transaction may be rejected if it conflicts with a pending swap.

## Connections

- The migration map (equation-by-equation copy/reinit/gauge-transform) is detailed in [[the-migration-map-transforms-state-between-program-versions-preserving-continuity-where-possible]]
- The tick-boundary ordering that makes this safe is [[tick-boundary-precedence-is-a-substrate-requirement-not-an-implementation-suggestion]]
- [[compile-and-swap-preserves-audio-continuity-during-recompilation]] is the practical audio-domain instantiation of this formal mechanism
- The double-buffer protocol here is structurally similar to the large-payload hold slot protocol in [[hold-slots-prevent-fast-thread-blocking-on-slow-rate-values-without-locks]]: both use two copies + atomic index flip to avoid blocking readers
- [[two-phase-descriptor-protocol-enables-multi-location-atomic-updates-from-single-word-cas]] (Fraser) is the lock-free theory underlying why a single atomic flag can coordinate a multi-word state exchange
