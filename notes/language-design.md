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

### Notation as a Tool of Thought (Iverson 1980)
- [[notation-shapes-thought-not-merely-expresses-it]] -- foundational claim from Boole/Whitehead/Babbage: language is an instrument of reason; available notation determines which problems are tractable
- [[executable-notation-combines-universality-with-mathematical-suggestivity]] -- neither math notation nor programming languages have both properties; APL demonstrates they can be combined; grounds the interactive programming ideal
- [[suggestive-notation-enables-discovery-through-structural-analogy]] -- notation that makes structural analogies visible enables discovery; the source of APL-style array programming's cognitive productivity
- [[subordination-of-detail-via-arrays-names-and-operators-extends-reasoning-range]] -- three mechanisms (arrays, names, operators) each hide irrelevant detail, extending tractable problem range; basis for universal auto-mapping
- [[economy-of-notation-requires-compositional-grammar-not-a-large-primitive-vocabulary]] -- economy from grammar rules generating many expressions from few primitives, not from providing a primitive for every concept
- [[uniform-right-to-left-evaluation-eliminates-precedence-hierarchy-without-loss-of-expressiveness]] -- single argument rule for all functions eliminates operator precedence complexity; supports both left-to-right analysis and right-to-left execution
- [[executable-notation-enables-proof-by-exhaustion-through-systematic-case-enumeration]] -- when notation is executable and supports arrays, exhaustive proof of properties over finite domains becomes a computation
- [[notation-introduced-in-context-is-a-quality-criterion-not-a-pedagogical-shortcut]] -- notation requiring a prerequisite course is a design deficiency; good notation is learnable in context
- [[clear-algorithms-are-the-necessary-foundation-for-efficient-ones]] -- clarity precedes efficiency; a clear algorithm is an executable specification from which efficient variants can be derived and tested
- [[premature-efficiency-emphasis-creates-circular-language-hardware-codesign]] -- languages designed for current hardware and hardware designed for current languages create a lock-in ratchet preventing notation evolution

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

### Hadron (Lucille, 2025): Compatibility, Governance, and Ecosystem
- [[hirams-law-makes-all-observable-interpreter-behavior-a-permanent-api-commitment]] -- any observable behavior becomes a permanent user dependency; even bugs and implementation accidents are locked in once enough users exist
- [[deferred-argument-initialization-exposes-sc-frame-setup-order-as-observable-behavior]] -- SC's two-pass frame init makes argument default evaluation timing visible and user-dependent; any reimplementation must reproduce the quirk
- [[constant-folding-can-silently-change-sc-program-semantics-via-initialization-timing]] -- replacing `2+2` with `4` shifts initialization from deferred to literal, changing observable behavior; basic optimization is not semantics-preserving in SC
- [[observable-semantics-lock-in-implementation-details-and-block-optimization]] -- when internals leak through observable behavior, rewrites and optimizations are permanently constrained; the antidote is explicit compatibility classification
- [[language-feature-adoption-requires-governance-structures-not-just-technical-readiness]] -- even feasible, desired language changes cannot ship without pre-negotiated decision authority and stakeholder process; technical readiness is not the binding constraint
- [[language-editions-group-breaking-changes-to-avoid-combinatorial-flag-explosion]] -- named edition releases bundle breaking changes rather than individual flags; prevents exponential configuration space, following Rust's edition model
- [[the-supercollider-ecosystem-rather-than-the-software-is-its-irreplaceable-value]] -- 25 years of community, creative works, and pedagogy are irreplaceable regardless of software quality; compatibility preserves access to this ecosystem
- [[language-runtime-bootstrap-requires-broad-infrastructure-before-any-program-can-run]] -- GC, dispatch, class library, REPL, and terminal output must all work before any visible output exists; interpreter progress appears non-linear
- [[compiler-explorer-extended-c-by-making-compilation-artifacts-inspectable-and-shareable]] -- inspectable, shareable compiler output transforms language teaching and bug reporting; Hadron's web WASM front end applies this to SC

### SAPF Language Design (2021 Codefest)
- [[concatenative-postfix-readability-breaks-when-argument-role-is-ambiguous]] -- without knowing a word's arity, reader cannot distinguish primary operand from auxiliary argument; McCartney's fix: pipeline the main subject, parenthesize options
- [[sapf-append-only-execution-log-provides-ten-year-session-provenance]] -- every executed expression logged for 10 years enables cross-session provenance at decade scale; complements within-session undo/redo
- [[lazy-infinite-lists-enable-sample-level-access-and-sonic-composting-in-signal-graph-languages]] -- audio as lazy sequences lets programs access individual samples, inspect them before rendering, and apply iterative processes enabling sonic composting patterns

### Compiler Architecture and Hardware
- [[mlir-enables-heterogeneous-hardware-targeting-that-llvm-cannot-provide]] -- MLIR's multi-level IR design targets CPUs, GPUs, and ASICs that LLVM's single-level IR cannot address; Mojo is effectively MLIR syntax
- [[compiler-generality-beats-human-specialization-at-scale-because-compilers-can-enumerate-configurations-humans-cannot]] -- Modular beat Intel MKL on Intel chips; the mechanism is exhaustive configuration search vs. human point-solution specialization
- [[cache-hierarchical-hardware-makes-linked-lists-slower-than-arrays-for-most-practical-sizes]] -- modern CPU caches invert classical algorithm analysis; contiguous array layout is 100x faster than pointer-chased structures at practical sizes
- [[purely-functional-languages-fail-on-modern-hardware-because-pointer-boxing-destroys-cache-locality]] -- OCaml/Lisp boxing and pointer indirection produce structural cache-miss overhead; Rust's contiguous-by-default model inverts this

