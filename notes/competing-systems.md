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

## Open Questions
(populated as gaps are identified)

---

Topics:
- [[index]]
