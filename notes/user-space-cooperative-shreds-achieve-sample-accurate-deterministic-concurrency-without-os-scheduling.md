---
description: ChucK shreds are non-preemptive user-space processes that yield only via the timing mechanism, making execution globally deterministic and synchronization implicit through shared time
type: decision
evidence: strong
source: [[wang-cook-2003-chuck]]
created: 2026-03-01
status: active
---

# user-space cooperative shreds achieve sample-accurate deterministic concurrency without os scheduling

ChucK's shreds are independently scheduled lightweight processes, but they differ from conventional threads in three critical ways that together produce deterministic, sample-accurate concurrent audio programming:

**Non-preemptive.** A shred cannot be preempted by another shred. Unlike kernel-scheduled threads whose interleaving is non-deterministic, a shred runs to its next time-advance point without interruption. This makes each shred locally deterministic and -- because the same is true of all shreds -- the entire set of shreds globally deterministic in their order of execution.

**Yield via timing, not yield().** Shreds do not call `yield()`. They relinquish the processor only when they advance time (`duration => now`) or wait on an event. This means the processor-yield point is the time-advance point: the shred is "shreduled" by ChucK's shreduler, which interacts directly with the audio engine. Two shreds that both advance to the same time point synchronize to that point naturally, without semaphores or condition variables.

**User-level implementation.** The entire ChucK VM runs in user-space. User-level parallelism has lower context-switch overhead than kernel threads (no kernel interaction required), and each shred has minimal state. The user-level shreduler is also directly modifiable to implement real-time scheduling optimizations (Dannenberg 1988) without kernel modifications.

The result is that multiple concurrent streams of audio and control data -- a sine tone generated at sample rate, MIDI messages every 80ms, a sensor poll every minute -- can be expressed as three separate shreds with independent, natural control flow, and their interleaving is fully determined by the timing values in the code, not by OS scheduling decisions.

This extends [[ideal-time-scheduling-anchors-event-sequences-to-desired-times-rather-than-actual-execution-times]] from Dannenberg & Bencina's scheduling pattern to a full language-level model: ChucK's shreduler is an application of ideal-time scheduling, but instead of a library call, it is embedded in the language semantics via `now`. The programmer does not manage a scheduler; the scheduler is the `now` mechanism.

The tradeoff: a hanging shred (one that never advances time) blocks the entire VM. ChucK mitigates this with two mechanisms: (1) the VM can identify the currently running shred when the system hangs, and (2) on-the-fly programming allows the hanging shred to be removed without stopping the VM. See [[live-assimilation-of-shreds-into-a-running-vm-enables-coding-composing-and-performing-as-a-single-activity]].

Shreds are analogous to the "zones" in Dannenberg & Brandt's Aura system (1996): Aura separates synchronous sound objects into asynchronous zones where objects in one zone cannot preempt each other. ChucK extends zones from objects to fully programmable shreds and makes the zone-to-zone preemption mechanism (priority-based sets) explicit in the shred model.

For murail: the shred model is structurally incompatible with murail's compile-and-swap architecture (shreds are running code, not compiled programs), but the determinism guarantee is directly relevant. Murail achieves the same goal -- deterministic audio-time ordering -- via the substrate's tick-boundary precedence requirement ([[tick-boundary-precedence-is-a-substrate-requirement-not-an-implementation-suggestion]]) rather than via cooperative scheduling in the language runtime. The question of whether murail's composition language should expose a shred-like concurrent programming model (vs. a purely graph-based model) is an open design question.

---

Topics:
- [[concurrent-systems]]
- [[audio-dsp]]
- [[language-design]]
