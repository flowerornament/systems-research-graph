---
description: RustBelt's adequacy theorem proves that any semantically well-typed Rust program will never perform invalid memory accesses and will not have data races -- achieved without a garbage collector
type: property
evidence: strong
source: [[rustbelt-2018]]
created: 2026-02-28
status: active
---

# Rust provides provably memory and data-race safe programs without garbage collection

Theorem 7.2 (Adequacy) in RustBelt states: any semantically well-typed λRust program, when executed, will not reach a stuck state in any execution. This implies:
- No invalid memory accesses (use-after-free, double-free, out-of-bounds)
- No data races (two concurrent accesses to the same location where at least one is a write and at least one is non-atomic)

This is the formal guarantee that Rust's informal marketing claim -- "memory safe and data-race free without a GC" -- is actually true for a realistic language model including unsafe code in standard library types.

The "without a garbage collector" part is significant for real-time audio: GCs introduce stop-the-world pauses that are incompatible with audio real-time requirements. Rust achieves GC-free memory safety through:
1. **Ownership** for deterministic RAII deallocation at scope exit
2. **Reference counting** (Arc/Rc) for shared ownership when needed -- with provably correct cycle prevention in common patterns
3. **Borrowing** for temporary access without ownership transfer

The adequacy theorem is not just about the type system -- it explicitly extends to programs mixing safe code with unsafe library implementations that satisfy their verification conditions. The proof handles the full λRust memory model (pointer arithmetic, non-atomic and sequentially-consistent atomic accesses).

**Relevance to murail:** This is the formal foundation of murail's core safety claim. murail targets real-time audio, which absolutely requires no GC pauses and no data races. Rust's formal proofs establish that Rust's ownership model provides these guarantees not just conventionally but provably -- including through the Mutex and Arc primitives that murail uses for NRT/RT coordination.

This claim stands in interesting tension with [[type-systems-have-not-empirically-reduced-defect-rates]], which notes types don't reduce general defect rates -- but Rusher explicitly carves out memory safety as the exception. Rust's formal proofs vindicate exactly that exception: memory safety and data-race freedom are the properties that receive formal guarantees, consistent with Rusher's observation that this is where type systems do provide meaningful safety properties.
