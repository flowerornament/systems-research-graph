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

## Open Questions
- What compile latency is realistic for primitive-level (non-UGen) graph IR? Cranelift < 1ms but poor optimization; LLVM 10-500ms with excellent optimization; McCartney's C-emit pipeline adds process overhead.
- Conditional subgraphs: design them in at scheduler level now, or defer and risk redesign later? McCartney's multi-year struggle with event codegen suggests this is harder than it looks.
- How should the audio graph handle the frame-rate to sample-rate boundary for neural network control signals? DDSP uses bilinear interpolation for f0, overlapping Hamming window envelopes for amplitudes -- are these the right primitives for murail's rate system?

---

Topics:
- [[index]]
