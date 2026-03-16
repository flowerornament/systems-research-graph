---
description: Source reference for Peter Naur's 1985 paper arguing that programming is fundamentally theory-building activity, not text production
type: source-reference
created: 2026-02-28
---

# naur-1985-programming-as-theory-building

Peter Naur, "Programming as Theory Building," *Microprocessing and Microprogramming*, 15(5):253-261, 1985. (Reprinted in *Concise Survey of Computer Methods*, 1974/1985.)

**Source location:** `/Users/morgan/code/murail/.design/references/papers/naur-1985-programming-as-theory-building.pdf` (image-based PDF, 14 pages, 908KB)

## Central argument

Programs are not text artifacts; they are expressions of programmer-held theories. The theory includes the programmer's understanding of the problem domain, the reasons for design choices, rejected alternatives, and anticipations of how the program might evolve. Source text cannot carry this theory. When the programmers leave, the theory decays even if the text survives.

## Claims extracted

- [[programming-is-theory-building-not-text-production]] -- the central thesis
- [[a-programs-source-text-cannot-fully-specify-its-meaning]] -- documentation cannot substitute for theory
- [[program-revival-by-newcomers-systematically-produces-degraded-designs]] -- the practical consequence
- [[the-programmers-theory-includes-why-alternatives-were-rejected-not-just-what-was-chosen]] -- anatomy of the theory
- [[no-documentation-can-substitute-for-the-programmer-held-theory]] -- categorical limitation of documentation
- [[software-quality-degrades-in-proportion-to-distance-from-original-theorists]] -- degradation over organizational time
- [[programming-education-should-develop-theory-building-capacity-not-text-writing-technique]] -- educational implication

## Cross-domain relevance

- **murail**: The theory-building frame grounds the rationale for ops/ and the knowledge graph. Every session handoff is a response to the revival problem. See [[developer-experience]] topic map, section "Theory building and knowledge transfer."
- **herald**: Stateless agents face Naur's revival problem in compressed form -- each agent invocation starts without the theory. The session-rhythm and persist protocols are the system's answer.

## Context in the knowledge graph

Naur 1985 is foundational for the developer experience thread. It is cited by or connects to claims about vibe coding, interactive programming, documentation practices, and audio education. It provides the theoretical grounding for why the knowledge graph's rationale-first design matters.

## Extension: Baniassad & Myers 2009

[[baniassad-myers-2009-program-as-language]] explicitly extends Naur by providing a linguistic framework. They argue that program languages are the medium through which theories are (partially) communicated: [[program-languages-communicate-naurs-theories-through-identifier-choice-idioms-and-abstraction-organization]]. Where Naur shows theories cannot be fully communicated, Baniassad & Myers characterize what *is* communicated and how.
