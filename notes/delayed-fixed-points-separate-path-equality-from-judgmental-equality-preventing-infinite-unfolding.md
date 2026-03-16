---
description: GCTT's dfix combinator produces a "later" term rather than an immediate term; fixed points are path-equal but not judgmentally equal to their unfoldings, preventing canonicity-breaking infinite unfolding
type: property
evidence: strong
source: [[birkedal-2016-guarded-cubical-type-theory]]
created: 2026-03-01
status: active
---

# delayed fixed points separate path equality from judgmental equality preventing infinite unfolding

In GDTT, fixed-point combinators `fix x.t` satisfy the judgmental equality `fix x.t = t[next fix x.t / x]`. This unrestricted unfolding rule is problematic for decidable type-checking: if you allow stuck closed terms `fix x.t` inhabiting `N`, canonicity fails — a closed normal form of type `N` should be a numeral, not a stuck fixed-point.

GCTT solves this with the **delayed fixed-point combinator** `dfix`:

- Typing: if `Γ, x : ▷A ⊢ t : A`, then `Γ ⊢ dfix_r x.t : ▷A` (for `r : I`)
- Equality: `dfix_1 x.t = next t[dfix_0 x.t / x] : ▷A`

The subscript `r : I` is a **position on the path** between the stuck fixed-point and its one-step unfolding. Define `fix_r x.t ≡ t[dfix_r x.t / x]`. Then `fix x.t` (i.e., `fix_0 x.t`) is the stuck term, and `fix_1 x.t` is the unfolded term.

**Canonical unfold lemma (Lemma 2):** For any `Γ, x : ▷A ⊢ t : A`, the term `⟨i⟩ fix_i x.t` is a **path** between `fix x.t` and `t[next fix x.t / x]`. So fixed points are path-equal (not judgmentally equal) to their unfoldings.

Since `dfix` produces a `▷A` (a "later" value), it cannot be a stuck closed term of type `N` — you would need to strip the `▷` to get a natural number, which requires clock quantification (left to future work). Canonicity for base types is thus preserved.

By transitivity of paths, `fix x.t` is path-equal to any finite number of unfoldings of itself.

**Unique guarded fixed points (Proposition 3):** Any guarded fixed point `a` of a function `f : ▷A → A` (meaning there is a path from `a` to `f(next a)`) is path-equal to `fix x.f x`. This is proved by Löb induction.

## Connections

- This is the core mechanism that makes GCTT viable where GDTT was not: the interval element `r : I` does the work that would otherwise require equality reflection
- [[equality-reflection-in-gdtt-makes-type-checking-undecidable-while-path-equality-in-gctt-preserves-the-potential-for-decidability]] — this claim is the concrete mechanism; that claim is the motivation
- [[the-loeb-rule-makes-coinductive-reasoning-derivable-in-guarded-domain-theory]] — Löb induction is used to prove Prop. 3 (unique guarded fixed points); the dfix mechanism makes Löb applicable in GCTT as well as GDTT
- Structural parallel in Murail: [[guarded-self-reference-is-the-sole-mechanism-for-temporal-evolution-in-the-murail-calculus]] — `self@d` with `d≥1` is the analog of `▷`; Murail's equations are "later" in the same sense that `dfix` produces a later term
