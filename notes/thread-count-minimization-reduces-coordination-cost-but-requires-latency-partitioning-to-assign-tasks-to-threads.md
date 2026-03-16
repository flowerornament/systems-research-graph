---
description: Fewer threads simplify shared-state coordination; latency-based partitioning assigns tasks to the thread whose priority matches their deadline requirement
type: pattern
evidence: strong
source: "[[dannenberg-bencina-2005-design-patterns-real-time-computer-music]]"
created: 2026-03-01
status: active
---

# thread-count minimization reduces coordination cost but requires latency partitioning to assign tasks to threads

Dannenberg and Bencina's "Static Priority Scheduling" pattern (also known as Deadline Monotonic Scheduling) identifies a fundamental tension in real-time system design: when tasks share state, running them in fewer threads simplifies coordination because they cannot preempt each other. But the shorter the required latency, the shorter the task that must preempt everything else — which forces some tasks into separate, higher-priority threads.

The resolution is to minimize thread count (typically 2 or 3) and partition tasks by *latency requirement* — the time from when a task becomes runnable to its completion deadline. Low-latency tasks (sample buffer computation) go in the highest-priority thread; high-latency tasks (disk I/O, GUI updates) go in lower-priority threads. The scheduler runs these threads at fixed priorities.

This partitioning is analytically tractable before implementation. Worst-case latency for the highest-priority thread is the sum of all its task run times. For lower-priority threads, this sum must also account for time stolen by higher-priority preemption. This analysis allows deadline feasibility to be verified at design time.

**Implications for murail:** The murail substrate's two-thread model (fast thread + NRT thread) is an instance of this pattern with thread count = 2. The fast thread owns all sample-rate computation (hard real-time deadline); the NRT thread handles compilation, graph manipulation, and external I/O (no hard deadline). The pattern formalizes the rationale for the binary split: adding a third thread buys finer scheduling granularity at the cost of more complex coordination protocols.

The worst-case latency analysis is directly relevant to murail's block-size parameter: since [[block-size-is-the-primary-latency-throughput-tradeoff-in-murail-execution]], the block size determines the real-time deadline period, and therefore the total fast-thread task budget that must fit within it.

## Connections

- [[block-size-is-the-primary-latency-throughput-tradeoff-in-murail-execution]] -- the block size sets the real-time deadline period that the fast-thread task budget must satisfy
- [[the-murail-fast-thread-never-halts-errors-degrade-quality-but-do-not-stop-evaluation]] -- the fast thread's axiom of output continuity is what makes its deadline inviolable; tasks that might violate the deadline must be moved to the NRT thread
- [[supercollider-client-server-architecture-moved-the-scripting-language-out-of-the-real-time-audio-thread]] -- SC3's split is the canonical implementation of this pattern in a production system: language execution had unpredictable latency, so it was moved to a separate process
- [[static-thread-pool-decouples-neural-inference-from-the-audio-callback-to-ensure-real-time-safety]] -- anira's static thread pool applies the same principle to neural inference: inference violates RT deadlines, so it is partitioned to a background pool
- [[hold-slots-prevent-fast-thread-blocking-on-slow-rate-values-without-locks]] -- hold slots are the substrate mechanism that makes two-thread communication safe without coordination within the fast thread
