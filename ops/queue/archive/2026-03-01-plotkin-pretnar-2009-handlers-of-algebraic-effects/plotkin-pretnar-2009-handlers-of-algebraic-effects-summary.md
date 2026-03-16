---
batch: plotkin-pretnar-2009-handlers-of-algebraic-effects
date: 2026-03-01
status: complete
---

# Batch Summary: plotkin-pretnar-2009-handlers-of-algebraic-effects

## Source

- **File**: `plotkin-pretnar-2009-handlers-of-algebraic-effects.pdf`
- **Archive location**: `inbox/archive/plotkin-pretnar-2009-handlers-of-algebraic-effects/`
- **Authors**: Gordon Plotkin and Matija Pretnar (University of Edinburgh)
- **Venue**: ESOP 2009

## Extraction Results

- **Claims created**: 7
- **Source reference note**: 1
- **Enrichments applied**: 2 (existing claims updated with new cross-links)
- **Connections added**: 22
- **Topic maps updated**: 2 (algebraic-effects, language-design)

## Claims Created

1. [[handling-a-computation-is-composing-it-with-the-unique-free-model-homomorphism]] -- the foundational semantic insight of the paper
2. [[continuations-are-the-only-standard-computational-effect-that-cannot-be-represented-algebraically]] -- the boundary of the algebraic framework
3. [[algebraic-operations-and-effect-handlers-are-categorically-dual-as-constructors-and-deconstructors]] -- intro/elim duality in categorical terms
4. [[separating-handler-description-from-computation-prevents-correctness-wellformedness-circularity]] -- the two-language design decision
5. [[parallel-composition-cannot-be-expressed-as-an-effect-handler-because-it-requires-folding-two-structures-simultaneously]] -- the known expressiveness limit
6. [[parameter-passing-handlers-simulate-stateful-handling-by-threading-state-through-operation-continuations]] -- the `@` parameter-passing pattern
7. [[rollback-is-encodable-as-an-effect-handler-that-threads-a-revert-function-through-state-operations]] -- transactional rollback as a concrete handler pattern

## Source Reference

- [[plotkin-pretnar-2009-handlers-of-algebraic-effects]]

## Existing Claims Enriched

- [[deep-handlers-differ-from-shallow-handlers-because-continuation-is-resumed-under-the-same-handler]] -- added reference to foundational homomorphism claim
- [[row-typed-effects-compose-freely-because-they-are-restricted-to-the-free-monad]] -- added cross-link to free-model homomorphism and continuations boundary

## Context Notes

The existing algebraic effects cluster was sourced entirely from Leijen's Koka work (2017/2016 TR). This batch adds the *foundational* paper -- Plotkin & Pretnar 2009, which Leijen's work builds on. The new claims provide the categorical foundations (free models, homomorphisms, constructor/destructor duality) that explain *why* the Koka compilation strategies work the way they do. The graph now has both the theoretical foundation (Plotkin & Pretnar) and the practical implementation (Leijen/Koka).

Key gap identified in graph: the algebraic effects topic map previously lacked a source reference to the paper that introduced handlers. Now fixed.

Key limit documented: parallel composition as the expressiveness boundary of the algebraic approach -- this is directly relevant to murail's audio graph concurrency design.
