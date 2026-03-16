---
description: Source reference for Baniassad & Myers 2009 OOPSLA paper arguing that programs define a unique, self-contained program-specific language on top of any underlying programming language
type: source-reference
created: 2026-03-01
---

# baniassad-myers-2009-program-as-language

Elisa Baniassad and Clayton Myers, "An Exploration of Program as Language," *OOPSLA '09: Proceedings of the 24th ACM SIGPLAN conference on Object Oriented Programming Systems Languages and Applications*, October 2009. DOI: 10.1145/1640089.1640132

**Source location:** `/Users/morgan/code/murail/.design/references/papers/archive/baniassad-myers-2009-program-as-language/baniassad-myers-2009-program-as-language.pdf`

## Central argument

Every program defines a program-specific language. The symbols of this "program language" are the abstractions created by programmers; its grammar is the set of (generally unwritten) rules about allowable combinations of those abstractions. The program is simultaneously the language's definition and its only use. This makes reading an unfamiliar program equivalent to learning a new natural language, and porting code between programs equivalent to translation between distinct languages.

The program language bridges what the paper calls the gap between program semantics (what the program means to humans, in terms of the problem domain) and code semantics (what the machine executes). The complexity of the program language is inversely proportional to the expressive power of the underlying programming language: higher-level languages formalize more constraints, leaving less for the informal program language to handle.

## Claims extracted

- [[each-program-defines-a-unique-program-specific-language-with-its-own-symbols-and-grammar]] -- the central thesis
- [[program-languages-bridge-the-gap-between-program-semantics-and-code-semantics]] -- what program languages communicate
- [[reading-an-unfamiliar-codebase-is-language-learning-not-mere-symbol-lookup]] -- consequence for program comprehension
- [[code-migration-between-programs-is-translation-between-distinct-natural-languages]] -- consequence for code reuse
- [[higher-level-programming-languages-reduce-program-language-complexity-by-formalizing-more-constraints]] -- the programming-language/program-language tradeoff
- [[program-languages-communicate-naurs-theories-through-identifier-choice-idioms-and-abstraction-organization]] -- connection to Naur 1985
- [[programs-are-works-of-art-not-craft-because-they-define-their-own-interpretive-language]] -- art/craft distinction
- [[programmer-language-differs-from-program-language-cross-program-idioms-are-not-program-specific]] -- key distinction

## Relation to Naur 1985

This paper explicitly builds on [[naur-1985-programming-as-theory-building]]. Naur argues that theories cannot be communicated by rules or documents. Baniassad & Myers refine this: program languages are precisely the medium through which theories ARE communicated -- imperfectly, implicitly, through abstraction naming, idiom choice, and code organization. The claim is that program languages *are* the theory's surface, not a substitute for it.

## Cross-domain relevance

- **murail composition language design**: If murail's composition language formalizes more of the audio graph's semantics (types, constraints, channel agnosticism), less of the design intent lives in unwritten program language rules. Every type constraint or named abstraction that the compiler understands is a piece of the program language that can no longer degrade across programmers or sessions.
- **Language legibility**: The gap between program semantics and code semantics is exactly what [[kolmogorov-complexity-provides-a-measurable-criterion-for-composition-language-design-quality]] tries to measure. A program language that needs elaborate idioms to express common patterns is a symptom of a programming language that formalizes too little.
