---
batch: wadler-1998-expression-problem
date: 2026-03-01
source: inbox/archive/wadler-1998-expression-problem/wadler-1998-expression-problem.md
original_source: https://homepages.inf.ed.ac.uk/wadler/papers/expression/expression.txt
---

# Batch Summary: wadler-1998-expression-problem

## Source

Philip Wadler, "The Expression Problem," email to java-genericity list, 12 November 1998. The original coinage of the term and the first presentation of a general-purpose solution using GJ (Generic Java) with virtual type indexing and F-bounded polymorphism.

## Extraction Results

- Claims extracted: 7
- Enrichments: 3 existing claims updated
- Topic maps updated: 2 (language-design.md, index.md)
- Connections added: 12+

## Claims Created

1. [[the-expression-problem-names-the-tension-between-adding-new-cases-and-new-operations-without-recompiling]]
2. [[functional-languages-fix-rows-oo-languages-fix-columns-in-the-expression-problem-table]]
3. [[the-expression-problem-requires-static-type-safety-and-independent-compilation-simultaneously]]
4. [[virtual-type-indexing-solves-the-expression-problem-by-allowing-subclasses-to-refer-to-sibling-types-in-their-bound]]
5. [[the-thistype-trick-provides-accurate-static-typing-in-the-presence-of-subtypes-by-bounding-the-type-parameter-on-itself]]
6. [[fixpoint-classes-tie-the-knot-after-open-recursive-parameterized-families-to-produce-closed-usable-types]]
7. [[the-visitor-pattern-solves-the-operations-dimension-of-the-expression-problem-but-not-the-cases-dimension]]

## Existing Claims Enriched

- [[multimethods-allow-code-generation-backends-to-be-organized-by-concern]] -- added backward links to Wadler's formulation; clarified that multimethod dispatch solves the operations dimension but the cases dimension remains O(backends × cases)
- [[evolvability-requires-trading-provability-for-extensibility]] -- added Wadler's counterpoint: with expressive enough type systems the tradeoff is avoidable; the tradeoff is type-system-dependent, not universal
- [[generic-operations-allow-extending-existing-code-over-new-types-without-modification]] -- clarified that Lisp generic dispatch solves the cases dimension at the cost of static typing; Wadler's solution avoids this tradeoff via virtual type indexing

## Source Reference

Created [[wadler-1998-expression-problem]] as source reference file in notes/.

## Verify

- Schema: PASS (all 7 claims have description, type, evidence, source, created)
- Dangling links: PASS (all wiki-links resolve to existing files)
- Topic map membership: PASS (all claims reachable via language-design.md)
