---
description: The Löb rule (✄ϕ → ϕ) → ϕ is provable inside the topos of trees and subsumes coinduction as a special case, making it a single general principle for reasoning about recursive definitions
type: property
evidence: strong
source: [[birkedal-2012-guarded-domain-theory]]
created: 2026-02-28
status: active
---

# the Löb rule makes coinductive reasoning derivable in guarded domain theory

The internal logic of the topos of trees S satisfies the **Löb rule**: `(✄ϕ → ϕ) → ϕ` for any proposition ϕ. This is Theorem 2.7(2) in Birkedal et al. (2012). Unpacked: if one can prove "whenever ϕ holds later, ϕ holds now," then ϕ holds absolutely. This is an internal induction principle that allows reasoning about recursive definitions without exposing the step-index structure.

The Löb rule is the logical analog of the fixed-point property for contractive maps. In the Kripke-Joyal forcing semantics for S, it expresses that ω has no infinite descending chains: you cannot have a world where ϕ fails but ✄ϕ holds at every smaller world, because the ordinal indexing is well-founded.

Practical uses demonstrated in the paper:
- **Trivial Löb application**: if a configuration reduces to itself (`step((t,s),(t,s))`), then `eval(t,s,Q)` holds for any Q — proved in one line using Löb
- **Fundamental theorem of logical relations**: the soundness proof for Fµ,ref uses Löb structurally, replacing the usual step-index induction argument
- **Unique fixed points**: the internal Banach fixed-point theorem (Theorem 2.9) is proved using Löb plus the fact that ω is a total object, establishing `∃n. f^n` is constant

Unlike coinduction rules (which require the user to exhibit a coalgebra structure), Löb requires only that the conclusion is stated under a ✄ guard. This makes it more easily applicable to recursive programs and types.

## Connections

- The Löb rule corresponds structurally to Murail's causality invariant: [[the-causality-condition-requires-every-dependency-cycle-to-contain-a-delay-edge]] ensures every "recursive" equation goes through a guard (`self@d` with d≥1), which is exactly the guardedness discipline that makes Löb applicable
- The Löb rule on predicates (✄ on Ω) complements [[the-later-modality-on-types-enables-guarded-recursive-domain-equations-in-the-topos-of-trees]] (◮ on types) — together they provide the complete foundation for guarded recursion on both the predicate and type levels
- RustBelt-style semantic methods described in [[rust-safety-with-unsafe-code-requires-semantic-rather-than-syntactic-proof-methods]] were later rebuilt on top of Iris, which uses guarded domain theory and the Löb rule as its core reasoning principle
- In GCTT ([[birkedal-2016-guarded-cubical-type-theory]]), Löb induction is used to prove unique guarded fixed points (Prop. 3) and properties of guarded programs (Prop. 4: zipWith preserves commutativity); [[path-types-in-gctt-enable-proving-properties-of-guarded-recursive-programs-not-just-defining-them]] is the claim that GCTT's combination of Löb + path equality enables this new capability; the Löb rule is unchanged, but the reasoning it enables expands when path types replace identity types
