---
description: Koka's type system statically guarantees that every operation invocation in a well-typed program has a corresponding handler, eliminating the runtime equivalent of unhandled exceptions
type: claim
evidence: strong
source: [[leijen-algebraic-effects]]
created: 2026-02-28
status: active
---

# well-typed algebraic effect programs cannot invoke unhandled operations

Leijen's Lemma 4.b states: if `Γ ⊢ Xop[op(v)] : τ | ε` and `op ∈ Σ(l)`, then `l ∈ ε`. In plain terms: if an expression is well-typed and it contains an operation call, the effect label for that operation must appear in the expression's effect type. Effect types cannot be discarded except by passing through a handler.

The consequence: a well-typed program with an empty effect type (`⟨⟩`) cannot contain any unhandled operation call. The type checker verifies that every effect is handled somewhere in the enclosing context. This is the effect-system analog of exhaustive pattern matching -- you cannot forget to handle a case. Combined with the operational semantics from [[effect-handlers-are-resumable-exceptions-that-capture-delimited-continuations]], this means every continuation capture has a well-defined delimiter -- the type system guarantees the handler exists.

The practical significance Leijen draws: "if a function does not have an `exc` effect, it will never throw an exception." This is stronger than Java's checked exceptions (which can be suppressed) and stronger than Rust's `Result` propagation (which requires explicit handling but doesn't prevent `unwrap()`). The soundness proof (Theorem 1) shows well-typed programs either produce a well-typed value or diverge -- they cannot reach a stuck state from an unhandled operation.

This contrasts with [[type-systems-have-not-empirically-reduced-defect-rates]] which argues empirically that type systems don't reduce ordinary programming defects. Algebraic effects address a different category: *coordination defects* (forgetting to handle a case) rather than ordinary logic bugs. The type-level guarantee is about interface completeness, not business logic correctness.

For [[formal-methods]] in murail: this property is relevant if murail's composition language ever uses algebraic effects for resource management (audio device access, allocation budgets, timing guarantees). A well-typed composition would statically guarantee that every resource operation has a handler -- no unhandled resource access can slip through.

The positive corollary is [[effect-type-absence-is-a-proof-of-non-interference]]: if an effect type is absent from a function's type, that function is proved to not invoke any operation from that effect. Together, the two lemmas make the effect type system a bidirectional resource accounting system.
