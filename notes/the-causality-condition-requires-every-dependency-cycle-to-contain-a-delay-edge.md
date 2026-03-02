---
description: Every cycle in the Murail dependency graph must include at least one @d edge; this is the structural invariant that makes the instantaneous-dependency subgraph a DAG
type: property
evidence: strong
source: [[murail-substrate-v3]]
created: 2026-02-28
status: active
---

# the causality condition requires every dependency cycle to contain a delay edge

The Murail dependency graph G(P) has two kinds of edges: instantaneous edges (the value is needed this tick) and delay edges (the value is from a prior tick, annotated @d). The causality condition states: every cycle in G(P) must contain at least one delay edge.

This single condition is what makes programs evaluable. Theorem 3.1 proves it directly: if the causality condition holds, the instantaneous-dependency subgraph is a DAG, and any topological sort of that DAG yields a valid evaluation order for one tick. Conversely, a program with an instantaneous cycle cannot be evaluated in finite steps and is rejected at compile time.

The condition also extends to variable delays: `self@φ_d` and `n@φ_d` are always classified as delay edges, regardless of the runtime value of φ_d. This is conservative but necessary -- the delay expression itself may reference other equations (as instantaneous edges, since the amount is needed this tick), but the value being delayed is guaranteed to come from a past tick because the minimum delay is enforced as >= 1 at runtime.

**Cross-rate cycles are automatically guarded.** Hold slots -- the mechanism for reading slower-rate values from a faster-rate equation -- introduce latency equivalent to @d with d >= 1, so feedback paths crossing a rate boundary never violate causality (Proposition 5.1). The rate system and the causality condition cooperate without explicit cross-rate delay annotations.

## Connections

- This condition is what guarded self-reference (see [[guarded-self-reference-is-the-sole-mechanism-for-temporal-evolution-in-the-murail-calculus]]) must satisfy to be admitted into a well-formed program
- Well-formedness is checked at compile time (Theorem 7.1); the causality condition is item 3 of 7
- [[faust-recursive-composition-with-implicit-one-sample-delay-is-the-primitive-for-all-feedback]] implicitly satisfies causality via the one-sample delay rule; Murail makes the obligation explicit and general
- Rate boundaries automatically satisfy this condition via [[hold-slots-prevent-fast-thread-blocking-on-slow-rate-values-without-locks]]
