---
description: Progress-and-preservation is a closed-world syntactic method that cannot account for Rust's extensible open-world approach of safe APIs built on unsafe internals
type: property
evidence: strong
source: [[rustbelt-2018]]
created: 2026-02-28
status: active
---

# rust safety with unsafe code requires semantic rather than syntactic proof methods

The standard technique for proving safety properties -- Wright and Felleisen's "progress and preservation" -- assumes a closed, fixed set of typing rules. This is incompatible with Rust's design, which intentionally leaves the type system open for extension through library-defined unsafe code that exports safe APIs.

Rust's extensible approach is fundamentally open-world: new safe types can be introduced at any time by writing a library that uses unsafe internally and exports a well-typed interface. Progress and preservation cannot be applied here because it cannot account for code that is syntactically outside the type system's rules but is observably safe to use.

The RustBelt solution is a semantic proof method: build a logical relation interpreting types as predicates in Iris (a higher-order concurrent separation logic). Types are modeled not by what syntactic rules allow, but by what is *observably safe* -- whether a term can be safely treated as having a given type, even if it uses unsafe features internally.

The semantic approach is strictly more powerful than the syntactic approach because:
1. It provides a verification condition for any new library using unsafe code (extensibility)
2. It allows gluing together syntactically-typed code with semantically-typed library components
3. The adequacy theorem relates the logical relation to actual program behavior (memory safety, data-race freedom)

**Relevance to murail:** murail uses Rust's type system to enforce NRT/RT thread separation and safe concurrent access to audio graph state. This claim establishes that these type-level guarantees have a formal semantic grounding -- not just a syntactic convention but a proven property. The unsafe internals of Mutex and Arc (which murail relies on) are among the specific libraries verified by RustBelt.

This claim extends [[evolvability-requires-trading-provability-for-extensibility]] by showing Rust found a third path: an extensible type system with an *extensible* proof method -- extensibility and verifiability are not necessarily in conflict when the proof method is semantic.
