---
description: When a low-priority thread holds a lock the audio callback needs, the RT thread blocks behind a task it outranks — and the scheduler makes it worse, not better
type: claim
evidence: strong
source: "[[bencina-2011-real-time-audio-programming-101]]"
created: 2026-03-01
status: active
---

# priority inversion blocks the RT thread behind a lower-priority task on general-purpose OSes

Priority inversion is the specific mechanism that makes mutex use in audio callbacks catastrophic on general-purpose operating systems. The failure scenario:

1. A GUI thread (low priority) acquires a shared mutex to update some data.
2. Before the GUI thread releases the lock, the OS schedules the audio callback (high priority).
3. The audio callback attempts to acquire the same mutex and blocks — even though the callback has higher priority than the GUI thread.
4. The OS then schedules *any other process* on the system ahead of the GUI thread, since the GUI thread has low priority.
5. The audio callback waits for that other process to finish, then waits for the GUI thread to finish, before it can even begin computing its buffer.

The audio thread, despite having the system's highest priority, is effectively blocked behind every other process on the machine. The buffer period expires. The audio glitches.

**The scheduler cannot fix this.** On a general-purpose OS, the scheduler's role is throughput optimization, not deadline enforcement. It has no obligation to detect or resolve priority inversion. Real-time operating systems implement priority inheritance protocols (temporarily elevating the lock-holder's priority to match the highest waiter), but this is not available on stock Windows, macOS, or standard Linux. The Linux RT preempt patch adds POSIX priority inheritance mutexes (`PTHREAD_PRIO_INHERIT`, available since kernel 2.6.18 / glibc 2.5), but relying on this breaks portability.

**Spin locks don't help.** A spin lock that busy-waits polling for the GUI thread to finish has the same problem: if the GUI thread is preempted by another process, the audio thread spins while the other process runs. Busy-waiting also consumes CPU cycles that could be used for audio computation.

**Consequence:** The only correct solution is to use no locks at all in the audio callback. [[lock-free-queues-are-the-canonical-communication-primitive-between-real-time-and-non-real-time-threads]] is the standard response: atomic operations (CAS) have no lock holder to be preempted.

**Murail:** The substrate's prohibition on locks in the fast thread (the resource invariant) is the formal codification of this analysis. [[hold-slots-prevent-fast-thread-blocking-on-slow-rate-values-without-locks]] specifically implements lock-free cross-rate reads because any lock on the slow-rate data would introduce priority inversion risk.

## Connections

- [[unbounded-execution-time-is-the-single-root-cause-of-all-audio-glitches-not-just-slowness]] -- priority inversion is the specific mechanism by which mutex use creates unbounded execution time for the RT thread
- [[lock-free-queues-are-the-canonical-communication-primitive-between-real-time-and-non-real-time-threads]] -- the canonical solution: CAS-based operations have no lock holder, so priority inversion cannot occur
- [[audio-system-os-calls-violate-real-time-constraints-through-unpredictable-lock-acquisition-and-page-faults]] -- the earlier claim covers the same mechanism from the OS-call perspective; this claim provides the full priority inversion mechanism with scheduling detail
- [[hold-slots-prevent-fast-thread-blocking-on-slow-rate-values-without-locks]] -- murail's substrate-level implementation of lock-free cross-rate communication to avoid priority inversion
- [[general-purpose-os-scheduler-interactions-from-the-rt-thread-have-hidden-priority-and-blocking-risks]] -- the broader scheduler paranoia argument; priority inversion is the most acute instance of this general risk
