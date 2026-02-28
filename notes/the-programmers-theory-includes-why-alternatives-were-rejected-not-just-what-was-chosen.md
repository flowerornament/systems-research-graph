---
description: Naur's claim that a programmer's theory includes negative knowledge — understanding why the design is not otherwise — which is fully tacit and cannot be recovered from source text
type: claim
evidence: strong
source: [[naur-1985-programming-as-theory-building]]
created: 2026-02-28
status: active
---

# the programmers theory includes why alternatives were rejected not just what was chosen

Naur specifies three components of a programmer's theory about a program's relationship to the world it models:

1. Why the program is structured the way it is (positive knowledge: the rationale for the chosen design)
2. How the program maps to real-world phenomena it handles (the model: what the code means in terms of the problem domain)
3. **Why the program is not structured differently** — knowledge of alternatives considered and rejected

The third component is the most tacit and most easily lost. It includes:
- Alternatives that were ruled out for performance reasons (and what performance data was available at the time)
- Design paths that were explored and abandoned when they led to dead ends
- Constraints that were active during development but may have relaxed since
- Simplifications that were deliberate (and which would produce correctness problems if removed)

This negative knowledge is what guides a program's evolution. A maintainer without it may "fix" a simplification that was intentional, remove a constraint that was load-bearing, or re-explore a path that was already tried and found deficient. The result looks like a reasonable change but violates the design's coherent structure.

**Why this matters for software documentation:** Good architecture decision records (ADRs) attempt to capture this by documenting rejected alternatives alongside the chosen approach. Naur's framework explains why this matters: without the rejected alternatives, the decision record is incomplete in the most important dimension.

**Why this is harder than it sounds:** During development, the reasons for rejection are usually clear and vivid. After the fact, they require reconstruction. And the most important rejections are often unarticulated even at the time -- the programmer had a sense of wrongness about the alternative before they could fully articulate it.

This connects to [[evolvability-requires-trading-provability-for-extensibility]]: Sussman argues that provable specs cannot capture the full design because they cannot anticipate future extension requirements. Naur provides the epistemological foundation for *why* that is -- the knowledge needed to extend correctly is partly negative and partly tacit, neither of which survives specification.

---

Source: [[naur-1985-programming-as-theory-building]]

Relevant Notes:
- [[programming-is-theory-building-not-text-production]] -- the parent claim establishing the theory concept
- [[a-programs-source-text-cannot-fully-specify-its-meaning]] -- source text captures positive choices but not negative ones
- [[evolvability-requires-trading-provability-for-extensibility]] -- Sussman's complementary argument: tight specs cannot serve future extension
- [[program-revival-by-newcomers-systematically-produces-degraded-designs]] -- newcomers lack this negative knowledge, which is why revival degrades
- [[no-documentation-can-substitute-for-the-programmer-held-theory]] -- even exhaustive documentation misses the tacit negative knowledge

Topics:
- [[developer-experience]]
- [[language-design]]
