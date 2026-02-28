---
description: Both guarded domain theory and Murail's causality invariant share one structural principle: every cycle must pass through a "later" guard -- an isomorphism connecting formal foundations to compiler enforcement
type: claim
evidence: moderate
source: [[birkedal-2012-guarded-domain-theory]]
created: 2026-02-28
status: active
---

# the guardedness condition on recursive definitions is the proof-theoretic analog of the causality condition on dependency graphs

Guarded domain theory (Birkedal et al. 2012) requires that every recursive type or predicate definition have its recursion variable guarded by ◮ (for types) or ✄ (for predicates). This "guardedness condition" is checked syntactically before a recursive definition is admitted. The Löb rule `(✄ϕ → ϕ) → ϕ` is then available for reasoning about guarded definitions.

Murail's causality condition ([[the-causality-condition-requires-every-dependency-cycle-to-contain-a-delay-edge]]) states that every cycle in the dependency graph G(P) must contain at least one delay edge (@d with d≥1). This condition is checked by the compiler. The `self@d` guard is exactly the delay that breaks cycles, and the instantaneous-dependency subgraph (all edges with d=0) must be a DAG for topological sort to determine evaluation order.

The structural isomorphism:
- ◮ (topos later modality) ↔ `@d` annotation on a `self` reference
- Guardedness condition (every recursive variable under ◮) ↔ Causality condition (every cycle through `@d` edge)
- Löb rule (guarded → well-founded) ↔ DAG property of instantaneous subgraph (delay-guarded → evaluable in finite steps)
- Unguarded recursion (rejected) ↔ Instantaneous cycle (compile-time error)

This is not coincidence. Both systems are instances of the same categorical pattern: well-foundedness of recursion is enforced by requiring every self-reference to pass through a "step," where a step is either a time step (◮ in the topos, `@d` in Murail) or a computational reduction step (as in step-indexing). The difference is that guarded domain theory works with ordinal steps in a topos, while Murail works with audio-clock ticks.

## Connections

- The Murail side of this connection is documented in [[guarded-self-reference-is-the-sole-mechanism-for-temporal-evolution-in-the-murail-calculus]] and [[the-causality-condition-requires-every-dependency-cycle-to-contain-a-delay-edge]]
- The topos-of-trees side is elaborated in [[the-later-modality-on-types-enables-guarded-recursive-domain-equations-in-the-topos-of-trees]] and [[the-loeb-rule-makes-coinductive-reasoning-derivable-in-guarded-domain-theory]]
- This correspondence suggests that Murail's formal model could be given a synthetic guarded domain theory interpretation, potentially making the causality checker a type-checker in the topos of trees sense — an open research direction
