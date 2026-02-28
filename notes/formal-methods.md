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
- [[evolvability-requires-trading-provability-for-extensibility]] -- Sussman's formal argument: tight specs enable proofs but produce brittle towers; generic extensibility buys evolvability at the cost of formal verifiability

### Rust Formal Foundations (RustBelt)
- [[rust-safety-with-unsafe-code-requires-semantic-rather-than-syntactic-proof-methods]] -- open-world extensibility requires logical relations (semantic) rather than progress-and-preservation (syntactic); the semantic approach is extensible to new unsafe libraries
- [[unsafe-encapsulation-is-the-foundational-soundness-obligation-for-rust-library-authors]] -- library-specific verification conditions derived from semantic API interpretation; formal basis for trusting the unsafe internals of standard library types
- [[rust-provides-provably-memory-and-data-race-safe-programs-without-garbage-collection]] -- adequacy theorem establishes no stuck states; memory safety and data-race freedom are proved properties, not conventions
- [[iris-separation-logic-enables-deriving-a-lifetime-logic-from-primitive-mechanisms]] -- Iris's two primitive mechanisms (higher-order ghost state + impredicative invariants) are sufficient to derive the complete lifetime logic

### Propagator Model and Provenance
- [[propagator-networks-provide-provenance-for-computed-conclusions]] -- Sussman's propagator model tracks the derivation chain of every computed value; potential basis for explainable audio computation in murail
- [[propagator-cells-hold-partial-information-that-accumulates-monotonically]] -- cells hold information about values (not values), accumulating monotonically; enables redundant paths and graceful degradation in murail's graph model
- [[truth-maintenance-systems-enable-locally-consistent-reasoning-in-an-inconsistent-knowledge-base]] -- TMSs maintain multiple locally consistent worldviews; relevant to tracking which physical model assumptions underlie a computed audio result
- [[dependency-directed-backtracking-prunes-search-using-provenance-rather-than-recency]] -- provenance-driven backtracking is more efficient than chronological; relevant if murail's compiler performs constraint-based scheduling

## Open Questions
- Where exactly is the tier boundary between Lean-appropriate formal verification (stable core formalism) and runtime-verification-appropriate testing (application layer) in murail's architecture?

---

Topics:
- [[index]]
