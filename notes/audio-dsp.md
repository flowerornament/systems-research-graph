---
description: Synthesis, signal processing, UGen design, and buffer management research
type: moc
created: 2026-02-27
---

# audio-dsp

Core audio DSP research for murail's graph engine. Covers synthesis algorithms, signal processing pipelines, UGen trait design, buffer management strategies, and sample-accurate timing.

## Key Sub-Areas
- Synthesis algorithms (FM, physical modeling, Karplus-Strong, wavetable)
- Signal flow and routing (planar buffers, SIMD alignment, channel layouts)
- UGen design patterns (trait-based dispatch, state management, parameter control)
- Sample rate and block size handling (sub-block splitting, rate adaptation)
- Latency compensation and scheduling

## Claims

### Core Audio Architecture
- [[core-audio-low-latency-performance-traces-to-an-architectural-insight-made-at-the-projects-inception]] -- McCartney's observation that Core Audio's low-latency advantage over prior macOS audio systems traces to a single architectural decision made at project inception; illustrates how inception-time design choices create lasting performance ceilings or floors

### Block-Based DSP and Sample-Accurate Timing
- [[sample-accurate-triggering-in-block-based-audio-requires-splitting-render-blocks-into-sub-block-execution-lambdas]] -- servicing triggers that arrive mid-block requires splitting the render block into pre-trigger and post-trigger execution lambdas; SIMD alignment complications follow from non-modulo segment sizes

### Channel Format Architecture
- [[channel-format-metadata-encapsulation-enables-audio-graph-reuse-across-channel-configurations]] -- bundling audio buffers with spatial format metadata (family type, channel positions) into a typed abstraction lets one graph wire serve mono through Atmos
- [[channel-agnostic-audio-types-require-three-polymorphic-subtypes-to-cover-all-known-and-future-formats]] -- discrete (speaker-assigned), sound field (ambisonics), and composite (hybrid/custom) cover all known spatial audio formats while leaving an escape hatch for future ones
- [[compatible-audio-format-transcoding-happens-automatically-while-cross-family-conversion-requires-an-explicit-cast]] -- within-family format negotiation (5.1 to stereo) is automatic; cross-family conversion (discrete to ambisonics) requires an explicit cast node with configured policy
- [[audio-format-type-must-be-resolved-at-graph-compile-time-not-during-execution]] -- format is fixed at compile/initialization time to preserve graph stability; mid-execution format mutation is unsafe for block-based audio systems

### Graph IR and Compiler Architecture
- [[eliminating-unit-generators-exposes-synthesis-graphs-to-cross-boundary-compiler-optimization]] -- replacing opaque UGen objects with four arithmetic primitives lets the compiler fuse, vectorize, and prune dead nodes across what were previously object boundaries
- [[construction-time-graph-optimization-distributes-compiler-cost-across-node-creation]] -- 120+ algebraic rewrites applied at node-creation time deliver a pre-simplified graph; rate inference (constant < init < reset < event < audio) and CSE are free at construction
- [[equality-saturation-can-replace-hand-coded-rewrite-rules-with-automatically-discovered-provably-terminating-optimizations]] -- e-graph saturation is monotonic and naturally terminates; algebraic properties of DSP primitives drive discovery of valid rewrites, multiple cost functions produce different optimal graphs for LiveFast vs. Deep service levels
- [[murails-graph-compiler-is-a-symbolic-numeric-compiler-and-should-be-designed-as-one]] -- the graph IR is a symbolic expression, optimization passes are algebraic simplification, schedule compilation is code generation; framing this explicitly opens array fusion, broadcasting, and layout optimization from the symbolic-numeric computing literature
- [[the-rate-lattice-provides-exactly-the-static-dynamic-parameter-separation-that-partial-evaluation-requires]] -- constant/init-rate parameters are compile-time known; partial evaluation specializes generic DSP code to them automatically, eliminating abstraction overhead on the RT path without target-specific UGen code
- [[stable-node-identities-enable-adapton-style-incremental-recompilation-where-only-affected-subgraphs-are-recompiled]] -- slotmap NodeIds provide the first-class names Nominal Adapton requires; each edit transaction triggers recompilation of only the transitively affected subgraph, bringing Deep service level toward single-digit milliseconds for typical edits
- [[multi-stage-audio-compilation-can-be-collapsed-by-stage-polymorphism-into-single-pass-code-generation]] -- if the three compilation layers (composition language -> graph IR -> compiled schedule) are written in stage-polymorphic style, a future partial evaluator can eliminate intermediate representations entirely
- [[denotational-semantics-define-the-correctness-criterion-for-graph-optimization-two-programs-are-equivalent-iff-they-denote-the-same-mathematical-function]] -- two graph programs are equivalent iff they denote the same function on signal sequences; this is the correctness criterion for all rewrite rules and the specification that compiled schedules must satisfy
- [[signal-shape-as-a-type-level-property-enables-compile-time-buffer-allocation-and-vectorization]] -- matrix shape as a signal type property (not metadata) enables static buffer allocation and SIMD planning; feedback loops require a separate recursive shape inference pass
- [[first-class-control-flow-nodes-in-synthesis-graphs-enable-conditional-and-demand-rate-execution]] -- if/switch/for as graph primitives make the synthesis graph a conditional dataflow graph, not a simple DAG; the scheduler must handle subgraph activation and deactivation
- [[delay-merging-collapses-structurally-identical-delays-enabling-implicit-multi-tap-sharing]] -- the first whole-graph compiler pass collapses delays with identical inputs and initialization into one; enables implicit multi-tap sharing when library functions independently delay the same signal
- [[recursive-shape-inference-is-required-for-feedback-delay-reads-in-matrix-signal-graphs]] -- reading a delay in a feedback loop creates a circularity in shape computation; a separate fixpoint resolution pass is required before buffer allocation can proceed
- [[graph-compiler-loop-formation-groups-same-dimension-trees-to-enable-vectorization]] -- after shape inference, expression trees with identical matrix dimensions and compatible rates are grouped into SIMD-vectorizable loops; topological order is preserved across loop boundaries
- [[synthesis-graph-construction-is-a-regular-program-not-a-domain-specific-declaration]] -- synthesis definitions are built by calling ordinary language functions that return graph nodes; no distinct synthdef syntax; the full language including auto-mapping is available

