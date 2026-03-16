---
description: Wadler's table metaphor: cases are rows, operations are columns; each paradigm makes extending one dimension easy and the other hard
type: claim
evidence: strong
source: [[wadler-1998-expression-problem]]
created: 2026-03-01
status: active
---

# functional languages fix rows oo languages fix columns in the expression problem table

Wadler's geometric framing: "One can think of cases as rows and functions as columns in a table. In a functional language, the rows are fixed (cases in a datatype declaration) but it is easy to add new columns (functions). In an object-oriented language, the columns are fixed (methods in a class declaration) but it is easy to add new rows (subclasses). We want to make it easy to add either rows or columns."

This is the clearest articulation of why the Expression Problem is a *paradigm-level* tension, not a library design question. Algebraic data types (Haskell, ML) give you all operations for free once you pattern-match, but adding a new case requires touching every pattern-match site. OO class hierarchies give you all cases for free via subclassing, but adding a new operation requires touching every class.

For murail's [[language-design]]: the audio graph engine has *both* dimensions under pressure. The cases dimension grows as new UGen types are added to the library. The operations dimension grows as new compiler backends, new analysis passes, new serialization formats, and new inspection tools are added. Neither a purely functional nor a purely OO design handles both without friction.

[[multimethods-allow-code-generation-backends-to-be-organized-by-concern]] addresses the operations dimension via multi-dispatch. [[generic-operations-allow-extending-existing-code-over-new-types-without-modification]] addresses the cases dimension via runtime generic dispatch. The table framing here is [[the-expression-problem-names-the-tension-between-adding-new-cases-and-new-operations-without-recompiling]]'s geometric companion.
