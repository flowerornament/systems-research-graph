---
description: Naur's structural argument that documentation is always incomplete as a substitute for the programmer's theory because documentation is static text and theory is a dynamic cognitive capacity
type: claim
evidence: strong
source: [[naur-1985-programming-as-theory-building]]
created: 2026-02-28
status: active
---

# no documentation can substitute for the programmer held theory

Naur argues that no amount of documentation, however thorough, can fully transfer the programmer's theory of a program to someone who did not participate in building it. This is a structural claim about the nature of theory, not a complaint about documentation quality.

**The argument:** Documentation is text. Text is a static artifact. Theory is a cognitive capacity that responds to novel situations. A person with a theory of their program can field unexpected questions: "What would happen if we added X? Is this behavior intentional or incidental? Why is this module structured this way?" The theory answers by generating responses, not by lookup.

Comprehensive documentation would need to anticipate every future question to substitute for the theory. This is not possible, because the questions arise from future situations the documentation cannot know. Documentation always covers the situation as it was understood when written; the theory generalizes to situations not yet encountered.

**What documentation can and cannot do:**

Documentation can:
- Record the behavior of the system on specified cases
- Describe the interface contracts
- Explain specific design decisions that were made consciously

Documentation cannot:
- Answer questions about novel cases not covered
- Convey the tacit knowledge of which things are load-bearing vs. incidental
- Transfer the negative knowledge: why alternatives were rejected (see [[the-programmers-theory-includes-why-alternatives-were-rejected-not-just-what-was-chosen]])
- Substitute for judgment about whether a proposed change is consistent with the design's coherent structure

**Implication for software teams:** Naur's argument supports knowledge transfer through active theory-building collaboration (pair programming, design review, apprenticeship patterns) over documentation-only knowledge management. The documentation is a partial record, not a transfer mechanism.

This does not make documentation useless. Documentation supports theory-building by providing anchor points -- facts the newcomer can use to build their own theory of the system. But the documentation is scaffolding for theory construction, not the theory itself.

For the arscontextica vault: this is precisely what the claim graph does for research knowledge. The wiki-linked claims are not the theory -- they are scaffolding for building and maintaining a theory across sessions.

---

Source: [[naur-1985-programming-as-theory-building]]

Relevant Notes:
- [[programming-is-theory-building-not-text-production]] -- establishes the distinction between text and theory
- [[a-programs-source-text-cannot-fully-specify-its-meaning]] -- source code is a special case of text-as-documentation
- [[the-programmers-theory-includes-why-alternatives-were-rejected-not-just-what-was-chosen]] -- specifically the negative knowledge documentation cannot capture
- [[program-revival-by-newcomers-systematically-produces-degraded-designs]] -- the consequence of documentation-only knowledge transfer
- [[agentsmd-is-gap-filling-for-llms-not-documentation-for-humans]] -- AgentsMD as a form of targeted documentation that acknowledges LLMs' different failure modes from humans

Topics:
- [[developer-experience]]
