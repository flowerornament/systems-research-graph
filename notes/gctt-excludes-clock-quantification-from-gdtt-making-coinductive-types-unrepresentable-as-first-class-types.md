---
description: GCTT deliberately omits clock quantification (the ∀κ binder of GDTT), which is what enables converting guarded types to first-class coinductive types; this is identified as the primary future work
type: open-question
evidence: strong
source: [[birkedal-2016-guarded-cubical-type-theory]]
created: 2026-03-01
status: active
---

# GCTT excludes clock quantification from GDTT making coinductive types unrepresentable as first-class types

Guarded dependent type theory (GDTT) has a **clock quantification** operator `∀κ.A` that allows controlled elimination of the later modality. Intuitively, if you have a term of type `∀κ. ▷_κ A` — a value that is "later" with respect to every clock — then you can extract an actual `A`. This is what enables representing first-class **coinductive types**: a guarded stream `▷Str = µX. A × ▷X` becomes a genuine coinductive `Stream A` via clock quantification.

GCTT **explicitly omits clock quantification** (the paper states this in the abstract and in footnote 2). The reason is that integrating clock quantification with the cubical type theory infrastructure raises unsolved problems:

1. **Decidable type-checking with clocks**: GDTT relies on clock-specific rules that seem difficult to implement decidably alongside the composition-based typing of CTT.
2. **Coherence problem for clock substitution**: when substituting a clock variable, the composition structures on types must cohere with the substitution; this is a known unsolved technical obstacle.

Without clock quantification, guarded recursive types in GCTT are **not** first-class coinductive types. A stream `StrA = fix x. A × ▷[y ← x].y` is a guarded type — you can reason about it by Löb induction and prove properties of specific stream functions — but you cannot freely eliminate the later modality to extract a "fully coinductive" stream.

**Proposed path forward**: The paper suggests that the product structure `C × D` (which already works for any `D` with an initial object) should compose with the presheaf model of GDTT with multiple clocks (Bizjak and Møgelberg, MFPS 2015), potentially yielding a full GCTT with clock quantification.

## Connections

- [[equality-reflection-in-gdtt-makes-type-checking-undecidable-while-path-equality-in-gctt-preserves-the-potential-for-decidability]] — this omission is the residual cost of the CTT-based approach; you gain decidable type-checking but lose full coinductive types for now
- [[the-loeb-rule-makes-coinductive-reasoning-derivable-in-guarded-domain-theory]] — without clocks, Löb induction is the primary tool for reasoning about recursive types; it compensates for the absence of coinduction rules but does not provide first-class coinductive types
- [[gctt-semantics-requires-presheaves-over-the-product-of-the-cube-category-and-the-natural-numbers-poset]] — the layered semantics (C × ω → C × D → C × multi-clock-model) is the conjectured route to adding clock quantification without losing the presheaf semantics structure
