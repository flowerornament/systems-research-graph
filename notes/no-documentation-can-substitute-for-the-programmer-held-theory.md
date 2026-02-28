---
description: Naur argues documentation is not a substitute for the programmer's theory because it cannot contain tacit relational knowledge; increasing documentation volume cannot close this gap
type: claim
evidence: strong
source: [[naur-1985-programming-as-theory-building]]
created: 2026-02-28
status: active
---

# no documentation can substitute for the programmer-held theory

Naur makes a categorical claim: the problem of theory transfer is not a documentation quality problem. No amount of documentation -- however comprehensive, however well-maintained -- can substitute for the programmer's held theory. This is not because we write bad docs. It is because the theory contains a kind of knowledge (tacit, relational, contextual) that documentation, as a category, cannot contain.

The claim distinguishes between:

- **Recoverable knowledge**: Facts about the code that a diligent reader could reconstruct. What the functions do. What the data structures contain. What the test cases verify. This knowledge can be documented.

- **Irreducible tacit knowledge**: How the parts relate to each other and to the problem domain, why the structure is the way it is, which aspects of the design are load-bearing, and what the design would need to look like to accommodate changes the original programmer imagined but didn't implement. This knowledge cannot be documented because it requires the theory to know which parts of it matter.

The distinction maps onto Ryle's "knowing that" vs. "knowing how": documentation transfers propositional knowledge; the theory is practical knowledge. Practical knowledge requires doing, not reading.

Implication for software teams: the standard practice of "make sure it's documented before you leave" is not wrong, but it is insufficient. Good documentation reduces the cost of revival; it does not eliminate it. The team rebuilding the theory from good documentation will take much less time than one rebuilding from bad documentation, but they are still rebuilding.

For murail's knowledge graph: this claim is the honest accounting of what the CLAUDE.md system can and cannot do. The system can encode propositional knowledge (claim texts, rationale, decisions, rejected alternatives). It cannot encode the tacit relational knowledge that a programmer holds from months of working with the system. That knowledge must be rebuilt each session.

This is a sober counterpoint to the knowledge-graph ambition. It argues for the graph while acknowledging the graph's limits. The graph reduces the cost of the rebuild; it does not substitute for it.

Connects directly to [[a-programs-source-text-cannot-fully-specify-its-meaning]]: if source text can't carry meaning, documentation can't either, because documentation is less information-dense than the text it documents. Also connects to [[agentsmd-is-gap-filling-for-llms-not-documentation-for-humans]]: gap-filling files are an acknowledgment that documentation cannot substitute for model world-knowledge -- an LLM analogue of Naur's point.
