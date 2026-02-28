---
description: Lean proofs, mathematical foundations, verification strategies, and algebraic spaces
type: moc
created: 2026-02-27
---

# formal-methods

Formal methods research for murail. Covers the mathematical foundations of the formal model, Lean 4 mechanized proofs, verification strategies, and connections to algebraic and category-theoretic frameworks.

## Key Sub-Areas
- Murail formal model ("Named Sparse Recurrence System over Rated Tensors in Algebraic Spaces")
- Lean 4 proofs (20+ modules: AG, Bundle, Compile, Dep, Diff, Domain, Rate, Signal, Tensor, etc.)
- Verification strategies (property-based testing, loom, miri, assert_no_alloc)
- Algebraic foundations (spaces, tensor products, rate lattices)
- Spec derivation from formal model (v8 → v9 pipeline)

## Claims

### Verification Philosophy
- [[type-systems-have-not-empirically-reduced-defect-rates]] -- empirical studies find no reliable defect-rate advantage from static types; formal verification justified only for high-stakes stable specs
- [[debuggability-is-more-valuable-than-correctness-by-construction]] -- for evolving software the ability to debug and patch a live system outweighs proofs about code that will be discarded
- [[propagator-networks-provide-provenance-for-computed-conclusions]] -- Sussman's propagator model tracks the derivation chain of every computed value; potential basis for explainable audio computation in murail

## Open Questions
- Where exactly is the tier boundary between Lean-appropriate formal verification (stable core formalism) and runtime-verification-appropriate testing (application layer) in murail's architecture?

---

Topics:
- [[index]]
