---
batch: birkedal-2012-guarded-domain-theory
completed: 2026-02-28
claims_created: 10
enrichments: 2
connections_added: 28
topic_maps_updated: 1
existing_claims_updated: 2
---

# Batch Summary: birkedal-2012-guarded-domain-theory

**Source:** Birkedal, Møgelberg, Schwinghammer, Støvring (2012). "First Steps in Synthetic Guarded Domain Theory: Step-Indexing in the Topos of Trees." *Logical Methods in Computer Science* 8(4:1), pp. 1–45.

**Archive:** `/Users/morgan/code/murail/.design/references/papers/archive/birkedal-2012-guarded-domain-theory/birkedal-2012-guarded-domain-theory.pdf`

## Claims Created (10)

1. [[the-topos-of-trees-internalizes-step-indexing-eliminating-explicit-index-arithmetic-from-proofs]]
2. [[the-later-modality-on-types-enables-guarded-recursive-domain-equations-in-the-topos-of-trees]]
3. [[the-loeb-rule-makes-coinductive-reasoning-derivable-in-guarded-domain-theory]]
4. [[locally-contractive-functors-guarantee-unique-fixed-points-for-mixed-variance-recursive-types]]
5. [[the-internal-banach-fixed-point-theorem-proves-unique-solutions-for-contractive-guarded-recursive-predicates]]
6. [[guarded-domain-theory-subsumes-complete-bounded-ultrametric-spaces-as-a-reflective-subcategory]]
7. [[dependent-types-require-a-slice-category-generalization-of-the-later-modality]]
8. [[guarded-domain-theory-generalizes-to-sheaves-over-any-well-founded-complete-heyting-algebra]]
9. [[a-model-of-higher-order-store-and-recursive-types-can-be-constructed-entirely-inside-the-internal-logic-of-the-topos-of-trees]]
10. [[the-guardedness-condition-on-recursive-definitions-is-the-proof-theoretic-analog-of-the-causality-condition-on-dependency-graphs]]

Source reference created: [[birkedal-2012-guarded-domain-theory]]

## Existing Claims Enriched (2)

- [[guarded-self-reference-is-the-sole-mechanism-for-temporal-evolution-in-the-murail-calculus]] — connection added to the-guardedness-condition claim
- [[rust-safety-with-unsafe-code-requires-semantic-rather-than-syntactic-proof-methods]] — connection added to Iris/guarded domain theory lineage

## Topic Maps Updated (1)

- [[formal-methods]] — new section "Guarded Domain Theory (Birkedal et al. 2012)" with all 10 claims; new open question about causality checker as guardedness checker

## Notable Connections

- **Murail causality ↔ Löb rule**: The structural isomorphism between `self@d` delay guards and the ◮ modality is documented as a first-class claim. The formal-methods open question proposes this as a research direction: can the causality checker be typed in guarded domain theory?

- **RustBelt lineage**: Birkedal 2012 is a direct precursor to Iris, which underlies RustBelt. The enrichment on [[rust-safety-with-unsafe-code-requires-semantic-rather-than-syntactic-proof-methods]] completes this chain.

- **Step-indexing improvements**: The synthetic approach eliminates explicit step-index arithmetic; this is directly relevant to any future formal verification work on murail's type system.

## Processing Notes

- The PDF contained dense category theory (45 pages). Claims were extracted selectively targeting: (1) core theorems with formal standing, (2) connections to murail's formal model, (3) connections to RustBelt/Iris lineage already in the graph.
- Two false wiki-links (LaTeX notation `[[Γ ⊢ ◮A]]` and `[[τ]]`) were fixed to backtick notation during the verify phase.
