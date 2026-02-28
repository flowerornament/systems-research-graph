---
description: Naur's argument that source code is radically underdeterminate — the text fixes only what was required, leaving unstated why it was required and what counts as correct for unspecified cases
type: claim
evidence: strong
source: [[naur-1985-programming-as-theory-building]]
created: 2026-02-28
status: active
---

# a programs source text cannot fully specify its meaning

Naur argues that a program's source text specifies only what was explicitly required at the time of writing. It does not encode why these requirements were chosen, what trade-offs were made, which behavior is correct for cases not covered by the original requirements, or what constitutes a legitimate modification.

Two programmers who agree on what the text says may disagree about what constitutes a correct extension of the program. The text cannot adjudicate between them. Only the theory -- the mental model of why the program is structured as it is -- can do so.

**The underdetermination problem in practice:** Software maintenance involves continuous novel situations: new requirements, unexpected bug reports, platform changes, integration demands. For each, the maintainer must decide whether a proposed change is consistent with the program's design. The text shows existing decisions; it does not expose the design rationale that should govern new ones.

This is not merely a documentation failure -- Naur argues the rationale cannot, in principle, be fully reduced to text. The theory is a dynamic capacity for responding to the world; text is a static record of past responses. Even exhaustive documentation written by the theorists themselves cannot fully transfer the theory, because the documentation would need to anticipate every future question to do so.

**Contrast with formal specifications:** A formal specification does constrain behavior more tightly -- but only within its domain. It cannot cover behavior outside the formalized domain, and it does not encode the informal knowledge about what *should* be formalized. This is the root of [[evolvability-requires-trading-provability-for-extensibility]] -- tight specs constrain the text but not the world.

For murail: the audio graph engine's RT safety constraints, memory model invariants, and graph compiler semantics can be formally specified in narrow domains. But the theory of why the architecture is the way it is -- what alternatives were considered and rejected, what the design is optimizing for -- lives in the developers' heads, not in any spec file.

---

Source: [[naur-1985-programming-as-theory-building]]

Relevant Notes:
- [[programming-is-theory-building-not-text-production]] -- the parent claim establishing what theory is
- [[no-documentation-can-substitute-for-the-programmer-held-theory]] -- documentation's structural limitations follow from this
- [[evolvability-requires-trading-provability-for-extensibility]] -- Sussman's formal version of why specifications are always incomplete
- [[hirams-law-makes-all-observable-interpreter-behavior-a-permanent-api-commitment]] -- a concrete example of underdetermination: observable behavior is locked in even when unspecified
- [[observable-semantics-lock-in-implementation-details-and-block-optimization]] -- related: text-level behavior observability outpaces designer intent

Topics:
- [[developer-experience]]
- [[language-design]]
