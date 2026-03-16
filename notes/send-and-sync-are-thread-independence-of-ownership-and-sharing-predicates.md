---
description: T is Send if its ownership predicate does not depend on thread ID; T is Sync if its sharing predicate does not depend on thread ID -- a simple formal characterization of Rust's thread-safety bounds
type: property
evidence: strong
source: [[rustbelt-2018]]
created: 2026-02-28
status: active
---

# Send and Sync are thread-independence of ownership and sharing predicates

Rust's `Send` and `Sync` marker traits enforce thread safety, but their meaning is subtle. RustBelt gives a clean semantic characterization:

**Send**: A type T is Send if `⟦T⟧.own(t, v)` does not depend on the thread identifier `t`. In other words: if ownership of a value of type T is thread-independent, then transferring that value between threads is safe -- the new thread's ownership is identical to the old thread's.

**Sync**: A type T is Sync if `⟦T⟧.shr(κ, t, ℓ)` does not depend on the thread identifier `t`. Equivalently, `&T` is Send if and only if T is Sync. A type is Sync if it is safe to have shared references to the same instance from multiple threads simultaneously.

This characterization explains the standard examples clearly:
- `Vec<i32>` is Send: moving a vector to another thread transfers exclusive ownership; the new owner's rights are identical to the old owner's
- `Vec<i32>` is Sync: shared references to it only permit reading; multiple threads reading is safe
- `Cell<i32>` is *not* Sync: Cell's sharing predicate uses non-atomic persistent borrows parameterized by thread ID; only one thread can hold the NA token for a given thread at a time
- `Mutex<T: Send>` is both Send and Sync: if the protected type T is Send, the Mutex's sharing predicate (using atomic borrows) is thread-independent

The model parameterizes both ownership and sharing predicates by thread identifier from the start. This makes Send/Sync fall out naturally from the semantics rather than requiring special treatment.

**Relevance to murail:** murail's architecture critically depends on Send/Sync for safe NRT/RT thread communication. Specifically:
- Audio processing nodes must be Send (moved to the RT thread during graph compilation)
- Shared graph state must be Sync (simultaneously observable from multiple observer threads)
- Lock-free queue types (rtrb) must be Send for the sender/receiver split

RustBelt's formal characterization confirms that murail's type-level thread-safety requirements are not conventions but proven properties. Related to [[rust-ownership-enforces-that-aliasing-and-mutation-cannot-coexist-on-any-location]], which establishes the single-thread aliasing/mutation invariant; Send/Sync extend that invariant across threads. A concrete architectural instance: [[static-thread-pool-decouples-neural-inference-from-the-audio-callback-to-ensure-real-time-safety]] shows the Send requirement in action — inference work objects submitted to the background thread pool must satisfy Send for the compiler to guarantee the handoff is race-free.
