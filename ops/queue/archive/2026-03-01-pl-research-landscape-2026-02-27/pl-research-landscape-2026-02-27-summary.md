---
batch: pl-research-landscape-2026-02-27
created: 2026-03-01
claims_created: 15
enrichments: 0
connections_added: 42
topic_maps_updated: 5
---

# Batch Summary: pl-research-landscape-2026-02-27

**Source:** `/Users/morgan/code/murail/.design/synthesis/pl-research-landscape-2026-02-27.md`
**Original location:** `/Users/morgan/code/murail/.design/synthesis/`
**Archive:** `/Users/morgan/code/murail/.design/synthesis/archive/pl-research-landscape-2026-02-27/`
**Date compiled:** 2026-02-27
**Date processed:** 2026-03-01

## Source Description

Survey of programming language research from OOPSLA/SPLASH 2015-2025, Strange Loop 2015-2023, ICFP, and LambdaJam with direct relevance to Murail's engine architecture, graph IR design, and composition language. Organized into 11 research threads: equality saturation, staged compilation, incremental computation, dataflow/reactive/lattice, live programming and typed holes, algebraic effects, generic dispatch, type systems for RT computation, music/creative coding, concatenative/point-free composition, symbolic-numeric computing.

## Claims Created

1. [[equality-saturation-can-replace-hand-coded-rewrite-rules-with-automatically-discovered-provably-terminating-optimizations]] -- e-graph saturation as replacement for hand-enumerated rewrite rules; monotonic termination eliminates need for three-guard protocol
2. [[murails-rate-inference-is-a-monotone-propagator-network-and-therefore-converges-to-a-unique-fixpoint]] -- Radul's convergence theorem applied directly to rate inference; validates the lattice-theoretic foundation
3. [[the-rate-lattice-provides-exactly-the-static-dynamic-parameter-separation-that-partial-evaluation-requires]] -- AnyDSL's approach: rate lattice levels map to compile-time/runtime boundary; enables automatic specialization of generic DSP code
4. [[multi-stage-audio-compilation-can-be-collapsed-by-stage-polymorphism-into-single-pass-code-generation]] -- "Collapsing Towers" result applied to Murail's three compilation layers; architecturally important aspiration
5. [[stable-node-identities-enable-adapton-style-incremental-recompilation-where-only-affected-subgraphs-are-recompiled]] -- slotmap NodeIDs as Nominal Adapton names; incremental recompilation per edit transaction
6. [[lattice-monotone-graph-operators-are-provably-confluent-enabling-safe-graph-transformation-without-global-locking]] -- Hydroflow's confluence theorem applied to Murail; any monotone-preserving transformation is semantically valid
7. [[glitch-free-parameter-propagation-requires-topological-ordering-combined-with-per-node-version-counters-not-global-locks]] -- REScala's glitch-freedom proof applied to audio parameter updates; compatible with RT-safety (D53)
8. [[typed-holes-allow-incomplete-audio-programs-to-remain-running-by-substituting-silence-rather-than-failing-compilation]] -- Hazel typed holes for audio: incomplete signal paths produce silence, fill-and-resume triggers incremental recompilation
9. [[quantizing-live-code-swaps-to-musical-temporal-boundaries-makes-changes-deterministic-and-musically-predictable]] -- Sonic Pi's temporal quantization semantics for audio hot-swap; beat/bar boundary as swap quantization
10. [[world-age-semantics-makes-live-operator-extension-safe-by-bounding-new-definitions-to-compilation-boundaries]] -- Julia's world-age applied to Murail's live-extensible composition language; well-defined semantics for mid-session operator definition
11. [[effects-as-capabilities-can-encode-rt-safety-requirements-in-the-composition-language-type-system]] -- value-level capability tokens for I/O and allocation; lighter-weight RT-safety enforcement than full effect type systems
12. [[kolmogorov-complexity-provides-a-measurable-criterion-for-composition-language-design-quality]] -- measurable criterion: common musical patterns should require fewer or equal characters in Murail vs. SuperCollider/Tidal Cycles
13. [[denotational-semantics-define-the-correctness-criterion-for-graph-optimization-two-programs-are-equivalent-iff-they-denote-the-same-mathematical-function]] -- StreamQL/Elliott FRP: two programs equivalent iff they denote the same function; formal correctness criterion for all graph rewrites
14. [[murails-graph-compiler-is-a-symbolic-numeric-compiler-and-should-be-designed-as-one]] -- reframing the compilation pipeline opens up algebraic simplification, array fusion, broadcasting, and layout optimization
15. [[linear-types-can-make-audio-buffer-management-errors-type-errors-rather-than-runtime-bugs]] -- Li et al. 2022 at real system scale: use-exactly-once typing for audio buffers catches write-before-read violations at compile time

## Topic Maps Updated

- [[audio-dsp]] -- 8 new claims added in "Graph IR and Compiler Architecture" and new "Live Editing and Composition" section
- [[formal-methods]] -- 5 new claims in "Propagator Model and Provenance" and new "Verification and Type Systems for RT Code" section
- [[language-design]] -- 5 new claims in new "Composition Language Design" section; source reference added
- [[concurrent-systems]] -- 4 new claims in new "RT Safety and Glitch Freedom" section
- [[algebraic-effects]] -- 1 new claim in new "Algebraic Effects for Murail" section
- [[developer-experience]] -- 3 new claims in new "Live coding and always-running programs" section
- [[notation-and-thought]] -- 1 new claim in new "Composition Language Design Criteria" section

## Key Observations

**Cross-cutting synthesis claim:** The most valuable extraction is [[murails-graph-compiler-is-a-symbolic-numeric-compiler-and-should-be-designed-as-one]] -- this reframes the entire compilation pipeline in a way that opens up a decade of well-studied PL techniques. The five PL research threads (equality saturation, partial evaluation, incremental computation, dataflow/lattice, symbolic-numeric) all converge on validating that Murail's lattice-theoretic formal model is not just mathematically elegant but directly enables practically efficient algorithms.

**Strongest formal result:** [[murails-rate-inference-is-a-monotone-propagator-network-and-therefore-converges-to-a-unique-fixpoint]] -- this closes the open question about whether rate inference is well-defined regardless of traversal order. Radul's 2009 convergence theorem is the proof.

**Most actionable for v1:** [[equality-saturation-can-replace-hand-coded-rewrite-rules-with-automatically-discovered-provably-terminating-optimizations]] -- directly addresses the 120+ rewrite rule maintenance burden described in D67-D68. The e-graph approach eliminates the termination proof burden.

**Most actionable for composition language (Stage 9):** [[typed-holes-allow-incomplete-audio-programs-to-remain-running-by-substituting-silence-rather-than-failing-compilation]] and [[quantizing-live-code-swaps-to-musical-temporal-boundaries-makes-changes-deterministic-and-musically-predictable]] together form a complete live-coding DX specification.
