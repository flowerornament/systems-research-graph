---
description: Making the top-level scope thread-local and copying it by pointer on thread fork gives each thread an isolated mutable namespace without a global interpreter lock or an explicit actor/message-passing runtime
type: pattern
evidence: moderate
source: [[mccartney-ideas-2026-02-15]]
created: 2026-02-28
status: active
---

# thread-local top-level scope with copy-on-fork achieves actor isolation without message passing

SuperCollider and CPython both use a global interpreter lock (GIL) because they have global mutable state (class libraries, garbage collector, object state) that cannot be safely accessed concurrently. McCartney's solution is architectural rather than lock-based: eliminate global state entirely.

The mechanism: the top-level scope (all global variable definitions) is stored in a persistent dictionary -- the same HAMT-based structure used for all other immutable data. This scope is thread-local. When a new thread is forked, the child gets a pointer copy of the parent's current scope dictionary. Both can then modify their scopes independently via path-copying (structural sharing with the old state). No global namespace exists; no thread can observe another thread's scope mutations.

McCartney frames this as similar to actor-model languages: "In actor-model languages like Erlang, every actor only knows what it was started with and what it's been passed as values. The same thing happens with this language." But unlike Erlang, there is no message-passing infrastructure, no mailbox, no scheduler for actor selection. OS threads are created directly; the isolation is a consequence of data structure choice, not of runtime architecture.

The efficiency point: because the scope is a persistent data structure, the fork is a pointer copy -- O(1) regardless of scope size. The new thread shares the parent's old scope state for free; divergence from that point incurs only path-copying costs proportional to the changes made, not to total scope size. The scope is also writable in place when unshared (using transient operations from the immer C++ library or Clojure-style transients), so the common single-threaded case has no overhead.

McCartney's explicit summary: "There's no interpreter thread because every thread is an interpreter thread. And there's no global variable, so there's no global state really."

**Implications for Murail Stage 9:** A composition language for Murail could use this pattern for safe multi-threaded composition without an actor runtime. Crucially, this pattern gives Murail control over thread isolation without depending on Rust's Send/Sync system at the language-runtime level -- the persistent data structure handles isolation structurally. However, mutable references to shared audio graph nodes still need the Ref/mutex pattern for thread-safe shared state.

This pattern builds on [[pervasive-immutability-dissolves-concurrency-problems-rather-than-managing-them]], which describes the general immutability strategy. The thread-local scope with copy-on-fork is the specific implementation mechanism for the "mutable state, don't share it" branch of safe concurrency. Compare [[erlang-actor-model-enables-safe-process-kill]], which achieves isolation through explicit message passing and supervision rather than data structure sharing.
