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

### herald (real-time application platform)
- [[herald]] -- agent architecture, LLM integration, OTP fitness for agentic workloads, implementation techniques

## Cross-Domain
- [[developer-experience]] -- feedback loops, introspection, notation, and how programming environments shape what developers can build

## Source References (processed transcripts and papers)
- [[stop-writing-dead-programs-jack-rusher-2022]] -- Jack Rusher, Strange Loop 2022: interactive programming, batch mode critique, language design survey
- [[we-dont-know-how-to-compute-sussman-2011]] -- Gerald Sussman, Strange Loop 2011: propagator model, truth maintenance, evolvability vs correctness, generic operations
- [[channel-agnosticism-metasounds-aaron-mcleran-adc]] -- Aaron McLeran (Epic Games), ADC: MetaSounds channel-agnostic types, polymorphic audio format abstraction, JIT graph compilation, instanced graph model
- [[2026-02-06-qmayIRViJms]] -- Darwin Gross interviews James McCartney (SuperCollider creator): SC version history, Pyrite origins, Core Audio architecture, APL influence, audio education, JUCE critique
- [[keynote-elixirs-ai-future-chris-mccord-elixirconf-us-2025]] -- Chris McCord, ElixirConf US 2025: Elixir's fitness for the agentic era, agent architecture, Phoenix 1.8 AgentsMD, implementation techniques
- [[faust-2009-npcm]] -- Orlarey, Fober & Letz (2009): FAUST's functional DSP model, block-diagram algebra, semantics-driven compiler, scalar/vector/parallel code generation, performance benchmarks
- [[ddsp-2020]] -- Engel et al. (Google Brain, ICLR 2020): differentiable DSP modules as neural network components; multi-scale spectral loss; disentangled latent synthesis
- [[rave-2021]] -- Caillon & Esling (IRCAM, 2021): real-time VAE for 48kHz neural audio synthesis; two-stage training; multiband decomposition; post-training latent compaction
- [[swift-to-mojo-chris-lattner]] -- Chris Lattner, Pragmatic Engineer podcast: LLVM origins, Swift development history, Mojo design philosophy, AI hardware stack fragmentation, sufficiently smart compiler critique, adoption dynamics
- [[iverson-1980-notation-as-tool-of-thought]] -- Kenneth Iverson, 1979 Turing Award lecture: notation as a tool of thought, APL, executability combined with mathematical suggestivity, economy of notation, subordination of detail

## Orientation
- ops/goals.md -- current active threads
- ops/methodology/methodology.md -- how this system works and why

## Getting Started
1. Capture source material in inbox/
2. Run /extract to decompose into atomic claims
3. Run /connect to find cross-disciplinary links
4. Browse topic maps to navigate the knowledge graph
