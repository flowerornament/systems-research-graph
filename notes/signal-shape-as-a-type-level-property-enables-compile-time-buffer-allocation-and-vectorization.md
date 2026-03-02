---
description: When matrix shape (rows x columns) is part of the signal's type rather than runtime metadata, the compiler allocates buffers, plans SIMD vectorization, and catches mismatches before audio runs
type: claim
evidence: moderate
source: [[mccartney-ideas-2026-02-15]]
created: 2026-02-28
status: active
---

# signal shape as a type-level property enables compile-time buffer allocation and vectorization

In McCartney's new system, every signal has three properties: a matrix shape (rows x columns), an element type (32/64-bit int/float), and a rate (constant/init/event/audio). A mono audio signal is a 1x1 float64 audio-rate matrix; stereo is 1x2; an FFT frame is 1xN complex. Matrix operations (transpose, reverse, reshape) are graph operations on par with arithmetic. Auto-mapping means any scalar operation applied to a matrix operates element-wise.

Making shape a type-level property -- not runtime metadata attached to a buffer -- has a direct compiler consequence: the compiler knows the exact dimensions of every signal in the graph at compile time. This enables three things that are impossible or fragile when shape is runtime metadata: (1) static buffer allocation with known sizes; (2) SIMD vectorization planning across channel dimensions; (3) shape mismatch detection as a compile error rather than a runtime fault.

The hard case is feedback loops: you read a delay before you have written to it, so the output shape is unknown when you encounter the read. McCartney handles this with an explicit recursive pass in the compiler for shape inference across feedback edges.

McCartney traces the idea to two sources: SuperCollider's multi-channel expansion (ad hoc, only works for UGens, logic is spread and implicit) and APL/J array programming (rank-polymorphic operations, but symbolic syntax excluded). He generalizes SC's multi-channel expansion into universal auto-mapping and makes the matrix shape explicit in the type rather than emergent from wiring.

**Question for Murail:** The spec defines `FrameDim { channels: u16, components: u16 }` as validation metadata. McCartney's approach makes shape a type-level property the compiler reasons about. The two approaches are compatible but differ in depth: shape-as-metadata enables validation; shape-as-type enables optimization. The deeper approach requires more compiler investment but enables automatic vectorization across channel dimensions. What is the right boundary for v1?

Extends [[channel-format-metadata-encapsulation-enables-audio-graph-reuse-across-channel-configurations]] by proposing that channel shape go beyond metadata encapsulation into the type system itself. Connects to [[audio-format-type-must-be-resolved-at-graph-compile-time-not-during-execution]] -- both depend on compile-time shape knowledge; McCartney's approach formalizes that knowledge as a type constraint.
