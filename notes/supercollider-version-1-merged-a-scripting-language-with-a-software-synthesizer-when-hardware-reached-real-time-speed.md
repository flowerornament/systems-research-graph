---
description: SuperCollider 1 combined McCartney's Pyrite scripting language with Synthomatic software synthesizer on the day Power Mac ran the synth 32x faster than real time
type: claim
evidence: strong
source: [[2026-02-06-qmayIRViJms]]
created: 2026-02-28
status: active
---

# SuperCollider version 1 merged a scripting language with a software synthesizer when hardware reached real-time speed

McCartney had two independent projects before SuperCollider: Pyrite (a Scheme-influenced scripting language with closures, developed as a Max object) and Synthomatic (a software modular synthesizer that generated audio samples for loading into a hardware sampler). In 1994, while using Synthomatic to generate granular sound for a dance performance, compile times were unacceptably slow on his Mac IIci. On the day the first Power Mac shipped, he bought the fastest model, recompiled his code, and found it ran 32 times faster than real time.

The realization was immediate: if the synthesis code runs faster than real time, it can run *as* real time. He took Pyrite and Synthomatic and merged them. The result was SuperCollider version 1: a real-time synthesis scripting language.

This origin narrative establishes that SuperCollider was not designed top-down from a grand architecture but emerged from a hardware discontinuity. The design constraint was "fast enough to be interactive" -- and when that threshold was crossed, the merge was obvious. The same logic applies to Murail's architecture: the binding question for any compilation approach is whether it clears the real-time threshold, not whether it is theoretically elegant.

McCartney had also tried two earlier scripting language experiments before Pyrite: "Xcode" (a C-like scripting language he found insufficiently flexible) and "Script" (a cryptic score language he used with a Nintendo Power Glove for algorithmic live performance with semi-random score trees). Pyrite was the third attempt -- motivated by wanting closures and first-class list operations that neither Xcode nor Script provided.

Contrast with [[eliminating-unit-generators-exposes-synthesis-graphs-to-cross-boundary-compiler-optimization]] -- SC1 assembled a scripting language over pre-written synth code; McCartney's new system eliminates that assembly boundary entirely, making UGens library functions over four primitive node types.

The published record of SC1's architecture is [[mccartney-1996-supercollider-icmc]], which documents the signal-buffer amortization mechanism, closure-based UGens, RT GC, and the composition/synthesis integration argument from the primary source.
