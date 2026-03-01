---
description: GCTT's ▷ modality allows negative recursive occurrences (contravariant positions) to be well-founded because the delay breaks immediate self-reference; this enables guarded variants of Curry's Y combinator
type: property
evidence: strong
source: [[birkedal-2016-guarded-cubical-type-theory]]
created: 2026-03-01
status: active
---

# guarded recursive types with negative variance are well-founded because the later modality breaks the polarity cycle

Ordinarily, recursive types with negative variance — where the recursion variable appears in a contravariant position, such as `RecA = µX. (X → A)` — are problematic: they make type systems inconsistent or allow non-termination (Curry's Y combinator `Y f = (λx.f(xx))(λx.f(xx))` is definable and produces divergence).

In GCTT, negative variance is tamed by the `▷` modality. The guarded recursive type:

```
RecA ≡ fix x. (▷[x' ← x]. x') → A
```

is **path-equal** to `▷RecA → A`. Any recursive occurrence of `x` must appear under `▷`, which means "you only access the recursive part one step later." This delay breaks the immediate self-reference that causes divergence.

**Guarded Y combinator (Section 2.4):**

```
∆  ≡  λx. f (next [x' ← x]. (unfold x') x)  :  ▷RecA → A
Y  ≡  λf. ∆ (next fold ∆)                    :  (▷A → A) → A
```

where `fold` and `unfold` are the transports along the path between `RecA` and `▷RecA → A`.

**Proposition 5 (Y is a guarded fixed-point combinator):** `Y f` is path-equal to `f(next(Y f))` for any `f : ▷A → A`. Therefore by Proposition 3 (unique guarded fixed points), `Y` is path-equal to `fix`.

This means that in GCTT, the Y combinator is provably correct (path-equal to `fix`) — not merely definable but verified. This is new relative to the simply-typed setting where Y can be defined but properties cannot be proved.

**Relevance to coinduction models:** Negative variance guarded types are essential for models of program logics with higher-order store, where recursive world types like `µX. Pred(Val × X)` appear with negative occurrences. The `▷` guard is what makes these models coherent.

## Connections

- [[the-later-modality-on-types-enables-guarded-recursive-domain-equations-in-the-topos-of-trees]] — that claim covers positive-variance recursive domain equations; this claim extends the pattern to negative variance, which is essential for program logic models
- [[delayed-fixed-points-separate-path-equality-from-judgmental-equality-preventing-infinite-unfolding]] — `fix` and `dfix` provide the underlying mechanism; negative variance types use the same mechanism via `fold`/`unfold` transports
- [[a-model-of-higher-order-store-and-recursive-types-can-be-constructed-entirely-inside-the-internal-logic-of-the-topos-of-trees]] — that claim (from the 2012 paper) uses negative variance types for Kripke world models; GCTT provides path-equality reasoning about such models, extending what the 2012 paper could express
- The guarded Y combinator is analogous to Murail's `self@d` in that both prevent immediate self-reference; but GCTT makes it possible to prove *properties of programs* using such combinators, which pure operational semantics cannot
