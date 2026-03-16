---
description: Schedulers that operate on "ideal" wake-up times prevent error accumulation across event sequences even when individual events execute late
type: pattern
evidence: strong
source: "[[dannenberg-bencina-2005-design-patterns-real-time-computer-music]]"
created: 2026-03-01
status: active
---

# ideal-time scheduling anchors event sequences to desired times rather than actual execution times

Dannenberg and Bencina's "Accurate Timing with Timestamps" pattern identifies a subtle error accumulation problem in naive timer-based scheduling:

```
A(); sleep(5); B(); sleep(3); C(); sleep(7); ...
```

Each sleep is relative to when the *previous* task completed. Since tasks take finite time to execute, and the OS does not guarantee sleep returns exactly at the target time, each sleep introduces a small error. These errors accumulate without bound across a long sequence.

**The solution:** The scheduler records the *ideal* time at which each task was supposed to run. When a task wakes up, it operates as though this ideal time is the true current time. Subsequent events are scheduled relative to the ideal time, not the actual wakeup time. If a task schedules itself to repeat every 0.1 seconds, it computes ideal wake-up times 0.1, 0.2, 0.3, ... with zero accumulated error regardless of how late each individual invocation runs.

This guarantees that *long-term* timing is accurate even though individual events may arrive slightly early or late. Momentary CPU overload causes momentary degradation but not permanent drift.

**The slip design choice:** Dannenberg and Bencina note that sometimes it is preferable to let time "slip" when a system falls too far behind. If a system is 200ms behind the ideal schedule, catching up by firing all pending events in rapid succession may be worse than continuing from the current position. The ideal-time scheduler must include a slip policy: when the accumulated delay exceeds a threshold, the scheduler abandons catch-up and advances its ideal clock to the current time.

**Connection to murail:** [[sample-accurate-triggering-in-block-based-audio-requires-splitting-render-blocks-into-sub-block-execution-lambdas]] addresses a related precision problem within a single block: triggers that arrive mid-block. Ideal-time scheduling handles precision across blocks and sessions. The two patterns together form the complete temporal accuracy stack: ideal-time scheduling across blocks, sub-block splitting within blocks.

The claim that this pattern "is closely tied to discrete event simulation" is significant: the entire computer music event scheduling tradition (Music IV, Csound, SC3) descends from the same discrete-event simulation literature.

ChucK's `now` mechanism is this pattern elevated to a language primitive: [[suspending-time-until-explicitly-advanced-gives-deterministic-reproducible-timing-across-machines]] encodes ideal-time scheduling directly in the language semantics by making the programmer's explicitly stated time value the ideal time, with the shreduler computing actual execution around it. Where Dannenberg & Bencina describe ideal-time scheduling as an implementation pattern, ChucK makes it the user-facing programming model itself.

## Connections

- [[sample-accurate-triggering-in-block-based-audio-requires-splitting-render-blocks-into-sub-block-execution-lambdas]] -- within-block timing precision; ideal-time scheduling is the cross-block equivalent
- [[pre-computed-event-buffers-with-constant-time-offset-trade-added-latency-for-reduced-jitter]] -- event buffers extend ideal-time scheduling by pre-computing events ahead of their ideal time and delivering them via a higher-priority channel; the timestamp on the buffer entry is the ideal time
- [[block-size-is-the-primary-latency-throughput-tradeoff-in-murail-execution]] -- block size determines the scheduling granularity; ideal-time scheduling operates at the resolution of individual events within this granularity
- [[the-murail-fast-thread-never-halts-errors-degrade-quality-but-do-not-stop-evaluation]] -- the fast thread's output-continuity axiom is related: even under load, output continues rather than stopping; the ideal-time scheduler's behavior under load (momentary degradation, no permanent drift) is the temporal analog
