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

### Effect Type Soundness
- [[well-typed-algebraic-effect-programs-cannot-invoke-unhandled-operations]] -- Leijen's Lemma 4.b: effect types cannot be discarded except by handlers; every operation invocation in a well-typed program statically has a corresponding handler; soundness proof via subject reduction + faulty-not-typeable
- [[effect-type-absence-is-a-proof-of-non-interference]] -- the positive corollary of Lemma 4.b: absent effect label proves the function cannot invoke any operation from that effect; machine-checked non-throwing, non-allocating, non-blocking guarantees
- [[open-and-close-type-rules-preserve-completeness-while-simplifying-effect-polymorphic-types]] -- open/close rules are type-level coercions that simplify inferred types without restricting the set of typeable programs; completeness proof ensures no typeable programs are excluded
- [[row-typed-effects-compose-freely-because-they-are-restricted-to-the-free-monad]] -- free monad restriction makes effect composition automatic and type-safe; relevant to modeling murail's resource effects (audio context, scheduling) as composable effects

### Propagator Model and Provenance
- [[propagator-networks-provide-provenance-for-computed-conclusions]] -- Sussman's propagator model tracks the derivation chain of every computed value; potential basis for explainable audio computation in murail
- [[propagator-cells-hold-partial-information-that-accumulates-monotonically]] -- cells hold information about values (not values), accumulating monotonically; enables redundant paths and graceful degradation in murail's graph model
- [[truth-maintenance-systems-enable-locally-consistent-reasoning-in-an-inconsistent-knowledge-base]] -- TMSs maintain multiple locally consistent worldviews; relevant to tracking which physical model assumptions underlie a computed audio result
- [[dependency-directed-backtracking-prunes-search-using-provenance-rather-than-recency]] -- provenance-driven backtracking is more efficient than chronological; relevant if murail's compiler performs constraint-based scheduling

### Guarded Domain Theory (Birkedal et al. 2012) -- [[birkedal-2012-guarded-domain-theory]]

- [[the-topos-of-trees-internalizes-step-indexing-eliminating-explicit-index-arithmetic-from-proofs]] -- working inside S's internal logic absorbs all step-index management into the later modality ✄; externally the model is a standard step-indexed model
- [[the-later-modality-on-types-enables-guarded-recursive-domain-equations-in-the-topos-of-trees]] -- the ◮ functor breaks circularity in recursive type definitions; locally contractive functors have unique fixed points that are simultaneously initial algebras and final coalgebras
- [[the-loeb-rule-makes-coinductive-reasoning-derivable-in-guarded-domain-theory]] -- (✄ϕ → ϕ) → ϕ holds internally in S; this single principle subsumes coinduction and powers the fundamental theorem proofs
- [[locally-contractive-functors-guarantee-unique-fixed-points-for-mixed-variance-recursive-types]] -- syntactic guardedness (recursion variable under ◮) ensures local contractiveness; fixed point is the Freyd initial dialgebra
- [[the-internal-banach-fixed-point-theorem-proves-unique-solutions-for-contractive-guarded-recursive-predicates]] -- inhabited types with internally contractive endomorphisms have unique fixed points; proved using Löb without external index arithmetic
- [[guarded-domain-theory-subsumes-complete-bounded-ultrametric-spaces-as-a-reflective-subcategory]] -- BiCBUlt embeds as a co-reflective subcategory of S; prior BiCBUlt models can be rebuilt with full higher-order logic and automatic non-expansiveness
- [[dependent-types-require-a-slice-category-generalization-of-the-later-modality]] -- ◮I must be a fibred endofunctor on S/I; the left adjoint ◭ fails to commute with reindexing and cannot serve as a dependent type constructor
- [[guarded-domain-theory-generalizes-to-sheaves-over-any-well-founded-complete-heyting-algebra]] -- any Sh(A) for a well-founded complete Heyting algebra A is a model of synthetic guarded domain theory
- [[a-model-of-higher-order-store-and-recursive-types-can-be-constructed-entirely-inside-the-internal-logic-of-the-topos-of-trees]] -- the Fµ,ref fundamental theorem is proved inside S's internal logic with only two explicit ✄ uses
- [[the-guardedness-condition-on-recursive-definitions-is-the-proof-theoretic-analog-of-the-causality-condition-on-dependency-graphs]] -- ◮ guard (topos) and `@d` delay guard (Murail) are the same categorical principle at different scales; suggests a formal connection between Murail's compiler and guarded type theory

### Guarded Cubical Type Theory (Birkedal et al. 2016) -- [[birkedal-2016-guarded-cubical-type-theory]]

GCTT extends GDTT with path equality from cubical type theory, giving computational extensionality for guarded recursive types while preserving potential for decidable type-checking.

