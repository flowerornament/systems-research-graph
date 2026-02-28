---
batch: rustbelt-2018
source: /Users/morgan/code/murail/.design/references/papers/rustbelt-2018.pdf
archived: 2026-02-28
claims_created: 10
enrichments: 0
connections_added: 14
topic_maps_updated: 4
existing_claims_updated: 3
---

# Batch Summary: rustbelt-2018

**Source:** Jung, Jourdan, Krebbers, Dreyer. "RustBelt: Securing the Foundations of the Rust Programming Language." POPL 2018.

**Archive:** `/Users/morgan/code/murail/.design/references/papers/archive/rustbelt-2018.pdf`

## Claims Created

1. [[rust-safety-with-unsafe-code-requires-semantic-rather-than-syntactic-proof-methods]] -- open-world extensibility requires logical relations, not progress-and-preservation; semantic approach is itself extensible
2. [[unsafe-encapsulation-is-the-foundational-soundness-obligation-for-rust-library-authors]] -- any library with unsafe must satisfy a library-specific verification condition from its API's semantic interpretation
3. [[rust-ownership-enforces-that-aliasing-and-mutation-cannot-coexist-on-any-location]] -- core type invariant eliminates use-after-free, data races, and iterator invalidation
4. [[rust-lifetimes-model-temporary-ownership-that-returns-to-the-original-owner-on-expiry]] -- full borrows + inheritances model ownership with an expiry date
5. [[interior-mutability-is-safe-mutation-through-shared-references-enforced-by-controlled-api-surfaces]] -- Cell, Mutex, RefCell encapsulate unsafe mutation via controlled APIs; verified by RustBelt
6. [[send-and-sync-are-thread-independence-of-ownership-and-sharing-predicates]] -- formal characterization of T:Send (ownership thread-independent) and T:Sync (sharing thread-independent)
7. [[iris-separation-logic-enables-deriving-a-lifetime-logic-from-primitive-mechanisms]] -- Iris's higher-order ghost state + impredicative invariants suffice to derive the complete lifetime logic
8. [[reborrowing-is-the-most-technically-subtle-feature-of-rusts-lifetime-system]] -- sub-borrows require inheritances restoring the original borrow; source of most complexity
9. [[mutexguard-lifetime-enforces-lock-release-before-deep-pointers-expire]] -- guard lifetime ties lock release to scope exit; deep pointers provably expire first
10. [[rust-provides-provably-memory-and-data-race-safe-programs-without-garbage-collection]] -- adequacy theorem: memory safety and data-race freedom proved without GC; formal foundation of murail RT safety

## Source Reference Created
- [[rustbelt-2018]] (notes/rustbelt-2018.md)

## Existing Claims Updated (Reweave)
- [[evolvability-requires-trading-provability-for-extensibility]] -- added note that RustBelt's semantic method partially dissolves the Sussman tradeoff
- [[type-systems-have-not-empirically-reduced-defect-rates]] -- added connection to rust-provides-provably-memory-and-data-race-safe-programs
- [[pervasive-immutability-dissolves-concurrency-problems-rather-than-managing-them]] -- added formal verification reference

## Topic Maps Updated
- [[rust-ecosystem]] -- added "Ownership and Type System Foundations (RustBelt)" section with 10 claims
- [[formal-methods]] -- added "Rust Formal Foundations (RustBelt)" section with 4 key claims
- [[concurrent-systems]] -- added "Rust Thread Safety -- Formal Foundations (RustBelt)" section with 5 claims
- [[language-design]] -- no changes required (connections covered by other maps)
