---
description: When every function transparently operates element-wise on sequences without explicit loops, programs become dramatically shorter and the programming model shifts from operating on channels to operating on structures
type: claim
evidence: moderate
source: [[mccartney-ideas-2026-02-15]]
created: 2026-02-28
status: active
---

# universal auto-mapping eliminates explicit iteration from signal processing programs

In SuperCollider, multi-channel expansion is special behavior of UGens: pass an array where a scalar is expected, get an array of UGens out. It works only for UGens; array operations on other types require explicit iteration. In McCartney's new language, *every function* auto-maps: any function defined for scalars transparently operates element-wise on sequences.

```
sqrt(9)           → 3
sqrt([4, 9, 16])  → [2, 3, 4]   // automatic, no loop written
```

Plus explicit `@` operators for controlling iteration shape: `@` expands one argument, `@1`/`@2` create nested (Cartesian) products for cross-product iteration. The inheritance hierarchy enforces this consistently: everything inherits from either `Item` (scalar) or `Sequence` (collection). Auto-mapping is part of the dispatch system, not a special case.

McCartney traces this to APL/J (rank-polymorphic operations are the semantic core, without APL's symbolic syntax) and F#'s `@` operators. He's explicit: he wants APL's density of expression without "Chinese" notation. He also mentions Stanley Jordan (guitarist, studied with Paul Lansky at Princeton) who wrote papers at the ACM on using APL to compose music and built a MIDI sequencer in APL -- evidence that APL-style thinking in music has precedent beyond McCartney's own language design work. Source: [[2026-02-06-qmayIRViJms]].

The consequence is a different programming model: you don't write loops over channels or samples; you describe operations on structures and let the language handle iteration. McCartney demonstrates programs that are a fraction of the SuperCollider equivalent in length -- not syntactic sugar but a genuinely different level of abstraction.

The flip side: auto-mapping can produce surprising behavior when a function unexpectedly receives a list. McCartney's decade of SAPF experience suggests this is learnable; whether it transfers to a community tool remains an open question.

Live demo context (2021 Codefest talk, [[2026-02-06-fmVdfQNPzkE]]): McCartney demonstrates SAPF interactively, showing how a list-of-seeds passed to a composition function automatically produces a list of compositions (via auto-mapping). The density is impressive -- whole musical structures in one line -- but requires knowing function arities to read. This is the readability tension described in [[concatenative-postfix-readability-breaks-when-argument-role-is-ambiguous]]: auto-mapping enables density, but density in postfix form creates parsing difficulty. McCartney's newer pipeline-style language addresses this by preserving auto-mapping while adding syntactic structure for argument roles.

**Question for Murail:** The language design context document (Feb 15) proposes set-lifting as a mechanism: `f {a, b, c}` maps `f` over a set. This is architecturally aligned. The question is scope: universal auto-mapping (every function, McCartney's approach, more powerful, harder to reason about statically) versus explicit lifting (you mark where lifting happens, safer, more verbose). The `@` operators for iteration shape control are worth considering regardless of which approach is chosen.

Extends [[channel-format-metadata-encapsulation-enables-audio-graph-reuse-across-channel-configurations]] from a language design angle: channel-agnostic audio types achieve format reuse in the graph; universal auto-mapping achieves the same at the program level. Connects to [[signal-shape-as-a-type-level-property-enables-compile-time-buffer-allocation-and-vectorization]] since auto-mapping operations are only statically analyzable if the shape is a type-level property.
