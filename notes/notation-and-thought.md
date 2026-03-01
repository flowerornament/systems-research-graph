---
description: How notation shapes mathematical and computational reasoning, from Iverson's 1980 Turing Award lecture
type: moc
created: 2026-02-28
---

# notation-and-thought

How notation shapes mathematical and computational reasoning. Draws primarily from Iverson's 1980 Turing Award lecture on APL, with implications for audio language design, interactive programming, and the cognitive ergonomics of DSLs.

## Claims

### Composition Language Design Criteria
- [[kolmogorov-complexity-provides-a-measurable-criterion-for-composition-language-design-quality]] -- Kolmogorov complexity of a musical idea in Murail should be <= its complexity in SuperCollider or Tidal Cycles; a measurable, not just subjective, criterion for when the composition language has failed at a pattern; applies with a legibility constraint (idiomatic readable code, not golf)

### Notation as a Tool of Thought (Iverson 1980)
- [[notation-shapes-thought-not-merely-expresses-it]] -- foundational claim from Boole/Whitehead/Babbage: language is an instrument of reason; available notation determines which problems are tractable
- [[executable-notation-combines-universality-with-mathematical-suggestivity]] -- neither math notation nor programming languages have both properties; APL demonstrates they can be combined; grounds the interactive programming ideal
- [[suggestive-notation-enables-discovery-through-structural-analogy]] -- notation that makes structural analogies visible enables discovery; the source of APL-style array programming's cognitive productivity
- [[subordination-of-detail-via-arrays-names-and-operators-extends-reasoning-range]] -- three mechanisms (arrays, names, operators) each hide irrelevant detail, extending tractable problem range; basis for universal auto-mapping
- [[economy-of-notation-requires-compositional-grammar-not-a-large-primitive-vocabulary]] -- economy from grammar rules generating many expressions from few primitives, not from providing a primitive for every concept
- [[uniform-right-to-left-evaluation-eliminates-precedence-hierarchy-without-loss-of-expressiveness]] -- single argument rule for all functions eliminates operator precedence complexity; supports both left-to-right analysis and right-to-left execution
- [[executable-notation-enables-proof-by-exhaustion-through-systematic-case-enumeration]] -- when notation is executable and supports arrays, exhaustive proof of properties over finite domains becomes a computation
- [[notation-introduced-in-context-is-a-quality-criterion-not-a-pedagogical-shortcut]] -- notation requiring a prerequisite course is a design deficiency; good notation is learnable in context
- [[clear-algorithms-are-the-necessary-foundation-for-efficient-ones]] -- clarity precedes efficiency; a clear algorithm is an executable specification from which efficient variants can be derived and tested
- [[premature-efficiency-emphasis-creates-circular-language-hardware-codesign]] -- languages designed for current hardware and hardware designed for current languages create a lock-in ratchet preventing notation evolution

---

Topics:
- [[index]]
- [[language-design]]