### FAUST Prior Art: DSP Compiler Techniques
- [[faust-signal-type-inference-classifies-computation-rate-to-enable-appropriate-caching]] -- rate classification (constant/init/UI/audio) inferred automatically, no programmer annotation; FAUST prior art confirming murail's construction-time rate inference approach
- [[faust-vectorized-code-generation-splits-sample-loop-into-multiple-simpler-loops-to-expose-simd]] -- section-based loop splitting exposes SIMD opportunities; 2.8x speedup demonstrated; prior art for murail's loop-formation pass
- [[faust-recursive-composition-with-implicit-one-sample-delay-is-the-primitive-for-all-feedback]] -- FAUST feedback primitive: mandatory 1-sample delay makes all recursion well-founded; clarifies the semantics of delay-containing feedback loops
- [[memory-bandwidth-is-the-binding-constraint-for-audio-dsp-parallelism-on-smp-machines]] -- SMP parallelism bounded by memory bus; audio DSP often better served by SIMD than multi-threading; benchmarked across 3 machines with 7 DSP programs
- [[faust-symbolic-propagation-normalizes-structurally-different-programs-that-compute-identical-functions]] -- symbolic propagation extracts mathematical equations from block-diagrams and normalizes them; structurally different programs with equivalent semantics produce identical compiled code

### Synthesis Graph Architecture (Dannenberg & Bencina 2005)
- [[caching-ugen-graph-evaluation-order-decouples-topology-modification-from-concurrent-execution]] -- caching the topological evaluation order in a flat list separates NRT topology modification from RT execution; the structural foundation that makes compile-and-swap possible; with graph coloring for buffer minimization

### Live Editing and Composition
- [[typed-holes-allow-incomplete-audio-programs-to-remain-running-by-substituting-silence-rather-than-failing-compilation]] -- unfinished signal paths produce silence (or pass-through or freeze) rather than compilation errors, keeping the audio system alive during composition; fill-and-resume triggers incremental recompilation of only the affected subgraph
- [[quantizing-live-code-swaps-to-musical-temporal-boundaries-makes-changes-deterministic-and-musically-predictable]] -- Sonic Pi's approach: code changes take effect at the next beat/bar/phrase boundary rather than immediately, making live hot-swap musically intentional rather than technically incidental
- [[glitch-free-parameter-propagation-requires-topological-ordering-combined-with-per-node-version-counters-not-global-locks]] -- REScala proves that topological propagation order plus per-node version counters achieves glitch-freedom without global locks, satisfying RT-safety (D53) while preventing transient inconsistencies from reaching the DAC

