---
description: Computing events ahead of their ideal delivery time and forwarding them via a higher-priority channel reduces timing variance at the cost of fixed added latency
type: pattern
evidence: strong
source: "[[dannenberg-bencina-2005-design-patterns-real-time-computer-music]]"
created: 2026-03-01
status: active
---

# pre-computed event buffers with constant time offset trade added latency for reduced jitter

Dannenberg and Bencina's "Event Buffers" pattern (also called Action Buffers) addresses a distinct timing problem from [[ideal-time-scheduling-anchors-event-sequences-to-desired-times-rather-than-actual-execution-times]]: what happens when data cannot be computed accurately at the desired delivery time?

**The problem:** Even with ideal-time scheduling, an event may be computed late if the OS fails to wake the computing thread promptly, or if work arrives in bursts. The computed ideal time is preserved, but the *moment of computation* has high variance (jitter). If the output device cannot accept pre-dated events, timing accuracy suffers.

**The solution:** Compute events early and include a timestamp indicating when they should be delivered. The actual delivery time is `ideal_time + constant_offset`, where the offset ensures the event is always in the future relative to when the computing thread runs. Events are buffered and passed to a higher-priority thread (or hardware device) that delivers them at the specified timestamp. The higher-priority thread has less jitter because it has fewer responsibilities.

**The fundamental tradeoff:** Reducing jitter requires adding latency. If events are pre-computed 20ms ahead of delivery, the system has 20ms of added latency but can smooth over 20ms of scheduling jitter. As latency approaches zero, jitter also approaches zero (the limit case: hard real-time with zero scheduling variance). This pattern is only advantageous when the computation time for output data is significant and variable.

**Concrete examples from the paper:** (1) Prefetching a MIDI sequence from disk so it can be output with lower latency than disk reads would otherwise allow. (2) Timestamps on MIDI data delivered to a device driver, which outputs events precisely at the specified time regardless of when the MIDI data was submitted.

**Connection to murail:** The block-based rendering model is a version of this pattern at the sample level. The fast thread pre-computes a block of N samples ahead of their playback time; the audio hardware delivers them at sample-accurate times. The block size N is the constant time offset. This means [[block-size-is-the-primary-latency-throughput-tradeoff-in-murail-execution]] is precisely the latency/jitter tradeoff named here: larger N adds more latency but provides more buffer against scheduling jitter.

## Connections

- [[ideal-time-scheduling-anchors-event-sequences-to-desired-times-rather-than-actual-execution-times]] -- ideal-time scheduling computes the timestamp on the buffer entry; event buffers extend the pattern by forwarding that timestamp to a higher-priority delivery channel
- [[block-size-is-the-primary-latency-throughput-tradeoff-in-murail-execution]] -- block rendering is event buffering at sample granularity; N samples of added latency buys N samples of jitter tolerance; this is the same tradeoff
- [[sample-accurate-triggering-in-block-based-audio-requires-splitting-render-blocks-into-sub-block-execution-lambdas]] -- sub-block splitting is the complementary technique that recovers within-block timing precision after choosing a block size
- [[anira-latency-formula-derives-minimum-required-buffering-from-worst-case-inference-time-and-buffer-size-mismatch]] -- anira's minimum buffer count formula applies this pattern to neural inference: pre-compute inference results ahead of time with enough buffering to absorb inference time variance
- [[thread-count-minimization-reduces-coordination-cost-but-requires-latency-partitioning-to-assign-tasks-to-threads]] -- the higher-priority delivery thread in this pattern is the same thread that static priority scheduling identifies as the low-latency partition
