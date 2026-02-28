---
description: The FAUST recursive operator ~ creates feedback loops with a mandatory implicit one-sample delay, making all recursion well-founded and computationally deterministic
type: property
evidence: strong
source: [[faust-2009-npcm]]
created: 2026-02-28
---

# FAUST recursive composition with implicit one-sample delay is the primitive for all feedback

In FAUST, feedback is expressed via the recursive composition operator `~`. The operator `f ~ g` connects the output of `f` back to the input of `g` (and the output of `g` to the input of `f`) but always inserts an implicit one-sample delay in the feedback path. This is not a limitation — it is a design invariant that makes all recursion well-founded.

The one-sample delay ensures that at time `t`, computing the output `Y(t)` only requires `Y(t-1)` — which has already been computed. Without this constraint, instantaneous feedback cycles would create algebraic loops (equations where `Y(t)` depends on itself at the same sample), which have no computable solution in a synchronous DSP model.

Example integrator: `process = + ~ _` computes `Y(t) = X(t) + Y(t-1)`.
Example noise generator LCG: `random = +(12345) ~ *(1103515245)` produces `R(t) = 12345 + 1103515245 * R(t-1)`.

This one-sample implicit delay is the formal primitive that distinguishes FAUST's model from pure function composition: it introduces state into an otherwise stateless functional system in the minimum necessary way.

For murail's graph IR, this is directly relevant: the graph compiler's feedback handling must track which edges represent the delayed feedback path. [[delay-merging-collapses-structurally-identical-delays-enabling-implicit-multi-tap-sharing]] already describes murail's delay optimization; the FAUST model clarifies that the primitive delay unit is one sample, and all longer delays are composed from this plus explicit delay nodes.

The contrast with dataflow languages (Max/PD) is instructive: those systems have complex firing rules and non-deterministic semantics for cycles. FAUST's mandatory one-sample delay makes cycle semantics trivially deterministic.

## Connections
- Grounds [[faust-block-diagram-algebra-unifies-functional-programming-with-visual-patch-notation]] — `~` is the operator that adds state to an otherwise stateless algebra
- Extends [[delay-merging-collapses-structurally-identical-delays-enabling-implicit-multi-tap-sharing]] — the implicit 1-sample delay in `~` is the base case; explicit `@` delays are composed on top
- Contrasts with [[first-class-control-flow-nodes-in-synthesis-graphs-enable-conditional-and-demand-rate-execution]] — FAUST has no conditional execution; feedback is the only form of non-trivial control
