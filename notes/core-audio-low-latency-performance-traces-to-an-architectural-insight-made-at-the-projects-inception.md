---
description: McCartney attributes Core Audio's consistent low-latency leadership to a foundational design decision made before he joined, not to incremental engineering effort applied over time
type: claim
evidence: moderate
source: [[2026-02-06-qmayIRViJms]]
created: 2026-02-28
status: active
---

# Core Audio low-latency performance traces to an architectural insight made at the project's inception

McCartney, who worked on Apple Core Audio from 2002 until his retirement ~2022, attributes the platform's consistent dominance in audio latency benchmarks to a design decision made before he joined: "a really brilliant insight into the way that the lowest level should work... to get the timing right with minimum overhead." He declines to characterize what the insight is specifically, but states it was the foundation everything else was built on.

He references an external benchmark ("I think it's the juice people have a table of latencies of different audio systems, and Core Audio and iOS are down in the lower left corner") and attributes the outcome to that foundational architectural choice rather than to the team's engineering effort during his tenure.

The general claim: **audio engine latency performance is determined by foundational architectural choices, not by optimization applied to a working system.** Getting the low-level model right at inception yields a platform that remains competitive for decades; getting it wrong cannot be remedied by optimization alone.

For Murail, the implication is the same as McCartney's lesson about SC1's UGen model: the IR granularity and RT scheduling model chosen at v1 will constrain what latency targets are achievable in v2. Decisions about the audio callback structure, thread model, and memory allocation policy should be treated as architectural invariants, not implementation details. See also [[compile-and-swap-preserves-audio-continuity-during-recompilation]] for a related "foundational choice determines viability" argument about compilation strategy.

The team growth described (10-12 people when McCartney joined in 2002, 200+ by the time he retired) also illustrates that Core Audio's architecture scaled to cover telephony (echo cancellation, codecs), HomePod acoustics, and automotive without architectural replacement -- a sign the foundational model was extensible.
