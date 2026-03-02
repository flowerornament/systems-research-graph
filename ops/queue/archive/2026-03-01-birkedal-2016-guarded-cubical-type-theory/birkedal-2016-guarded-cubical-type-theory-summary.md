---
batch: birkedal-2016-guarded-cubical-type-theory
processed: 2026-03-01
source: /Users/morgan/code/murail/.design/references/papers/archive/birkedal-2016-guarded-cubical-type-theory/birkedal-2016-guarded-cubical-type-theory.pdf
claims_created: 8
enrichments: 3
connections_added: 25
topic_maps_updated: 1
existing_claims_updated: 3
---

# Batch Summary: birkedal-2016-guarded-cubical-type-theory

**Source:** Birkedal, Bizjak, Clouston, Grathwohl, Spitters, Vezzosi. "Guarded Cubical Type Theory: Path Equality for Guarded Recursion." arXiv:1606.05223v2, 2016.

**Archive:** ops/queue/archive/2026-03-01-birkedal-2016-guarded-cubical-type-theory/

## Claims Created

1. [[equality-reflection-in-gdtt-makes-type-checking-undecidable-while-path-equality-in-gctt-preserves-the-potential-for-decidability]]
2. [[delayed-fixed-points-separate-path-equality-from-judgmental-equality-preventing-infinite-unfolding]]
3. [[gctt-semantics-requires-presheaves-over-the-product-of-the-cube-category-and-the-natural-numbers-poset]]
4. [[the-later-type-former-must-preserve-composition-structures-for-gctt-to-be-semantically-sound]]
5. [[path-extensionality-for-later-types-is-derivable-in-gctt-not-merely-axiomatized]]
6. [[gctt-excludes-clock-quantification-from-gdtt-making-coinductive-types-unrepresentable-as-first-class-types]]
7. [[guarded-recursive-types-with-negative-variance-are-well-founded-because-the-later-modality-breaks-the-polarity-cycle]]
8. [[path-types-in-gctt-enable-proving-properties-of-guarded-recursive-programs-not-just-defining-them]]

## Source Reference Created

- [[birkedal-2016-guarded-cubical-type-theory]]

## Enrichments (Existing Claims Updated)

- [[the-later-modality-on-types-enables-guarded-recursive-domain-equations-in-the-topos-of-trees]] — added GCTT extension noting the ω-factor is the topos of trees; C-factor adds path equality
- [[the-loeb-rule-makes-coinductive-reasoning-derivable-in-guarded-domain-theory]] — added note on Löb in GCTT context (Props 3 and 4)
- [[the-guardedness-condition-on-recursive-definitions-is-the-proof-theoretic-analog-of-the-causality-condition-on-dependency-graphs]] — added GCTT as extension enabling formal program equivalence proofs

## Topic Maps Updated

- [[formal-methods]] — added new section "Guarded Cubical Type Theory (Birkedal et al. 2016)" with all 8 claims; added 2 new open questions about Murail + GCTT connections

## Key Themes

- GCTT solves GDTT's undecidability problem by using CTT path types instead of equality reflection
- The `dfix` combinator is the central mechanism: path-equal but not judgmentally equal to unfoldings
- Semantics in C × ω: cube category for paths + natural numbers poset for later modality
- The later-preserves-composition obligation (Lemma 9) is the core technical challenge
- Negative variance recursive types are well-founded; guarded Y combinator is provably correct
- Strong Murail connection: GCTT could enable formal proofs of audio program equivalence
