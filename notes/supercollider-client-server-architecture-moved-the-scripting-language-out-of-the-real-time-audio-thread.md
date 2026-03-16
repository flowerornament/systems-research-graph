---
description: SC3's client-server split was motivated by language-execution pauses in the RT thread; the server model also enabled remote playback as a side effect
type: claim
evidence: strong
source: [[2026-02-06-qmayIRViJms]]
created: 2026-02-28
status: active
---

# SuperCollider client-server architecture moved the scripting language out of the real-time audio thread

SuperCollider versions 1 and 2 ran the scripting language in the real-time audio thread. The scripting language caused pauses -- garbage collection, allocation, or other non-deterministic execution would interrupt the audio callback. SC3's client-server architecture (sclang + scsynth as separate processes) was the solution: the language runs in a non-RT client process and sends OSC messages to the synthesis server, which runs the RT-safe audio loop.

McCartney describes this as "sort of an experiment" that he "just pushed out." The architecture was not derived from first principles but from a specific felt friction: language pauses in RT caused audio glitches. Moving the language to a separate process eliminated the coupling between language execution and audio deadline pressure.

The remote playback capability (putting the server on a different machine over a network) emerged as a secondary benefit of the separation, not as a primary design goal.

This history is relevant to Murail's design: Murail's scripting language (if any) faces the same constraint. Any non-RT-safe execution (Rust's allocator, complex data structure traversal, JIT compilation) must be isolated from the audio callback. The client-server separation is one solution; another is Murail's compile-and-swap model, which compiles the graph in a background thread and swaps atomically. See [[compile-and-swap-preserves-audio-continuity-during-recompilation]]. The same constraint resurfaces for neural inference: [[inference-engines-violate-real-time-principles-on-every-inference-not-just-initial-ones]] shows with RadSan evidence that all major inference engines (LibTorch, TFLite, ONNX Runtime) perform allocations and mutex operations on every inference call — confirming that the "non-RT code in RT context" problem SC3 solved architecturally in 2001 remains unsolved at the library level in 2024.

SC2 was an intermediate version using a Smalltalk-inspired language with Ruby-like syntax, still without client-server separation. See [[supercollider-version-2-used-a-smalltalk-inspired-language-without-client-server-separation]].

The client-server split also solved the GC problem: SC1's RT incremental GC (which [[real-time-incremental-garbage-collection-eliminates-static-voice-count-limits-in-synthesis-engines]] describes as enabling dynamic voice instantiation) moved to the client process; scsynth uses fixed allocation. The split trades dynamic flexibility for deterministic RT behavior.

Directly enriches the historical context of [[compile-and-swap-preserves-audio-continuity-during-recompilation]], which documents the C-emit pipeline McCartney tried before the client-server model but does not explain why the client-server model itself was introduced.
