---
description: A sub-borrow at shorter lifetime κ' must include an inheritance restoring the original borrow at κ after κ' ends -- source of most complexity in the RustBelt lifetime logic
type: property
evidence: strong
source: [[rustbelt-2018]]
created: 2026-02-28
status: active
---

# reborrowing is the most technically subtle feature of Rust's lifetime system

Reborrowing is the act of creating a new, shorter borrow from an existing borrow. In surface Rust, this happens implicitly whenever you pass a mutable reference to a function that returns a reference with a sub-lifetime. The type system accepts this because the new borrow must expire before the original.

The formal rule (LftL-reborrow) is:

`κ' ⊑ κ * &κ_full P ⟹⊛ &κ'_full P * ([†κ'] ⟹⊛ &κ_full P)`

This reads: given that κ' is shorter than κ, a full borrow at κ can be updated to a full borrow at κ', along with an inheritance that restores the original borrow at κ once κ' ends.

The subtlety: unlike shortening (LftL-bor-shorten, which simply weakens the borrow), reborrowing must guarantee that the original borrow is *recoverable*. This requires carefully threading ownership through the lifetime token system -- once κ' ends, the inheritance fires and the borrow at κ is restored, even if no explicit action is taken by the programmer.

This rule is why interior mutable types like `RefCell<T>` and `RwLock<T>` required a novel mechanism (deriving lifetime inclusions from fractured borrows) -- these types allow sharing data structures for a lifetime that cannot be established in advance, requiring dynamic establishment of lifetime inclusion relationships.

**The Leakpocalypse connection**: Many of Rust's historical soundness bugs involved subtle violations of the reborrowing invariant -- cases where the restoration of the original borrow after a sub-lifetime ended was not guaranteed. The formal lifetime logic catches these because every reborrow must provide a concrete inheritance proof that the restoration is possible.

**Relevance to murail:** murail's audio nodes hold processing references that are semantically sub-borrows of the graph ownership -- the RT thread borrows the graph, then individual processing calls borrow individual nodes. The lifetime system's formal guarantee that sub-borrows are properly restored is what makes the graph ownership model safe. Understanding reborrowing's complexity helps explain why murail's compile-and-swap mechanism must be careful about when and how it transfers graph ownership between threads.

Related to [[rust-lifetimes-model-temporary-ownership-that-returns-to-the-original-owner-on-expiry]], extending it with the specific mechanism for nested (re)borrows.
