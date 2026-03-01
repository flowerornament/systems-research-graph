---
description: Rate systems, typed composition, formal semantics, and the expression problem in audio languages
type: moc
created: 2026-02-27
---

# language-design

Programming language design research for murail. Covers rate type systems, typed signal composition, formal semantics, the expression problem in audio contexts, and connections to general PL theory.

## Key Sub-Areas
- Rate systems (lattice structures, rate inference, multi-rate graphs)
- Type-driven composition (signal types, bundle types, tensor representations)
- Formal semantics (denotational, operational, algebraic)
- The expression problem (adding new operations vs new data types in audio)
- Connections to Elixir/BEAM, tau5, and broader PL research

## Sub-Topics
- [[notation-and-thought]] -- how notation shapes mathematical and computational reasoning; Iverson's 1980 Turing Award lecture and its implications for audio DSL design
- [[mccartney-language-design]] -- James McCartney's post-SuperCollider work in SAPF and tau5: signal types, runtime architecture, creative workflow, and SC prehistory
- [[algebraic-effects]] -- effect handlers as a unified abstraction for exceptions, state, async, and control flow; Leijen 2017 and Koka compilation strategies
- [[compiler-and-adoption]] -- compiler architecture and hardware targeting (MLIR, cache effects), language adoption dynamics, and ecosystem governance (Hadron, SuperCollider compatibility)

## Claims

### Interactive Programming and Batch Mode
- [[batch-processing-incurs-avoidable-cognitive-overhead]] -- punch-card era compile-run separation imposes cognitive costs unrelated to the actual problem; murail's compile-and-swap partially addresses this
- [[interactive-programming-eliminates-the-compile-run-cycle]] -- combining editor and running system produces preserved state, runtime introspection, and failure recovery; the ideal murail targets
- [[static-languages-prevent-runtime-introspection]] -- compilation to static artifacts severs the source-runtime connection; explains the gap in current murail debugging
- [[smalltalk-image-model-prevents-source-runtime-drift]] -- image-based development makes source and runtime one artifact; compile-and-swap is a weaker but structurally similar approximation

### FAUST: Formal Semantics as Language Design Tool
- [[faust-programs-denote-mathematical-functions-enabling-semantics-driven-compilation]] -- a FAUST program is a mathematical function from signals to signals; formal denotational semantics enables optimization, normalization, and long-term program preservation
- [[faust-block-diagram-algebra-unifies-functional-programming-with-visual-patch-notation]] -- five composition operators form a closed algebra over signal processors; formal semantics gives unambiguous meaning to visual notation
- [[purely-functional-dsp-semantics-enables-compiler-optimizations-impossible-in-C]] -- functional semantics removes aliasing/side-effect barriers; specific mechanism by which functional languages outperform C in optimization opportunity
- [[dataflow-languages-lack-explicit-formal-semantics-making-program-behavior-engine-dependent]] -- Max/PD semantics hidden in the engine; formal semantics is the prerequisite for portable, preservable, embeddable programs
- [[faust-compiler-discovers-parallelism-automatically-but-expressing-it-efficiently-remains-hard]] -- functional languages make parallelism detection trivial; generating efficient parallel code is hard and hardware-dependent

### Composition Language Design
- [[kolmogorov-complexity-provides-a-measurable-criterion-for-composition-language-design-quality]] -- Kolmogorov complexity of a musical idea expressed in Murail should be <= its complexity in SuperCollider or Tidal Cycles; if a common pattern requires more code, the language has a measurable design failure fixable with better abstractions
- [[typed-holes-allow-incomplete-audio-programs-to-remain-running-by-substituting-silence-rather-than-failing-compilation]] -- Hazel's typed-hole semantics applied to audio: unfinished signal paths produce silence rather than compilation errors; turns the edit-compile-swap cycle into a continuous always-running experience
- [[world-age-semantics-makes-live-operator-extension-safe-by-bounding-new-definitions-to-compilation-boundaries]] -- Julia's world-age: new operator definitions take effect at the next compilation boundary, not retroactively; gives well-defined semantics for live-coding environments where musicians define and redefine operators mid-session
- [[quantizing-live-code-swaps-to-musical-temporal-boundaries-makes-changes-deterministic-and-musically-predictable]] -- musical time (beat, bar, phrase) not wall-clock time is the semantically meaningful swap boundary for audio code changes; Sonic Pi demonstrates that quantized hot-swap is both predictable and compositionally useful
- [[effects-as-capabilities-can-encode-rt-safety-requirements-in-the-composition-language-type-system]] -- RT functions receive only the "pure computation" capability token; I/O and allocation capabilities are absent, making RT-safety a type guarantee rather than a code-review convention

