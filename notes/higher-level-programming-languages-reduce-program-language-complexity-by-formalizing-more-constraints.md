---
description: As programming language expressiveness increases, the informal program language shrinks because more program semantics can be captured in formal types and constraints rather than implicit conventions
type: claim
evidence: moderate
source: [[baniassad-myers-2009-program-as-language]]
created: 2026-03-01
status: active
---

# higher-level programming languages reduce program language complexity by formalizing more constraints

Baniassad & Myers articulate an inverse relationship: the more that a programming language can formally express, the less work the informal program language must do. This is not about the programming language being "better" in an abstract sense -- it is about the division of labor between formal and informal communication.

**The mechanism**: Programming language abstractions that closely match program semantics abstractions require little supplementary program language. A message buffer implemented as a queue datatype has its most important properties (ordering, entry/exit discipline, message identity) handled by the type system. The program language needs to add little. A user session concept spread across multiple classes and involving non-local invariants has a poor code-semantics fit; the program language must supply all the rules about how the parts relate, what order operations must occur, and what invariants must be maintained.

**Haskell as illustration**: In Haskell, more program abstractions map directly to code abstractions. The type system can express many constraints that in C must live in comments, naming conventions, and idioms. This makes Haskell's program language more "synthetic" (individual words are more complex because they combine many concepts) and less "analytic" (fewer separate expression sequences needed to communicate a single program idea).

**Greenspun's corollary applied**: Complex programs written in low-level languages require correspondingly complex program languages for humans to understand them. This is why low-level languages tend toward elaborate coding standards, naming conventions, and documentation requirements -- all attempts to supplement the program language that the programming language cannot provide.

**The design implication**: This is an argument for expressiveness in domain-specific language design. Every feature a DSL can formally encode is a rule that no longer needs to live in the informal program language. Types that encode signal rates, capability systems that encode RT safety, structured graph descriptions that encode topology constraints -- each formalizes something that would otherwise live in programmer knowledge and convention.

For murail: the composition language (Stage 9) should be evaluated partly by how little informal program language it leaves to programmers. If common audio graph patterns require elaborate idiomatic sequences to express safely, that is evidence the language is not formalizing enough. Connects to [[kolmogorov-complexity-provides-a-measurable-criterion-for-composition-language-design-quality]] and [[effects-as-capabilities-can-encode-rt-safety-requirements-in-the-composition-language-type-system]].

Relates to [[evolvability-requires-trading-provability-for-extensibility]]: there is a tension. More expressive type systems can formalize more constraints but may sacrifice extensibility (Sussman's argument). The tradeoff is between reducing informal program language burden and maintaining the ability to evolve the program language itself.
