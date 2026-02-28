---
description: Iris is a language-generic framework providing higher-order ghost state and impredicative invariants that suffice to derive the full lifetime logic needed to model Rust's borrowing mechanism
type: property
evidence: strong
source: [[rustbelt-2018]]
created: 2026-02-28
status: active
---

# Iris separation logic enables deriving a lifetime logic from primitive mechanisms

Choosing the right logic for modeling Rust was the most fundamental design decision in RustBelt. The requirements were clear: the logic must support high-level reasoning about ownership and borrowing. The answer is Iris.

Iris is a language-generic framework for higher-order concurrent separation logic. Its two key primitive mechanisms are:
1. **Higher-order ghost state**: abstract resources with custom algebra (separation from the logic's structure)
2. **Impredicative invariants**: invariants that can quantify over the invariant space itself (enabling the recursive structure needed for higher-order state)

These two mechanisms are sufficient to derive the entire lifetime logic as a *library within Iris*, rather than requiring it as a primitive:

- **Full borrows** `&κ_full P`: temporary ownership for the duration of lifetime κ
- **Fractured borrows** `&κ_frac Φ`: persistent, fractional access (the default sharing predicate for simple types)
- **Non-atomic persistent borrows** (for Cell-like types): thread-specific full access, single-threaded only
- **Atomic persistent borrows** (for Mutex-like types): globally accessible access, protected by atomicity constraint

All of these are derived from a single internal mechanism (indexed borrows) built on Iris's primitives.

The use of Iris rather than a custom step-indexed model is what makes the proof feasible: all prior semantic soundness proofs for substructural type systems were done directly in set-theoretic step-indexed models. Iris provides the layer of abstraction needed to reason at the level of lifetimes and borrowing rather than low-level step indices.

**Relevance to murail:** This claim establishes the proof infrastructure context. It matters that murail's safety properties are grounded in Iris, a mature, machine-checked framework with active development and multiple verification projects. The lifetime logic used to verify Mutex and Arc is not ad hoc -- it is a modular derivation within a general framework.

This claim provides context for [[rust-lifetimes-model-temporary-ownership-that-returns-to-the-original-owner-on-expiry]], explaining *how* that temporal model is formally constructed.