### Language Design Tradeoffs
- [[type-systems-have-not-empirically-reduced-defect-rates]] -- empirical studies find no reliable advantage of static types over fault-tolerant runtime designs for defect reduction
- [[debuggability-is-more-valuable-than-correctness-by-construction]] -- because specs are always wrong and software is continuous change, live debugging outweighs static verification for most engineering work
- [[evolvability-requires-trading-provability-for-extensibility]] -- Sussman's formal argument: tight specs enable proofs but are brittle; generic extensibility buys evolvability at the cost of provability
- [[generic-operations-allow-extending-existing-code-over-new-types-without-modification]] -- Lisp-style runtime generic dispatch extends existing programs over new types without modification; demonstrated with symbolic algebra, automatic differentiation, dimensional analysis
- [[programmer-time-dominates-computation-cost-in-the-post-scarcity-era]] -- memory and compute are now effectively free; the binding constraint is programmer expressiveness, making scarcity-oriented design obsolete
- [[rust-lacks-interactive-programming-despite-suitable-foundations]] -- Rust's multi-stage compilation could support interactivity; instead it shipped with batch-mode tooling
- [[library-languages-must-not-bundle-a-mandatory-runtime]] -- embeddable languages must not require importing their full runtime; directly constrains murail's Rust choice
- [[progressive-disclosure-of-complexity-fails-when-feature-accumulation-is-not-actively-prevented]] -- Lattner: Swift's progressive disclosure ideal collapsed under piecemeal feature additions; Mojo's response is strict scope limits and metaprogramming to subsume special cases
- [[value-semantics-allow-in-place-mutation-when-ownership-is-clear-making-them-strictly-more-powerful-than-purely-functional-copies]] -- logical separation from functional programming plus in-place efficiency from ownership proofs; strictly superior to immutable-copy functional models
- [[incremental-migration-between-languages-requires-binary-level-interoperability-not-just-semantic-compatibility]] -- Swift/ObjC, C/C++, Python/Mojo coexistence: whole-ecosystem transitions fail; class-by-class migration succeeds
- [[source-incompatibility-as-explicit-commitment-converts-forced-migration-to-opt-in-experiment]] -- explicitly declaring instability removes executive trap-risk and makes early adoption voluntary; the "relief valve" principle

### Representation
- [[visual-representation-exposes-structure-text-notation-obscures]] -- visual cortex processes relational structure in parallel; text notation forces serial parsing; cyclic audio graphs are especially poorly served by linear text
- [[wiring-diagram-notation-names-every-intermediate-value-enabling-inspection-and-reuse]] -- Sussman: expression trees have anonymous interior nodes; wiring diagrams name every wire, making each intermediate value addressable -- relevant to murail's audio graph DSL design

## Open Questions
- Can murail's graph compiler expose a query interface for inspecting running node states, approximating interactive programming without full image-based development?
- Is there a structure editor approach for audio graph DSL authoring that handles cyclic topology better than linear text notation?
- Universal auto-mapping (every function, McCartney) vs. explicit set-lifting (`f {a,b,c}`, current Murail language design context) -- which scope is right for Murail's audience?
- If the composition language (Stage 9) adopts persistent immutable data structures, how does McCartney's flexible class model (classes as type tags, not structure constraints) interact with Rust's strict struct layout requirements?
- What compatibility classes should murail define for its graph compiler? Which behaviors are guaranteed, version-gated, and explicitly unspecified? (See [[observable-semantics-lock-in-implementation-details-and-block-optimization]])

## Source References
- [[leijen-algebraic-effects]] -- primary source for the algebraic effects cluster: Koka language, row-typed effect system, selective CPS translation, and effect handler compilation strategies
- [[leijen-2016-algebraic-effects-tr]] -- 2016 technical report version with full proofs, open/close type rules, trampoline runtime detail, domain-specific effect examples (parser combinators), and deep vs shallow handler semantics
- [[llvm-creator-interview-chris-lattner]] -- Chris Lattner interview covering LLVM origins, Swift's development history (source incompatibility decisions, progressive disclosure collapse), and Mojo's design philosophy; primary source for Lattner-attributed claims

---

Topics:
- [[index]]
