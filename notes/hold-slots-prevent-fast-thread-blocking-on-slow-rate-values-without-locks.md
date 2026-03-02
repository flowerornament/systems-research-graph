---
description: Hold slots give the fast thread a lock-free read path for slower-rate values using one of three protocols selected by data size; the fast thread never waits for a slow-thread write to complete
type: property
evidence: strong
source: [[murail-substrate-v3]]
created: 2026-02-28
status: active
---

# hold slots prevent fast thread blocking on slow-rate values without locks

When a faster-rate equation reads a value computed by a slower-rate equation, it would naively need to wait for the slow thread to finish writing. A lock would accomplish this but violates the resource invariant (the fast thread cannot acquire locks). Hold slots resolve this by providing a lock-free read protocol.

The protocol is selected by the byte size B_n of the data:

| Size class | Condition | Protocol |
|---|---|---|
| Atomic | B_n ≤ machine word | Aligned-word atomic read/write |
| Small | word < B_n ≤ K_hold (~64 bytes) | Sequence counter with bounded retry |
| Large | B_n > K_hold | Double-buffer with atomic index swap |

All three protocols guarantee that the fast thread observes a value that was fully written at some prior tick. No partial writes are ever observed. The fast thread never blocks -- the sequence counter protocol retries up to R_max times, and if that limit is reached, falls back to the previous value. The double-buffer protocol has no retry; it always reads the active copy.

**Hold semantics.** The fast thread reads the most recently written value:
`read(n_j, t) = σ^(j)_{t_last(t)}` where `t_last(t) = max{t' ≤ t | n_j was written at t'}`.

This is a "hold" because the value holds steady between slow-thread updates -- it doesn't change at every fast-rate tick, only when the slow thread writes a new value. Combined with smoothing (see [[cross-rate-smoothing-eliminates-staircase-discontinuities-from-hold-slot-reads]]), this produces a continuously-varying parameter at the fast rate from a discretely-updated slow-rate source.

**The protocol hierarchy mirrors lock-free data structure design.** The sequence counter protocol is structurally similar to Fraser's descriptor-based multi-word CAS ([[two-phase-descriptor-protocol-enables-multi-location-atomic-updates-from-single-word-cas]]): a counter signals in-progress writes, readers detect and retry. The double-buffer protocol is analogous to RCU (read-copy-update) for larger payloads.

## Connections

- Hold slots are the fast thread's only mechanism for observing slow-thread state; the full inter-thread communication surface is: hold slots (continuous), event queues (sporadic), and atomic swap flags (program updates) -- see [[atomic-swap-enables-program-updates-at-tick-granularity-without-output-gaps]]
- The staircase artifact introduced by hold semantics is smoothed away by [[cross-rate-smoothing-eliminates-staircase-discontinuities-from-hold-slot-reads]]
- Cross-rate feedback cycles are automatically causally valid because hold slots introduce latency ≥ 1 tick (see [[the-causality-condition-requires-every-dependency-cycle-to-contain-a-delay-edge]])
- [[existing-hardware-cas-primitives-suffice-for-practical-lock-free-data-structures]] is the foundational result that makes the atomic and sequence-counter protocols viable
- [[send-and-sync-are-thread-independence-of-ownership-and-sharing-predicates]] gives the formal basis for the safety of hold-slot reads in Rust
