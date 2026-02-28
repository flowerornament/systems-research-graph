---
description: A mutable reference borrows ownership for the duration of a lifetime; when the lifetime ends, full ownership reverts to the original owner -- modeled in the lifetime logic as a full borrow with an inheritance
type: property
evidence: strong
source: [[rustbelt-2018]]
created: 2026-02-28
status: active
---

# rust lifetimes model temporary ownership that returns to the original owner on expiry

Standard separation logic assertions represent ownership for an unlimited duration. Rust's mutable references represent something fundamentally different: ownership with an expiry date. When the lifetime of a mutable reference expires, the original owner regains full ownership. This temporal dimension is not captured by standard separation logic.

RustBelt's lifetime logic formalizes this with two key primitives:

**Full borrow** (`&κ_full P`): Represents ownership of resource P for the duration of lifetime κ. During κ, the borrower can access P. After κ ends, P must be returned.

**Inheritance** (`[†κ] ▷ P`): The complement of a full borrow. When lifetime κ ends (evidenced by the dead token [†κ]), the inheritance can be converted into ownership of P. This is how the original owner recovers resources after the lifetime expires.

LftL-borrow is the core rule: it splits ownership of P into a full borrow (usable during κ) and an inheritance (usable after κ). This is *temporal disjointness* -- not spatial disjointness as in standard separation logic, but disjointness in time.

**Lifetime tokens** `[κ]_q` witness that a lifetime is ongoing. They are fractional (can be split) so multiple parties can simultaneously verify the lifetime is alive. The full token `[κ]_1` is required to end the lifetime, ensuring all borrows are closed before ownership is recovered.

The formal model of reborrowing (passing a borrowed reference to another function that creates a shorter sub-borrow) is especially subtle and accounts for most of the complexity in the lifetime logic. A reborrow creates a new shorter lifetime κ' ⊆ κ; after κ' ends, the original borrow at κ is restored.

**Relevance to murail:** This formal model explains exactly why Rust can safely implement compile-and-swap: the audio graph is "borrowed" by the RT processing thread for a lifetime bounded by the processing cycle; when that lifetime ends, the NRT thread recovers graph ownership and can safely swap in a new graph. The type system enforces this is safe.

Related to [[rust-ownership-enforces-that-aliasing-and-mutation-cannot-coexist-on-any-location]], which establishes the static invariant; this claim establishes the dynamic (lifetime-bounded) mechanism for temporarily relaxing exclusive ownership.
