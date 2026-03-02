---
description: GCTT is modeled in presheaves over C × ω, combining the cubical structure (for path equality) with the natural numbers poset (for the later modality); neither factor alone suffices
type: property
evidence: strong
source: [[birkedal-2016-guarded-cubical-type-theory]]
created: 2026-03-01
status: active
---

# GCTT semantics requires presheaves over the product of the cube category and the natural numbers poset

Guarded cubical type theory (GCTT) inherits its semantic structure from two independent sources:

- **CTT** is modeled in presheaves over the **cube category C** (the opposite of the Kleisli category of the free De Morgan algebra monad on finite sets). This gives the interval type `I`, path types, and composition operations.
- **GDTT** (without clock quantification) is modeled in presheaves over **ω** (the natural numbers poset), i.e., the **topos of trees** `Set^{ω^op}`. This gives the later modality `▷` and guarded fixed points.

GCTT is modeled in presheaves over **C × ω**, denoted `C×ω^` in the paper. The semantics is structured in three layered steps:

1. Any presheaf topos with an internal non-trivial De Morgan algebra `I` satisfying the **disjunction property** gives semantics to CTT without glueing and the universe. Any category `C × D` inherits such an interval from `C` via the projection functor `C × D → C`.

2. Any topos `C×D^` for `D` with an **initial object** can extend the semantics to include glueing and the universe of fibrant types. The glueing construction requires an internal right adjoint `∀` to the map `ϕ ↦ λ_.ϕ : F → (I → F)`, which exists for any `D` with an initial object.

3. The site is fixed to `C × ω`. The later type-former `▷` is defined as:
   ```
   (▷X)(I, n) = { {★}  if n = 0
                { X(I, m)  if n = m + 1
   ```
   This definition depends only on the ω-component and ignores the C-component, making the verification of GDTT rules parallel to the topos-of-trees case.

The key technical challenge (Lemma 9) is showing that `▷ξ.A` inherits a **composition structure** whenever `A` has one — compositions are what make types "fibrant" in the CTT sense. The proof uses two isomorphisms: Lemma 7 (commuting `▷` with Π-types over ω-constant types) and Corollary 8 (commuting `▷` with Π-types over face propositions).

## Connections

- [[the-later-modality-on-types-enables-guarded-recursive-domain-equations-in-the-topos-of-trees]] — the ω factor here is exactly the topos of trees; GCTT extends that setting with the cube category C for path equality
- [[guarded-domain-theory-generalizes-to-sheaves-over-any-well-founded-complete-heyting-algebra]] — the layered semantics in this paper is more specific: it requires the cube category for the De Morgan algebra structure, not arbitrary sites
- [[the-later-type-former-must-preserve-composition-structures-for-gctt-to-be-semantically-sound]] — Lemma 9 is the heart of the semantic construction; the C-component and ω-component interact precisely here
