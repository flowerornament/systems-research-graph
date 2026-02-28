---
description: The ◮ functor on the topos of trees acts as a "later" guard that breaks the circularity in recursive type definitions, making them well-founded
type: property
evidence: strong
source: [[birkedal-2012-guarded-domain-theory]]
created: 2026-02-28
status: active
---

# the later modality on types enables guarded recursive domain equations in the topos of trees

In the topos of trees S (presheaves over ω), the functor ◮ : S → S is defined by ◮X(1) = {⋆} and ◮X(n+1) = X(n). This "later" functor delays access to a type's content by one step. A recursive type equation `µX.F(X)` is well-founded whenever F is a **locally contractive** functor — meaning its action on morphism spaces FX,Y : Y^X → FY^FX is contractive (factors through ◮).

The key result (Theorem 2.14): for any locally contractive functor F : S^op × S → S, there exists a unique (up to isomorphism) X such that F(X,X) ≅ X. The proof constructs the fixed point as the limit of the sequence 1 ← F1 ← F²1 ← ... where F maps n-isomorphisms to (n+1)-isomorphisms, so the diagonal gives a well-defined object.

This means recursive type equations like `Str ≅ N × ◮Str` (the type of streams) and the domain equation for Kripke worlds in models of higher-order store (`Tb = µX.◮((N →fin X) →mon P(Value))`) are all well-defined as fixed points of locally contractive functors. S is algebraically compact with respect to locally contractive functors: fixed points are simultaneously initial algebras and final coalgebras.

Type expressions built from ◮ and standard constructors where the recursion variable appears only under ◮ are automatically locally contractive — so the syntactic "guarded" condition ensures semantic well-foundedness.

## Connections

- The structural analog in Murail is [[guarded-self-reference-is-the-sole-mechanism-for-temporal-evolution-in-the-murail-calculus]]: `self@d` with d≥1 is the delay guard; equations with unguarded self-reference are rejected at compile time, exactly as unguarded recursive types are rejected in synthetic guarded domain theory
- Extends beyond the case of [[the-loeb-rule-makes-coinductive-reasoning-derivable-in-guarded-domain-theory]] by applying to types (not just predicates): fixed points of types require the ◮ functor, while fixed points of predicates use the ✄ modality
- Dependent types complicate the picture: [[dependent-types-require-a-slice-category-generalization-of-the-later-modality]] to ensure ◮ is a fibred endofunctor on the codomain fibration
