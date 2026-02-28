---
description: MetaSounds compiles graphs on-the-fly at play time, letting format-agnostic graphs resolve their concrete channel configuration from actual runtime assets rather than requiring static declaration
type: property
evidence: strong
source: [[channel-agnosticism-metasounds-aaron-mcleran-adc]]
created: 2026-02-28
status: active
---

# JIT graph compilation enables context-aware channel format inference at playback time

MetaSounds graphs compile just-in-time: when a sound starts playing, the graph compiles from its definition, and the compilation step can make decisions based on the game context at that moment. This is a powerful property for channel format inference under the CAT system.

A graph can have a wave player node that doesn't know its format at authoring time. At playback, the game feeds actual wave asset references into the meta sound. At compilation, the wave player examines those assets and infers: "these are all stereo variations, so I'll initialize to stereo CAT format." The graph's topology is fixed at compilation; what changes is the concrete format used.

This enables a middle path between:
- **Static declaration**: "this graph is always 7.1" (simple, inflexible)
- **Runtime mutation**: changing format while the graph is running (ruled out as "insane" by McLeran)

JIT compilation allows the format to be determined from real game data -- which wave file is active, which bus is connected, what speaker configuration the platform has -- while still providing format stability within the execution lifetime.

The builder API extends this: procedurally constructed graphs (built at runtime by game code) can also set format explicitly.

For murail: JIT compilation is a mechanism that murail's architecture could exploit for the same kind of context-driven configuration. If graph nodes are parameterized at compile time (not execution time), the "compile" moment becomes a rich configuration window. This connects to [[interactive-programming-eliminates-the-compile-run-cycle]] in an interesting way -- MetaSounds' JIT *is* a form of interactive compilation, but it happens at playback rather than at edit time. The distinction matters for audio systems where mid-execution mutations are unsafe.
