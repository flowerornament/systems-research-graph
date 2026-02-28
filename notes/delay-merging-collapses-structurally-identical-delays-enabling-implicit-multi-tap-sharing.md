---
description: When two delays have identical inputs and initialization, the graph compiler collapses them into one, so multiple UGen-style library functions can share the same delay line without explicit coordination
type: pattern
evidence: moderate
source: [[mccartney-ideas-2026-02-15]]
created: 2026-02-28
status: active
---

# delay merging collapses structurally identical delays enabling implicit multi-tap sharing

The first whole-graph compiler pass in McCartney's system is delay merging: "If a delay has the same inputs and initialization as another delay, then just make that into one delay."

This handles a specific case that arises when multiple library functions each introduce their own delay on the same signal. Consider two filter functions both delaying the same input signal by one sample: in a UGen-based system, they would each maintain separate delay lines. In McCartney's primitive-IR system, both functions create a `delay(x)` node, and the compiler's hash-based CSE at construction time will already collapse them if they are structurally identical. The delay merge pass handles cases that construction-time CSE misses -- typically when initialization expressions differ in form but not in computed value, or when delays are introduced through different code paths that converge to the same structure.

The effect is implicit multi-tap sharing: multiple parts of a synthesis graph that each logically need to read from "one sample ago" of the same signal share a single underlying delay buffer without the programmer explicitly wiring a shared delay node. The programmer writes functions as if each has its own delay; the compiler consolidates.

McCartney notes this can arise "if you're calling different functions, they're each delaying the same input, and then they'll be merged into one delay." This is only possible because UGens have been eliminated: when UGens are opaque objects, two separate `OnePole` instances each manage their own delay state invisibly. With primitive-level IR, the delay is a visible node in the graph, subject to merging.

**Implication for Murail:** This optimization is only available at the primitive-IR level described by [[eliminating-unit-generators-exposes-synthesis-graphs-to-cross-boundary-compiler-optimization]]. If Murail retains opaque UGen objects (current spec), delay merging across UGen boundaries is structurally impossible. The optimization is a concrete, practical benefit of the primitive-IR approach that justifies its complexity. Worth naming as an explicit benefit in any evaluation of IR granularity options.

Relates to [[construction-time-graph-optimization-distributes-compiler-cost-across-node-creation]] -- CSE at construction time handles the common case; delay merging is the whole-graph pass that catches the rest. See [[graph-compiler-loop-formation-groups-same-dimension-trees-to-enable-vectorization]] for the subsequent compiler passes that build on the merged graph.
