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

### SuperCollider 1: Language-Synthesis Integration (McCartney 1996 ICMC)
- [[scripting-and-synthesis-in-the-same-language-eliminates-the-boundary-between-composition-and-sound-design]] -- unifying the scripting and synthesis languages lets compositional algorithms directly parameterize synthesis, enabling granular synthesis at full expressive power; the design argument McCartney carries forward into tau5 and that SC3's client-server split (partially) reverts

### ChucK: Operator Design and Live Coding (Wang & Cook 2003)
- [[a-single-overloaded-operator-can-unify-assignment-signal-routing-and-synchronization-in-an-audio-language]] -- ChucK's `=>` operator unifies five distinct operations under one left-to-right construct; positive design constraint for murail's DSL (signal-routing legibility) with caveats about informal type-dispatch semantics
- [[vm-based-audio-runtimes-trade-raw-performance-for-determinism-and-language-level-flexibility]] -- ChucK's VM positions itself opposite FAUST on the performance-expressiveness tradeoff; establishes the two endpoints of the design spectrum that murail's hybrid architecture attempts to bridge
- [[live-assimilation-of-shreds-into-a-running-vm-enables-coding-composing-and-performing-as-a-single-activity]] -- ChucK collapses coding, composing, and performing into one activity via additive live coding; complements murail's substitutive compile-and-swap and typed holes approaches

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

### The Expression Problem (Wadler 1998)
- [[the-expression-problem-names-the-tension-between-adding-new-cases-and-new-operations-without-recompiling]] -- Wadler 1998: the canonical formulation; extending a datatype with new cases and new operations without recompiling and without casts is the central tension in language-level extensibility
- [[functional-languages-fix-rows-oo-languages-fix-columns-in-the-expression-problem-table]] -- cases are rows, operations are columns; each paradigm makes one dimension easy and the other hard; murail needs both dimensions to grow independently
- [[the-expression-problem-requires-static-type-safety-and-independent-compilation-simultaneously]] -- these two constraints together exclude all prior solutions; Wadler's GJ approach is the first satisfying both via general-purpose mechanisms
- [[virtual-type-indexing-solves-the-expression-problem-by-allowing-subclasses-to-refer-to-sibling-types-in-their-bound]] -- the GJ mechanism that lets `This.Exp` and `This.Visitor` refer to sibling types in the type bound; the key insight enabling co-evolution of mutually recursive type families
- [[the-thistype-trick-provides-accurate-static-typing-in-the-presence-of-subtypes-by-bounding-the-type-parameter-on-itself]] -- F-bounded polymorphism (`LangF<This extends LangF<This>>`) provides covariant return types; Rust's `Self` is the native spelling
- [[fixpoint-classes-tie-the-knot-after-open-recursive-parameterized-families-to-produce-closed-usable-types]] -- `final class Lang extends LangF<Lang>` closes the open recursion; fixpoint classes are the Y combinator of class hierarchies
- [[the-visitor-pattern-solves-the-operations-dimension-of-the-expression-problem-but-not-the-cases-dimension]] -- Extended Visitor adds new operations without modification but requires dynamic casts or recompilation to add new cases; statically typed solutions require the full GJ mechanism

### Representation
- [[visual-representation-exposes-structure-text-notation-obscures]] -- visual cortex processes relational structure in parallel; text notation forces serial parsing; cyclic audio graphs are especially poorly served by linear text
- [[wiring-diagram-notation-names-every-intermediate-value-enabling-inspection-and-reuse]] -- Sussman: expression trees have anonymous interior nodes; wiring diagrams name every wire, making each intermediate value addressable -- relevant to murail's audio graph DSL design

### Program Language (Baniassad & Myers 2009)
- [[each-program-defines-a-unique-program-specific-language-with-its-own-symbols-and-grammar]] -- every program is both definition and sole use of a language whose symbols are its abstractions and whose grammar is implicit combination rules; makes every codebase a language acquisition task
- [[program-languages-bridge-the-gap-between-program-semantics-and-code-semantics]] -- the gap between what code means to humans (program semantics) and what it means to the machine (code semantics) is what program languages communicate; formalizing this gap into the programming language is the central DSL design task
- [[higher-level-programming-languages-reduce-program-language-complexity-by-formalizing-more-constraints]] -- inverse relationship: more expressive programming languages leave less for informal program language; every type constraint added to the composition language is a rule that no longer degrades across programmers
- [[reading-an-unfamiliar-codebase-is-language-learning-not-mere-symbol-lookup]] -- comprehending a new codebase requires learning its unique program language; explains the cognitive cost of onboarding and the failure mode of "revival by newcomers"
- [[code-migration-between-programs-is-translation-between-distinct-natural-languages]] -- inter-program code copying requires semantic translation; false cognates (same identifier, different program-semantic content) cause silent corruption of meaning
- [[program-languages-communicate-naurs-theories-through-identifier-choice-idioms-and-abstraction-organization]] -- extends Naur: naming, idiomatic patterns, and code organization are the specific textual mechanisms through which theories surface in text; connects theory-building to program-language structure
- [[programmer-language-differs-from-program-language-cross-program-idioms-are-not-program-specific]] -- cross-program idioms and design patterns are "programmer language" (shared across programs); "program language" is unique to each program; DSLs create programmer language for a domain but programs written in them still develop unique program languages
- [[programs-are-works-of-art-not-craft-because-they-define-their-own-interpretive-language]] -- artifacts that define their own interpretive language are art; those working within a pre-existing language are craft; programs are art, which explains why they resist full quantification and specification

