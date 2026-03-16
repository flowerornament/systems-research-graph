---
description: Cross-program idioms belong to "programmer language" (shared conventions); "program language" is unique to each program; DSLs create programmer language but their users still develop unique program languages
type: claim
evidence: moderate
source: [[baniassad-myers-2009-program-as-language]]
created: 2026-03-01
status: active
---

# programmer language differs from program language cross-program idioms are not program-specific

Baniassad & Myers carefully distinguish what is unique to a specific program from what is shared across programs. Conflating these would inflate the program language concept to include all of software engineering practice:

**Programmer language**: Idioms, patterns, and conventions shared across multiple programs and communities. Lock-do_stuff-unlock appears in every multi-threaded program. Singleton, Observer, Strategy are design patterns applicable to any object-oriented program. Hungarian notation is a naming convention portable across programs. These are "programmer language" -- they are pre-existing resources that programmers bring to every codebase, not inventions specific to each program.

**Program language**: Combinations of concepts within a particular program that are specific to that program. The specific invariant a particular module maintains, the specific order in which its operations must be called, the specific meaning of identifier names within the context of this codebase's domain model -- these are program language elements. They exist nowhere else.

**Why the distinction matters**: Design patterns provide a vocabulary for programmer language. Knowing "this uses Observer" tells you something universal about the structure. But knowing "in this program, the observer must be registered before the subject's constructor returns" is program language knowledge -- it exists only in this program's implicit grammar.

**DSLs occupy a middle ground**: Domain-specific languages are more formal than program languages (they have machine-processable syntax and semantics) but more specialized than general programming languages. DSLs provide programmer-language structures for a domain, but programs written in a DSL still develop their own program languages on top. There is no level of formalism at which the program language disappears entirely, only levels at which it becomes less burdensome.

**Implications for murail**: The composition language itself is programmer language -- a shared formalism for audio graph programs. But each musical piece or performance system built in murail will develop its own program language: the meaning of the patch's node names, the conventions for how certain subgraph patterns are combined, the idioms that have emerged in that specific creative context. Language design reduces the program language burden but cannot eliminate it.

Connects to [[each-program-defines-a-unique-program-specific-language-with-its-own-symbols-and-grammar]] by clarifying what makes program languages distinct from shared resources. Also connects to [[economy-of-notation-requires-compositional-grammar-not-a-large-primitive-vocabulary]]: both programmer language (design patterns) and program language (idioms) benefit from compositional grammar over large primitive vocabularies.
