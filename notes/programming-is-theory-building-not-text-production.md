---
description: Naur's central claim that a program is the externalization of a theory held by its programmers, not the text itself; the theory is the primary product
type: claim
evidence: strong
source: [[naur-1985-programming-as-theory-building]]
created: 2026-02-28
status: active
---

# programming is theory building not text production

Naur's 1985 central argument: programming is an activity by which programmers build a theory of how certain affairs of the world are handled by, or supported by, a computer program. The theory, not the text, is the primary product of programming.

Naur adopts Ryle's philosophical use of "theory" -- a person has a theory when they can do more than state facts: when they can explain phenomena, relate parts to whole, respond to unexpected situations, and recognize ill-fit attempts. A programmer with a theory of their program can answer questions about it that do not appear in any specification. A programmer without the theory cannot, even with full access to the source text.

**Why this matters:** The text is a static artifact; the theory is a live cognitive structure that responds to novel situations. When a user asks "can we extend the system to handle X?", the answer requires understanding why the current architecture is the way it is -- what constraints were being respected, what alternatives were rejected and why. This is not in the code. It is in the theory.

The distinction has direct consequences for maintenance: if the original theorists leave and the program is maintained by people who built their knowledge only from the text, the responses to new requirements will be degraded. They may fix bugs and add features, but they cannot maintain the underlying design coherence because they do not hold the theory.

This provides a theoretical foundation for [[vibe-coding-produces-unauditable-architectural-debt]]: vibe coding externalizes code production to an agent that never builds the theory, producing systems whose maintainers are structurally in the position of the "newcomers" Naur describes -- reading text, not holding theory.

The claim also reframes [[debuggability-is-more-valuable-than-correctness-by-construction]]: the reason live debugging matters is not just feedback speed -- it is because interactive engagement with a running system is one of the mechanisms by which programmers build and maintain their theory. Batch-mode programming severs this theory-building feedback.

---

Source: [[naur-1985-programming-as-theory-building]]

Relevant Notes:
- [[vibe-coding-produces-unauditable-architectural-debt]] -- vibe coding is the extreme case: no developer theory is built at all
- [[debuggability-is-more-valuable-than-correctness-by-construction]] -- live systems support ongoing theory-building in ways static artifacts cannot
- [[no-documentation-can-substitute-for-the-programmer-held-theory]] -- the corollary about documentation's limits
- [[program-revival-by-newcomers-systematically-produces-degraded-designs]] -- what happens when theory-holders leave
- [[evolvability-requires-trading-provability-for-extensibility]] -- Sussman reaches a related conclusion about the primacy of adaptable human understanding over formal specifications
- [[interactive-programming-eliminates-the-compile-run-cycle]] -- interactive environments support theory-building by closing the feedback loop between code and running behavior

Topics:
- [[developer-experience]]
- [[language-design]]
