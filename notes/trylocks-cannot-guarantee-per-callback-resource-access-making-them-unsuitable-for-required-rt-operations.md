---
description: Trylocks return immediately but cannot guarantee lock acquisition — acceptable for optional operations, but structurally unable to protect resources that must be accessed every callback
type: claim
evidence: strong
source: "[[bencina-2011-real-time-audio-programming-101]]"
created: 2026-03-01
status: active
---

# trylocks cannot guarantee per-callback resource access making them unsuitable for required RT operations

Trylocks (`pthread_mutex_trylock()` on POSIX, `TryEnterCriticalSection()` on Windows) are sometimes proposed as a "safe" alternative to blocking mutexes in RT audio code: instead of blocking until the lock is acquired, they return immediately with a failure code if the lock is held.

**This solves the blocking problem but not the access problem.** For resources that must be accessed every callback, trylocks introduce a different failure mode: if the lock is held by the GUI thread during a callback, the callback simply cannot access the resource at all. Under adversarial scheduling — where another thread continuously holds the lock — the audio callback may never acquire it.

The trylock is only appropriate when:
1. The resource is *optional* for any given callback. Missing access is acceptable — the callback can proceed with stale data or skip the operation.
2. The probability of contention is understood to be low and the consequence of missing access is tolerable.

**The structural issue:** Any state that must be accessed every callback cannot be protected by a trylock. The audio callback either blocks (bad) or skips (also bad if the data is required). Neither option is acceptable for required shared state.

**The correct alternative:** Required shared state between the RT and NRT threads should use lock-free communication — either [[lock-free-queues-are-the-canonical-communication-primitive-between-real-time-and-non-real-time-threads]] for event data or atomic operations for scalar values. Lock-free operations always complete without acquiring a lock, so there is no "failure to acquire" case.

**In practice:** Trylocks might be usable for infrequent optional updates (e.g., updating a parameter display in the GUI, where missing one callback's worth of data is acceptable). They are not a substitute for lock-free communication on the critical path.

## Connections

- [[lock-free-queues-are-the-canonical-communication-primitive-between-real-time-and-non-real-time-threads]] -- the correct alternative to both blocking mutexes and trylocks for required RT/NRT communication
- [[general-purpose-os-scheduler-interactions-from-the-rt-thread-have-hidden-priority-and-blocking-risks]] -- trylocks still interact with the OS scheduler; even a non-blocking trylock call is a scheduler touch point
- [[priority-inversion-blocks-the-rt-thread-behind-a-lower-priority-task-on-general-purpose-oses]] -- trylocks avoid blocking but not the underlying access failure caused by priority inversion dynamics
- [[unbounded-execution-time-is-the-single-root-cause-of-all-audio-glitches-not-just-slowness]] -- trylocks address the blocking (unbounded time) problem but create a new problem: guaranteed access failure under contention
- [[hold-slots-prevent-fast-thread-blocking-on-slow-rate-values-without-locks]] -- murail's hold slots are the architectural answer to this problem: never share mutable state directly; instead maintain separate per-thread copies synchronized via atomic swap
