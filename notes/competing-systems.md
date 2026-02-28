---
description: Architecture analysis of SuperCollider, Faust, Web Audio, JUCE, NIH-plug, Firewheel, HexoDSP
type: moc
created: 2026-02-27
---

# competing-systems

Competitive analysis for murail. Detailed architecture comparison with existing audio systems, their trade-offs, and where murail diverges.

## Key Sub-Areas
- SuperCollider (group tree, RT graph mutation, OSC protocol, SynthDef compilation)
- Faust (functional DSP, AOT compilation, static graphs, algebraic semantics)
- Web Audio API (AudioWorklet, browser constraints, channel semantics)
- JUCE (plugin framework, parameter management, commercial ecosystem)
- NIH-plug (Rust plugin framework, modern CLAP/VST3)
- Firewheel (Rust audio graph, compile-and-swap precedent)
- HexoDSP / FunDSP (Rust DSP libraries, alternative graph approaches)
- Hadron (Rust SC reimplementation)
- MetaSounds / Unreal Engine (JIT compilation, instanced graphs, CAT channel types, enforced interfaces)

## Claims
(populated by /extract from .design/references/competing-systems.md and sc-internals.md)

### Interactive Programming Comparison
- [[batch-processing-incurs-avoidable-cognitive-overhead]] -- SuperCollider, Faust, and JUCE are all compile-run systems; evaluating murail against the interactive programming ideal reveals the gap all audio systems share
- [[static-languages-prevent-runtime-introspection]] -- Faust's AOT compilation and SuperCollider's SynthDef compilation both produce static artifacts; neither supports runtime query of running graph state
- [[visual-representation-exposes-structure-text-notation-obscures]] -- SuperCollider has a graphical node editor alongside its text notation; murail's DSL will face the same cyclic-graph-in-linear-text tension

### MetaSounds Architecture (Epic Games / Unreal Engine)
- [[metasounds-instanced-graph-model-requires-compositional-thinking-rather-than-singleton-patch-design]] -- hundreds of MetaSound instances run simultaneously; graphs are reusable templates, not singleton patches, requiring a different design vocabulary than Max MSP
- [[JIT-graph-compilation-enables-context-aware-channel-format-inference-at-playback-time]] -- MetaSounds compiles graphs on-the-fly at play time, enabling format resolution from actual runtime asset data rather than requiring static declarations
- [[enforced-data-interfaces-enable-plug-and-play-interoperability-between-independently-authored-audio-subsystems]] -- typed interface contracts let gameplay systems specify audio requirements and accept any conforming MetaSound without coupling to its internals
- [[audio-format-type-must-be-resolved-at-graph-compile-time-not-during-execution]] -- MetaSounds explicitly trades runtime format mutability for graph stability; format is fixed at compile time, contrasting with SuperCollider's RT graph mutation model

### Channel Format Comparison (MetaSounds vs Max MSP)
- [[mono-buffer-assumption-locks-audio-graph-topology-to-a-specific-channel-configuration]] -- MetaSounds' original mono-only design (and Max MSP's default) forces sound designers to maintain per-channel-config graph variants; the topology becomes the format
- [[max-MSP-mc-signal-bundles-lack-format-metadata-making-them-unsuitable-for-plug-and-play-graph-interoperability]] -- Max 8 MC bundles group channels without semantic metadata; useful in single-author contexts but insufficient for cross-system interoperability
- [[channel-format-metadata-encapsulation-enables-audio-graph-reuse-across-channel-configurations]] -- CAT types (MetaSounds) bundle audio with format metadata, enabling one graph to serve mono, 5.1, Atmos without structural changes
- [[channel-agnostic-audio-types-require-three-polymorphic-subtypes-to-cover-all-known-and-future-formats]] -- MetaSounds CAT uses discrete/sound-field/composite families as a comprehensive taxonomy that also accommodates unknown future formats
- [[compatible-audio-format-transcoding-happens-automatically-while-cross-family-conversion-requires-an-explicit-cast]] -- within-family downmix/upmix is automatic; cross-family conversion (discrete to ambisonics) requires an explicit cast node

### McCartney's New Audio Language (SuperCollider author, 2021-2025)
- [[eliminating-unit-generators-exposes-synthesis-graphs-to-cross-boundary-compiler-optimization]] -- flattening UGens to four arithmetic primitives lets the compiler fuse, vectorize, and dead-code-eliminate across what were previously opaque object boundaries in SC3
- [[construction-time-graph-optimization-distributes-compiler-cost-across-node-creation]] -- applying constant folding, CSE, rate inference, and 120+ algebraic rewrites at node creation time delivers a pre-simplified graph to the final compiler pass
- [[compile-and-swap-preserves-audio-continuity-during-recompilation]] -- previous sound plays while new graph compiles; solves the 45-second silence problem that killed McCartney's 1990s whole-graph compilation attempt
- [[first-class-control-flow-nodes-in-synthesis-graphs-enable-conditional-and-demand-rate-execution]] -- treating if/switch/for as graph primitives enables pause and demand-rate patterns impossible in Faust; event codegen and scheduling remain McCartney's unsolved hard problem

## Open Questions
- Is there an IR granularity between UGen-level (opaque, v1) and arithmetic-primitive-level (McCartney's approach, requires massive compiler investment) that would allow incremental lowering?
- McCartney's event codegen and scheduler are explicitly unfinished after years of work -- what is the blocker, and does it affect Murail's conditional subgraph plans?

---

Topics:
- [[index]]
