---
batch: murail-substrate-v3
date: 2026-02-28
source: /Users/morgan/code/murail/.design/formal-model/murail-substrate-v3.md
claims_created: 15
enrichments: 3
connections_added: 28
topic_maps_updated: 3
existing_claims_updated: 2
---

# Batch Summary: murail-substrate-v3

## Source

Murail substrate specification v3 (February 2026). Domain-independent formal model for real-time recurrence over tensors. Four-layer architecture: Layer 0 (The Calculus), Layer 1 (The Execution Model), Layer 2 (The Liveness Model), Layer 3 (The Domain Interface).

## Claims Created

### Layer 0: The Calculus
- [[guarded-self-reference-is-the-sole-mechanism-for-temporal-evolution-in-the-murail-calculus]]
- [[the-causality-condition-requires-every-dependency-cycle-to-contain-a-delay-edge]]
- [[set-cardinality-and-tensor-shape-are-orthogonal-dimensions-in-the-murail-calculus]]
- [[variable-delay-requires-a-compile-time-declared-maximum-enabling-static-ring-buffer-allocation]]

### Layer 1: The Execution Model
- [[all-murail-program-state-fits-in-a-single-pre-allocated-contiguous-region]]
- [[block-size-is-the-primary-latency-throughput-tradeoff-in-murail-execution]]
- [[hold-slots-prevent-fast-thread-blocking-on-slow-rate-values-without-locks]]
- [[cross-rate-smoothing-eliminates-staircase-discontinuities-from-hold-slot-reads]]
- [[tick-boundary-precedence-is-a-substrate-requirement-not-an-implementation-suggestion]]
- [[the-murail-fast-thread-never-halts-errors-degrade-quality-but-do-not-stop-evaluation]]
- [[load-shedding-preserves-the-critical-set-exactly-while-degrading-non-critical-equations]]

### Layer 2: The Liveness Model
- [[atomic-swap-enables-program-updates-at-tick-granularity-without-output-gaps]]
- [[the-migration-map-transforms-state-between-program-versions-preserving-continuity-where-possible]]

### Layer 3 / Cross-Cutting
- [[the-murail-substrate-is-instantiated-by-a-domain-configuration-without-modifying-layers-0-through-2]]
- [[dsp-and-ml-are-structurally-identical-under-shape-driven-dispatch-in-the-murail-calculus]]

## Reference Note
- [[murail-substrate-v3]]

## Enrichments to Existing Claims (3)
- [[compile-and-swap-preserves-audio-continuity-during-recompilation]] -- added connections to atomic-swap, migration-map, tick-boundary-precedence
- [[faust-recursive-composition-with-implicit-one-sample-delay-is-the-primitive-for-all-feedback]] -- added substrate generalization connection
- [[dataflow-languages-lack-explicit-formal-semantics-making-program-behavior-engine-dependent]] -- added substrate architecture connection

## Topic Maps Updated (3)
- [[formal-methods]] -- added "Murail Substrate: Calculus Properties" section (6 claims) and new open question
- [[audio-dsp]] -- added "Murail Substrate: Execution Model" (7 claims) and "Liveness Model" (2 claims) sections
- [[concurrent-systems]] -- added 3 substrate claims to "Real-Time Thread Separation" section

## Notable Learnings
- The DSP/ML unification claim ([[dsp-and-ml-are-structurally-identical-under-shape-driven-dispatch-in-the-murail-calculus]]) bridges the [[ai-ml]] and [[formal-methods]] topic maps through a single formal result -- the most cross-cutting connection in this batch
- The four-layer substrate factoring provides a clear boundary for Lean verification scope: Layers 0-2 are domain-independent and verifiable without knowing about audio
- Hold slot protocols (§10) are a direct formalization of what was previously ad-hoc practice; the formal specification enables precise correctness claims for the NRT/RT communication contract
