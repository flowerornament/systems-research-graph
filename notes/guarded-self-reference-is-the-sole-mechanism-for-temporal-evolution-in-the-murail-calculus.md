---
description: The self@d form is the only way a Murail equation can depend on its own past; all recurrence, memory, and feedback derive from this single primitive
type: property
evidence: strong
source: [[murail-substrate-v3]]
created: 2026-02-28
status: active
---

# guarded self-reference is the sole mechanism for temporal evolution in the murail calculus

Every equation in a Murail program is a binding of a name to an expression. Temporal evolution -- the ability of an equation to remember its own history -- enters exclusively through the `self@d` (static delay) and `self@φ_d` (variable delay) forms. Without these forms, every equation is a pure function of its current-tick inputs and produces no persistent state.

This design choice has a strong structural consequence: the entire recurrence calculus reduces to one primitive, guarded self-reference. Ring buffers exist to implement it. The causality condition (every cycle must contain a delay edge) exists to discipline it. The state region layout algorithm exists to statically allocate storage for it. Rate inference exists to clock it. Every Layer 1 mechanism traces back to the need to evaluate self-referential equations safely and efficiently.

The "guarded" part is essential: only `self@d` with d >= 1 is permitted as a cycle-breaking edge. Unguarded self-reference (`self@0`) would create an instantaneous cycle -- an equation that depends on its own current-tick value -- which is a compile-time error. The guard is the delay itself.

This differs from most signal-processing languages where recursion and delay are syntactically distinct: Faust uses `~` for feedback with implicit one-sample delay; SC uses `SampleDelay` UGens explicitly. Murail makes delay an expression-level annotation on any self or cross-equation reference, unifying feedback, delay lines, and ring buffers under one form.

## Connections

- Extends [[faust-recursive-composition-with-implicit-one-sample-delay-is-the-primitive-for-all-feedback]] by making the delay amount an explicit annotation rather than an implicit one-sample assumption, enabling multi-tap lookback and variable delay from the same primitive
- The causality condition that disciplines this primitive is stated in [[the-causality-condition-requires-every-dependency-cycle-to-contain-a-delay-edge]]
- Runtime storage for self-reference is allocated statically in [[all-murail-program-state-fits-in-a-single-pre-allocated-contiguous-region]]
- The mathematical theory underlying guarded self-reference is the topos of trees: [[the-guardedness-condition-on-recursive-definitions-is-the-proof-theoretic-analog-of-the-causality-condition-on-dependency-graphs]] shows that Murail's delay guard and guarded domain theory's ◮ modality are the same categorical principle at different scales
