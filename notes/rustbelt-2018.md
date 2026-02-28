---
description: Jung, Jourdan, Krebbers, Dreyer (2018) -- first machine-checked safety proof for a realistic Rust subset using Iris separation logic
type: source
created: 2026-02-28
---

# rustbelt-2018

Jung, Jourdan, Krebbers, Dreyer. "RustBelt: Securing the Foundations of the Rust Programming Language." POPL 2018.

**Summary:** First formal (machine-checked in Coq) safety proof for λRust, a continuation-passing style language formalizing the core of Rust including borrowing, lifetimes, and interior mutability. Uses the Iris concurrent separation logic framework to build a semantic (logical relations) model of types that can verify that unsafe library implementations safely encapsulate their unsafety behind well-typed APIs.

**Key contributions:**
- λRust: formal language formalizing Rust's ownership, borrowing, lifetimes, and interior mutability
- Lifetime logic: a library in Iris modeling full borrows, fractured borrows, lifetime tokens, and lifetime inclusion
- Semantic type soundness (not syntactic): types modeled as Iris predicates, enabling open-world extensibility
- Verified safety of: Arc, Rc, Cell, RefCell, Mutex, RwLock, mem::swap, thread::spawn, rayon::join, take_mut
- Send/Sync modeled as thread-independence of ownership/sharing predicates

**Relevance to murail:**
- Formal foundations for Rust's ownership and lifetime system that murail's safety guarantees rely on
- Interior mutability types (Mutex, RwLock) are exactly the concurrency primitives murail uses for NRT/RT communication
- Send/Sync bounds as the type-level mechanism enforcing thread safety -- murail's architecture depends on these
- The paper demonstrates Rust's type system provides provable memory and data-race safety, even through unsafe library abstractions

---

Topics:
- [[rust-ecosystem]]
- [[formal-methods]]
- [[concurrent-systems]]
