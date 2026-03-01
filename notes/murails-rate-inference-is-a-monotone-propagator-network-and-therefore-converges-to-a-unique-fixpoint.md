---
description: Radul's convergence theorem applies directly to rate inference because the rate lattice is a join-semilattice and rate-combining operators are monotone functions on it
type: property
evidence: strong
source: [[pl-research-landscape-2026-02-27]]
created: 2026-03-01
status: active
---

# Murail's rate inference is a monotone propagator network and therefore converges to a unique fixpoint

Radul's 2009 MIT thesis formalizes the propagator model: if cells form a join-semilattice and propagators are monotone functions, the network converges to a unique fixpoint regardless of evaluation order. Murail's rate inference (Definition 8.2 in the formal model) satisfies both conditions exactly.

The rate lattice (Definition 8.1) is a join-semilattice: constant < init < control < audio, with join as the least upper bound. Rate inference -- combining signals at different rates produces output at the higher rate -- is a monotone function over this lattice. Adding more information (more concrete rate assignments to nodes) can only push rates upward in the lattice, never downward.

The consequence is that Radul's convergence theorem applies directly: rate inference terminates with a unique answer regardless of the order in which graph nodes are visited during propagation. This is the formal guarantee making Murail's rate inference well-defined: without it, inferred rates could depend on traversal order, producing different compiled schedules from the same graph (non-determinism at compile time).

The propagator model also suggests a natural implementation strategy: treat each graph node as a propagator, each edge's rate annotation as a cell, and let the network converge by propagating until no cell changes. This is the same mechanism that [[propagator-cells-hold-partial-information-that-accumulates-monotonically]] describes for Sussman's general propagator model, instantiated for the rate domain.

Beyond rate inference, this result validates the lattice-theoretic foundation of the entire formal model. Every other monotone computation over the rate lattice -- space inference (Definition 7.3), buffer allocation, schedule optimization -- inherits the same convergence guarantee. The choice to build on lattice theory was not merely mathematically elegant but implies a whole family of provably correct algorithms.

Extends [[propagator-cells-hold-partial-information-that-accumulates-monotonically]] by applying Radul's convergence theorem to the specific case of rate inference. Strengthens [[the-causality-condition-requires-every-dependency-cycle-to-contain-a-delay-edge]] -- both are structural guarantees that make the formal model's algorithms well-defined. See also [[construction-time-graph-optimization-distributes-compiler-cost-across-node-creation]] for the current implementation approach to rate inference.

---

Topics:
- [[formal-methods]]
- [[audio-dsp]]
- [[language-design]]
