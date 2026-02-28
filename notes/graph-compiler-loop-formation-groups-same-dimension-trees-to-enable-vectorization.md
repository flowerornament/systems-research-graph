---
description: After cutting a signal graph into expression trees, the compiler groups trees with identical matrix dimensions into loops, partitioned by rate, preserving topological order, so SIMD vectorization operates on structurally compatible operations
type: pattern
evidence: moderate
source: [[mccartney-ideas-2026-02-15]]
created: 2026-02-28
status: active
---

# graph compiler loop formation groups same-dimension trees to enable vectorization

After construction-time optimization and whole-graph passes (delay merging, topological sort, shape inference), McCartney's compiler executes a loop formation step. The step takes the graph -- which at this point has been cut into expression trees -- and decides which trees go into which output loops.

The algorithm has two constraints:
1. **Topological order must be preserved** -- a tree can only enter a loop after all its input trees have been assigned.
2. **All trees in a loop must have the same matrix dimensions** -- mixing different shapes would require different iteration bounds within the same loop, defeating vectorization.

Additionally, loops are separated by rate: constant-rate, initialization-time, reset-time, event-rate, and audio-rate expressions each form their own loop group. This mirrors the rate lattice used during construction (constant < init < reset < event < audio).

The motivation is vectorization (SIMD): if a loop processes N elements of a float32 matrix, the compiler can emit a single AVX2 instruction operating on 8 elements at once. This is only possible if all operations in the loop have the same element count and type. Mixing a mono signal (shape 1×1) with a stereo signal (shape 1×2) in the same loop would prevent vectorization; the loop formation pass ensures they are separated.

McCartney describes cutting the graph into trees as having two purposes: (1) identifying where instance variables or local variables are needed in the emitted code, and (2) structuring the code into loops. The loop is the code emission unit; each loop becomes a `for` statement over the matrix elements in the emitted C code.

**Implication for Murail:** This is a concrete compiler architecture for matrix-typed signal graphs. If Murail adopts matrix-typed signals, the compilation pipeline needs a loop-formation pass with the same two constraints. For single-channel (scalar) signals, the pass degenerates: all dimensions are 1×1, all trees go into one loop per rate. The pass becomes important when vector or matrix signals are in scope. Relevant to any future SIMD backend work in Murail.

Related to [[signal-shape-as-a-type-level-property-enables-compile-time-buffer-allocation-and-vectorization]] -- shape is the type property that makes this loop formation possible. Extends [[construction-time-graph-optimization-distributes-compiler-cost-across-node-creation]] by specifying what the compiler does after construction-time optimization is complete. Also see [[recursive-shape-inference-is-required-for-feedback-delay-reads-in-matrix-signal-graphs]] -- shape inference must complete before loop formation, since loop assignment depends on known shapes.
