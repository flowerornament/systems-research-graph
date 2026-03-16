---
description: Keeping the old graph playing while a new graph compiles eliminates the silence gap that made whole-graph recompilation impractical in 1990s SuperCollider, restoring interactive workflow
type: claim
evidence: strong
source: [[mccartney-ideas-2026-02-15]]
created: 2026-02-28
status: active
---

# compile-and-swap preserves audio continuity during recompilation

In the early 1990s, McCartney built a predecessor to SuperCollider that generated C code from synthesis scripts and compiled it for execution. The approach was "conceptually strong" -- compiled code outperformed the pre-compiled-UGen-wired-at-runtime model that became SC3. But the C compiler took ~45 seconds, during which the user waited in silence. He abandoned the approach, presented a paper at ICMC, and built the client/server model (SC3) instead -- accepting the optimization ceiling in exchange for instant graph assembly.

Now, 25 years later, he returns to whole-graph compilation with a crucial difference: the old sound keeps playing while the new graph compiles. The user writes new code, hits play, and continues hearing the previous audio; when compilation finishes, the new graph swaps in. No silence gap. No 45-second wait that disrupts creative flow.

This is structurally the same decision as Firewheel's compile-and-swap architecture (which Murail cites as a precedent) but McCartney provides the historical failure context that explains *why* compile-and-swap is the right solution: it is the only way to have both whole-graph optimization quality *and* interactive workflow. The broader pattern — work executes in a background thread, the RT audio callback only handles the handoff — is also instantiated by [[static-thread-pool-decouples-neural-inference-from-the-audio-callback-to-ensure-real-time-safety]], where inference runs in a separate ThreadPool and the callback submits work atomically; compile-and-swap is the graph-recompilation instance of the same RT-isolation architecture.

The 45-second failure was not a hardware limitation that modern CPUs solve. C compilation for audio graphs at modern scales still takes meaningful time. What changed: incremental construction-time optimization (see [[construction-time-graph-optimization-distributes-compiler-cost-across-node-creation]]) delivers a pre-simplified graph; and compile-and-swap means latency is hidden by continuity rather than eliminated. Both changes together make the approach viable.

McCartney gave a paper at ICMC about the C-emit approach but never developed it further. He describes it explicitly as "before Faust" -- he independently discovered whole-graph AOT compilation from a synthesis scripting language before Faust existed, ran into the interactivity wall, and abandoned it. See [[supercollider-version-1-merged-a-scripting-language-with-a-software-synthesizer-when-hardware-reached-real-time-speed]] for the full SC origin history, and [[supercollider-client-server-architecture-moved-the-scripting-language-out-of-the-real-time-audio-thread]] for why he chose the client-server model over the C-emit approach.

**Question for Murail (D65):** The spec defines two compilation service levels: LiveFast (P99 <= 2 audio blocks, ~2.9ms) and Deep (P99 <= 500ms). If Murail moves toward primitive-level compilation (see [[eliminating-unit-generators-exposes-synthesis-graphs-to-cross-boundary-compiler-optimization]]), what compile latency is realistic? Cranelift JITs in <1ms with poor optimization; LLVM takes 10-500ms with excellent optimization. McCartney's C-emit-compile-link-load adds process overhead. The compile-and-swap model means latency is tolerable as long as continuity is preserved -- but the right latency budget for each service level still matters.

Directly extends [[interactive-programming-eliminates-the-compile-run-cycle]] -- compile-and-swap is a specific mechanism for approaching the interactive programming ideal in a compiled audio context. The claim there notes that "state continuity" is missing from compile-and-swap (swapping a new graph loses running audio state); McCartney's model mitigates this with audio continuity but still loses internal graph state (accumulated oscillator phase, filter memory) unless state threading is implemented. This state-loss limitation is precisely what [[long-running-servers-require-continuity-oriented-programming-models]] identifies as the gap between compile-and-swap and full continuity: an audio engine is a long-lived server with accumulated state, and graph replacement without state threading is a partial solution.

Compile-and-swap also serves a source-runtime coherence function analogous to what [[smalltalk-image-model-prevents-source-runtime-drift]] describes: each swap atomically replaces the running audio graph with a fresh compilation of the current definition, preventing the source-runtime drift that plagues file-based interactive systems. The running graph is always a faithful representation of the current code -- structurally similar to Rusher's Clerk, which refuses to use code removed from the namespace file.

The broader principle -- that [[creative-workflow-friction-should-determine-audio-engine-architecture]] -- explains *why* compile-and-swap exists: it traces to McCartney's specific felt friction of the 45-second silence gap disrupting creative flow. Immutability ([[pervasive-immutability-dissolves-concurrency-problems-rather-than-managing-them]]) is what makes the "old graph keeps playing" property safe: immutable graph data can be read by the RT thread while the NRT thread constructs the replacement without synchronization hazards.

**Structural parallel to MCAS/FSTM:** The compile-and-swap mechanism is structurally identical to the [[two-phase-descriptor-protocol-enables-multi-location-atomic-updates-from-single-word-cas]] from Fraser's lock-free systems work: the "compiling graph" acts as a descriptor installed in a pending state; the swap is the atomic decision point CAS; the old graph continues playing during the "acquire phase" equivalent. The graph pointer swap is the linearisation point for the new audio graph becoming visible to the RT thread.

ChucK's [[live-assimilation-of-shreds-into-a-running-vm-enables-coding-composing-and-performing-as-a-single-activity]] is an alternative model: instead of swapping a whole program, ChucK assimilates additional concurrent shreds into a running VM. Additive (assimilation adds voices) vs. substitutive (swap replaces the program) are the two primary live-code-modification strategies; compile-and-swap is substitutive.

The Murail substrate formalizes this mechanism precisely in [[atomic-swap-enables-program-updates-at-tick-granularity-without-output-gaps]]: double-buffered state regions, migration maps, gauge transforms for seamless reparameterization, and a fixed tick-boundary precedence order ([[tick-boundary-precedence-is-a-substrate-requirement-not-an-implementation-suggestion]]) that eliminates all ambiguity in the swap/hold interaction. State continuity (the open question above) is addressed by [[the-migration-map-transforms-state-between-program-versions-preserving-continuity-where-possible]]: gauge annotations assert output-equivalent reparameterizations and enable the compiler to thread state across the swap boundary without audible artifacts.

---

The structural pattern — cache the evaluation order in a flat list, then swap atomically — is named explicitly in [[caching-ugen-graph-evaluation-order-decouples-topology-modification-from-concurrent-execution]] (Dannenberg & Bencina 2005): compile-and-swap is the full realization of the cached-evaluation-order variant of the Synchronous Dataflow Graph pattern.

McLean's [[live-coding-performance-requires-three-distinct-feedback-loops-that-together-define-being-in-time]] provides the user-facing explanation for why compile-and-swap's silence-elimination is not merely a convenience but a correctness requirement: the performance feedback loop (programmer <-> sound) must not be interrupted. Audio silence during recompilation is not just an annoyance -- it breaks the feedback loop that connects the programmer to the live moment and the audience. Compile-and-swap is the architectural mechanism that preserves this loop.

Topics:
- [[audio-dsp]]
- [[competing-systems]]
- [[concurrent-systems]]
- [[developer-experience]]
- [[language-design]]
