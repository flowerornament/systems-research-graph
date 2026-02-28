---
description: MutexGuard's lifetime is tied to the mutex's shared reference lifetime, ensuring deep pointers into the guarded data expire before the lock is released -- the compiler enforces this automatically
type: pattern
evidence: strong
source: [[rustbelt-2018]]
created: 2026-02-28
status: active
---

# MutexGuard lifetime enforces lock release before deep pointers expire

Rust's `Mutex<T>` uses a guard type `MutexGuard<'a, T>` where `'a` is the lifetime of the shared mutex reference passed to `lock()`. This lifetime threading has a precise formal purpose: it ensures that any deep pointers obtained from the guard (via `deref_mut`) expire *before* the guard itself is dropped.

The formal semantic of this is captured in the sharing predicate for Mutex in RustBelt:
- The status flag is managed via an atomic persistent borrow (thread-safe state transition)
- The content `T` is wrapped in a *full borrow* at an inner lifetime κ'
- When acquiring the lock, you get the content only under this full borrow at κ'
- When κ' ends (the guard's lifetime expires), the full borrow expires, ownership of the content returns to the Mutex

The inner full borrow is necessary -- not incidental -- because of a subtle case: if the MutexGuard is leaked (its destructor never called), the Mutex must still eventually become fully owned again. The full borrow at κ' handles this: when κ' ends (by the surrounding scope ending, even without the destructor running), the Mutex's invariant is restored. The content's ownership is returned through the inheritance mechanism of the lifetime logic.

**Key consequence:** The compiler guarantees that you cannot hold a mutable reference to the guarded data after the lock is released. This is not just a convention; it is enforced by the lifetime system. Attempting to do so is a compile-time error.

**Relevance to murail:** murail uses Mutex for shared state accessed from both NRT (control) and RT (audio) threads. The MutexGuard lifetime pattern ensures that audio processing code cannot accidentally retain a reference to graph state after the processing lock is released, preventing subtle use-after-release bugs. The formal verification that this invariant holds -- even in edge cases like leaked guards -- is directly relevant to murail's correctness.

Related to [[interior-mutability-is-safe-mutation-through-shared-references-enforced-by-controlled-api-surfaces]], which covers the broader pattern; this claim isolates the specific lifetime mechanism that makes Mutex's lock/unlock protocol safe.
