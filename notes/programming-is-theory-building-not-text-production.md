---
description: Naur argues the primary product of programming is the programmer's mental theory, not the source text; the text is an expression of the theory, not the theory itself
type: claim
evidence: strong
source: [[naur-1985-programming-as-theory-building]]
created: 2026-02-28
status: active
---

# programming is theory building not text production

Naur's central thesis: a program is not the text that describes it. The essential artifact of programming activity is the theory held in the minds of the programmers -- a body of understanding about the problem domain, the reasons for each design choice, and the knowledge of what the program will and will not do. Source code is the precipitate of that theory, not the theory itself.

The paper uses "theory" in Ryle's sense: not a formal theory but the kind of knowledge that cannot be fully articulated. A programmer who holds the theory can modify the program to handle new cases, explain why the code is written as it is (not just what it does), and judge whether a proposed change fits the existing design. A programmer who has only the source text -- even perfectly commented source text -- has none of these capabilities.

This is a fundamental claim about the nature of programming knowledge: it is *tacit*, not codifiable. You cannot transfer a program to another team by handing over the source and documentation; you transfer the theory by transferring the people or by having the new team rebuild the theory from scratch through sustained contact with the program.

The implication is practical: programming teams are not interchangeable. The theory lives in specific people. When those people leave, the theory decays even if the text survives.

For murail: the design rationale captured in CLAUDE.md, ops/, and notes/ is an attempt to externalize the architectural theory so that future sessions (and future agents) can hold it. The limitation is Naur's point: no documentation fully substitutes for the theory. See [[no-documentation-can-substitute-for-the-programmer-held-theory]].

The claim directly challenges the "if it's documented it's maintainable" assumption. It also provides the theoretical grounding for [[vibe-coding-produces-unauditable-architectural-debt]]: vibe coding produces text without building the programmer's theory, so the resulting code is immediately in the "revival by newcomers" condition.

Extends [[debuggability-is-more-valuable-than-correctness-by-construction]] by explaining *why* specs are always wrong: they are attempts to articulate theory that is inherently tacit. Relates to [[evolvability-requires-trading-provability-for-extensibility]] by adding a social dimension: evolvability requires that the *theory* be transferable, not just that the specification be extensible.

See also [[interactive-programming-eliminates-the-compile-run-cycle]]: interactive systems preserve more state and more runtime context than batch systems, reducing the theory-text gap.
