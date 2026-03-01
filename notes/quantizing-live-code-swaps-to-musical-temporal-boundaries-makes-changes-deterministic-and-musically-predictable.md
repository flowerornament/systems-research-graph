---
description: Sonic Pi's temporal semantics show that code hot-swaps taking effect at the next beat boundary rather than immediately give musicians rhythmic control over when changes become audible
type: claim
evidence: strong
source: [[pl-research-landscape-2026-02-27]]
created: 2026-03-01
status: active
---

# quantizing live code swaps to musical temporal boundaries makes changes deterministic and musically predictable

Sonic Pi (Sam Aaron, Strange Loop 2015) addresses the temporal semantics problem in live-coding: when a musician edits and re-runs code while music is playing, *when* does the change take effect? Taking effect immediately produces glitches if the change arrives mid-phrase or mid-beat. Ignoring the change until a natural boundary is musically sensible but introduces latency that disrupts the direct-manipulation feeling of live coding.

Sonic Pi's solution is deterministic temporal quantization: code changes take effect at the next temporal boundary -- a beat, bar, or phrase, depending on the musician's declared granularity. The runtime runs multiple cooperative fibers in sync with a global clock; each fiber can declare "my changes apply at the next bar." The hot-swap mechanism then queues the new code and activates it at the declared boundary, regardless of when the edit was actually made.

The key insight is that musical time, not wall-clock time, is the semantically meaningful boundary for audio code changes. A change that takes effect at bar 3 is deterministic and reproducible: the musician can predict and compose with it. A change that takes effect 200ms after submission is implementation-dependent and musically meaningless.

For Murail, the compile-swap-retire lifecycle (Section 35) provides the mechanism; Sonic Pi's temporal semantics inform how the swap boundary should be exposed to the user. The atomic swap at tick granularity ([[atomic-swap-enables-program-updates-at-tick-granularity-without-output-gaps]]) is the most precise available boundary. The practical question is whether the composition language should expose coarser musical boundaries (beat, bar, phrase) as a higher-level swap quantization mechanism, making the change-latency experience musically intentional rather than technically incidental.

This extends the live-coding architecture beyond the mechanical question (how to swap) to the musical question (when to swap, in terms the musician finds meaningful). A Murail composition environment that exposes temporal swap semantics would allow a musician to write `@next_bar: update_filter(freq: 1000)` and know with certainty that the filter change will occur at bar boundary, not at some arbitrary point during the current bar.

The formal model's timed command kernel (D69) provides sample-accurate scheduling; Sonic Pi's contribution is the vocabulary for expressing swap timing in musical rather than sample-count terms. Connects to [[typed-holes-allow-incomplete-audio-programs-to-remain-running-by-substituting-silence-rather-than-failing-compilation]] -- both are composition-language-level mechanisms for keeping the audio system alive and predictable during live editing. See [[compile-and-swap-preserves-audio-continuity-during-recompilation]] for the underlying swap mechanism. ChucK's [[live-assimilation-of-shreds-into-a-running-vm-enables-coding-composing-and-performing-as-a-single-activity]] is the immediate-assimilation alternative: changes take effect at the next available scheduling point without musical-boundary quantization, maximizing responsiveness at the cost of potential musical discontinuity.

---

Topics:
- [[audio-dsp]]
- [[language-design]]
- [[developer-experience]]
- [[audio-dsp]]
