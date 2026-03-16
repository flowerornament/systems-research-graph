---
description: Most production software runs as long-lived servers or GUIs with complex event-driven state, not as input-output transformers; the compile-run model was designed for the latter and fails the former
type: claim
evidence: strong
source: [[stop-writing-dead-programs-jack-rusher-2022]]
created: 2026-02-28
status: active
---

# long-running servers require continuity-oriented programming models

Rusher's taxonomy of programs we actually write: mostly long-lived servers (uptime of thousands of days) and GUI programs with complex input (keyboard, mouse, network, camera, microphone simultaneously). These do not match the input-output transformer model that batch processing was designed for.

The compile-run cycle works only for programs that (1) start from blank state, (2) run to termination. Servers violate (1) continuously -- they accumulate state over time. GUIs violate both -- they never terminate cleanly and their state is driven by external events.

Consequence: a programming model optimized for batch transformation (linear execution, blank-state startup, no runtime introspection) inflicts maximal impedance mismatch on the programs that matter most. Rusher's server with 1000-day uptime is not a pathological case -- it is the normal case for production infrastructure.

For [[concurrent-systems]] in murail: the audio engine is the most extreme version of this pattern. It is a long-lived server (runs for the lifetime of a performance or recording session), driven by external event streams (control signals, MIDI, OSC), with accumulated state (oscillator phases, filter memories, reverb tails) that must not be reset. The compile-and-swap architecture is a partial solution: it allows the graph structure to change while preserving the running audio state. But full continuity requires node-level state threading, where replacing a node carries its state into the replacement.

Connects to [[batch-processing-incurs-avoidable-cognitive-overhead]] (the model that fails here) and [[erlang-actor-model-enables-safe-process-kill]] (Erlang's model is designed for exactly this scenario).
