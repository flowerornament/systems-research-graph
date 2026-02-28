---
description: Entry point to the research knowledge graph
type: moc
created: 2026-02-27
---

# index

A cross-disciplinary research knowledge graph. Claims are atomic, flat, and wiki-linked across domains. Topic maps provide navigation within and between domains.

## Domains

### murail (audio graph engine)
- [[audio-dsp]] -- synthesis, signal processing, UGen design, buffer management
- [[language-design]] -- rate systems, typed composition, formal semantics, expression problem
- [[concurrent-systems]] -- lock-free communication, RT scheduling, memory safety, thread models
- [[rust-ecosystem]] -- crates, nightly features, type-driven design, unsafe boundaries
- [[ai-ml]] -- neural UGens, differentiable audio, DDSP, generative composition
- [[competing-systems]] -- SuperCollider, Faust, Web Audio, JUCE, NIH-plug, Firewheel, HexoDSP
- [[formal-methods]] -- Lean proofs, mathematical foundations, verification, algebraic spaces

## Cross-Domain
(topic maps that span multiple domains appear here — e.g., BEAM/Elixir patterns shared between murail language design and herald)

## Source References (processed transcripts and papers)
- [[stop-writing-dead-programs-jack-rusher-2022]] -- Jack Rusher, Strange Loop 2022: interactive programming, batch mode critique, language design survey
- [[we-dont-know-how-to-compute-sussman-2011]] -- Gerald Sussman, Strange Loop 2011: propagator model, truth maintenance (preliminary stub)

## Orientation
- ops/goals.md -- current active threads
- ops/methodology/methodology.md -- how this system works and why

## Getting Started
1. Capture source material in inbox/
2. Run /extract to decompose into atomic claims
3. Run /connect to find cross-disciplinary links
4. Browse topic maps to navigate the knowledge graph
