---
description: Wadler 1998 coined the term for the challenge of extending a datatype with new cases and new operations simultaneously, without recompilation and with static type safety
type: claim
evidence: strong
source: [[wadler-1998-expression-problem]]
created: 2026-03-01
status: active
---

# the expression problem names the tension between adding new cases and new operations without recompiling

Wadler's 1998 formulation: "The goal is to define a datatype by cases, where one can add new cases to the datatype and new functions over the datatype, without recompiling existing code, and while retaining static type safety (e.g., no casts)."

The problem is *a new name for an old problem*. Reynolds (1975), Cook (1990), and Krishnamurthi, Felleisen & Friedman (1998) all discuss the same tension. What Wadler contributes in 1998 is the name, the clean formulation of the constraint set, and the first known solution satisfying all constraints via general-purpose language mechanisms rather than special extensions.

The concrete motivating example: start with one expression type (constants) and one operation (evaluation). Add a second expression type (plus) and a second operation (show). The challenge is to add either without recompiling the other.

This framing directly enters murail's [[language-design]] context: the composition language must be extensible over both new node types (new UGen cases) and new operations over those nodes (new compilation backends, new inspectors, new optimizers) without requiring full recompilation of the graph engine. As noted in [[multimethods-allow-code-generation-backends-to-be-organized-by-concern]], multimethod dispatch solves the operations dimension cleanly; as noted in [[generic-operations-allow-extending-existing-code-over-new-types-without-modification]], Lisp-style generic dispatch solves the cases dimension at the cost of static typing.

[[algebraic-effects-unify-exceptions-state-iterators-and-async-under-a-single-abstraction]] offers a different angle: effect operations are abstract cases (adding a new effect adds a new case to the effect alphabet) while handlers provide operations over those cases (adding a new handler adds a new operation). The free-model homomorphism structure ([[handling-a-computation-is-composing-it-with-the-unique-free-model-homomorphism]]) means that new cases and new operations can be added independently as long as each handler is a model of the algebraic theory -- precisely the expression problem's constraint, solved by the categorical structure of the free model rather than by type system mechanisms.
