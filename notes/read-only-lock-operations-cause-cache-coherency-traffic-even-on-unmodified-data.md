---
description: Acquiring even a read-only lock writes to lock metadata, generating cache coherency traffic on unmodified data and creating a bottleneck at heavily-read structures like tree roots
type: claim
evidence: strong
source: "[[fraser-2004-practical-lock-freedom]]"
created: 2026-02-28
status: active
---

# read-only lock operations cause cache coherency traffic even on unmodified data

A fundamental problem with lock-based synchronization in cache-coherent multiprocessor systems is that lock *operations themselves* generate memory writes, even for read-only critical sections. When a reader acquires a multi-reader lock, the lock's internal state (reader count, queue node) is updated atomically — forcing exclusive cache line ownership. This produces coherency traffic that propagates across all processors sharing that cache line.

Fraser cites Larson and Krishnan's observation that "reducing the frequency of access to shared, fast-changing data items" is critical to prevent cache bouncing from limiting system throughput. Multi-reader locks are intended to allow concurrent reads, but their acquire/release operations create contention between otherwise non-conflicting readers.

This effect is particularly severe at the root of a tree structure: all operations must traverse the root, so even with multi-reader locks, the root node's lock becomes a throughput bottleneck when multiple processors are reading concurrently. Fraser's empirical results show this is often the dominant performance bottleneck for lock-based tree designs.

Lock-free approaches sidestep this by reading shared memory locations directly without acquiring any lock metadata — a pure read never writes anything. Reads can proceed without affecting the cache lines of other readers.

**Implications for murail:** Any parameter node in the audio graph that is read every block by the RT thread but written only occasionally by the NRT thread is subject to this problem if protected by a lock. Lock-free atomic reads (Rust `Relaxed` or `Acquire` ordering) generate no write traffic and are appropriate for the RT read path. See also [[compile-and-swap-preserves-audio-continuity-during-recompilation]] for how murail's graph swap avoids this pattern entirely.
