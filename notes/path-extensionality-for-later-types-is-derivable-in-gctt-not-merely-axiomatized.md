---
description: The GCTT term λp.⟨i⟩ next [p'←p]. p' i gives a computational witness for extensionality of later types, replacing the axiom that made GDTT's type checking undecidable
type: property
evidence: strong
source: [[birkedal-2016-guarded-cubical-type-theory]]
created: 2026-03-01
status: active
---

# path extensionality for later types is derivable in GCTT not merely axiomatized

In GDTT, to support Löb induction one needs the ability to convert proofs of `▷ Id_A t u` into proofs of `Id_{▷A} (next t) (next u)`. Because this conversion corresponds to an isomorphism in the intended model (the topos of trees), GDTT **postulated it as a judgmental equality axiom**:

```
Id_{▷ξ.A} (next ξ. t) (next ξ. u) = ▷ξ. Id_A t u
```

Asserting axioms as judgmental equalities without computational content — and in a system without equality reflection — destroys **canonicity**: a closed normal-form term of a base type might fail to reduce to a canonical value.

GCTT derives this extensionality as a **computation term** (Example 1 and the discussion of Equation 2):

```
λp. ⟨i⟩ next ξ[p' ← p]. p' i  :  (▷ξ. Path_A t u) → Path_{▷ξ.A} (next ξ. t) (next ξ. u)
```

This term is structurally parallel to the `funext` term in CTT:

```
funext f g ≡ λp. ⟨i⟩ λx. p x i  :  ((x:A) → Path_B (f x) (g x)) → Path_{A→B} f g
```

In both cases, a path abstraction `⟨i⟩` combined with substitution into a "delayed" or "applied" argument provides the computational interpretation. The delayed substitution notation `[p' ← p]` unwraps the `▷`-wrapped path `p` inside the later context.

**Why this matters for Löb induction:** The standard Löb proof technique assumes `ih : ▷ Path_A a (fix x.f x)` (the induction hypothesis is available "later"), then constructs a composition that connects `a` to `fix x.f x`. The extensionality term is used implicitly to move the path `ih` across later-type boundaries during this construction.

## Connections

- [[equality-reflection-in-gdtt-makes-type-checking-undecidable-while-path-equality-in-gctt-preserves-the-potential-for-decidability]] — this derivable term is the specific payoff for switching from equality reflection to path types; the extensionality that was undecidable-introducing in GDTT is now computationally witnessed
- [[delayed-fixed-points-separate-path-equality-from-judgmental-equality-preventing-infinite-unfolding]] — Proposition 3 (unique guarded fixed points) uses this extensionality term in its proof via Löb induction
- [[the-loeb-rule-makes-coinductive-reasoning-derivable-in-guarded-domain-theory]] — the Löb rule remains the induction principle; this claim provides the extensionality that Löb arguments need when reasoning about path equality across the later boundary
