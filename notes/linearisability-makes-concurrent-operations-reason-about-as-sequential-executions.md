---
description: A linearisable operation appears to execute instantaneously at some point between its invocation and return, making concurrent collections safe to reason about as if protected by a single global lock
type: property
evidence: strong
source: "[[fraser-2004-practical-lock-freedom]]"
created: 2026-02-28
status: active
---

# linearisability makes concurrent operations reason about as sequential executions

Linearisability (Herlihy and Wing, 1990) is the key correctness criterion for concurrent data structures. An operation is linearisable if and only if it appears to execute instantaneously at some point between its invocation (request) and return (response).

This has an important consequence: a set of concurrent linearisable operations always has a corresponding sequential execution that produces the same results. Equivalently, linearisable operations behave as if the shared data were protected by a single mutual-exclusion lock acquired immediately on invocation and released just before return.

**Why this matters for composition:** Linearisability is a local property — individual operations can be verified independently without reasoning about the entire system. This composability is the crucial advantage over weaker consistency properties like serializability (which requires global reasoning about transactions).

**Verification method (Fraser's approach):** Since formal proof of linearisability is difficult, Fraser uses an off-line model checker: log every operation invocation with its parameters, result, and start/end timestamps, then search for a valid linearised ordering. A valid ordering must (a) respect time ordering (no operation B can appear before A if B started after A completed), and (b) produce correct abstract state transitions. Fraser reports that one hour of random workload testing on a 4-processor machine reliably exposes even subtle linearisability bugs.

**Disjoint-access parallelism** is a complementary property: operations on disjoint memory locations must not interfere with each other. This bridges the gap between the formal progress guarantee of [[lock-freedom-guarantees-system-wide-progress-but-not-per-operation-progress]] and actual hardware performance — a lock-free structure can still serialize all operations via contention even if technically lock-free. Linearisability is the *correctness* criterion (do operations produce valid results?) while lock-freedom is the *progress* criterion (do operations eventually complete?). Both are necessary for a sound concurrent system.

**Verification depends on memory ordering:** Linearisability assumes sequentially consistent memory, but real hardware provides weaker ordering. Correct barrier placement is required to enforce the orderings that linearisability proofs depend on — and since [[memory-barrier-placement-in-lock-free-algorithms-is-manual-and-architecture-specific]], the verification method described above (offline model checking against hardware execution logs) is the practical validation strategy. In Rust, the `Ordering` parameter on atomic operations (`Acquire`, `Release`, `SeqCst`) maps directly to barrier placement decisions.

**Implications for murail:** The audio graph's parameter update protocol must be linearisable — an NRT write and RT read on the same parameter must serialize consistently. Rust's atomic operations (`compare_exchange`, `swap`) are linearisable by construction, and since [[rust-provides-provably-memory-and-data-race-safe-programs-without-garbage-collection]], the type system prevents the most common classes of errors that would violate linearisability in C/C++ lock-free code. Any compound NRT-side update (e.g., reconnecting multiple edges during graph recompilation) needs a linearisation point — the moment the new graph becomes visible to RT. This is exactly [[compile-and-swap-preserves-audio-continuity-during-recompilation]]: the CAS on the graph pointer is the linearisation point. The [[two-phase-descriptor-protocol-enables-multi-location-atomic-updates-from-single-word-cas]] generalises this pattern — the descriptor's status CAS is the linearisation point for multi-location atomic updates.
