---
description: The essential idea of Rust's type system: at any point in execution, aliasing and mutation cannot coexist on a given memory location, which eliminates use-after-free, data races, and iterator invalidation
type: property
evidence: strong
source: [[rustbelt-2018]]
created: 2026-02-28
status: active
---

# rust ownership enforces that aliasing and mutation cannot coexist on any location

The core safety invariant in Rust's type system is simple to state: for any memory location at any point in execution, you may have *either* multiple aliases (shared references) *or* mutation capability (unique ownership or mutable reference), but never both simultaneously.

This single constraint eliminates a surprisingly broad class of memory safety errors:
- **Use-after-free**: freed memory requires unique ownership; aliased references cannot exist to freed locations
- **Double-free**: uniqueness of owned pointers prevents freeing the same location twice
- **Data races**: races require concurrent write access; the aliasing/mutation exclusion prevents this at the type level
- **Iterator invalidation**: modifying a container while iterating requires mutation under aliasing; this is statically rejected

Rust expresses this through three ownership modes:
1. **Exclusive ownership** (move semantics): one owner, full mutation rights, no aliases
2. **Mutable references** (`&mut T`): temporary exclusive access, mutation permitted, aliasing excluded for the duration
3. **Shared references** (`&T`): aliasing permitted, mutation prohibited (except through interior mutability types with controlled APIs)

The `Copy` bound describes types where shallow copying is safe (integers, `&T`). The `Send`/`Sync` bounds extend this to cross-thread safety.

**Relevance to murail:** murail's NRT/RT thread separation relies on Rust enforcing this invariant at the type level -- the audio graph cannot be mutated (NRT side) while the RT side holds processing references, and the RT side cannot alias graph state during NRT modifications. Rust's ownership system makes these thread-safety properties compile-time guarantees rather than runtime checks.

This claim is the foundational property from which [[unsafe-encapsulation-is-the-foundational-soundness-obligation-for-rust-library-authors]] derives: unsafe code is dangerous precisely because it can violate this invariant; the verification condition requires proving the invariant is restored at the API boundary.
