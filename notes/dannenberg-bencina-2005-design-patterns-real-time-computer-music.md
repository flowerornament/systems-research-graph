---
description: Dannenberg and Bencina's 2005 ICMC workshop paper cataloguing six design patterns for real-time computer music systems
type: source-ref
created: 2026-03-01
---

# dannenberg-bencina-2005-design-patterns-real-time-computer-music

Roger B. Dannenberg and Ross Bencina. "Design Patterns for Real-Time Computer Music Systems." ICMC 2005 Workshop on Real Time Systems Concepts for Computer Music, 4 September 2005.

Six patterns: Static Priority Scheduling, Real-Time Memory Management, Communication and Synchronization with Lock-Free Queues, Accurate Timing with Timestamps, Event Buffers, and Synchronous Dataflow Graph.

The paper predates most of the formal lock-free literature (Fraser 2004 is contemporaneous) and is notable as an applied engineering distillation of RT systems design for practitioners building computer music systems. Many of the patterns here are now well-established practice, but the paper provides authoritative provenance for the pattern names and the specific problem/force/solution framing.

## Claims

- [[thread-count-minimization-reduces-coordination-cost-but-requires-latency-partitioning-to-assign-tasks-to-threads]]
- [[audio-system-os-calls-violate-real-time-constraints-through-unpredictable-lock-acquisition-and-page-faults]]
- [[real-time-safe-memory-strategies-form-a-spectrum-from-up-front-fixed-allocation-to-incremental-gc]]
- [[lock-free-queues-are-the-canonical-communication-primitive-between-real-time-and-non-real-time-threads]]
- [[ideal-time-scheduling-anchors-event-sequences-to-desired-times-rather-than-actual-execution-times]]
- [[pre-computed-event-buffers-with-constant-time-offset-trade-added-latency-for-reduced-jitter]]
- [[caching-ugen-graph-evaluation-order-decouples-topology-modification-from-concurrent-execution]]
