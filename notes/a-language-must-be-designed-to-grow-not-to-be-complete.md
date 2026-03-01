---
description: Steele's central OOPSLA 1998 thesis: the right answer to "small or large language?" is neither -- design a language that can grow, because neither extreme is viable
type: claim
evidence: strong
source: [[steele-1998-growing-a-language]]
created: 2026-03-01
status: active
---

# a language must be designed to grow, not to be complete

Steele's central claim at OOPSLA 1998: the question "should I design a small language or a large one?" is the wrong question. A small language cannot meet modern user needs (painting bits on screen, networking, multithreading, loading code on the fly, internationalization). A large language designed all at once is too costly to build and too hard to port -- it arrives late and a small language with warts has already filled the niche.

The historical record supports this: Fortran grew and grew (the new Fortran looks strange to old hands but fits well). Pascal did not grow and was limited by this. C grew out of B and into C++; its spread was possible precisely because it started small. PL/I was designed to be everything from the start -- no one knew all of PL/I -- and it failed to take hold.

The escape from this dilemma is the recognition that growth itself can be designed. The language does not need to contain all needed vocabulary; it needs to provide the mechanisms by which users can extend it in a clean, seamless way. The designer's job is to plan for growth -- but to leave choices for users to make at a later time.

This directly extends [[evolvability-requires-trading-provability-for-extensibility]]: where Sussman argues from software systems that evolvability requires accepting dynamic extensibility, Steele argues from language design that evolvability requires designing the growth mechanism into the language itself. The two claims are complementary at different levels of abstraction (runtime dispatch vs. language-level user extensibility).

Connects to [[new-language-success-requires-designing-for-expansion-to-adjacent-domains]] (Lattner): both claims argue that a language's success depends on its ability to reach unanticipated domains. Steele grounds this in the mechanism (design for growth); Lattner grounds it in the outcome (expansion to adjacent domains is the success criterion).

Contrasts with [[language-quality-validation-requires-production-use-not-internal-development]]: Steele argues growth must be *planned*; mere production use without a growth mechanism produces the APL outcome (frozen language with only a handful of developers able to evolve it).

For murail: the composition language (Stage 9) must be designed so that users can extend it -- defining new operators, new UGen abstractions, new scheduling patterns -- without those extensions looking second-class. The growth mechanism is not a polish feature; it is the core design requirement from day one.
