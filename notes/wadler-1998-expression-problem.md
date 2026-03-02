---
description: Wadler's 1998 email to the java-genericity list coining "The Expression Problem" and presenting a GJ solution using virtual types and the ThisType trick
type: source
created: 2026-03-01
---

# wadler-1998-expression-problem

Philip Wadler, email to java-genericity list, 12 November 1998. URL: https://homepages.inf.ed.ac.uk/wadler/papers/expression/expression.txt

Original source of the term "The Expression Problem." Wadler names an old problem, states it precisely, defines the constraint set (static type safety, independent compilation), shows the OO/functional duality in rows/columns terms, and presents a solution in GJ (Generic Java) using the virtual type indexing mechanism from his earlier note "Do parametric types beat virtual types?" The solution requires the ThisType trick to preserve static typing in the presence of subtypes, and uses fixpoint classes to tie the knot.

**Archive location:** `/Users/morgan/code/systems-research-graph/inbox/archive/wadler-1998-expression-problem/`

Claims extracted from this source:
- [[the-expression-problem-names-the-tension-between-adding-new-cases-and-new-operations-without-recompiling]]
- [[functional-languages-fix-rows-oo-languages-fix-columns-in-the-expression-problem-table]]
- [[the-expression-problem-requires-static-type-safety-and-independent-compilation-simultaneously]]
- [[virtual-type-indexing-solves-the-expression-problem-by-allowing-subclasses-to-refer-to-sibling-types-in-their-bound]]
- [[the-thistype-trick-provides-accurate-static-typing-in-the-presence-of-subtypes-by-bounding-the-type-parameter-on-itself]]
- [[fixpoint-classes-tie-the-knot-after-open-recursive-parameterized-families-to-produce-closed-usable-types]]
- [[the-visitor-pattern-solves-the-operations-dimension-of-the-expression-problem-but-not-the-cases-dimension]]

---

Topics:
- [[language-design]]
