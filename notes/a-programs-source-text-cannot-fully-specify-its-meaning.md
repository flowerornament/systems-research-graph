---
description: Source code, comments, and formal specifications together cannot capture the theory behind a program; meaning exists in the programmer's mind, not on the page
type: claim
evidence: strong
source: [[naur-1985-programming-as-theory-building]]
created: 2026-02-28
status: active
---

# a program's source text cannot fully specify its meaning

Naur's corollary to the theory-building thesis: no document -- however detailed -- can substitute for the programmer's held theory. This is not an argument for better documentation. It is a claim that the category of "documentation" cannot, in principle, contain what the theory contains.

The gap has three components:

**1. The rationale gap.** Source text shows what was chosen. The theory holds why alternatives were rejected. Comments can record this *after the fact*, but only partially: the programmer who wrote "we tried X and it was slow" does not know which parts of the rejected design the reader needs. The theory includes implicit knowledge about what constraints were binding, what the problem domain rules out, and what changed during development.

**2. The judgment gap.** A programmer holding the theory can judge whether a proposed change is coherent with the design. A programmer reading the source can check whether the change compiles and passes tests. These are different capabilities. The theory holder can say "that would work mechanically but it violates the design" and explain why.

**3. The extension gap.** New requirements arrive in problem-domain terms ("we need to handle the case where X"). The theory holder knows how to map the new requirement onto the existing code structure. The source-only programmer must infer the mapping from the text, which requires reverse-engineering the design decisions.

This claim is in tension with strong versions of "code as documentation" programming philosophy. Literate programming (Knuth), comprehensive tests-as-spec, and type-directed programming all attempt to narrow the gap. Naur would acknowledge they narrow it but deny they close it: the theory includes knowledge about the non-computational world that no formal system can represent.

For murail: [[the-programmers-theory-includes-why-alternatives-were-rejected-not-just-what-was-chosen]] captures the rationale gap directly. The ops/derivation.md and ops/methodology/ files are an attempt to record rejected alternatives, but they are only as complete as what the agent writing them thought to capture.

Connects forward to [[evolvability-requires-trading-provably-for-extensibility]]: if specs can't fully specify meaning, tight specs are doubly brittle. Connects to [[hirams-law-makes-all-observable-interpreter-behavior-a-permanent-api-commitment]]: users will rely on the full observable behavior of a system because they have no way to know which behaviors were intentional from the source text alone.
