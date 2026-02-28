---
description: When UGens are library functions over four primitives (constants, math, delays, control flow) rather than opaque compiled objects, the compiler sees the full graph and can fuse, vectorize, and eliminate dead nodes across what were previously opaque boundaries
type: claim
evidence: moderate
source: [[mccartney-ideas-2026-02-15]]
created: 2026-02-28
status: active
---

# eliminating unit generators exposes synthesis graphs to cross-boundary compiler optimization

In McCartney's new system, a "sine oscillator" is not a precompiled C++ class with a `process()` method -- it is a library function that constructs a subgraph from exactly four kinds of primitive nodes: constants, math operators, delays (init/read/write), and control flow (if/switch/for). The entire synthesis graph -- oscillators, filters, delays, envelopes -- becomes one flat graph of arithmetic and memory operations.

The consequence for the compiler is fundamental: because UGen boundaries are now source-level rather than runtime objects, the compiler can optimize *across* them. A filter followed by a gain stage can be fused into a single loop. Common subexpressions spanning multiple "UGens" can be eliminated. Dead branches can be pruned regardless of which library function created them. None of this is possible when UGens are opaque boxes where the engine calls `process()` on each in sequence.

McCartney traces this directly to SuperCollider's limitation: two separate buffer loops with two separate function calls, even for trivially composable operations, because the engine cannot see inside compiled UGen objects.

The tradeoff is a lower-level IR: instead of `SinOsc(freq=440)` the IR holds `sin(accumulate(440 * sample_duration))`. This increases compiler burden and complicates the IR, but enables optimization opportunities that are architecturally foreclosed at the UGen-assembly level.

**Question for Murail (D51):** The spec treats UGens as trait objects behind a slotmap -- opaque boxes. This design enables the current v1 but forecloses cross-boundary optimization in future versions. The IR granularity choice is a one-way door: adding primitive-level IR later requires redesign; starting primitive-level allows UGen-level sugar on top. What IR granularity should v1 adopt that does not foreclose a lowered v2?

McCartney demonstrates this with concrete UGen equivalents: a one-pole filter, a one-zero filter, and a fade-in envelope are each ordinary language functions that create delay and arithmetic nodes. The "bubbles" patch from SuperCollider is a one-liner in this language. These are not special UGen objects -- they are functions that return graph node values, and the compiler sees every node they create.

Contrasts with [[JIT-graph-compilation-enables-context-aware-channel-format-inference-at-playback-time]], which optimizes at graph assembly time (format inference) rather than at the primitive arithmetic level. Related to [[audio-format-type-must-be-resolved-at-graph-compile-time-not-during-execution]], where compile-time knowledge is already exploited for format; McCartney's approach extends this to arithmetic itself. See [[synthesis-graph-construction-is-a-regular-program-not-a-domain-specific-declaration]] for the consequence this has for the programming model, and [[delay-merging-collapses-structurally-identical-delays-enabling-implicit-multi-tap-sharing]] for the specific whole-graph optimization that this primitive IR enables.
