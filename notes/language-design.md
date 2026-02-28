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

### Representation
- [[visual-representation-exposes-structure-text-notation-obscures]] -- visual cortex processes relational structure in parallel; text notation forces serial parsing; cyclic audio graphs are especially poorly served by linear text
- [[wiring-diagram-notation-names-every-intermediate-value-enabling-inspection-and-reuse]] -- Sussman: expression trees have anonymous interior nodes; wiring diagrams name every wire, making each intermediate value addressable -- relevant to murail's audio graph DSL design

### McCartney's New Language (2021-2025): Signal Model and Type System
- [[signal-shape-as-a-type-level-property-enables-compile-time-buffer-allocation-and-vectorization]] -- making matrix shape (rows x columns) part of the signal type rather than runtime metadata enables static buffer allocation, SIMD planning, and shape mismatch as compile error
- [[universal-auto-mapping-eliminates-explicit-iteration-from-signal-processing-programs]] -- APL-style rank polymorphism applied to every function, not just UGens, makes programs dramatically shorter; explicit `@` operators control iteration shape for Cartesian products
- [[multimethods-allow-code-generation-backends-to-be-organized-by-concern]] -- dispatching on both the code generator type and the expression type lets all codegen for one backend live together; prevents concern-spreading across expression classes

### McCartney's New Language (2021-2025): Workflow Architecture
- [[creative-workflow-friction-should-determine-audio-engine-architecture]] -- each of McCartney's innovations traces to a specific felt friction in creative practice; the design method: test every architectural decision against "does this create friction in the creative loop?"
- [[first-class-control-flow-nodes-in-synthesis-graphs-enable-conditional-and-demand-rate-execution]] -- if/switch/for as graph primitives on equal footing with arithmetic enables pause and demand-rate patterns; McCartney explicitly marks event codegen and scheduling as his unsolved hard problems

## Open Questions
- Can murail's graph compiler expose a query interface for inspecting running node states, approximating interactive programming without full image-based development?
- Is there a structure editor approach for audio graph DSL authoring that handles cyclic topology better than linear text notation?
- Universal auto-mapping (every function, McCartney) vs. explicit set-lifting (`f {a,b,c}`, current Murail language design context) -- which scope is right for Murail's audience?
- If the composition language (Stage 9) adopts persistent immutable data structures, how does McCartney's flexible class model (classes as type tags, not structure constraints) interact with Rust's strict struct layout requirements?

---

Topics:
- [[index]]
