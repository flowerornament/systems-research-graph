---
description: Beyond mutexes, any OS synchronization call from the RT thread interacts with an implementation-defined scheduler that may block or deschedule the thread in non-obvious ways
type: claim
evidence: moderate
source: "[[bencina-2011-real-time-audio-programming-101]]"
created: 2026-03-01
status: active
---

# general-purpose OS scheduler interactions from the RT thread have hidden priority and blocking risks

Bencina's "justified scheduler paranoia" argument extends the no-mutex rule to any OS synchronization call. The reasoning: general-purpose OS schedulers are complex, proprietary, and not certified for real-time behavior. Their implementations change between OS versions. No scheduler provides documented real-time guarantees.

**Specific risks beyond mutexes:**

- **Condition variables / semaphores (signaling from RT thread):** Some pthreads implementations internally use a mutex to provide correct POSIX semantics. Signaling a condition variable from the RT thread may acquire an internal lock with all the priority inversion risks of explicit mutex use. As of Bencina's writing, the pthreads condition variable implementation on Windows used an internal mutex. This is not documented in the API contract.

- **Spin locks / busy-wait polling:** A spin lock that polls for a flag set by another thread is not merely inefficient. If the thread being polled has lower priority and is preempted by any other process, the audio thread spins without making progress while burning CPU cycles. The effective result is the same as blocking.

- **OS priority changes:** Any scheduler call gives the OS an opportunity to exercise scheduling decisions. On a non-RT OS, "giving the scheduler a reason to think about you" is risky — it may not schedule you back for longer than anticipated.

**The safe boundary:** The RT thread should assume that the only valid scheduler interaction is the initial invocation of the callback itself. Beyond that, every synchronization primitive is suspect unless it has documented non-blocking real-time semantics on all target platforms. The only exceptions Bencina trusts for time queries are `QueryPerformanceCounter()` (Windows) and `mach_absolute_time()` (macOS) — and he notes he is not 100% confident of even these.

**Portability constraint:** Priority inheritance mutexes (`PTHREAD_PRIO_INHERIT`) are available on Linux (since kernel 2.6.18) but not on Windows or macOS. Relying on OS-specific RT extensions breaks portability. Portable RT audio code must work on all three platforms.

**The conservative stance** Bencina advocates: avoid all OS synchronization functions in the audio callback. Use lock-free communication exclusively. This is the same conclusion as [[lock-free-queues-are-the-canonical-communication-primitive-between-real-time-and-non-real-time-threads]] but reached from the scheduler paranoia direction rather than the data structure direction.

## Connections

- [[priority-inversion-blocks-the-rt-thread-behind-a-lower-priority-task-on-general-purpose-oses]] -- priority inversion is the most acute instance of this general risk; scheduler interactions make the inversion worse by giving the OS reasons to further deprioritize the lock holder
- [[unbounded-execution-time-is-the-single-root-cause-of-all-audio-glitches-not-just-slowness]] -- scheduler interactions are another source of unbounded execution time: the scheduler may not return to the audio thread for an indeterminate time after any synchronization call
- [[lock-free-queues-are-the-canonical-communication-primitive-between-real-time-and-non-real-time-threads]] -- the solution: CAS-based operations do not interact with the scheduler; the RT thread never yields or blocks
- [[trylocks-cannot-guarantee-per-callback-resource-access-making-them-unsuitable-for-required-rt-operations]] -- trylocks are sometimes proposed as a "safe" alternative, but they still interact with the scheduler and cannot guarantee acquisition
- [[audio-system-os-calls-violate-real-time-constraints-through-unpredictable-lock-acquisition-and-page-faults]] -- related: OS API calls generally are suspect; this claim extends that to all scheduler interactions specifically
