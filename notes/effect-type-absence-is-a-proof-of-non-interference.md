---
description: A function typed with an empty effect row is statically proved to not invoke any user-defined effects, giving non-throwing, non-aborting, non-async guarantees at the type level
type: property
evidence: strong
source: [[leijen-2016-algebraic-effects-tr]]
created: 2026-03-01
status: active
---

# effect type absence is a proof of non-interference

Leijen's Lemma 4.b ("faulty expressions are not typeable") has a positive reading beyond soundness. The lemma states: if `Γ ⊢ Xop[op(v)] : τ | ε` with `op ∈ Σ(l)`, then `l ∈ ε`. Contrapositive: if `l ∉ ε`, then no operation from effect `l` can appear in the computation.

This means a **closed effect row** is not just a permission set -- it is a **non-interference certificate**. A function typed `() → ⟨⟩ int` (total, empty effect row) is statically proved to:
- Never throw an exception
- Never perform I/O
- Never issue any user-defined effect operation
- Terminate (if `div` is excluded from the environment)

The effect type system thus makes non-interference decidable and machine-checked. This is stronger than documentation or convention -- the type checker enforces it.

**Practical value**: in a system with multiple resources (audio buffers, scheduling context, UI events), an inner-loop computation typed with the empty effect row is statically guaranteed not to interact with any of those resources unexpectedly. The guarantee is local (derivable from the function's type alone) and compositional (if two total functions are composed, the composition is total).

**Comparison to preconditions**: the guarantee is not just "this function does not throw in practice" -- it is "this function cannot, by construction, invoke any operation that would affect the surrounding context." This is the difference between testing non-interference and proving it.

**Connection to [[well-typed-algebraic-effect-programs-cannot-invoke-unhandled-operations]]**: that claim covers the positive direction (operations must have handlers); this claim covers the negative direction (the absence of an effect in the type is a proof that no such operation occurs). Together they make the effect type system a bidirectional resource accounting system.

Connects to [[rust-provides-provably-memory-and-data-race-safe-programs-without-garbage-collection]]: both systems use type-level resource accounting to give compile-time proofs of absence properties. Rust's ownership system proves absence of data races; Leijen's effect system proves absence of effect invocations. The proof strategy is the same -- type inference tracks the resource, and an empty type is a proved absence.

Relevance to [[language-design]] in murail: real-time audio code must not perform allocations, I/O, or blocking operations. An effect type system could enforce this at compile time by requiring that the audio callback's type has an effect row excluding `alloc`, `io`, and `block` effects. The guarantee would be machine-checked, not a convention.