## Open Questions
- Can murail's graph compiler expose a query interface for inspecting running node states, approximating interactive programming without full image-based development?
- Is there a structure editor approach for audio graph DSL authoring that handles cyclic topology better than linear text notation?
- Universal auto-mapping (every function, McCartney) vs. explicit set-lifting (`f {a,b,c}`, current Murail language design context) -- which scope is right for Murail's audience?
- If the composition language (Stage 9) adopts persistent immutable data structures, how does McCartney's flexible class model (classes as type tags, not structure constraints) interact with Rust's strict struct layout requirements?
- What compatibility classes should murail define for its graph compiler? Which behaviors are guaranteed, version-gated, and explicitly unspecified? (See [[observable-semantics-lock-in-implementation-details-and-block-optimization]])
- What is the minimum mechanism set that allows murail's composition language to grow via user contribution? Does it satisfy [[user-defined-extensions-must-be-syntactically-indistinguishable-from-built-in-primitives]]?

### Growing a Language (Steele 1998)
- [[a-language-must-be-designed-to-grow-not-to-be-complete]] -- Steele's OOPSLA 1998 central thesis: neither small nor large is right; design for growth as a first-class requirement, since no language can be designed complete up front for modern user needs
- [[user-defined-extensions-must-be-syntactically-indistinguishable-from-built-in-primitives]] -- the "no seams" criterion for user-driven language growth: if user-defined operations look different from built-ins, users cannot grow the language and distributed innovation stalls
- [[apl-failed-to-grow-because-user-defined-and-built-in-operations-have-different-surface-syntax]] -- the negative case: APL's glyph/identifier asymmetry locked evolution to source-code holders; the seam between user and built-in syntax is what killed distributed contribution
- [[lisp-succeeded-at-user-driven-growth-because-user-definitions-are-syntactically-primitive]] -- the positive case: Lisp's bidirectional indistinguishability (user-defined looks like built-in and vice versa) enabled the designer to grow the language by curating user contributions rather than writing everything
- [[the-minimum-extensibility-mechanism-for-user-driven-language-growth-is-generic-types-and-operator-overloading]] -- Steele's concrete proposal: add generic types + user-defined operator overloading + value types to Java; these three mechanisms unlock all user-defined numeric and collection types without requiring language-level additions per type
- [[language-design-is-now-designing-a-pattern-for-language-designs-not-a-language]] -- the meta-claim: language design must go one level up; design a pattern for language designs (a meta-pattern with slots for user choices) rather than a complete language object
- [[a-good-programmer-builds-a-working-vocabulary-not-just-programs]] -- programming at scale is inseparable from language design; a million-line program is necessarily a new language built on the base, and good programmers recognize and act on this
- [[worse-is-better-because-small-languages-with-warts-reach-users-before-well-designed-large-languages]] -- Gabriel's thesis endorsed by Steele: the deployable small language wins the race against the well-designed late one; the escape is not perfect design but growable design
- [[bazaar-development-succeeds-because-the-plan-can-change-in-real-time-to-meet-user-needs]] -- the bazaar model's decisive advantage is adaptability (plan changes in real time) and user buy-in, not just distributed labor; requires a curator who can make and ship decisions quickly

## Source References
- [[mccartney-1996-supercollider-icmc]] -- McCartney's original 1996 ICMC paper introducing SuperCollider 1; primary source for signal-buffer amortization, closure-UGens, RT GC, and the scripting/synthesis integration argument
- [[plotkin-pretnar-2009-handlers-of-algebraic-effects]] -- original foundational paper (ESOP 2009): handlers as free-model homomorphisms, operations/handlers duality, two-language separation, continuations as the non-algebraic exception, parallel composition as the framework boundary
- [[leijen-algebraic-effects]] -- primary source for the algebraic effects cluster: Koka language, row-typed effect system, selective CPS translation, and effect handler compilation strategies
- [[leijen-2016-algebraic-effects-tr]] -- 2016 technical report version with full proofs, open/close type rules, trampoline runtime detail, domain-specific effect examples (parser combinators), and deep vs shallow handler semantics
- [[llvm-creator-interview-chris-lattner]] -- Chris Lattner interview covering LLVM origins, Swift's development history (source incompatibility decisions, progressive disclosure collapse), and Mojo's design philosophy; primary source for Lattner-attributed claims
- [[pl-research-landscape-2026-02-27]] -- survey of OOPSLA/SPLASH/Strange Loop/ICFP/LambdaJam 2015-2025 research with direct relevance to Murail: equality saturation, staged compilation, incremental computation, algebraic effects, live programming, Julia dispatch, Kolmogorov complexity, denotational semantics
- [[baniassad-myers-2009-program-as-language]] -- Baniassad & Myers (OOPSLA 2009): program as language thesis; program languages as informal grammars bridging program semantics and code semantics; uniqueness of program languages; programming as language creation; extends Naur 1985
- [[wadler-1998-expression-problem]] -- Philip Wadler, 1998 email to java-genericity list: coined "The Expression Problem," defined the rows/columns duality, stated the static-typing + independent-compilation constraint set, and presented the first general-purpose GJ solution via virtual type indexing and F-bounded polymorphism
- [[steele-1998-growing-a-language]] -- Guy Steele, OOPSLA 1998: language design as pattern for growth; no-seams extensibility criterion; APL vs Lisp case studies; "Worse is Better"; bazaar model; minimum extensibility mechanism set (generic types + operator overloading)

---

Topics:
- [[index]]
