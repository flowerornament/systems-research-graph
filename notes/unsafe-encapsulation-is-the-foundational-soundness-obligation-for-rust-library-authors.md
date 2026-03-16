---
description: Any Rust library using unsafe code internally must satisfy a library-specific verification condition -- that the unsafe is genuinely encapsulated behind the exported safe API
type: property
evidence: strong
source: [[rustbelt-2018]]
created: 2026-02-28
status: active
---

# unsafe encapsulation is the foundational soundness obligation for Rust library authors

Rust's extensible ownership discipline depends on a critical invariant: libraries that use unsafe code internally export APIs that are observably safe. This is not enforced by the compiler -- it is an obligation that library authors must satisfy, and one that has historically been violated (the Leakpocalypse bug, Jung 2017's MutexGuard soundness bug).

RustBelt formalizes exactly what this obligation means: For each library exporting a type T with unsafe internals, the library must satisfy a *library-specific verification condition* derived from the semantic interpretation of T's interface. This verification condition specifies:
- The **ownership predicate**: what it means to own a value of type T
- The **sharing predicate**: what it means to have a shared reference to T (this is where interior mutability is modeled)
- For each exported function: that the implementation satisfies the semantic interpretation of its declared type

When a library satisfies its verification condition, RustBelt's fundamental theorem guarantees that any well-typed program using only that library is safe to execute -- even though the library uses unsafe code internally.

This is the formal basis for why Rust's ecosystem of unsafe crates (like Arc, Mutex, and the many crates murail relies on) can be trusted: their safety is a proof obligation, not an assumption, and RustBelt has discharged that obligation for the standard library primitives.

**Practical consequence:** Soundness bugs in unsafe Rust are not random -- they are failures to satisfy this formal verification condition. The Leakpocalypse bug (interaction of scoped threads and reference cycles) was subtle because it involved an *interaction* between multiple libraries each satisfying their individual conditions but failing in combination. RustBelt's extensible framework can detect this class of bug because verification conditions for each library must compose.

Related to [[rust-safety-with-unsafe-code-requires-semantic-rather-than-syntactic-proof-methods]], which establishes why semantic methods are needed; this claim specifies the exact obligation those methods impose.
