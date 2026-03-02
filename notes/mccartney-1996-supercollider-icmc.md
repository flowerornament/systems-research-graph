---
description: McCartney's 1996 ICMC paper introducing SuperCollider: real-time synthesis language on Power Mac with GC, closures-as-UGens, and algorithmic composition integration
type: claim
source: https://www.audiosynth.com/icmc96paper.html
created: 2026-03-01
status: active
---

# mccartney-1996-supercollider-icmc

Source reference for "SuperCollider: A New Real Time Synthesis Language," James McCartney, International Computer Music Conference (ICMC), 1996.

Primary source: `/Users/morgan/code/systems-research-graph/inbox/archive/mccartney-1996-supercollider-icmc/mccartney-1996-supercollider-icmc.md`

## Key Topics

- High-level language for RT audio synthesis: dynamic typing, closures, garbage collection, lists on Power Macintosh without additional hardware
- Signal buffer as a type: amortizing interpreter cost over many samples rather than per-sample evaluation
- Closures as UGen implementation primitive: environment holds oscillator phase and filter delay state; UGen creation is a function call that captures state into a closure
- Real-time incremental GC (citing Wilson 1992): enables dynamic voice instantiation; no static voice count required; voice stealing provided as an option, not a necessity
- Algorithmic composition + synthesis in the same language: especially beneficial for granular synthesis; list-processing library for musical data
- Synthesis function specialization by input rate: single algorithm implemented in 12 variants (Aoscilia oscillator) based on whether inputs are audio-rate, control-rate, or static
- Origin: Synth-O-Matic (1990, non-RT C-like synthesis language, abandoned), combined with Pyrite interpreter (MAX object with the language extended for SC)
- The C-emit variant: this paper is the ICMC presentation of the C-generating pipeline that McCartney later abandoned due to 45-second compile times

## Claims Extracted

- [[signal-buffers-as-a-type-amortize-interpreter-overhead-making-high-level-languages-viable-for-real-time-dsp]]
- [[closures-encapsulate-unit-generator-state-making-ugen-creation-a-function-call-not-a-class-definition]]
- [[real-time-incremental-garbage-collection-eliminates-static-voice-count-limits-in-synthesis-engines]]
- [[scripting-and-synthesis-in-the-same-language-eliminates-the-boundary-between-composition-and-sound-design]]
- [[synthesis-function-specialization-by-input-rate-multiplies-performance-without-multiplying-algorithm-complexity]]

## Cross-Referenced In

- [[supercollider-version-1-merged-a-scripting-language-with-a-software-synthesizer-when-hardware-reached-real-time-speed]] -- SC1 origin history; this paper is the primary published source for SC1 architecture
- [[compile-and-swap-preserves-audio-continuity-during-recompilation]] -- references the ICMC C-emit paper as the abandoned approach that preceded SC3; this file is that paper
- [[mccartney-language-design]] -- topic map covering McCartney's full language design trajectory from SC1 to tau5
