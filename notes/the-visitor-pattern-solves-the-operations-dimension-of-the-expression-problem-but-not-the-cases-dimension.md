---
description: The Visitor pattern (Krishnamurthi et al. Extended Visitor) adds new operations over a fixed type hierarchy but cannot add new cases without breaking existing visitors
type: claim
evidence: strong
source: [[wadler-1998-expression-problem]]
created: 2026-03-01
status: active
---

# the visitor pattern solves the operations dimension of the expression problem but not the cases dimension

Wadler explicitly compares his GJ solution to the Extended Visitor pattern described by Krishnamurthi, Felleisen & Friedman (ECOOP 1998). The Extended Visitor addresses the operations dimension: new operations can be added as new visitors without modifying existing code. But it cannot extend the cases dimension statically:

"Their solution differs in that it is not statically typed; they cannot distinguish `Lang.Exp` from `Lang2.Exp`, and as a result must depend on dynamic casts at some key points. This isn't due to a lack of cleverness on their part, rather it is due to a lack of expressiveness in Pizza."

The Visitor pattern (standard OOP) defines the cases as fixed abstract methods in the visitor interface. Adding a new case (a new expression subclass) requires adding a new method to the visitor interface, breaking every existing visitor implementation. The operations dimension (adding new visitors) is easy; the cases dimension (adding new expression types) requires recompilation.

This is the classic asymmetry in [[functional-languages-fix-rows-oo-languages-fix-columns-in-the-expression-problem-table]]: Visitor is an OO solution that lets operations grow (new visitors) but fixes cases (methods in the interface). Extended Visitor relaxes this at the cost of static typing.

For murail's [[language-design]]: this analysis applies directly to the graph compiler's IR. If UGen nodes are modeled as a fixed visitor-visitable type hierarchy, adding new node types requires touching every visitor (every compiler pass). [[multimethods-allow-code-generation-backends-to-be-organized-by-concern]] offers the operations-dimension solution (new backends without touching node types) but does not automatically solve the cases dimension. Wadler's point is that both dimensions require explicit design; the visitor pattern's asymmetry is a trap for architectures that start with a fixed node set but expect growth.
