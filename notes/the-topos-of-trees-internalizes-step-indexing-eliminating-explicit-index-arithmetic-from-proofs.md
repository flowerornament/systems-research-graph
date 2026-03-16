---
description: Working inside the internal logic of the topos of trees yields step-indexed models whose proofs look like naive set-theoretic proofs with no visible step-index bookkeeping
type: claim
evidence: strong
source: [[birkedal-2012-guarded-domain-theory]]
created: 2026-02-28
status: active
---

# the topos of trees internalizes step-indexing eliminating explicit index arithmetic from proofs

Step-indexed models of programming languages are notoriously tedious to work with because every proof step must track which approximation level it operates at, requiring index arithmetic throughout. Birkedal et al. show that by working entirely inside the internal logic of the topos of trees S — a presheaf category over the first infinite ordinal ω — all step-index management is absorbed into the structural rules of the logic.

The key mechanism is the "later" modality ✄ on predicates (and ◮ on types). Every recursive definition that would require step-indices externally instead uses a guard ✄, expressing "this holds one step later." The Löb rule `(✄ϕ → ϕ) → ϕ` provides the induction principle. When viewed from outside S, the resulting model is a standard step-indexed model — the relationship is made precise in Section 3.5 via Propositions 3.5 and 3.6. But when reasoning inside S, the step indices are invisible.

The practical consequence: the fundamental theorem for the language Fµ,ref (a call-by-value language with impredicative polymorphism, recursive types, and ML-like references) is proved with two explicit uses of ✄ in the type interpretation and a clean case analysis, versus the tedious index arithmetic that external step-indexed proofs require.

## Connections

- The internal-logic approach is the synthetic alternative to explicit step-indexing as used in [[rust-safety-with-unsafe-code-requires-semantic-rather-than-syntactic-proof-methods]], where RustBelt's logical relations are built on step-indexed semantics; Iris later moved this approach into guarded domain theory
- The eval predicate at the heart of the soundness proof uses guarded recursion: since [[the-later-modality-on-types-enables-guarded-recursive-domain-equations-in-the-topos-of-trees]], the predicate is well-defined without circularity
- The synthetic approach requires that all functions in the model are "suitably non-expansive" automatically — this is enforced by the topos structure rather than explicit proof obligations
