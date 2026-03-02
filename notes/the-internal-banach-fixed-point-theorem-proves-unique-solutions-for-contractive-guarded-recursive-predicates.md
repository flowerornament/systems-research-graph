---
description: In the internal logic of the topos of trees, inhabited types with internally contractive endomorphisms have unique fixed points, proved without external step-index arithmetic
type: property
evidence: strong
source: [[birkedal-2012-guarded-domain-theory]]
created: 2026-02-28
status: active
---

# the internal Banach fixed-point theorem proves unique solutions for contractive guarded recursive predicates

Theorem 2.9 in Birkedal et al. (2012) states, in the internal logic of the topos of trees S: if X is inhabited and f : X → X is internally contractive (meaning `∀x,x'. ✄(x=x') → f(x)=f(x')`), then f has a unique fixed point. The proof goes via Lemma 2.10: any internally contractive map eventually becomes constant, specifically `∃n : N. ∀x,x'. f^n(x) = f^n(x')`. Combined with existence (from inhabitedness and Löb), uniqueness follows.

This is the metric/predicative version of the Banach fixed-point theorem, generalized from complete ultrametric spaces (where "contractive" means a strict Lipschitz constant less than 1) to the internal logic of a topos. The internal contractiveness condition `✄(x=x') → f(x)=f(x')` says "if x and x' agree one step later, then f(x) and f(x') agree now" — which is exactly contractiveness in the ultrametric sense where later steps are closer.

Key applications in the paper:
- Well-definedness of recursive predicates `r = ϕ(r)` where r occurs only under ✄ in ϕ (Section 2.5) — the guardedness makes ϕ internally contractive
- The eval predicate (Section 3.2): `eval(t,s,Q) ⟺ (t∈Value ∧ Q(t,s)) ∨ (∃t₁,s₁. step((t,s),(t₁,s₁)) ∧ ✄eval(t₁,s₁,Q))` — well-defined by Theorem 2.9
- The semantic type Tb for Kripke worlds in the model of Fµ,ref — existence follows from Theorem 2.14 (the type-level version)

The theorem is proved internally using the Löb rule and the fact that N is a total object (all restriction maps are surjective), making it available without importing any external metric space theory.

## Connections

- Relies on [[the-loeb-rule-makes-coinductive-reasoning-derivable-in-guarded-domain-theory]] as the induction principle in the proof
- The type-level analog is [[locally-contractive-functors-guarantee-unique-fixed-points-for-mixed-variance-recursive-types]] (Theorem 2.14) — they address the same fixed-point existence question at different levels (predicate vs. type)
- The complete bounded ultrametric space category BiCBUlt is a co-reflective subcategory of S (Section 5 of the paper), so [[guarded-domain-theory-subsumes-complete-bounded-ultrametric-spaces-as-a-reflective-subcategory]] — the internal Banach theorem generalizes the classical ultrametric fixed-point theorem
