---
description: Pre-computing and caching the topological evaluation order of the synthesis graph lets the graph be modified without protecting the execution list from concurrent access
type: pattern
evidence: strong
source: "[[dannenberg-bencina-2005-design-patterns-real-time-computer-music]]"
created: 2026-03-01
status: active
---

# caching UGen graph evaluation order decouples topology modification from concurrent execution

Dannenberg and Bencina's "Synchronous Dataflow Graph" pattern (also known as synthesis graph, UGen graph, Signal Graph in PD, Filter Graph in DirectShow) identifies two implementation strategies for evaluating data-dependent module networks:

1. **Direct traversal**: The graph is traversed at every evaluation tick to determine evaluation order. Simple to implement, but the graph traversal itself is part of the RT execution path — modifying the graph while it is being traversed requires protecting the traversal from concurrent access.

2. **Cached evaluation order**: The graph is traversed *once* to determine evaluation order, which is stored in a secondary flat list. At evaluation time, the list is iterated directly. The graph topology can be modified by updating this cached list, and the RT thread only touches the list, not the graph structure.

**The key insight:** Caching the evaluation order separates two concerns — *topology modification* (which happens at low priority, in NRT context) and *topological execution* (which happens at high priority, in RT context). The RT thread never needs to traverse pointer-chased graph structures; it reads a flat, cache-friendly execution list. The NRT thread can modify the graph and recompute the cached order, then atomically swap in the new list.

This is precisely the two-phase approach that [[compile-and-swap-preserves-audio-continuity-during-recompilation]] implements: compilation happens in the NRT thread (graph analysis, topological sort, code generation), and the result is swapped atomically into the RT thread. The synthesis graph pattern is the structural reason compile-and-swap is possible: the compiled schedule *is* the cached evaluation order.

**Graph coloring for buffer minimization:** The paper also notes that compiler graph-coloring techniques can minimize the number of intermediate buffers needed between modules. This is directly relevant to murail's IR design: [[signal-shape-as-a-type-level-property-enables-compile-time-buffer-allocation-and-vectorization]] provides the shape information that graph coloring requires to determine which buffers can be aliased.

**Murail's refinement:** Murail goes beyond simple topological ordering to a full compiler pipeline that includes loop formation, vectorization, and delay merging. The "cached evaluation order" in murail is a compiled binary schedule that has been optimized through multiple passes. The NRT/RT boundary is the same; the complexity is in what happens on the NRT side.

The contrast with ChucK's approach is instructive: [[user-space-cooperative-shreds-achieve-sample-accurate-deterministic-concurrency-without-os-scheduling]] avoids the concurrent-modification problem entirely by making modification a language-level operation -- shreds yield only at explicit time-advance points, so the shreduler can modify the shred list between time steps without concurrent access issues. Cached evaluation order is the *compiled* solution to concurrent modification; cooperative shreds are the *runtime* solution. Both achieve the same safety property -- the executing code never races with the graph-modification code -- but through different mechanisms that carry different performance and expressiveness tradeoffs.

## Connections

- [[compile-and-swap-preserves-audio-continuity-during-recompilation]] -- the compile-and-swap mechanism is the implementation of cached evaluation order: the compiled schedule is the cached execution list, and compilation is the one-time traversal
- [[construction-time-graph-optimization-distributes-compiler-cost-across-node-creation]] -- construction-time simplification happens during the NRT-side graph building phase; by the time topological ordering runs, the graph is already partially optimized
- [[signal-shape-as-a-type-level-property-enables-compile-time-buffer-allocation-and-vectorization]] -- shape information enables buffer aliasing analysis (the graph coloring the paper refers to) at compile time
- [[graph-compiler-loop-formation-groups-same-dimension-trees-to-enable-vectorization]] -- loop formation is a post-topological-sort pass that groups same-dimension expression trees; only possible in the cached-order model because direct traversal would need to re-do this analysis at every tick
- [[delay-merging-collapses-structurally-identical-delays-enabling-implicit-multi-tap-sharing]] -- delay merging is another NRT-side analysis pass that the cached-order model enables; impossible to do in direct traversal without the overhead appearing in the RT path
- [[stable-node-identities-enable-adapton-style-incremental-recompilation-where-only-affected-subgraphs-are-recompiled]] -- stable node IDs allow incremental recomputation of only the affected portion of the cached evaluation order after a graph edit, rather than full re-traversal
- [[audio-format-type-must-be-resolved-at-graph-compile-time-not-during-execution]] -- format resolution happens during the NRT-side compilation phase; the RT-side execution list contains only fully-resolved operations
