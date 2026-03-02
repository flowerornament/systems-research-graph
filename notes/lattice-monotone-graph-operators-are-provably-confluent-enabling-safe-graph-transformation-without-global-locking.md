---
description: Hydroflow proves that if graph operators are monotone functions on join-semilattices, any transformation preserving monotonicity is semantically valid regardless of evaluation order
type: property
evidence: strong
source: [[pl-research-landscape-2026-02-27]]
created: 2026-03-01
status: active
---

# lattice-monotone graph operators are provably confluent enabling safe graph transformation without global locking

Hydroflow (Laddad et al. OOPSLA 2023) is a Rust dataflow runtime built on lattice-theoretic foundations. Its key theorem: if values at each node form a join-semilattice and computation operators are monotone functions on those values, the dataflow computation is confluent -- the result is independent of the order in which data arrives, and any graph transformation that preserves operator monotonicity is semantically valid. This enables parallelization, reordering, and optimization of the dataflow graph without changing program semantics.

Murail's rate lattice (Definition 8.1) is a join-semilattice: constant < init < control < audio. Murail's graph operators are (by the formal model's construction) monotone functions on rated tensor spaces. Hydroflow's confluence theorem therefore applies directly: the graph optimizer can perform fusion, fission, node reordering, and subgraph rearrangement without invalidating program semantics, as long as the transformations preserve lattice ordering and operator monotonicity.

The practical implication for D67: the 120+ rewrite rules in the Tier U optimization contract do not all need to be explicitly enumerated and verified. Any transformation that can be shown to preserve monotonicity over the rate lattice is automatically semantically correct. This gives the optimizer a structural criterion for correctness rather than a list of permitted rewrites.

Beyond theory, Hydroflow is implemented in Rust with a focus on systems-level efficiency. Its runtime demonstrates that lattice-based dataflow can run at systems-programming speed -- the same performance tier Murail targets. This is encouraging evidence that the lattice-theoretic foundation does not impose a performance overhead.

The confluence property also has implications for the multi-thread model (D3): if both the RT thread and NRT thread operate on lattice-valued computations with monotone operators, they cannot produce conflicting results regardless of scheduling order. The lock-free communication requirement (D13) is compatible with confluence: monotone accumulation is safe without locks.

Extends [[murails-rate-inference-is-a-monotone-propagator-network-and-therefore-converges-to-a-unique-fixpoint]] -- that claim establishes convergence of rate inference; this claim establishes confluence of the broader graph transformer. Both derive from the same mathematical foundation: join-semilattices with monotone functions. Connects to [[equality-saturation-can-replace-hand-coded-rewrite-rules-with-automatically-discovered-provably-terminating-optimizations]] because the confluence property validates that discovered rewrites preserving monotonicity are sound. See [[propagator-cells-hold-partial-information-that-accumulates-monotonically]] for the general propagator model underlying both.

---

Topics:
- [[formal-methods]]
- [[audio-dsp]]
- [[concurrent-systems]]