### ChucK: Timing Model and Concurrency (Wang & Cook 2003 ICMC)
- [[suspending-time-until-explicitly-advanced-gives-deterministic-reproducible-timing-across-machines]] -- ChucK's "suspended animation" rule makes audio timing hardware-independent and reproducible; language-level analog of murail's tick-boundary precedence; shows that deterministic timing can be embedded in language semantics rather than substrate contracts
- [[user-space-cooperative-shreds-achieve-sample-accurate-deterministic-concurrency-without-os-scheduling]] -- ChucK shreds yield only via the timing mechanism, making concurrent audio computation deterministic without OS synchronization; complementary to murail's RT/NRT binary thread split
- [[control-rate-as-emergent-product-of-time-advancement-eliminates-the-fixed-control-rate-constraint]] -- ChucK eliminates the fixed control rate; rate emerges from time-advancement choices, enabling per-shred and dynamically varying rates; contrasts with murail's static rate lattice approach
- [[live-assimilation-of-shreds-into-a-running-vm-enables-coding-composing-and-performing-as-a-single-activity]] -- ChucK's on-the-fly compiler assimilates new shreds into a running VM; additive live coding as an alternative model to murail's substitutive compile-and-swap

### SuperCollider 1 Architecture (McCartney 1996 ICMC)
- [[signal-buffers-as-a-type-amortize-interpreter-overhead-making-high-level-languages-viable-for-real-time-dsp]] -- a signal type representing a buffer of samples lets the interpreter dispatch once per buffer rather than per sample, clearing the RT performance threshold for a dynamic language; the foundational mechanism behind block-based DSP
- [[closures-encapsulate-unit-generator-state-making-ugen-creation-a-function-call-not-a-class-definition]] -- SC1 UGens are closures whose environments hold oscillator phase and filter delay state; UGen creation is an ordinary function call, not a class instantiation; the predecessor to the "UGens as library functions" approach in tau5
- [[real-time-incremental-garbage-collection-eliminates-static-voice-count-limits-in-synthesis-engines]] -- an RT GC that never halts processing enables dynamic voice instantiation; the maximum polyphony is a performance budget, not a structural limit; granular synthesis benefits most
- [[synthesis-function-specialization-by-input-rate-multiplies-performance-without-multiplying-algorithm-complexity]] -- implementing a single algorithm in 12 variants (Aoscilia: 3 frequency rates × 4 AM variants) specialized for audio/control/static input combinations achieves maximum performance without requiring the programmer to select variants

### Workflow and Embeddability
- [[compile-and-swap-preserves-audio-continuity-during-recompilation]] -- audio continuity during whole-graph recompilation is the specific mechanism that makes whole-graph compilation viable for interactive use; solves the 45-second silence problem
- [[persistent-data-structures-make-lossless-undo-an-architectural-side-effect]] -- lossless composition history emerges from persistent data structures at no additional design cost; reframes composition as temporal exploration
- [[sapf-append-only-execution-log-provides-ten-year-session-provenance]] -- SAPF logs every executed expression to an append-only file; 151k lines over 10 years; cross-session provenance distinct from within-session undo
- [[sapf-was-factored-into-an-embeddable-c-library-by-replacing-the-parser-with-c-functions]] -- eliminating the parser and wrapping all SAPF functions as C functions converted a language into a linkable library without changing the execution model; existence proof for murail's embeddability goal
- [[supercollider-3d5-applied-signal-graphs-to-pixel-synthesis-demonstrating-graph-generality-beyond-audio]] -- SC3D5's pixel-producing UGens demonstrate that a signal graph execution model is domain-agnostic; the same IR can drive audio, visual, or other signal-processing domains

### Differentiable Synthesis Components (source -- [[ddsp-2020]])
- [[harmonic-plus-noise-model-covers-most-natural-instrument-timbres-with-a-deterministic-plus-stochastic-decomposition]] -- additive harmonic + filtered noise (HPN/SMS) is expressive enough for MPEG-4 parametric coding; the natural high-level synthesis abstraction for pitched acoustic instruments in murail
- [[harmonic-oscillator-amplitude-factorization-separates-loudness-control-from-spectral-shape]] -- factorizing per-harmonic amplitudes into global loudness * normalized spectral distribution aligns the synthesis parameter space with perceptual dimensions; natural UGen interface design
- [[frequency-sampling-method-converts-network-outputs-into-interpretable-linear-phase-fir-filters]] -- predicting frequency-domain transfer functions and converting via IDFT produces time-varying linear-phase FIR filters; also the bridging pattern from frame-rate control signals to audio-rate processing
- [[explicit-reverb-factorization-enables-blind-dereverberation-as-a-modular-architectural-side-effect]] -- frequency-domain convolution (O(n log n)) for room-scale IRs; explicit reverb as a separable graph node unlocks acoustic transfer and dereverberation as architectural properties
- [[time-and-frequency-domain-neural-synthesis-impose-a-phase-alignment-prior-that-conflicts-with-periodic-audio-structure]] -- explains why oscillator-based synthesis (instantaneous phase integration) is a better representation for periodic audio than frame-based or Fourier approaches

