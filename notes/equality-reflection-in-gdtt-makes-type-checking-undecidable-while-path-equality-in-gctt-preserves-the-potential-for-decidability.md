---
description: GDTT's equality reflection rule is the source of undecidability; GCTT replaces it with CTT's path types to regain decidable type-checking without sacrificing extensional reasoning about guarded recursive types
type: property
evidence: strong
source: [[birkedal-2016-guarded-cubical-type-theory]]
created: 2026-03-01
status: active
---

# equality reflection in GDTT makes type-checking undecidable while path equality in GCTT preserves the potential for decidability

GDTT (guarded dependent type theory) needed to prove equalities about guarded recursive constructions — for example, that two stream functions produce equal outputs — but intensional Martin-Löf type theory cannot accommodate such arguments. GDTT's solution was the **equality reflection rule**: if one can prove `Id_A t u`, then one may derive the judgmental equality `t = u`. This is well-known to make type-checking undecidable, because type-checking now requires proof search.

GCTT's solution is to replace identity types with **path types** from cubical type theory (CTT). Paths are terms of type `Path A t u`, and they are introduced by path abstraction `⟨i⟩ t` (analogous to λ-abstraction) and eliminated by path application `t r` for `r : I` (an interval element). Path types support functional extensionality computationally (not as an axiom), and the type checker can remain decidable because it does not need to search for proof terms.

The payoff: extensionality for later types — the ability to map terms of type `▷ Id_A t u` to proofs of `Id_{▷A} (next t) (next u)` — was an axiom in GDTT. In GCTT this becomes a derivable computation term:

```
λp. ⟨i⟩ next [p' ← p]. p' i : (▷ Path_A t u) → Path_{▷A} (next t) (next u)
```

This term is a **computational interpretation** of extensionality for later types, analogous to how `funext f g ≡ λp. ⟨i⟩ λx. p x i` witnesses functional extensionality in CTT.

## Connections

- Directly extends [[the-later-modality-on-types-enables-guarded-recursive-domain-equations-in-the-topos-of-trees]]: that claim established the semantic well-foundedness of guarded recursive types; this claim establishes that we can now *reason about their extensions* without sacrificing decidable type-checking
- The interval-element annotation on fixed points (see [[delayed-fixed-points-separate-path-equality-from-judgmental-equality-preventing-infinite-unfolding]]) is another place where CTT's interval does work that equality reflection previously did via axioms
- The connection to Murail: if the causality checker is understood as a guardedness checker ([[the-guardedness-condition-on-recursive-definitions-is-the-proof-theoretic-analog-of-the-causality-condition-on-dependency-graphs]]), GCTT's decidable type-checking suggests a path toward a formally verified causality check
