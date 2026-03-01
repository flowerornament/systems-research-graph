---
description: Lock-free queues are the standard solution for exchanging data between RT and NRT threads because OS mutexes have unbounded block times incompatible with RT constraints
type: pattern
evidence: strong
source: "[[dannenberg-bencina-2005-design-patterns-real-time-computer-music]]"
also: "[[bencina-2011-real-time-audio-programming-101]]"
created: 2026-03-01
status: active
---

# lock-free queues are the canonical communication primitive between real-time and non-real-time threads

Dannenberg and Bencina's "Communication and Synchronization with Lock-Free Queues" pattern names the solution that the computer music community had independently converged on by 2005: use lock-free queues as the communication boundary between RT and NRT threads.

The problem is that OS synchronization primitives (mutexes, semaphores) are optimized for high-throughput, not low-latency. On a general-purpose OS, acquiring a mutex involves a syscall that may block the calling thread for arbitrarily long if another thread holds the lock. This is acceptable for NRT threads but fatal for an RT audio callback that has a hard deadline measured in milliseconds.

Lock-free queues solve this by using only atomic operations (CAS) whose execution time is bounded and does not depend on other threads' scheduling state. The RT thread can enqueue or dequeue without ever blocking. The queue must be polled periodically to prevent overflow; a semaphore may be used to signal a waiting NRT thread when the queue has data, but the RT thread never waits on the semaphore.

**Production evidence (2005):** SuperCollider 3, AudioMulch, JSyn, Aura, and PortMIDI all used this pattern independently — convergent practice across five distinct systems. The queue contents varied: data samples, message records, variable-length messages, or pointers.

**Connection to existing graph:** This pattern is the foundational framing for claims that already exist in this graph but were sourced from other papers. [[existing-hardware-cas-primitives-suffice-for-practical-lock-free-data-structures]] (Fraser 2004) provides the formal proof that CAS alone suffices for practical lock-free queues; this paper provides the applied motivation. [[lock-freedom-guarantees-system-wide-progress-but-not-per-operation-progress]] (Fraser) characterizes the precise progress guarantee these queues provide.

**Murail:** The hold slot mechanism ([[hold-slots-prevent-fast-thread-blocking-on-slow-rate-values-without-locks]]) is a specialized form of lock-free communication for continuous parameter values; event queues for sporadic events are the general form named by this pattern. The atomic swap flag for program updates ([[atomic-swap-enables-program-updates-at-tick-granularity-without-output-gaps]]) is a degenerate single-element lock-free queue.

## Connections

- [[existing-hardware-cas-primitives-suffice-for-practical-lock-free-data-structures]] -- Fraser 2004 provides the theoretical foundation: CAS alone is sufficient to build these queues without exotic hardware
- [[lock-freedom-guarantees-system-wide-progress-but-not-per-operation-progress]] -- the progress guarantee these queues provide: some operation always completes, but no per-operation bound; RT thread must account for this
- [[hold-slots-prevent-fast-thread-blocking-on-slow-rate-values-without-locks]] -- murail's hold slots are the continuous-value specialization of lock-free communication; this pattern is the general case
- [[atomic-swap-enables-program-updates-at-tick-granularity-without-output-gaps]] -- the atomic swap flag is a minimal lock-free channel: one writer (NRT compilation), one reader (fast thread), single-element capacity
- [[audio-system-os-calls-violate-real-time-constraints-through-unpredictable-lock-acquisition-and-page-faults]] -- the OS mutex failure modes that this pattern avoids
- [[trylocks-cannot-guarantee-per-callback-resource-access-making-them-unsuitable-for-required-rt-operations]] -- Bencina 2011 identifies trylocks as an inadequate substitute; lock-free queues are the correct alternative because they always complete without lock acquisition
- [[priority-inversion-blocks-the-rt-thread-behind-a-lower-priority-task-on-general-purpose-oses]] -- lock-free queues specifically avoid priority inversion: no lock holder to be preempted by lower-priority work
- [[supercollider-client-server-architecture-moved-the-scripting-language-out-of-the-real-time-audio-thread]] -- SC3's OSC message passing is an application of this pattern: OSC messages are sent via a lock-free queue from the language client to the synthesis server
