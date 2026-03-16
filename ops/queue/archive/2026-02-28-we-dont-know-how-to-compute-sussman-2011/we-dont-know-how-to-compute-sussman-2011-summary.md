---
batch: we-dont-know-how-to-compute-sussman-2011
date: 2026-02-28
source: /Users/morgan/code/murail/.design/references/transcripts/we-dont-know-how-to-compute-sussman-2011.md
claims_created: 8
enrichments: 2
topic_maps_updated: 4
---

# Batch Summary: we-dont-know-how-to-compute-sussman-2011

**Source:** Gerald Sussman, "We Really Don't Know How to Compute!", Strange Loop 2011
**URL:** https://www.youtube.com/watch?v=HB5TrK7A4pI
**Duration:** 64 minutes
**Transcribed:** 2026-02-27
**Processed:** 2026-02-28

## Claims Created (8)

1. [[programmer-time-dominates-computation-cost-in-the-post-scarcity-era]]
2. [[evolvability-requires-trading-provability-for-extensibility]]
3. [[generic-operations-allow-extending-existing-code-over-new-types-without-modification]]
4. [[propagator-cells-hold-partial-information-that-accumulates-monotonically]]
5. [[monotonic-information-cells-eliminate-synchronization-problems-in-parallel-propagator-networks]]
6. [[wiring-diagram-notation-names-every-intermediate-value-enabling-inspection-and-reuse]]
7. [[truth-maintenance-systems-enable-locally-consistent-reasoning-in-an-inconsistent-knowledge-base]]
8. [[dependency-directed-backtracking-prunes-search-using-provenance-rather-than-recency]]

## Existing Claims Enriched (2)

1. [[propagator-networks-provide-provenance-for-computed-conclusions]] -- upgraded from secondhand (Rusher) to primary source; evidence upgraded from moderate to strong; circuit analyzer example added; links to new architectural claims
2. [[we-dont-know-how-to-compute-sussman-2011]] -- upgraded from preliminary stub to active source reference with full claim index

## Topic Maps Updated (4)

- [[formal-methods]] -- added evolvability claim and full propagator/TMS section (4 new entries)
- [[concurrent-systems]] -- added monotonic-cell claim under Concurrency Models
- [[language-design]] -- added 3 claims to Language Design Tradeoffs, 1 to Representation
- [[ai-ml]] -- added TMS claim to Explainability section
- [[index]] -- removed "(preliminary stub)" from source reference entry

## Connections Added

- `evolvability-requires-trading-provability-for-extensibility` extends `debuggability-is-more-valuable-than-correctness-by-construction` and is in tension with `type-systems-have-not-empirically-reduced-defect-rates`
- `propagator-cells-hold-partial-information-that-accumulates-monotonically` refines `propagator-networks-provide-provenance-for-computed-conclusions`
- `wiring-diagram-notation-names-every-intermediate-value-enabling-inspection-and-reuse` extends `visual-representation-exposes-structure-text-notation-obscures`
- `monotonic-information-cells-eliminate-synchronization-problems-in-parallel-propagator-networks` connects to lock-free NRT/RT patterns in `concurrent-systems`

## Selectivity Gate Notes

Excluded from extraction:
- Lagrangian mechanics / gear integrator examples: engineering application examples illustrating generic ops, already covered by the generic-ops claim
- Salamander limb regeneration / genome analogy: vivid rhetoric for the self-organizing systems argument; the core claim (evolvability) is already captured
- Five-floor puzzle details: implementation example of TMS/backtracking, adequately summarized in the dependency-directed backtracking claim
- Multi-paradigm systems argument: interesting but lower murail relevance; not a distinct claim Sussman develops with technical specificity

## Learnings

- Source was previously stub-noted from a secondhand reference (Rusher 2022). The primary transcript substantially expanded the claim set -- 8 new claims vs the 1 stub entry. Processing primary sources after secondhand references reliably adds depth.
- Transcript format (continuous speech, 63KB, ~35 lines) required character-offset reading rather than line-based reading. Long-line transcripts should be read in 15KB chunks via python3.
