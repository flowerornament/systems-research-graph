---
description: A functor is locally contractive if its action on hom-objects factors through ◮; this syntactically verifiable condition ensures the recursive type equation has a unique solution that is simultaneously an initial algebra and final coalgebra
type: property
evidence: strong
source: [[birkedal-2012-guarded-domain-theory]]
created: 2026-02-28
status: active
---

# locally contractive functors guarantee unique fixed points for mixed-variance recursive types

In the topos of trees S, a strong endofunctor F is **locally contractive** if for all objects X, Y, the action FX,Y : Y^X → FY^FX factors through ◮(Y^X) — meaning the functor is strictly less powerful at relating morphisms than at relating objects. Definition 2.12 requires this factoring to respect identity and composition (making it an enriched functor structure).

The significance: locally contractive functors include mixed-variance cases (F : S^op × S → S), and Theorem 2.14 guarantees unique fixed points up to isomorphism for all of them. The proof is constructive: form the sequence 1 ← F(1) ← F²(1) ← ..., observe that F maps n-isomorphisms to (n+1)-isomorphisms (Lemma 2.15), take the limit as the diagonal. The fixed point is the unique initial dialgebra in the sense of Freyd, unifying initial algebras and final coalgebras for mixed-variance functors.

Syntactic conditions for local contractiveness: any type expression in which the recursion variable appears only under ◮ induces a locally contractive functor. This means:
- `µX. N × ◮X` (streams) — locally contractive in X
- `µX. ◮((N →fin X) →mon P(Value))` (Kripke worlds for higher-order store) — locally contractive
- Composition of a strong functor and a locally contractive functor (in either order) — locally contractive

The result generalizes to parametrized domain equations in slice categories (Theorem 4.5), which is needed to interpret nested recursive types in dependent type theory.

## Connections

- Provides the categorical backbone behind [[the-later-modality-on-types-enables-guarded-recursive-domain-equations-in-the-topos-of-trees]]
- The mixed-variance case handles the function-type constructor, which appears negatively in the domain and positively in the codomain — this is the case that classical domain theory (CPOs, Scott domains) handled via bilimits; here it is handled uniformly by contractiveness
- The analog in Murail is implicit: the causality checker in [[the-causality-condition-requires-every-dependency-cycle-to-contain-a-delay-edge]] plays the role of the syntactic contractiveness check — it verifies that every cyclic dependency passes through a delay (guard), which is what makes the recurrence well-founded
- [[guarded-domain-theory-generalizes-to-sheaves-over-any-well-founded-complete-heyting-algebra]] extends this fixed-point theorem beyond the topos of trees to a wide class of sheaf toposes