### Murail Substrate: Execution Model (source -- [[murail-substrate-v3]])
- [[all-murail-program-state-fits-in-a-single-pre-allocated-contiguous-region]] -- the state region Σ is a contiguous block whose size is fully determined at compile time; this is the structural foundation enabling the no-allocation, no-blocking resource invariant
- [[block-size-is-the-primary-latency-throughput-tradeoff-in-murail-execution]] -- N ticks per TICK call; smaller N reduces latency, larger N improves throughput via vectorization; semantics are identical regardless of N
- [[host-buffer-to-model-input-mismatch-and-parallel-inference-remain-unbenchmarked-in-real-time-audio-contexts]] -- neural UGens compound the block-size latency cost when model input shape diverges from host buffer size; the performance impact of H_adapt alignment buffering is unknown
- [[hold-slots-prevent-fast-thread-blocking-on-slow-rate-values-without-locks]] -- three lock-free protocols (atomic, sequence-counter, double-buffer) selected by data size allow the fast thread to read slow-rate values without ever waiting
- [[cross-rate-smoothing-eliminates-staircase-discontinuities-from-hold-slot-reads]] -- smoothing filters applied automatically at every hold-slot read prevent zipper noise; the substrate provides the mechanism so no domain has to reinvent parameter interpolation
- [[tick-boundary-precedence-is-a-substrate-requirement-not-an-implementation-suggestion]] -- hold-slot writes, data swaps, program swaps, TICK must execute in this exact order; any other ordering creates ambiguity in the swap+hold interaction
- [[the-murail-fast-thread-never-halts-errors-degrade-quality-but-do-not-stop-evaluation]] -- output continuity is an axiom; NaN/Inf substitution, error flags, and the flag-overflow-policy exclusion all derive from it
- [[load-shedding-preserves-the-critical-set-exactly-while-degrading-non-critical-equations]] -- the backward closure of outputs is never shed; non-critical equations hold their last value under deadline pressure; determinism is lost but continuity is maintained

### Murail Substrate: Liveness Model (source -- [[murail-substrate-v3]])
- [[atomic-swap-enables-program-updates-at-tick-granularity-without-output-gaps]] -- double-buffered state regions and an atomic swap flag allow the new program to take effect at a tick boundary with no output gap; the formal mechanism underlying compile-and-swap
- [[the-migration-map-transforms-state-between-program-versions-preserving-continuity-where-possible]] -- per-equation copy/reinit/gauge-transform populates the new state region from the old; gauge annotations enable seamless edits by asserting output-equivalent reparameterizations

## Open Questions
- What compile latency is realistic for primitive-level (non-UGen) graph IR? Cranelift < 1ms but poor optimization; LLVM 10-500ms with excellent optimization; McCartney's C-emit pipeline adds process overhead.
- Conditional subgraphs: design them in at scheduler level now, or defer and risk redesign later? McCartney's multi-year struggle with event codegen suggests this is harder than it looks.
- How should the audio graph handle the frame-rate to sample-rate boundary for neural network control signals? DDSP uses bilinear interpolation for f0, overlapping Hamming window envelopes for amplitudes -- are these the right primitives for murail's rate system?
- Should the graph optimizer be built as an equality saturation engine over the formal model's algebraic spaces (Definition 7.1), or is construction-time optimization (current approach) sufficient? The e-graph approach eliminates the need to maintain termination proofs for 120+ rewrite rules.
- Can incremental recompilation (Adapton-style, via stable slotmap IDs) bring the Deep service level from graph-size-bound to edit-size-bound? What would the memoization table look like -- per-compilation-phase or per-subgraph?

## Source References
- [[mccartney-1996-supercollider-icmc]] -- McCartney's 1996 ICMC paper: SC1 architecture, signal-buffer type, closures-as-UGens, RT GC, and synthesis-function specialization by input rate; the primary published source for SC1 design decisions


- [[dannenberg-bencina-2005-design-patterns-real-time-computer-music]] -- six applied RT patterns for computer music; Synchronous Dataflow Graph pattern provides the formal rationale for cached evaluation order and its relationship to compile-and-swap; Accurate Timing and Event Buffers patterns are the temporal accuracy stack
- [[bencina-2011-real-time-audio-programming-101]] -- companion article to Dannenberg-Bencina 2005; RT callback rules with mechanism-level explanations; "if you don't know how long it will take, don't do it" as the cardinal rule; worst-case complexity and scheduler paranoia claims
- [[pl-research-landscape-2026-02-27]] -- survey of PL research (OOPSLA/SPLASH/Strange Loop 2015-2025) covering equality saturation, partial evaluation for DSP, incremental compilation, dataflow confluency, live programming, and symbolic-numeric compilation; primary source for graph-IR and compilation claims in this map

---

Topics:
- [[index]]
