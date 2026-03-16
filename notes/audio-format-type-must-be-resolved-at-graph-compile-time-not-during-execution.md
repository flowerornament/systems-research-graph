---
description: CAT format is fixed when a MetaSounds graph compiles, not allowed to change mid-execution, preserving graph stability; JIT compilation defers resolution to playback start if needed
type: decision
evidence: strong
source: [[channel-agnosticism-metasounds-aaron-mcleran-adc]]
created: 2026-02-28
status: active
---

# audio format type must be resolved at graph compile time not during execution

A core design decision in MetaSounds' CAT system: the channel format of a running graph cannot change while the graph is executing. If a wave player initially loads a mono file and then a stereo file is substituted, the CAT type cannot silently change format mid-block. McLeran: "We decided that was insane."

The resolution happens at graph initialization (compile time). Three modes:
1. **Static declaration** -- sound designer specifies format a priori: "this is always 7.1"
2. **Compile-time inference** -- format is determined when the graph compiles based on connected assets (wave files, buses). A wave player initializes to the minimal channel type given the wave assets in context.
3. **JIT deferred inference** -- because MetaSounds compiles graphs on the fly at playback time (not ahead-of-time), "compile time" can mean "at the moment you play it." Game data can feed assets into the meta sound, and the graph resolves format at that moment: "this is a bunch of stereo variations, so this wave player initializes to stereo."

The builder API also supports explicit format assignment for procedurally constructed graphs.

The invariant: within a single execution lifetime, format is stable. This preserves the semantic guarantees that make automatic transcoding safe -- nodes downstream of a CAT-typed wire can rely on the format remaining consistent throughout processing.

This connects to [[JIT-graph-compilation-enables-context-aware-channel-format-inference-at-playback-time]] and sits in tension with live-patching approaches like SuperCollider's RT graph mutation. MetaSounds explicitly trades mutability for stability. Contrast with [[long-running-servers-require-continuity-oriented-programming-models]]: where long-running servers need continuity, MetaSounds takes the opposite stance for format state -- stability is preferred over live reconfiguration.
