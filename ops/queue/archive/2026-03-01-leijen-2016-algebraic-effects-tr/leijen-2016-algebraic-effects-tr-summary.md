---
description: Batch summary for leijen-2016-algebraic-effects-tr processing
created: 2026-03-01
---

# Batch Summary: leijen-2016-algebraic-effects-tr

**Source:** `/Users/morgan/code/murail/.design/references/papers/archive/leijen-2016-algebraic-effects-tr/leijen-2016-algebraic-effects-tr.pdf`
**Paper:** "Algebraic Effects for Functional Programming (Type Directed Compilation of Row-typed Algebraic Effects)" — Daan Leijen, Microsoft Research, August 2016

## Relationship to Prior Batch

This is the 2016 technical report version of the same paper as [[leijen-algebraic-effects]] (POPL 2017 conference version, processed 2026-02-28). The two files are distinct (193k vs 265k). The TR contains additional content including complete proofs, full type rules for the explicitly typed core calculus, the open/close type simplification rules with completeness proof, domain-specific effect examples (parser combinators, non-determinism), multi-effect composition order semantics, deep vs shallow handler distinction, and trampoline runtime details. Claims extracted here are non-overlapping with the prior batch.

## Extraction Results

- Source reference file created: 1 ([[leijen-2016-algebraic-effects-tr]])
- Claims extracted: 6
- Enrichments (existing claims updated): 4

## Claims Created

1. [[open-and-close-type-rules-preserve-completeness-while-simplifying-effect-polymorphic-types]]
2. [[deep-handlers-differ-from-shallow-handlers-because-continuation-is-resumed-under-the-same-handler]]
3. [[algebraic-effects-implement-domain-specific-dsls-by-separating-the-operation-interface-from-evaluation-strategy]]
4. [[multi-effect-composition-order-determines-state-scope-in-algebraic-effects]]
5. [[a-trampoline-runtime-implements-tail-resumption-as-a-loop-eliminating-stack-growth-for-effect-handlers]]
6. [[effect-type-absence-is-a-proof-of-non-interference]]

Source reference: [[leijen-2016-algebraic-effects-tr]]

## Existing Claims Enriched

- [[type-directed-selective-cps-translation-eliminates-overhead-for-total-functions]] -- added connection to open/close rules as the mechanism that makes the 80% reduction achievable
- [[tail-resumption-optimization-eliminates-continuation-capture-for-the-common-case]] -- added connection to trampoline runtime as the implementation mechanism
- [[well-typed-algebraic-effect-programs-cannot-invoke-unhandled-operations]] -- added connection to effect-type-absence as the positive corollary
- [[row-typed-effects-compose-freely-because-they-are-restricted-to-the-free-monad]] -- added connection to multi-effect composition order claim
- [[first-class-control-flow-nodes-in-synthesis-graphs-enable-conditional-and-demand-rate-execution]] -- added deep vs shallow handler distinction as relevant to audio-rate iteration patterns

## Topic Maps Updated

- [[algebraic-effects]] -- added "Algebraic Effects -- Type System and Compilation (Leijen 2016 TR)" section with all 6 claims
- [[language-design]] -- added [[leijen-2016-algebraic-effects-tr]] to Source References
- [[formal-methods]] -- added [[effect-type-absence-is-a-proof-of-non-interference]] and [[open-and-close-type-rules-preserve-completeness-while-simplifying-effect-polymorphic-types]] to Effect Type Soundness section

## Key Connections to murail Research

- **Real-time safety**: [[effect-type-absence-is-a-proof-of-non-interference]] is directly applicable to murail's no-allocation-on-fast-thread invariant ([[all-murail-program-state-fits-in-a-single-pre-allocated-contiguous-region]]). An effect type system could enforce this at compile time.
- **Embedded DSL design**: [[algebraic-effects-implement-domain-specific-dsls-by-separating-the-operation-interface-from-evaluation-strategy]] provides a principled mechanism for murail's "same audio graph code under different execution backends" goal (test, real-time, visualization).
- **Demand-rate execution**: [[deep-handlers-differ-from-shallow-handlers-because-continuation-is-resumed-under-the-same-handler]] is the answer to McCartney's unsolved pause/demand-rate problem in the context of algebraic effects -- deep handlers are the correct model for iterative audio-rate effects.
- **Type system design**: [[open-and-close-type-rules-preserve-completeness-while-simplifying-effect-polymorphic-types]] addresses the readability concern for effect-polymorphic types in a practical language; essential for any Stage 9 language design.

## Archive Location

`ops/queue/archive/2026-03-01-leijen-2016-algebraic-effects-tr/`
