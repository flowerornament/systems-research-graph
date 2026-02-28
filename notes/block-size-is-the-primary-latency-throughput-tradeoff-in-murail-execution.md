---
description: Block size N controls how many ticks are processed per TICK invocation; smaller N reduces latency, larger N improves throughput via vectorization, with identical semantics either way
type: decision
evidence: strong
source: [[murail-substrate-v3]]
created: 2026-02-28
status: active
---

# block size is the primary latency-throughput tradeoff in murail execution

The tick function TICK processes N ticks per invocation. N is called the block size and is described in the substrate as "the single most important tuning parameter in every domain." Its effect is straightforward:

- **Lower N (smaller blocks):** Less latency. The output of tick t is available after N/ν(r_top) seconds.
- **Higher N (larger blocks):** Better throughput. Feed-forward equations (no self-reference) can be vectorized across the block dimension, treating it as an additional leading shape axis. This promotes every dispatch tier by one rank: scalars become vectors of length N, vectors become matrices.

Block-mode execution is semantically equivalent to N individual N=1 invocations. This equivalence is a substrate requirement, not an optimization hint -- implementations must produce identical output regardless of N. This requirement is what makes block size a tunable runtime parameter rather than a semantic choice.

**Stateful vs. feed-forward within a block.** Equations with `self@d` must be evaluated per-sample -- the block loop is the inner loop because each sample depends on the previous one's state. Feed-forward equations (no self-reference) can be vectorized across the block. This distinction drives the compilation of the tick function into a mixed scalar/vector schedule.

In audio, this tradeoff is directly observable: a block size of 64 at 48kHz produces 1.3ms latency; a block size of 512 produces 10.7ms. Most DAWs expose this as "buffer size" in their audio settings. Murail formalizes this tradeoff at the substrate level, making it a first-class design parameter rather than an implementation detail.

## Connections

- Block-mode vectorization connects to [[faust-vectorized-code-generation-splits-sample-loop-into-multiple-simpler-loops-to-expose-simd]] which solves a closely related problem via different mechanism (loop splitting rather than block promotion)
- The latency-throughput tradeoff is the underlying motivation for the NRT/RT separation in [[hold-slots-prevent-fast-thread-blocking-on-slow-rate-values-without-locks]]; slow-rate equations running at low frequency don't need the low latency the fast thread provides
- [[all-murail-program-state-fits-in-a-single-pre-allocated-contiguous-region]] enables safe block processing because state is pre-allocated and head indices advance correctly per sample within the block
