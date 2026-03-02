---
description: Source reference for McCartney's 2025 SuperCollider Symposium keynote; covers his new audio language runtime design and synthesis graph compiler pipeline in direct first-person detail
type: claim
source: https://www.youtube.com/watch?v=Ke8e7pGAxec
created: 2026-02-28
status: active
---

# mccartney supercollider symposium 2025 keynote

James McCartney's keynote at the 2025 SuperCollider Symposium (50:33). Direct first-person account of two workstreams: a new dynamically-typed interpreted language runtime, and a synthesis graph IR and code generation library with bindings from the language.

**Language design topics covered:** dynamic class/method creation (classes as type tags, not field contracts); module namespacing; thread-local persistent-dictionary scope with copy-on-fork; pervasive immutability with HAMT-based persistent data structures (immer C++ library); explicit mutex-protected mutable Refs; reference counting without a garbage collector; multimethods with multiple argument dispatch; universal auto-mapping with explicit `@` operators for Cartesian/parallel expansion.

**Synthesis IR/compiler topics covered:** all signals as typed matrices (shape × element type × rate); five-level rate lattice (constant, init, reset, event, audio); construction-time optimization (constant folding, CSE, rate inference, 120+ algebraic rewrite rules); whole-graph compiler passes (delay merge, topological sort, delay length calculation, recursive shape inference for feedback loops, graph-to-tree cutting, loop formation by dimension and rate, code emission to C, compile, link, load); UGens as library functions over primitive nodes.

**Outstanding work (as of 2025):** event codegen, scheduler, synth server protocol, SIMD code generator (had working version, needs rewrite after immutability refactor).

**Influences cited:** Dylan (linearized multiple inheritance, multimethods), Clojure (persistent data structures, transients), immer C++ library (Juan Pedro Bolivar Fuente), Joy/concatenative languages (SAPF precursor), F# (pipe operator, `@` operators via F#), Kronos (multi-rate reactive, McCartney's codegen inspiration), Faust (comparison point throughout).

Primary claims extracted from this transcript:
- [[reference-counting-becomes-viable-when-immutability-prevents-object-cycles]]
- [[classes-as-type-tags-allow-per-instance-field-variation]]
- [[thread-local-top-level-scope-with-copy-on-fork-achieves-actor-isolation-without-message-passing]]
- [[recursive-shape-inference-is-required-for-feedback-delay-reads-in-matrix-signal-graphs]]
- [[graph-compiler-loop-formation-groups-same-dimension-trees-to-enable-vectorization]]
- [[delay-merging-collapses-structurally-identical-delays-enabling-implicit-multi-tap-sharing]]
- [[synthesis-graph-construction-is-a-regular-program-not-a-domain-specific-declaration]]

Cross-referenced transcript: [[mccartney-ideas-2026-02-15]] synthesizes this and three other McCartney talks. Archive: `/Users/morgan/code/murail/.design/references/transcripts/archive/2026-02-06-Ke8e7pGAxec.md`
