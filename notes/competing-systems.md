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

## Claims
(populated by /extract from .design/references/competing-systems.md and sc-internals.md)

## Open Questions
(populated as gaps are identified)

---

Topics:
- [[index]]
