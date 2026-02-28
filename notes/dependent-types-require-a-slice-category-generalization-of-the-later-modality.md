---
description: Extending ◮ to dependent types requires defining ◮I as a fibred endofunctor on each slice category S/I; the left adjoint ◭ does not extend to a well-behaved dependent type constructor
type: property
evidence: strong
source: [[birkedal-2012-guarded-domain-theory]]
created: 2026-02-28
status: active
---

# dependent types require a slice category generalization of the later modality

In the topos of trees S, the "later" functor ◮ : S → S is defined on objects. Dependent types in context Γ ⊢ A are interpreted as objects of the slice category S/Γ. To use ◮ as a type constructor in dependent type theory, it must extend to a **fibred endofunctor** — a family of functors ◮I : S/I → S/I that commutes with reindexing (pullback).

Birkedal et al. (Section 4) give the concrete definition: if pX : X → I is an object of S/I, then (◮I X)(n,i) = {⋆} when n=1, and X(n-1, i|_{n-1}) when n>1. The key fact (Proposition 4.4) is that u* ∘ ◮I ≅ ◮J ∘ u* for any morphism u : J → I — making ◮ a fibred endofunctor on the codomain fibration. This is what allows `Γ ⊢ ◮A` to be interpreted consistently under substitution.

Crucially, the **left adjoint** ◭ (which maps X(n) to X(n+1)) does **not** commute with reindexing (Proposition in Section 6.1), so it cannot serve as a well-behaved dependent type constructor. This asymmetry — ◮ is fibred, ◭ is not — is a structural fact about the codomain fibration, not a technical oversight.

The slice-category generalization also extends the fixed-point combinator: for any contractive f : X → X in ̂I (presheaves over the forest ∫I), the fixed point is constructed by x_{(1,i)} = g_{(1,i)}(⋆), x_{(n+1,i)} = g_{(n+1,i)}(x_{(n,i|n)}). This gives Theorem 4.5: parametrized recursive domain equations in slice categories have unique solutions for locally contractive functors, enabling nested recursive types in dependent type theory.

## Connections

- Without the slice-category extension, [[the-later-modality-on-types-enables-guarded-recursive-domain-equations-in-the-topos-of-trees]] would be restricted to simple type theory; the slice generalization lifts it to full dependent type theory
- The failure of ◭ to be fibred explains why "previous" (earlier-future) operators are not standard in guarded type theories — only ◮ (later) has the right categorical structure
- [[guarded-domain-theory-generalizes-to-sheaves-over-any-well-founded-complete-heyting-algebra]] faces the same slice-category requirement, handled abstractly via the axiomatic treatment of Section 6
