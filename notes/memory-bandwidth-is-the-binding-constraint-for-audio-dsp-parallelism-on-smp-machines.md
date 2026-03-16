---
description: On SMP (multi-core) machines, audio DSP parallelism is bounded not by CPU count but by shared memory bandwidth; a sequential program saturating memory bandwidth has no room for parallel speedup
type: claim
evidence: strong
source: [[faust-2009-npcm]]
created: 2026-02-28
---

# Memory bandwidth is the binding constraint for audio DSP parallelism on SMP machines

Audio DSP workloads are memory-bandwidth-bound, not compute-bound. A real-time audio program continuously reads input samples and writes output samples — the bottleneck is moving data between memory and CPU, not the arithmetic performed on it.

On SMP (multi-core, shared-memory) machines, all cores share the same memory bus. If a sequential program already saturates the available memory bandwidth, adding more cores cannot improve throughput — each additional core competes for the same bus. The parallel version can only perform the same or worse.

The FAUST benchmarks document this precisely:
- **copy1.dsp** (pure memory copy, no computation): parallel versions are catastrophically worse than scalar on all machines — OpenMP thread overhead dominates because there is no compute to parallelize
- **rms8.dsp** (8 RMS computations in parallel): icc achieves speedup of ~3x on Mac (8-core), ~2.5x on XPS (4-core) — but a theoretical 8x speedup is impossible because memory bandwidth is shared
- **8-core Mac vs 4-core XPS**: on parallel workloads, the 8-core Mac at 3GHz was slower than the 4-core XPS at 2.5GHz, because 8 cores competing for the same memory bus has worse per-core bandwidth

The practical implication: audio DSP parallelism only pays off when there is genuine compute work (not just memory reads/writes) and when the computation-to-memory ratio is high. For synthesis graphs with many samples per output (e.g., long convolution, physical modeling), parallelism is profitable. For simple filters or routing graphs, it is not.

For murail, this is a direct design constraint: the murail graph compiler should not parallelize aggressively by default. Parallelism should be opt-in and benchmarked per workload. The [[compile-and-swap-preserves-audio-continuity-during-recompilation]] pattern requires the compiler to finish quickly, which sequential scalar code achieves better than a parallel version with synchronization overhead.

## Connections
- Grounds [[faust-vectorized-code-generation-splits-sample-loop-into-multiple-simpler-loops-to-expose-simd]] — SIMD vectorization exploits the same CPU core's vector units, not additional cores; it avoids the memory bus contention of SMP parallelism
- Extends [[purely-functional-dsp-semantics-enables-compiler-optimizations-impossible-in-C]] — the semantic freedom to restructure code matters most for SIMD, less so for SMP parallelism
- Relevant to murail's executor design: thread pool sizing for the audio graph render should be conservative, not greedy
