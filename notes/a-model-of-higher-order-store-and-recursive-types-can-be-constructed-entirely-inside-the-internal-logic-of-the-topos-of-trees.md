---
description: The soundness proof for Fµ,ref (impredicative polymorphism, recursive types, ML-like references) is carried out entirely within S's internal logic using guarded recursion, with no external step-index arithmetic
type: claim
evidence: strong
source: [[birkedal-2012-guarded-domain-theory]]
created: 2026-02-28
status: active
---

# a model of higher-order store and recursive types can be constructed entirely inside the internal logic of the topos of trees

Section 3 of Birkedal et al. (2012) demonstrates the synthetic approach by constructing a complete semantic model of Fµ,ref — a call-by-value language with:
- Impredicative polymorphism (∀α.τ)
- Recursive types (µα.τ)
- General ML-like mutable references (ref τ)

All definitions — including operational semantics, Kripke worlds, semantic types, and the fundamental theorem — are made inside the internal logic of S. The external step-indexed model is recovered as a corollary (Propositions 3.5–3.6): externally, the eval predicate satisfies "n |= eval(t,s,Q) iff for all m < n, if (t,s) reduces in m steps to (v,s'), then (n−m) |= Q(v,s')."

Key construction steps:
1. **eval predicate** (Definition via Theorem 2.9): `eval(t,s,Q) ⟺ (t∈Value ∧ Q(t,s)) ∨ (∃t₁,s₁. step(t,s,t₁,s₁) ∧ ✄eval(t₁,s₁,Q))` — well-defined by the internal Banach fixed-point theorem
2. **Kripke worlds** (Section 3.3): the circularity W = N →fin T, T = W →mon P(Value) is resolved via the guarded fixed point `Tb = µX.◮((N →fin X) →mon P(Value))`
3. **Type interpretation** (Section 3.4): recursive types use `fix`, reference types use ✄ to handle the one-step semantic delay between store lookup and value access
4. **Fundamental theorem** (Proposition 3.4): if ⊢ t : τ, then for all worlds w, t ∈ comp([[τ]]∅)(w) — proved with two explicit ✄ uses and no index arithmetic

The proof is "almost like a naive set-theoretic model" except at two points where guarded recursion is essential: the definition of recursive types (well-foundedness requires the guard) and the reference type interpretation (the store indirection introduces a one-step delay).

## Connections

- This example vindicates [[the-topos-of-trees-internalizes-step-indexing-eliminating-explicit-index-arithmetic-from-proofs]]: the fundamental theorem proof is substantially simpler than external step-indexed proofs for the same language
- The eval predicate is proved well-defined by [[the-internal-banach-fixed-point-theorem-proves-unique-solutions-for-contractive-guarded-recursive-predicates]]
- The Kripke world construction uses [[locally-contractive-functors-guarantee-unique-fixed-points-for-mixed-variance-recursive-types]]
- The approach scales to relational (rather than unary) models and more sophisticated local state models — relevant for future RustBelt-style proofs that [[rust-safety-with-unsafe-code-requires-semantic-rather-than-syntactic-proof-methods]] requires
