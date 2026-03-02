---
description: Guy Steele's OOPSLA 1998 keynote arguing that language design must shift from designing complete languages to designing patterns for user-driven growth
type: source
created: 2026-03-01
---

# steele-1998-growing-a-language

Guy L. Steele Jr., "Growing a Language," OOPSLA 1998 keynote. Published in Higher-Order and Symbolic Computation 12(3), 1999.

The talk is itself a demonstration of its thesis: Steele delivers it using only one-syllable words as primitives, defining all multi-syllable words before use. This enacts the experience of programming in a small language and the necessity of building up vocabulary.

## Key Claims Extracted

- [[a-language-must-be-designed-to-grow-not-to-be-complete]] -- the central thesis: no language can be designed complete up front; design must be a pattern for growth
- [[user-defined-extensions-must-be-syntactically-indistinguishable-from-built-in-primitives]] -- the "no seams" criterion: if user-defined operations look different from built-ins, users cannot grow the language
- [[apl-failed-to-grow-because-user-defined-and-built-in-operations-have-different-surface-syntax]] -- concrete case study: APL glyphs vs. user identifiers create an unbridgeable seam
- [[lisp-succeeded-at-user-driven-growth-because-user-definitions-are-syntactically-primitive]] -- the positive case: in Lisp, all primitives look like user-defined words and vice versa
- [[the-minimum-extensibility-mechanism-for-user-driven-language-growth-is-generic-types-and-operator-overloading]] -- Steele's specific proposal for Java: these two features unlock all other user-defined numeric and collection types
- [[language-design-is-now-designing-a-pattern-for-language-designs-not-a-language]] -- the meta-level claim: go meta; a language design must be a pattern that generates language designs
- [[a-good-programmer-builds-a-working-vocabulary-not-just-programs]] -- programming at scale requires language design on top of a base language; large programs are new languages
- [[worse-is-better-because-small-languages-with-warts-reach-users-before-well-designed-large-languages]] -- Gabriel's thesis endorsed: in a race, the deployable small language beats the right-but-late large language
- [[bazaar-development-succeeds-because-the-plan-can-change-in-real-time-to-meet-user-needs]] -- the key distinction from cathedral: adaptability and user buy-in, not just distributed labor

## Source References
- [[language-design]] for the topic map
- [[notation-and-thought]] for the Iverson connection (economy of notation)

---

Topics:
- [[language-design]]
