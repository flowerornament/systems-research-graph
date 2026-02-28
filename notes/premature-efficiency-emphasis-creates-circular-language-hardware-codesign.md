---
description: Designing languages to match current hardware capabilities and hardware to match current language patterns creates a lock-in cycle that prevents notation from evolving toward better thought tools
type: claim
evidence: moderate
source: [[iverson-1980-notation-as-tool-of-thought]]
created: 2026-02-28
status: active
---

# premature efficiency emphasis creates circular language-hardware codesign

Iverson's closing argument in Section 5.4: "overemphasis of efficiency leads to an unfortunate circularity in design: for reasons of efficiency early programming languages reflected the characteristics of the early computers, and each generation of computers reflects the needs of the programming languages of the preceding generation."

The circularity is a ratchet: language L1 is designed to run efficiently on hardware H1; hardware H2 is designed to run L1-style code efficiently; language L2 is designed to run efficiently on H2; and so on. Each iteration optimizes for the previous generation's constraints, preventing the notation from evolving toward what would be a better tool for thought. APL's array operations were considered inefficient on 1980 hardware; implementers added efficient support for heavily-used boolean operations (`^/B`, `v/B`) precisely because the notation attracted users who wrote that code.

The counterexample Iverson cites: "because functions on booleans (such as `^/B` and `v/B`) are found to be heavily used in APL, implementers have provided efficient execution of them." Use patterns driven by expressive notation drive hardware/implementation improvements -- the causal arrow runs from notation to efficiency, not the other way.

This is a design governance argument as much as a technical one. Efficiency concerns should not veto notation decisions in early design phases. The question "is this efficient?" only makes sense relative to a specific hardware/implementation target; the question "does this serve thought?" is more durable.

Connects to [[programmer-time-dominates-computation-cost-in-the-post-scarcity-era]]: Sussman's argument that programmer expressiveness is now the binding constraint is the contemporary form of Iverson's 1980 argument. The scarcity that justified language-hardware co-optimization (limited memory, slow CPUs) has been removed; the circularity should break.

The argument also explains APL's influence on array languages (J, K, Q, Julia) -- each generation freed from the original hardware constraints found that the notational properties Iverson identified were worth recovering. The thought-tool value was latent in the design; efficiency was a temporary obstacle.