- [[equality-reflection-in-gdtt-makes-type-checking-undecidable-while-path-equality-in-gctt-preserves-the-potential-for-decidability]] -- GDTT's equality reflection is the source of undecidability; GCTT replaces it with CTT path types, making type-checking potentially decidable without losing extensional reasoning
- [[delayed-fixed-points-separate-path-equality-from-judgmental-equality-preventing-infinite-unfolding]] -- `dfix` produces a later term; fixed points are path-equal but not judgmentally equal to their unfoldings; canonical unfold lemma (Lemma 2) bridges the gap during proofs
- [[path-extensionality-for-later-types-is-derivable-in-gctt-not-merely-axiomatized]] -- `λp.⟨i⟩ next [p'←p]. p' i` is the computational witness for extensionality of later types; structurally parallel to `funext` for function extensionality
- [[gctt-semantics-requires-presheaves-over-the-product-of-the-cube-category-and-the-natural-numbers-poset]] -- C × ω combines cubical structure (path equality) with the topos of trees (later modality); neither factor alone suffices
- [[the-later-type-former-must-preserve-composition-structures-for-gctt-to-be-semantically-sound]] -- Lemma 9 is the central technical challenge: ▷ξ.A inherits a composition structure from A via isomorphisms that commute ▷ with Π over ω-constant types
- [[path-types-in-gctt-enable-proving-properties-of-guarded-recursive-programs-not-just-defining-them]] -- zipWith commutativity (Prop. 4) is the flagship example: Löb induction + path types + canonical unfold lemma together prove an extensional property of a guarded recursive stream function
- [[guarded-recursive-types-with-negative-variance-are-well-founded-because-the-later-modality-breaks-the-polarity-cycle]] -- RecA = fix x.(▷x' → A) is well-founded; the guarded Y combinator is provably a fixed-point combinator (Prop. 5), not merely definable
- [[gctt-excludes-clock-quantification-from-gdtt-making-coinductive-types-unrepresentable-as-first-class-types]] -- clock quantification (∀κ) is deferred to future work due to decidability and coherence problems; first-class coinductive types require clocks

### Murail Substrate: Calculus Properties (source -- [[murail-substrate-v3]])
- [[guarded-self-reference-is-the-sole-mechanism-for-temporal-evolution-in-the-murail-calculus]] -- the `self@d` form is the only way a Murail equation can depend on its own past; all recurrence, memory, and feedback derive from this single primitive
- [[the-causality-condition-requires-every-dependency-cycle-to-contain-a-delay-edge]] -- every cycle in G(P) must include at least one @d edge; this structural invariant makes the instantaneous-dependency subgraph a DAG and determines evaluation order by topological sort
- [[set-cardinality-and-tensor-shape-are-orthogonal-dimensions-in-the-murail-calculus]] -- shape describes the internal structure of each value; cardinality describes how many independent instances evolve in parallel; these dimensions are independent and compose separately
- [[variable-delay-requires-a-compile-time-declared-maximum-enabling-static-ring-buffer-allocation]] -- D_max declared at compile time converts dynamic delay amounts into a statically-bounded ring buffer; the out-of-range case degrades to default element without blocking
- [[the-murail-substrate-is-instantiated-by-a-domain-configuration-without-modifying-layers-0-through-2]] -- audio, robotics, and games each provide a domain configuration tuple; the three-domain test validates that the four-layer factoring is at the right level of generality
- [[dsp-and-ml-are-structurally-identical-under-shape-driven-dispatch-in-the-murail-calculus]] -- the equation `y = a·y@1 + b·x` is a one-pole filter at scalar shape and a recurrent neural layer at shape (16); only the dispatch target differs; the unification is a formal consequence of shape-driven dispatch

## Open Questions
- Can Murail's causality checker be given a type-theoretic interpretation in guarded domain theory? The structural correspondence between the `@d` guard and the ◮ modality ([[the-guardedness-condition-on-recursive-definitions-is-the-proof-theoretic-analog-of-the-causality-condition-on-dependency-graphs]]) suggests the causality checker is doing the work of a guardedness checker in a guarded type theory. Formalizing this could give soundness of the causality condition a categorical proof.
- Where exactly is the tier boundary between Lean-appropriate formal verification (stable core formalism) and runtime-verification-appropriate testing (application layer) in murail's architecture?
- The substrate validation criteria (Appendix B) specify the three-domain test as the correctness criterion for the factoring. Which domain should be implemented first to exercise the most substrate mechanisms with the least domain-specific complexity? (The toy-domain test suggests a spreadsheet-like domain, not audio, as the first validation target.)

---

Topics:
- [[index]]
