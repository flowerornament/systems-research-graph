---
description: Batch summary for faust-2009-npcm processing
type: batch-summary
created: 2026-02-28
---

# Batch Summary: faust-2009-npcm

**Source:** `/Users/morgan/code/murail/.design/references/papers/faust-2009-npcm.pdf`
**Source remains at:** original location (not an inbox item; sourced from `.design/references/papers/`)
**Completed:** 2026-02-28

## Extraction Summary

- Claims extracted: 10
- Enrichments: 3 (existing claims updated)
- Source reference note: 1

## Claims Created

1. [[faust-programs-denote-mathematical-functions-enabling-semantics-driven-compilation]]
2. [[faust-block-diagram-algebra-unifies-functional-programming-with-visual-patch-notation]]
3. [[purely-functional-dsp-semantics-enables-compiler-optimizations-impossible-in-C]]
4. [[faust-separates-dsp-specification-from-host-architecture-enabling-multi-target-retargeting]]
5. [[faust-recursive-composition-with-implicit-one-sample-delay-is-the-primitive-for-all-feedback]]
6. [[faust-signal-type-inference-classifies-computation-rate-to-enable-appropriate-caching]]
7. [[faust-vectorized-code-generation-splits-sample-loop-into-multiple-simpler-loops-to-expose-simd]]
8. [[memory-bandwidth-is-the-binding-constraint-for-audio-dsp-parallelism-on-smp-machines]]
9. [[faust-symbolic-propagation-normalizes-structurally-different-programs-that-compute-identical-functions]]
10. [[dataflow-languages-lack-explicit-formal-semantics-making-program-behavior-engine-dependent]]
11. [[faust-compiler-discovers-parallelism-automatically-but-expressing-it-efficiently-remains-hard]] (open-question type)

## Source Reference Created

- [[faust-2009-npcm]]

## Existing Claims Enriched (reweave)

- [[eliminating-unit-generators-exposes-synthesis-graphs-to-cross-boundary-compiler-optimization]] -- added FAUST as prior art for functional DSP and its mechanism
- [[library-languages-must-not-bundle-a-mandatory-runtime]] -- added FAUST architecture files as second existence proof
- [[static-languages-prevent-runtime-introspection]] -- added nuance: FAUST compensates via formal semantics but is still static

## Topic Maps Updated

- [[competing-systems]] -- added FAUST section (11 entries)
- [[audio-dsp]] -- added FAUST Prior Art section (5 entries)
- [[language-design]] -- added FAUST: Formal Semantics section (5 entries)
- [[index]] -- added faust-2009-npcm source reference

## Connections Added

Approximately 30+ forward and backward connections woven into claim prose.

## Notable Insights

1. **Denotational semantics is the specific mechanism** enabling FAUST's optimization power — not just "functional" in general, but having a precise mathematical denotation for every expression
2. **Memory bandwidth is the binding DSP parallelism constraint** — confirmed empirically across 3 machines; SIMD outperforms SMP for most DSP workloads
3. **Architecture file system is the FAUST solution to embeddability** — directly confirms [[library-languages-must-not-bundle-a-mandatory-runtime]] from the DSP language direction
4. **Implicit one-sample delay is the feedback primitive** — clarifies the semantics murail needs to support for feedback loops

## No Learnings Captured

No friction, surprises, or methodology gaps noted during this processing session.
