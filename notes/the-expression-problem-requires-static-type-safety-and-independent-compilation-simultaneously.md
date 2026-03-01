---
description: Wadler's constraint set excludes runtime casts and forces the solution to work without recompiling existing code, ruling out most prior approaches
type: property
evidence: strong
source: [[wadler-1998-expression-problem]]
created: 2026-03-01
status: active
---

# the expression problem requires static type safety and independent compilation simultaneously

Wadler's constraints are precise: extensibility in both dimensions *without recompiling existing code* and *without runtime casts*. These two constraints together exclude the prior solutions Wadler surveys:

- **Krishnamurthi, Felleisen & Friedman's Extended Visitor pattern** (Pizza/Java): dynamically typed extension -- cannot distinguish `Lang.Exp` from `Lang2.Exp` without dynamic casts. Wadler: "This isn't due to a lack of cleverness on their part, rather it is due to a lack of expressiveness in Pizza."
- **Special-purpose language extensions** (Krishnamurthi's paper and Odersky's student's thesis): satisfy the constraints but require dedicated mechanisms designed specifically for the problem; not general-purpose.
- **Corky Cartwright's contravariant extension**: satisfies static typing but requires contravariant subtyping (a non-standard language feature).

The constraint set is the distinguishing criterion: whether a language can *solve* the Expression Problem using only general-purpose mechanisms (type parameters, virtual types, subtyping) is a "salient indicator of its capacity for expression." Wadler knew of no widely-used language satisfying both constraints before GJ with virtual type indexing.

For murail's [[language-design]]: the constraint set maps directly to Murail's situation. Independent compilation means the graph engine and composition language can evolve separately. Static type safety means UGen type mismatches are caught at compile time, not audio-render time. Both constraints are desirable and their tension is exactly the Expression Problem.

This tightens [[evolvability-requires-trading-provability-for-extensibility]]: Sussman argues extensibility is worth sacrificing static proofs, but Wadler's solution shows the tradeoff is not necessary when the type system is expressive enough. The question for Murail is which type system mechanisms (traits? multimethods? virtual types?) make the tradeoff avoidable.
