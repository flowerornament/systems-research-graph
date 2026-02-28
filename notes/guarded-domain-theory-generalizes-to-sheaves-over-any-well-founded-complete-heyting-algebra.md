---
description: The topos of trees is one instance of a broader class: any topos of sheaves Sh(A) where A is a complete Heyting algebra with a well-founded basis satisfies the axioms of synthetic guarded domain theory
type: claim
evidence: strong
source: [[birkedal-2012-guarded-domain-theory]]
created: 2026-02-28
status: active
---

# guarded domain theory generalizes to sheaves over any well-founded complete Heyting algebra

Birkedal et al. (Sections 6–8) give an **axiomatic categorical treatment** of synthetic guarded domain theory that abstracts away from the concrete topos of trees S. The axioms characterize models as toposes equipped with a fibred endofunctor ◮ satisfying:
- A natural transformation next : id → ◮
- A fixed-point combinator fix : (◮X → X) → X
- Appropriate commutativity and uniqueness conditions

The main generalization theorem: for any **complete Heyting algebra** A with a **well-founded basis** (a join-dense sub-meet-semilattice that is well-founded under the strict order), the topos of sheaves Sh(A) is a model of synthetic guarded domain theory. The topos of trees S is the special case where A = ω (the natural numbers with their usual order, extended with ∞).

The well-founded basis condition plays the same role that the ordinal ω's well-foundedness plays in S: it ensures the Löb rule is valid (there are no infinite descending chains in the index structure, so induction terminates). The complete Heyting algebra structure provides the subobject classifier Ω needed for the internal logic.

The generalized fixed-point theorem (Theorem 8.x, proved for Sh(A)-categories — categories enriched in sheaves over A) extends all the fixed-point results from S to this broader class. This includes existence of fixed points for locally contractive functors on mixed-variance domain equations.

## Connections

- Establishes that the specific choice of ω in the topos of trees is not essential for [[the-topos-of-trees-internalizes-step-indexing-eliminating-explicit-index-arithmetic-from-proofs]]; other well-founded ordinals or more complex Heyting algebras give equally valid models
- The axiomatic treatment separates the categorical axioms from their concrete realization, enabling future work to identify new models of guarded domain theory (e.g., for non-standard computational effects)
- [[dependent-types-require-a-slice-category-generalization-of-the-later-modality]] is addressed in the axiomatic treatment by defining ◮I via pullback (Proposition 4.3's pullback diagram is taken as the abstract definition)
- Potential relevance for murail: if murail's formal model ever needs a non-ω step-index structure (e.g., for transfinite computation steps), the generalization shows there is a well-understood categorical framework to fall back on
