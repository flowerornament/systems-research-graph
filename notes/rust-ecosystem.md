---
description: Crate survey, nightly features, type-driven design, and unsafe boundaries
type: moc
created: 2026-02-27
---

# rust-ecosystem

Rust ecosystem research for murail. Covers crate selection and verification, nightly feature dependencies, type-driven design patterns, unsafe code boundaries, and build system considerations.

## Key Sub-Areas
- Verified crate stack (rtrb, arc-swap, bumpalo, slotmap, cpal, criterion)
- Nightly features (portable_simd, allocator_api, pinning)
- Type-driven design (newtype wrappers, zero-cost abstractions, trait objects)
- Unsafe boundaries (loom testing, miri verification, assert_no_alloc)
- Workspace architecture (9-crate tiered dependency DAG)

## Claims

### Library Design Constraints
- [[library-languages-must-not-bundle-a-mandatory-runtime]] -- using a Go library from C requires importing ~2MB Go runtime; Rust's zero-runtime model is the correct choice for murail as an embeddable library
- [[rust-lacks-interactive-programming-despite-suitable-foundations]] -- Rust's multi-stage compilation could support REPL-style exploration but shipped with batch tooling; affects murail graph compiler DX

### Ownership and Type System Foundations (RustBelt)
- [[rust-ownership-enforces-that-aliasing-and-mutation-cannot-coexist-on-any-location]] -- the core type system invariant: aliasing and mutation cannot coexist; eliminates use-after-free, data races, and iterator invalidation at the type level
- [[rust-lifetimes-model-temporary-ownership-that-returns-to-the-original-owner-on-expiry]] -- lifetimes are ownership with an expiry date; the formal model uses full borrows and inheritances; basis for compile-and-swap safety
- [[reborrowing-is-the-most-technically-subtle-feature-of-rusts-lifetime-system]] -- sub-borrows must provide an inheritance restoring the original borrow; accounts for most complexity in the lifetime logic
- [[send-and-sync-are-thread-independence-of-ownership-and-sharing-predicates]] -- T is Send if ownership predicate is thread-independent; T is Sync if sharing predicate is thread-independent; formal basis for murail's NRT/RT safety
- [[interior-mutability-is-safe-mutation-through-shared-references-enforced-by-controlled-api-surfaces]] -- Cell, Mutex, RefCell permit mutation through shared refs via controlled unsafe APIs; murail depends on Mutex and Arc specifically
- [[mutexguard-lifetime-enforces-lock-release-before-deep-pointers-expire]] -- guard's lifetime ties lock release to scope exit; deep pointers provably expire before the lock drops
- [[unsafe-encapsulation-is-the-foundational-soundness-obligation-for-rust-library-authors]] -- any library using unsafe must satisfy a library-specific verification condition; formal basis for trusting crates in murail's stack
- [[rust-provides-provably-memory-and-data-race-safe-programs-without-garbage-collection]] -- RustBelt's adequacy theorem: no stuck states in any execution; memory safety and data-race freedom proved without GC
- [[rust-safety-with-unsafe-code-requires-semantic-rather-than-syntactic-proof-methods]] -- progress-and-preservation is closed-world; Rust's extensible unsafe approach requires the open-world semantic proof method of logical relations
- [[iris-separation-logic-enables-deriving-a-lifetime-logic-from-primitive-mechanisms]] -- Iris's higher-order ghost state and impredicative invariants suffice to derive the complete lifetime logic as a library

## Source References
- [[rustbelt-2018]] -- primary source for the RustBelt formal verification cluster: Iris-based semantic proof method, ownership/lifetime logic, Send/Sync characterization, and the adequacy theorem establishing memory and data-race safety without GC

## Open Questions
- Are there existing Rust-native interactive exploration tools (evcxr, etc.) that could be adapted for murail graph exploration, or does this require custom tooling?
- Given RustBelt's verification of Mutex and Arc, what additional unsafe crates in murail's stack (rtrb, arc-swap, bumpalo) have comparable formal or bounded-model-checker verification?

---

Topics:
- [[index]]
