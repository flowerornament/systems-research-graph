---
batch: fraser-2004-practical-lock-freedom
date: 2026-02-28
claims_created: 11
enrichments: 2
connections_added: ~18
topic_maps_updated: 1
---

# Batch Summary: fraser-2004-practical-lock-freedom

**Source:** Keir Fraser, "Practical lock-freedom" — PhD dissertation, UCAM-CL-TR-579, University of Cambridge Computer Laboratory, February 2004. 5151 lines.

**Processing date:** 2026-02-28

## Claims Created (11)

1. [[existing-hardware-cas-primitives-suffice-for-practical-lock-free-data-structures]] — Central thesis of the dissertation; CAS suffices; refutes DCAS requirement
2. [[lock-freedom-guarantees-system-wide-progress-but-not-per-operation-progress]] — The lock-freedom/wait-freedom/obstruction-freedom progress hierarchy
3. [[two-phase-descriptor-protocol-enables-multi-location-atomic-updates-from-single-word-cas]] — Core pattern behind MCAS and FSTM; structural analog to compile-and-swap
4. [[epoch-based-reclamation-amortizes-garbage-collection-across-concurrent-operations]] — EBR as NRT-side memory reclamation; tradeoffs vs. hazard pointers
5. [[read-only-lock-operations-cause-cache-coherency-traffic-even-on-unmodified-data]] — Cache coherency cost of locking even for reads; tree root bottleneck
6. [[mcas-and-stm-trade-performance-for-programmability-at-a-quantifiable-cost]] — CAS > MCAS > STM performance hierarchy; 2-4x STM overhead
7. [[linearisability-makes-concurrent-operations-reason-about-as-sequential-executions]] — Correctness criterion for concurrent data structures; composability
8. [[obstruction-freedom-allows-conflict-abort-instead-of-recursive-helping-reducing-implementation-complexity]] — Weaker progress guarantee; abort vs. help tradeoff
9. [[pointer-marking-for-logical-deletion-prevents-concurrent-insertion-into-deleted-nodes]] — Harris's pointer marking technique extended to skip lists
10. [[skip-lists-decompose-multi-level-updates-enabling-higher-lock-free-parallelism-than-trees]] — Per-level decomposability; crossbeam-skiplist recommendation
11. [[memory-barrier-placement-in-lock-free-algorithms-is-manual-and-architecture-specific]] — Open problem; Rust memory model context for murail

**Source reference file:** [[fraser-2004-practical-lock-freedom]]

## Enrichments (2)

1. **[[compile-and-swap-preserves-audio-continuity-during-recompilation]]** — Added structural parallel to two-phase descriptor protocol; linearisation point analysis
2. **[[concurrent-systems]]** (topic map) — Added "Lock-Free Systems (Fraser 2004)" section with 11 claims

## Notable Connections

- [[two-phase-descriptor-protocol-enables-multi-location-atomic-updates-from-single-word-cas]] → [[compile-and-swap-preserves-audio-continuity-during-recompilation]]: compile-and-swap is a domain-specific application of the two-phase descriptor pattern
- [[epoch-based-reclamation-amortizes-garbage-collection-across-concurrent-operations]] → [[reference-counting-becomes-viable-when-immutability-prevents-object-cycles]]: complementary memory management approaches
- [[lock-freedom-guarantees-system-wide-progress-but-not-per-operation-progress]] → [[erlang-actor-model-enables-safe-process-kill]]: Erlang's shared-nothing model eliminates helping chains entirely
- [[linearisability-makes-concurrent-operations-reason-about-as-sequential-executions]] → [[rust-provides-provably-memory-and-data-race-safe-programs-without-garbage-collection]]: formal correctness → formal safety

## Domain Relevance

Primary: concurrent-systems (murail NRT→RT communication, parameter update protocols, graph swap mechanism)
Secondary: formal-methods (linearisability proofs, progress guarantees)

## Learnings

- Lock-free systems research connects directly to murail's compile-and-swap via the two-phase descriptor pattern — stronger cross-domain connection than expected
- Epoch-based reclamation is the appropriate NRT-side memory management pattern; hazard pointers are too expensive for RT-adjacent use
- The performance hierarchy (CAS > MCAS > STM > RW-locks) is empirically quantified and directly applicable to murail design decisions
