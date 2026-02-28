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

## Claims

### Interactive Programming and Batch Mode
- [[batch-processing-incurs-avoidable-cognitive-overhead]] -- punch-card era compile-run separation imposes cognitive costs unrelated to the actual problem; murail's compile-and-swap partially addresses this
- [[interactive-programming-eliminates-the-compile-run-cycle]] -- combining editor and running system produces preserved state, runtime introspection, and failure recovery; the ideal murail targets
- [[static-languages-prevent-runtime-introspection]] -- compilation to static artifacts severs the source-runtime connection; explains the gap in current murail debugging
- [[smalltalk-image-model-prevents-source-runtime-drift]] -- image-based development makes source and runtime one artifact; compile-and-swap is a weaker but structurally similar approximation

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

### McCartney's New Language (2021-2025): Signal Model and Type System
- [[signal-shape-as-a-type-level-property-enables-compile-time-buffer-allocation-and-vectorization]] -- making matrix shape (rows x columns) part of the signal type rather than runtime metadata enables static buffer allocation, SIMD planning, and shape mismatch as compile error
- [[universal-auto-mapping-eliminates-explicit-iteration-from-signal-processing-programs]] -- APL-style rank polymorphism applied to every function, not just UGens, makes programs dramatically shorter; explicit `@` operators control iteration shape for Cartesian products
- [[multimethods-allow-code-generation-backends-to-be-organized-by-concern]] -- dispatching on both the code generator type and the expression type lets all codegen for one backend live together; prevents concern-spreading across expression classes

### McCartney's New Language (2021-2025): Runtime and Type System Design
- [[classes-as-type-tags-allow-per-instance-field-variation]] -- classes impose no required instance variables; any instance of any class can carry arbitrary fields, making classes pure dispatch labels and enabling flexible metadata without subclassing
- [[reference-counting-becomes-viable-when-immutability-prevents-object-cycles]] -- in a non-lazy, non-mutable language new objects can only reference old objects so reference cycles are structurally impossible; RC is sufficient and pause-free, critical for any language runtime near RT audio
- [[thread-local-top-level-scope-with-copy-on-fork-achieves-actor-isolation-without-message-passing]] -- top-level scope stored in a persistent dictionary is thread-local; fork is a pointer copy; divergence uses path-copying; no global interpreter lock, no actor runtime infrastructure needed

### McCartney's New Language (2021-2025): Workflow Architecture
- [[creative-workflow-friction-should-determine-audio-engine-architecture]] -- each of McCartney's innovations traces to a specific felt friction in creative practice; the design method: test every architectural decision against "does this create friction in the creative loop?"
- [[first-class-control-flow-nodes-in-synthesis-graphs-enable-conditional-and-demand-rate-execution]] -- if/switch/for as graph primitives on equal footing with arithmetic enables pause and demand-rate patterns; McCartney explicitly marks event codegen and scheduling as his unsolved hard problems
- [[synthesis-graph-construction-is-a-regular-program-not-a-domain-specific-declaration]] -- no synthdef syntax or graph-construction DSL; synthesis graphs are built by calling ordinary language functions; the full language is available for algorithmic graph construction

### McCartney Pre-History (Pyrite and SuperCollider Origins)
- [[supercollider-version-1-merged-a-scripting-language-with-a-software-synthesizer-when-hardware-reached-real-time-speed]] -- SC1 was Pyrite + Synthomatic merged when Power Mac hit real-time speed; the merge was immediate and opportunistic, not planned
- [[supercollider-version-2-used-a-smalltalk-inspired-language-without-client-server-separation]] -- SC2 was Smalltalk-with-Ruby-syntax, scripting in RT thread; SC3 introduced the client-server split that defined SuperCollider's architecture
- [[pyrite-introduced-closures-into-max-patching-enabling-separation-of-ui-and-logic]] -- Pyrite's Scheme-style closures let Max patches contain only UI while all logic lived in a Pyrite script; demonstrated the text-script / visual-patch complementarity SC formalized

### Compiler Architecture and Hardware
- [[mlir-enables-heterogeneous-hardware-targeting-that-llvm-cannot-provide]] -- MLIR's multi-level IR design targets CPUs, GPUs, and ASICs that LLVM's single-level IR cannot address; Mojo is effectively MLIR syntax
- [[compiler-generality-beats-human-specialization-at-scale-because-compilers-can-enumerate-configurations-humans-cannot]] -- Modular beat Intel MKL on Intel chips; the mechanism is exhaustive configuration search vs. human point-solution specialization
- [[cache-hierarchical-hardware-makes-linked-lists-slower-than-arrays-for-most-practical-sizes]] -- modern CPU caches invert classical algorithm analysis; contiguous array layout is 100x faster than pointer-chased structures at practical sizes
- [[purely-functional-languages-fail-on-modern-hardware-because-pointer-boxing-destroys-cache-locality]] -- OCaml/Lisp boxing and pointer indirection produce structural cache-miss overhead; Rust's contiguous-by-default model inverts this

## Open Questions
- Can murail's graph compiler expose a query interface for inspecting running node states, approximating interactive programming without full image-based development?
- Is there a structure editor approach for audio graph DSL authoring that handles cyclic topology better than linear text notation?
- Universal auto-mapping (every function, McCartney) vs. explicit set-lifting (`f {a,b,c}`, current Murail language design context) -- which scope is right for Murail's audience?
- If the composition language (Stage 9) adopts persistent immutable data structures, how does McCartney's flexible class model (classes as type tags, not structure constraints) interact with Rust's strict struct layout requirements?

---

Topics:
- [[index]]
