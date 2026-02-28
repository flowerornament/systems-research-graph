---
description: Naur's pedagogical corollary that computer science education, by focusing on text production and algorithm correctness, trains the wrong skill — theory-building capacity is the primary competence
type: claim
evidence: moderate
source: [[naur-1985-programming-as-theory-building]]
created: 2026-02-28
status: active
---

# programming education should develop theory building capacity not text writing technique

Naur draws a pedagogical implication from the theory-building thesis: if the primary product of programming is a theory held by programmers, then education that focuses on text-writing technique and algorithmic correctness is optimizing the wrong thing.

**What standard programming education teaches:**
- How to write syntactically correct programs
- How to reason about program correctness against specifications
- Algorithmic problem-solving (input → output transformations)
- Data structure selection and analysis

**What theory-building education would teach:**
- How to build a mental model of a complex system
- How to respond to novel questions about a system you built
- How to recognize when a proposed change is coherent or incoherent with the design
- How to hold and maintain understanding over time as requirements change
- How to transfer theory to collaborators (not just documentation, but active engagement)

The distinction is not subtle. A student who can write a correct implementation of a specification, pass all the tests, and explain the algorithm still may not be developing the capacity to build a theory. The theory emerges from extended engagement with a system's relationship to real-world problems -- not from solving isolated exercises.

**Connection to software apprenticeship:** The theory-building view recovers the classical apprenticeship argument for software -- that working alongside experienced practitioners in real systems develops capacities that coursework cannot. The apprentice builds theory by participating in theory-building with the master; the classroom can only teach the text-writing shell.

This is an open question for murail: the engine is technically complex enough that newcomers cannot build the theory from documentation alone. What onboarding structure would accelerate theory-building rather than just knowledge transfer?

Connects to [[audio-programming-education-requires-reading-production-engine-source-code-across-multiple-systems]]: McCartney's prescription (read multiple real engines) is not just about acquiring information -- it is about building theory by engaging with real design decisions across different approaches.

---

Source: [[naur-1985-programming-as-theory-building]]

Relevant Notes:
- [[programming-is-theory-building-not-text-production]] -- the foundational claim this follows from
- [[audio-programming-education-requires-reading-production-engine-source-code-across-multiple-systems]] -- McCartney's domain-specific version: building theory by reading real design decisions
- [[juce-abstracts-away-audio-engine-fundamentals-producing-developers-who-cannot-reason-about-threading-and-resource-management]] -- the consequence of teaching only the text layer; developers who pass tests but cannot build theory of the underlying system
- [[debuggability-is-more-valuable-than-correctness-by-construction]] -- interactive engagement with running systems is how theory-building actually happens

Topics:
- [[developer-experience]]
- [[language-design]]
