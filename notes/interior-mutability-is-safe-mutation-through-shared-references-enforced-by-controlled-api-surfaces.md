---
description: Interior mutability types (Cell, Mutex, RefCell) permit mutation through shared references safely by enforcing appropriate restrictions at the API boundary using unsafe code internally
type: pattern
evidence: strong
source: [[rustbelt-2018]]
created: 2026-02-28
status: active
---

# interior mutability is safe mutation through shared references enforced by controlled API surfaces

Rust's ownership rule prohibits mutation through shared references (`&T`). Yet real programs require shared mutable state -- mutual exclusion, reference cells, concurrent communication. Rust resolves this tension through *interior mutability*: types that permit mutation through shared references, but only via controlled APIs that guarantee safety.

The key insight is that mutation through shared references is unsafe *in general* but can be made safe when the right restrictions are enforced:

- **Cell**: restricts mutation to Copy types only, disallows taking references to the interior (preventing deep pointers), and is not Sync (cannot be shared across threads). Result: get/set operations on shared state with no allocation, no synchronization overhead, but single-threaded only.

- **Mutex**: uses atomic operations to enforce mutual exclusion. MutexGuard lifetime ties lock release to scope exit. The full borrow inside the Mutex ensures ownership of the protected data is returned when the guard's lifetime ends -- even if the guard is leaked (the inner full borrow expires on its own terms).

- **RefCell**: provides runtime-checked borrowing (panics instead of compile error on conflict); allows taking references to the interior under dynamic borrow tracking.

RustBelt models interior mutability by giving each type T a *sharing predicate* (separate from the ownership predicate) that specifies what operations are valid on `&T`. For basic types like `i32`, the sharing predicate is read-only. For `Mutex<T>`, the sharing predicate encodes an atomic persistent borrow allowing atomic state transitions on the lock bit.

The formal verification of these types demonstrates that unsafe code in the standard library is indeed safe: each type satisfies its verification condition.

**Relevance to murail:** murail uses `Mutex` and `Arc` (atomic reference counting over interior mutability) as core primitives for NRT/RT graph state management. RustBelt's verification of these types establishes that murail's safety properties -- no data races, no use-after-free in graph node access -- have a formal proof backing, not just informal reasoning.

Extends [[unsafe-encapsulation-is-the-foundational-soundness-obligation-for-rust-library-authors]] with the specific mechanism by which unsafe encapsulation works for the most important class of types.
