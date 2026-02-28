---
description: Synthesis, signal processing, UGen design, and buffer management research
type: moc
created: 2026-02-27
---

# audio-dsp

Core audio DSP research for murail's graph engine. Covers synthesis algorithms, signal processing pipelines, UGen trait design, buffer management strategies, and sample-accurate timing.

## Key Sub-Areas
- Synthesis algorithms (FM, physical modeling, Karplus-Strong, wavetable)
- Signal flow and routing (planar buffers, SIMD alignment, channel layouts)
- UGen design patterns (trait-based dispatch, state management, parameter control)
- Sample rate and block size handling (sub-block splitting, rate adaptation)
- Latency compensation and scheduling

## Claims

### Block-Based DSP and Sample-Accurate Timing
- [[sample-accurate-triggering-in-block-based-audio-requires-splitting-render-blocks-into-sub-block-execution-lambdas]] -- servicing triggers that arrive mid-block requires splitting the render block into pre-trigger and post-trigger execution lambdas; SIMD alignment complications follow from non-modulo segment sizes

### Channel Format Architecture
- [[channel-format-metadata-encapsulation-enables-audio-graph-reuse-across-channel-configurations]] -- bundling audio buffers with spatial format metadata (family type, channel positions) into a typed abstraction lets one graph wire serve mono through Atmos
- [[channel-agnostic-audio-types-require-three-polymorphic-subtypes-to-cover-all-known-and-future-formats]] -- discrete (speaker-assigned), sound field (ambisonics), and composite (hybrid/custom) cover all known spatial audio formats while leaving an escape hatch for future ones
- [[compatible-audio-format-transcoding-happens-automatically-while-cross-family-conversion-requires-an-explicit-cast]] -- within-family format negotiation (5.1 to stereo) is automatic; cross-family conversion (discrete to ambisonics) requires an explicit cast node with configured policy
- [[audio-format-type-must-be-resolved-at-graph-compile-time-not-during-execution]] -- format is fixed at compile/initialization time to preserve graph stability; mid-execution format mutation is unsafe for block-based audio systems

## Open Questions
(populated as gaps are identified)

---

Topics:
- [[index]]
