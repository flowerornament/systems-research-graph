---
description: Lemma 9 of Birkedal et al. 2016 is the central technical contribution: showing ▷ξ.A is fibrant (has a composition structure) whenever A is fibrant, enabling the product semantics C×ω to work
type: property
evidence: strong
source: [[birkedal-2016-guarded-cubical-type-theory]]
created: 2026-03-01
status: active
---

# the later type-former must preserve composition structures for GCTT to be semantically sound

In cubical type theory, every type must carry a **composition structure** to be fibrant. Intuitively, a composition structure lets you fill the open end of a "box" in the type: given a path and a partial open box of compatible paths, you can complete it to a full path. Without composition, types cannot support transitivity or transport of path equality.

The key technical challenge of GCTT's semantics is showing that **`▷ξ.A` is fibrant whenever `A` is fibrant** (Lemma 9). This is non-trivial because `▷` is defined using the ω-component of `C × ω`, while compositions are defined using the C-component (the interval). The two components must interact correctly.

**Proof sketch (simplified case, empty delayed substitution `ξ`):**

Given a composition structure `c_A : Φ(Γ; A)`, we want `c : Φ(Γ; ▷A)`. Introduce variables:
- `γ : I → Γ` (a path in the context)
- `ϕ : F` (a face formula)
- `u : Π(i:I). (▷A(γ i))^ϕ` (a partial tube)
- `a₀ : (▷A)(γ 0)[ϕ ↦ u 0]` (a base)

Using **Lemma 7** (commuting `▷` with Π over ω-constant types) and **Corollary 8** (commuting `▷` with Π over face propositions), we obtain `ũ : ▷(Π(i:I). A(γ i)^ϕ)` isomorphic to `u`. Then the desired composition is:

```
next [u' ← ũ, a₀' ← a₀]. c_A γ ϕ u' a₀' : ▷(A(γ 1))
```

The critical obligation is that `a₀'` agrees with `u' 0` on the extent `ϕ`. This reduces to inhabiting `▷[u' ← ũ, a₀' ← a₀]. Id(a₀', u' 0)^ϕ`, which follows from the assumption that `a₀ = u 0` on `[ϕ]` and the isomorphism structure of `ũ`.

**Why the interval type `I` is ω-constant** (needed for Lemma 7): the interval `I` in `C × ω` is the pullback of the interval in `C` along the projection; it depends only on the C-component and is thus constant with respect to ω. Same for face propositions `[ϕ]`.

## Connections

- [[gctt-semantics-requires-presheaves-over-the-product-of-the-cube-category-and-the-natural-numbers-poset]] — this lemma is why the product structure works; without it, `▷` would break the fibrant type structure
- [[equality-reflection-in-gdtt-makes-type-checking-undecidable-while-path-equality-in-gctt-preserves-the-potential-for-decidability]] — the composition structures are what give path types their computational behavior; Lemma 9 is what makes the path equality approach viable for later types
- The later-preserves-composition requirement has no analog in GDTT (which used equality reflection without composition structures) — this is a genuinely new obligation that GCTT must discharge
