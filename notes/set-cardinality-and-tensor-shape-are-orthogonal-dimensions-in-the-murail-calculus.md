---
description: Shape describes the internal structure of each value; cardinality describes how many independent instances evolve in parallel -- these two dimensions are independent and compose separately
type: property
evidence: strong
source: [[murail-substrate-v3]]
created: 2026-02-28
status: active
---

# set cardinality and tensor shape are orthogonal dimensions in the murail calculus

A Murail equation has two structural properties that are explicitly kept independent:

- **Shape**: the tuple of dimensions describing the internal structure of each value (e.g., `()` for scalar, `(512)` for vector, `(16, 16)` for matrix)
- **Cardinality**: how many independent instances of that value evolve in parallel (e.g., `j = 4` for a set of four independent oscillators)

An equation with cardinality 4 and shape `(512)` has four independent ring buffers, each holding vectors of 512 elements. Operations applied to a set apply element-wise: `f({a1,...,aj}, {b1,...,bj}) = {f(a1,b1),...,f(aj,bj)}`. Fold (`⊕/{v1,...,vj}`) is the only way cardinality decreases.

The orthogonality has a practical consequence: universal auto-mapping ([[universal-auto-mapping-eliminates-explicit-iteration-from-signal-processing-programs]]) operates over shape via rank polymorphism, while set expressions operate over cardinality. The two mechanisms compose without interaction: an operation can be rank-polymorphic over shape and simultaneously applied element-wise over a set.

**Why cardinality is a compile-time constant.** Dynamically-sized sets would require dynamic state allocation, violating the static state region guarantee ([[all-murail-program-state-fits-in-a-single-pre-allocated-contiguous-region]]). Fixed cardinality allows the layout compiler to pre-allocate exactly `j × depth(n)` frames per set-valued equation. Templates and bounded iteration (`for i in 1..N`) are the practical mechanism for building set-valued programs without writing `j` separate equations.

## Connections

- The state region layout formula accounts for cardinality: `card(n) × size(n) × depth(n)` per equation (see [[all-murail-program-state-fits-in-a-single-pre-allocated-contiguous-region]])
- Rank polymorphism over shape is separate from element-wise lifting over sets; [[signal-shape-as-a-type-level-property-enables-compile-time-buffer-allocation-and-vectorization]] covers shape's role in dispatch
- The orthogonality is analogous to how [[universal-auto-mapping-eliminates-explicit-iteration-from-signal-processing-programs]] (McCartney's `@` operator) treats the shape dimension while leaving parallelism to explicit set expressions
