---
description: Lisp's bidirectional syntax indistinguishability -- user-defined looks like built-in and vice versa -- let designers grow the language by curating users, not writing
type: claim
evidence: strong
source: [[steele-1998-growing-a-language]]
created: 2026-03-01
status: active
---

# Lisp succeeded at user-driven growth because user definitions are syntactically primitive

Steele on Lisp: "new words defined by the user look like primitives and, what is more, all primitives look like words defined by the user." This bidirectional indistinguishability is the key property. It was not planned by the designer (Steele says Lisp "works in a way that I think he did not plan for"), but it produced a remarkable outcome: the language designer could grow the language by curating user contributions with "close to no work on his part."

The specific mechanism: when any user can add a new word (function) that looks and works exactly like a primitive, many users try things out. The best of their code becomes visible to the whole community. The language maintainer's role shifts from *author* to *curator* -- choosing, testing, and integrating the best user contributions. This is far more scalable than a single person or team designing everything from scratch.

Lisp grew faster than APL despite both being designed by single smart individuals. The difference was structural, not personal: the Lisp architecture enabled distributed contribution; APL's did not.

Note: Lisp's later decline ("not used quite as much as it used to be") and the survival of some of its ideas in other languages (garbage collection being the named example) is consistent with Steele's "Worse is Better" argument -- the ideas from the well-designed language live on even if the language itself does not win the deployment race. See [[worse-is-better-because-small-languages-with-warts-reach-users-before-well-designed-large-languages]].

The curator model described here anticipates the bazaar/cathedral framing that follows in the talk. The bazaar is not anarchy; it requires "a person in charge who is a quick judge of good work and who will take it in and shove it back out fast." The Lisp designer who curates user contributions is exactly this role.

This is the positive case for [[user-defined-extensions-must-be-syntactically-indistinguishable-from-built-in-primitives]]: Lisp's lack of a seam between user and built-in syntax is precisely what enabled distributed innovation.

Enriches [[generic-operations-allow-extending-existing-code-over-new-types-without-modification]] (Sussman): the Lisp success story is the historical instantiation of Sussman's generic dispatch argument. Sussman describes the mechanism; Steele describes how the same mechanism enabled ecosystem-level growth.
