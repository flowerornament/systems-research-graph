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

### FAUST: Functional DSP Compiler Architecture (Orlarey, Fober & Letz 2009)
- [[faust-programs-denote-mathematical-functions-enabling-semantics-driven-compilation]] -- a FAUST program is a mathematical function from signals to signals; the compiler compiles the function not the text, enabling optimizations impossible when compiling programs literally
- [[faust-block-diagram-algebra-unifies-functional-programming-with-visual-patch-notation]] -- five composition operators (sequential, parallel, recursive, split, merge) define a closed algebra; block-diagram construction is literally function composition
- [[purely-functional-dsp-semantics-enables-compiler-optimizations-impossible-in-C]] -- the absence of side effects and pointer aliasing removes the barriers that prevent C/C++ compilers from aggressive optimization; FAUST's functional model is the mechanism
- [[faust-separates-dsp-specification-from-host-architecture-enabling-multi-target-retargeting]] -- architecture files decouple the generated DSP class from its host; the same .dsp source produces JACK apps, CoreAudio apps, LADSPA, VST, Max, PD, SuperCollider plugins
- [[faust-recursive-composition-with-implicit-one-sample-delay-is-the-primitive-for-all-feedback]] -- the `~` operator mandates a one-sample delay in the feedback path, making all recursion well-founded and computationally deterministic
- [[faust-signal-type-inference-classifies-computation-rate-to-enable-appropriate-caching]] -- compile-time rate classification (constant/init/UI/audio) enables automatic caching at the right granularity without programmer annotation
- [[faust-vectorized-code-generation-splits-sample-loop-into-multiple-simpler-loops-to-expose-simd]] -- the -vec code generator splits the single sample loop into sections, producing SIMD-friendly code; 2.8x speedup on RMS benchmark with Intel icc
- [[memory-bandwidth-is-the-binding-constraint-for-audio-dsp-parallelism-on-smp-machines]] -- SMP parallelism is bounded by shared memory bus; a sequential program already saturating bandwidth cannot benefit from more cores
- [[faust-symbolic-propagation-normalizes-structurally-different-programs-that-compute-identical-functions]] -- symbolic propagation discovers mathematical equations of outputs, then normalizes them; different block-diagrams with equivalent meanings compile to identical code
- [[dataflow-languages-lack-explicit-formal-semantics-making-program-behavior-engine-dependent]] -- Max/PD semantics are hidden in the engine; global patch behavior requires knowing the engine internals, and long-term preservation is threatened
- [[faust-compiler-discovers-parallelism-automatically-but-expressing-it-efficiently-remains-hard]] -- detection of parallelism is trivial in a functional language; generating efficient OpenMP code is hard due to overhead and memory pressure

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

### SuperCollider History (McCartney primary source)
- [[supercollider-version-1-merged-a-scripting-language-with-a-software-synthesizer-when-hardware-reached-real-time-speed]] -- SC1 emerged when Power Mac ran Synthomatic 32x faster than real time; McCartney immediately merged Pyrite (scripting) and Synthomatic (synthesis) into one real-time system
- [[supercollider-version-2-used-a-smalltalk-inspired-language-without-client-server-separation]] -- SC2 was Smalltalk-with-Ruby-syntax, scripting still in the RT thread; SC3 introduced the client-server split
- [[supercollider-client-server-architecture-moved-the-scripting-language-out-of-the-real-time-audio-thread]] -- the client-server split solved language-execution pauses in the RT audio thread; remote playback was a secondary benefit

### McCartney's New Audio Language (SuperCollider author, 2021-2025)
- [[eliminating-unit-generators-exposes-synthesis-graphs-to-cross-boundary-compiler-optimization]] -- flattening UGens to four arithmetic primitives lets the compiler fuse, vectorize, and dead-code-eliminate across what were previously opaque object boundaries in SC3
- [[construction-time-graph-optimization-distributes-compiler-cost-across-node-creation]] -- applying constant folding, CSE, rate inference, and 120+ algebraic rewrites at node creation time delivers a pre-simplified graph to the final compiler pass
- [[compile-and-swap-preserves-audio-continuity-during-recompilation]] -- previous sound plays while new graph compiles; solves the 45-second silence problem that killed McCartney's 1990s whole-graph compilation attempt
- [[first-class-control-flow-nodes-in-synthesis-graphs-enable-conditional-and-demand-rate-execution]] -- treating if/switch/for as graph primitives enables pause and demand-rate patterns impossible in Faust; event codegen and scheduling remain McCartney's unsolved hard problem

### Hadron (Lucille, 2025): SC Interpreter Compatibility and Ecosystem
- [[hirams-law-makes-all-observable-interpreter-behavior-a-permanent-api-commitment]] -- any observable SC behavior becomes a permanent user dependency; Hadron must reproduce quirks including deferred initialization ordering
- [[deferred-argument-initialization-exposes-sc-frame-setup-order-as-observable-behavior]] -- SC's two-pass frame initialization is visible in program outputs; a reimplementation that eliminates the quirk breaks user code
- [[constant-folding-can-silently-change-sc-program-semantics-via-initialization-timing]] -- basic optimization is not semantics-preserving in SC; applies to murail wherever evaluation timing is observable by users
- [[observable-semantics-lock-in-implementation-details-and-block-optimization]] -- internals that leak through observable behavior cannot be replaced without a compatibility strategy; antidote is explicit compatibility classification
- [[the-supercollider-ecosystem-rather-than-the-software-is-its-irreplaceable-value]] -- 25 years of community and creative work is the real value of SC; compatible reimplementations preserve ecosystem access
- [[compiler-explorer-extended-c-by-making-compilation-artifacts-inspectable-and-shareable]] -- Hadron's WASM web front end applies the Godbolt model: shareable, inspectable compilation artifacts for SC/Hadron

### Audio Programming Education and Abstraction Costs
- [[juce-abstracts-away-audio-engine-fundamentals-producing-developers-who-cannot-reason-about-threading-and-resource-management]] -- Apple Core Audio interviews found JUCE-trained developers knew DSP inner loops but not threading models or resource management; JUCE as crutch
- [[audio-programming-education-requires-reading-production-engine-source-code-across-multiple-systems]] -- McCartney's prescription: read CSound, VCV Rack, SuperCollider, Chuck, and Pure Data to understand the engine problem space from multiple angles

### Compiler Generality and Hardware Targeting (Lattner)
- [[compiler-generality-beats-human-specialization-at-scale-because-compilers-can-enumerate-configurations-humans-cannot]] -- validates [[eliminating-unit-generators-exposes-synthesis-graphs-to-cross-boundary-compiler-optimization]] from the compiler research direction: flatter representations enable the exhaustive optimization McCartney's approach requires
- [[mlir-enables-heterogeneous-hardware-targeting-that-llvm-cannot-provide]] -- the current state of the art for audio DSP targeting future accelerator hardware; relevant for murail's neural UGen path
- [[purely-functional-languages-fail-on-modern-hardware-because-pointer-boxing-destroys-cache-locality]] -- explains why Faust's functional model, while semantically clean, requires careful backend code generation to avoid performance penalties from functional-style intermediate representations

## Open Questions
- Is there an IR granularity between UGen-level (opaque, v1) and arithmetic-primitive-level (McCartney's approach, requires massive compiler investment) that would allow incremental lowering?
- McCartney's event codegen and scheduler are explicitly unfinished after years of work -- what is the blocker, and does it affect Murail's conditional subgraph plans?

---

Topics:
- [[index]]
