---
description: GCTT's path equality + Löb induction together allow proving extensional properties of guarded recursive programs (e.g., that zipWith preserves commutativity) which simply-typed guarded calculi cannot express
type: claim
evidence: strong
source: [[birkedal-2016-guarded-cubical-type-theory]]
created: 2026-03-01
status: active
---

# path types in GCTT enable proving properties of guarded recursive programs not just defining them

Simply-typed guarded recursion (Clouston et al. 2015) allows *defining* productive operations on coinductive data — you can define `zipWith`, streams, and even the Y combinator. What you cannot do is *prove* that these programs satisfy extensional properties like commutativity, because the simply-typed calculus has no equality infrastructure beyond definitional reduction.

GCTT adds two complementary tools:

**1. Path types** allow stating and proving extensional equalities. For streams: `Path StrA (zipWith f s₁ s₂) (zipWith f s₂ s₁)`.

**2. Löb induction** allows proving by assuming the property holds "later" (`ih : ▷ (∀ s₁ s₂. Path StrA (zipWith f s₁ s₂) (zipWith f s₂ s₁))`), then constructing the proof for "now".

**Proposition 4 (zipWith preserves commutativity):** If `f : A → A → B` is commutative (witnessed by `c : ∀ a₁ a₂. Path_B (f a₁ a₂) (f a₂ a₁)`), then `zipWith f` is commutative.

The proof term builds a stream `v` that is path-equal to `zipWith f s₁ s₂` at endpoint `i=0` and `zipWith f s₂ s₁` at endpoint `i=1`, by combining:
- The commutativity path `c (hd s₁) (hd s₂) i` for the head
- The induction hypothesis applied to the tails: `next [q ← ih, t₁ ← tl s₁, t₂ ← tl s₂]. q t₁ t₂ i`
- The canonical unfold lemma (Lemma 2) to handle the path-vs-judgmental equality gap at the stream boundary

The proof has been **mechanically verified** in the prototype GCTT type checker (available in the gctt-examples repository).

**The upgrade over GDTT:** In GDTT you could state such a property via identity types, but the proof would require equality reflection (making type-checking undecidable) or be blocked by the definitional gap at the fixed-point boundary. GCTT's `dfix`-based fixed points are path-equal (not judgmentally equal) to their unfoldings, and the canonical unfold lemma provides the path that bridges this gap during proof construction.

## Connections

- [[equality-reflection-in-gdtt-makes-type-checking-undecidable-while-path-equality-in-gctt-preserves-the-potential-for-decidability]] — this claim concretizes what "extensional reasoning about guarded recursive types" means in practice
- [[delayed-fixed-points-separate-path-equality-from-judgmental-equality-preventing-infinite-unfolding]] — the canonical unfold lemma (Lemma 2) is the bridge that makes proof terms like the zipWith commutativity proof composable
- [[path-extensionality-for-later-types-is-derivable-in-gctt-not-merely-axiomatized]] — the later-extensionality term is used implicitly in the Löb induction step to move the induction hypothesis across the `▷` boundary
- Relevance to Murail: if Murail programs could be expressed in a GCTT-like setting, this would mean one could formally prove that two audio graph programs produce the same output streams — a formal correctness criterion for audio program equivalence; [[the-guardedness-condition-on-recursive-definitions-is-the-proof-theoretic-analog-of-the-causality-condition-on-dependency-graphs]] suggests this direction
