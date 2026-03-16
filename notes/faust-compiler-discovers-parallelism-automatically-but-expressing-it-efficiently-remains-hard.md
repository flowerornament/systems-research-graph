---
description: The FAUST compiler can automatically identify all parallelizable computation in a program, but generating efficient parallel code is much harder than detection due to SMP overhead and memory pressure
type: open-question
evidence: strong
source: [[faust-2009-npcm]]
created: 2026-02-28
---

# FAUST compiler discovers parallelism automatically but expressing it efficiently remains hard

A functional language with explicit denotational semantics makes parallelism *detection* trivial: any two subexpressions without data dependencies can be computed in parallel. The FAUST compiler topologically sorts its loop graph and identifies all independent loop sets `L0, L1, ...` — these are by definition parallelizable.

But detection is not the hard problem. Generating efficient parallel code with OpenMP is hard because:
- Thread creation, synchronization, and barrier overhead may exceed the time saved
- Shared memory access requires coordination, and the memory bus becomes the bottleneck (see [[memory-bandwidth-is-the-binding-constraint-for-audio-dsp-parallelism-on-smp-machines]])
- The tradeoff between parallelism benefit and overhead is workload-dependent and not statically predictable

The FAUST benchmarks demonstrate: purely memory-bound workloads (copy1.dsp) are made catastrophically worse by parallelization; compute-bound parallel workloads (rms8.dsp — 8 independent RMS channels) show speedups of ~2.5-3x on an 8-core machine. The speedup is well below the core count because of memory bandwidth sharing.

The authors explicitly note: "While it is easy to discover all the potential parallelism of a FAUST program, generating efficient OpenMP programs is much more difficult due to the overheads introduced and the additional pressure on the shared memory."

This is an open design question for murail: if the graph IR exposes all parallelism (as FAUST does), the executor needs a principled strategy for deciding what to actually parallelize. A conservative default (sequential) with profiling-guided opt-in is likely safer than aggressive parallelism.

The broader principle is that parallelism is an implementation concern, not a language concern: "FAUST is not a parallel language... Parallelism is an implementation aspect and as such it is of the compiler responsibility, not of the language responsibility."

## Connections
- Grounds [[memory-bandwidth-is-the-binding-constraint-for-audio-dsp-parallelism-on-smp-machines]] — the hard problem is not detection but efficient expression given memory constraints
- Contrasts with [[faust-programs-denote-mathematical-functions-enabling-semantics-driven-compilation]] — semantics-driven compilation works well for optimization; parallelism requires hardware-profile-driven decisions beyond semantics
- Connects to murail executor design: the graph compiler should separate parallelism exposure (compiler's job) from parallelism exploitation (executor's job)