### Algebraic Effects (Leijen 2017, Koka)
- [[algebraic-effects-unify-exceptions-state-iterators-and-async-under-a-single-abstraction]] -- one mechanism (effect handlers) subsumes exceptions, mutable state, iterators, async-await, and non-determinism; eliminates specialized language constructs and their interaction surface
- [[effect-handlers-are-resumable-exceptions-that-capture-delimited-continuations]] -- operational semantics: three-way classification (no resume, tail resume, non-tail/multiple resume) determines compilation strategy and overhead
- [[row-typed-effects-compose-freely-because-they-are-restricted-to-the-free-monad]] -- algebraic restriction to free monad makes composition automatic unlike monad transformers; nesting order controls scoping semantics explicitly
- [[type-directed-selective-cps-translation-eliminates-overhead-for-total-functions]] -- 80% of Koka stdlib functions avoid CPS transformation after type simplification; inner-loop code pays zero overhead
- [[effect-polymorphic-functions-require-dual-compilation-to-avoid-calling-convention-mismatches]] -- functions polymorphic over effects need CPS and non-CPS compiled versions plus a runtime wrapper; 20% code size increase in practice
- [[handler-composition-order-determines-effect-scope-making-semantics-explicit-and-controllable]] -- outer vs inner handler nesting gives global vs local state semantics; both are valid, type-checked, and programmer-controlled
- [[nominal-effect-types-keep-inferred-types-small-at-the-cost-of-requiring-complete-handlers]] -- Koka's nominal approach keeps types readable at 14,000 loc scale; structural approach (Links) is more expressive but verbose
- [[tail-resumption-optimization-eliminates-continuation-capture-for-the-common-case]] -- tail-position single resume (the common case for state, logging, simple I/O) compiles to a direct function call with zero overhead
- [[well-typed-algebraic-effect-programs-cannot-invoke-unhandled-operations]] -- effect soundness: type system statically guarantees every operation invocation has a handler; eliminates runtime equivalent of unhandled exceptions
- [[algebraic-effects-model-async-without-async-await-keywords-by-registering-the-continuation-as-a-callback]] -- handler registers resume continuation as OS callback; async-await as library code, not language syntax; multi-core OCaml uses this for concurrency

- [[sufficiently-smart-compilers-produce-leaky-abstractions-not-reliable-performance]] -- auto-optimization heuristics fire until a refactor silently breaks them; Mojo's response is explicit library-expressed optimizations with predictable contracts
- [[compiler-power-moved-into-libraries-gives-explicit-control-without-requiring-compiler-expertise]] -- expressing optimizations as callable library functions turns them from fragile heuristics into contracts, opening the talent pool beyond compiler engineers
- [[unifying-program-and-metaprogram-eliminates-two-world-complexity-of-templates]] -- compile-time and runtime code in one language makes metaprogramming debuggable with the same tools; Mojo/Zig vs. C++ template sublanguage
- [[ai-hardware-stack-fragmentation-mirrors-pre-gcc-compiler-era]] -- CUDA, ROCm, XLA, MLX are isolated vertical stacks; Modular/Mojo aims to be the neutral GCC-equivalent layer above AI hardware diversity
- [[llm-friendly-language-design-reduces-to-readability-not-llm-specific-features]] -- LLM suitability is a consequence of readability and large open-source corpus, not special-purpose LLM syntax

### Language Adoption and Institutional Strategy (Lattner / Swift / Mojo)
- [[experts-resist-new-languages-because-their-prior-investment-is-invalidated]] -- expert practitioners protect accrued expertise; S-curve adoption follows because transition resets competitive advantage to zero
- [[new-language-success-requires-designing-for-expansion-to-adjacent-domains]] -- languages that outlast their target domain were designed for generality; JavaScript running web servers and Swift enabling non-expert app developers are design consequences
- [[language-quality-validation-requires-production-use-not-internal-development]] -- a team of 250 under NDA cannot produce the usage diversity needed to validate design decisions; production release is epistemologically necessary
- [[early-breaking-changes-with-public-commitment-are-preferable-to-locking-in-mistakes]] -- announcing source breakage at 1.0 and delivering it avoids locked-in mistakes; Swift 1-3 broke three times before committing to stability
- [[incremental-institutional-adoption-requires-non-zero-business-value-at-each-step]] -- LLVM's path through Apple: small win every six months, top-down champion plus bottom-up results; the pattern for any ambitious project inside an institution

## Open Questions
- Can murail's graph compiler expose a query interface for inspecting running node states, approximating interactive programming without full image-based development?
- Is there a structure editor approach for audio graph DSL authoring that handles cyclic topology better than linear text notation?
- Universal auto-mapping (every function, McCartney) vs. explicit set-lifting (`f {a,b,c}`, current Murail language design context) -- which scope is right for Murail's audience?
- If the composition language (Stage 9) adopts persistent immutable data structures, how does McCartney's flexible class model (classes as type tags, not structure constraints) interact with Rust's strict struct layout requirements?
- What compatibility classes should murail define for its graph compiler? Which behaviors are guaranteed, version-gated, and explicitly unspecified? (See [[observable-semantics-lock-in-implementation-details-and-block-optimization]])

## Source References
- [[leijen-algebraic-effects]] -- primary source for the algebraic effects cluster: Koka language, row-typed effect system, selective CPS translation, and effect handler compilation strategies
- [[llvm-creator-interview-chris-lattner]] -- Chris Lattner interview covering LLVM origins, Swift's development history (source incompatibility decisions, progressive disclosure collapse), and Mojo's design philosophy; primary source for Lattner-attributed claims

---

Topics:
- [[index]]
