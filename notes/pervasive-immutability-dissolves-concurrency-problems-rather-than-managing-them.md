---
description: Making all data structures immutable with explicit mutable Refs eliminates GC write barriers, makes reference counting sufficient, enables lock-free cross-thread sharing, and makes undo a pointer operation -- all as architectural side effects of one decision
type: claim
evidence: strong
source: [[mccartney-ideas-2026-02-15]]
created: 2026-02-28
status: active
---

# pervasive immutability dissolves concurrency problems rather than managing them

McCartney's new runtime makes almost everything immutable: records, arrays, maps, tuples, lists -- all immutable with structural sharing (HAMTs via the `immer` library). The only mutable things are explicit `Ref` objects protected by mutex. This is not a style preference; McCartney enumerates five architectural consequences that flow from this single decision:

1. **No garbage collector.** Immutability without laziness makes reference cycles impossible (new objects can only reference old objects). Reference counting is sufficient. Zero memory leaks in unit tests.

2. **No GC write barriers.** SuperCollider requires write barriers in every primitive that allocates; forgetting one creates bugs that manifest far from the cause and are very hard to track down. Immutability eliminates this entire class of bug.

3. **Lock-free cross-thread sharing.** Immutable values can be shared across threads without locks. Thread-local scope uses transient (in-place) mutation when unshared and structural sharing when forked.

4. **Cheap undo/versioning.** Every modification creates a new version; undo is saving a pointer to the previous version. Cost is proportional to the change, not the data size.

5. **Fork as pointer copy.** When a thread forks, the child gets a pointer to the current persistent data structure. Both can mutate independently; the shared prefix is shared.

McCartney traces this to a decade of daily SAPF use: explicit mutable references turned out to be rarely needed in practice. He also makes the architectural diagnosis explicit: single-threaded Python (GIL) and single-threaded SuperCollider have the same root cause -- so much mutable state that concurrent access is unmanageable. Immutability dissolves the problem rather than managing it with locks.

**Question for Murail (Stage 9 composition language):** Murail's engine is in Rust, which already has ownership-based memory safety (formally verified by [[rust-provides-provably-memory-and-data-race-safe-programs-without-garbage-collection]]). But the composition language needs its own memory model. Should it follow McCartney's lead (persistent immutable structures with explicit mutable refs) or leverage Rust's ownership system differently? The persistent-structure approach has proven advantages for undo/versioning and concurrency; Rust ownership has proven advantages for zero-overhead performance. These might combine: Rust for the engine, persistent structures for the language runtime's data model.

Related to [[long-running-servers-require-continuity-oriented-programming-models]] -- both address how concurrent systems maintain coherent state over time, with immutability as one path and Erlang-style supervision as another. Extends [[interactive-programming-eliminates-the-compile-run-cycle]] by showing how immutability enables the state-preservation property McCartney desires.
