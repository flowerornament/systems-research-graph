---
description: No automatic method exists for optimal memory barrier placement in lock-free programs; manual placement requires per-architecture analysis and is validated by offline linearisability checking against hardware-measured execution logs
type: open-question
evidence: strong
source: "[[fraser-2004-practical-lock-freedom]]"
created: 2026-02-28
status: active
---

# memory barrier placement in lock-free algorithms is manual and architecture-specific

Lock-free algorithms are typically designed assuming a sequentially-consistent memory model, but no contemporary multiprocessor architecture provides sequential consistency. Hardware features like out-of-order execution, write buffers, and write-back caches relax the memory ordering guarantees, requiring explicit memory barrier instructions to enforce the orderings that lock-free correctness depends on.

The fundamental problem: determining the *minimum* set of required barriers — which pairs of memory accesses need ordering enforcement — requires a formal correctness specification and a proof that the pseudocode satisfies it under sequential consistency, followed by analysis of which relaxations each target architecture introduces. Fraser describes his approach as "essentially applying an informal version of the analysis method" backed by extensive hardware testing.

**Fraser's validation method:** Run random workloads on real hardware, log all operation invocations with timestamps and results, then run an offline linearisability checker. This NP-complete search (Wing and Gong) is made tractable by (a) checking operations on disjoint keys independently, and (b) distributing checking across processors. An hour of testing reliably exposes linearisability violations from incorrect barrier placement.

**Quantified cost of conservative placement:** Adding the memory barriers required for hazard pointer-style SMR (safe memory reclamation) to Fraser's BST increased execution time by over 20%. Unnecessary barriers are not free — they serialize memory operations and flush pipelines.

**Current state (2024):** This remains an open problem. The Rust memory model (`Ordering::Acquire`, `Ordering::Release`, etc.) exposes a portable abstraction over architecture-specific barriers, but the selection of the correct ordering for each atomic access in a complex algorithm is still manual and requires careful reasoning. Tools like `loom` (for model checking) partially address validation.

**Implications for murail:** Any lock-free atomic in murail's RT path must use the minimum necessary Rust ordering (`Relaxed` for reads/writes with no ordering requirements, `Acquire`/`Release` at synchronization points). Using `SeqCst` everywhere is correct but carries overhead. Systematic review of atomic orderings should be a code review gate.

See [[linearisability-makes-concurrent-operations-reason-about-as-sequential-executions]] for the correctness property this is targeting.
