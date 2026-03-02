---
description: Batch summary for leijen-algebraic-effects processing
created: 2026-02-28
---

# Batch Summary: leijen-algebraic-effects

**Source:** `/Users/morgan/code/murail/.design/references/papers/archive/leijen-algebraic-effects/leijen-algebraic-effects.pdf`
**Paper:** "Type Directed Compilation of Row-Typed Algebraic Effects" — Daan Leijen, Microsoft Research

## Extraction Results

- Claims extracted: 10
- Source reference file created: 1
- Enrichments (existing claims updated): 2

## Claims Created

1. [[algebraic-effects-unify-exceptions-state-iterators-and-async-under-a-single-abstraction]]
2. [[effect-handlers-are-resumable-exceptions-that-capture-delimited-continuations]]
3. [[row-typed-effects-compose-freely-because-they-are-restricted-to-the-free-monad]]
4. [[type-directed-selective-cps-translation-eliminates-overhead-for-total-functions]]
5. [[effect-polymorphic-functions-require-dual-compilation-to-avoid-calling-convention-mismatches]]
6. [[handler-composition-order-determines-effect-scope-making-semantics-explicit-and-controllable]]
7. [[nominal-effect-types-keep-inferred-types-small-at-the-cost-of-requiring-complete-handlers]]
8. [[tail-resumption-optimization-eliminates-continuation-capture-for-the-common-case]]
9. [[well-typed-algebraic-effect-programs-cannot-invoke-unhandled-operations]]
10. [[algebraic-effects-model-async-without-async-await-keywords-by-registering-the-continuation-as-a-callback]]

Source reference: [[leijen-algebraic-effects]]

## Existing Claims Enriched

- [[first-class-control-flow-nodes-in-synthesis-graphs-enable-conditional-and-demand-rate-execution]] -- added cross-language note connecting McCartney's unsolved pause/demand-rate problem to algebraic effects' explicit resumption model
- [[clojure-csp-channels-sacrifice-introspectability]] -- added contrast with algebraic effects' explicit continuation in handler clauses as the structural advantage over CSP channel compilation

## Topic Maps Updated

- [[language-design]] -- added "Algebraic Effects (Leijen 2017, Koka)" section with all 10 claims
- [[formal-methods]] -- added "Effect Type Soundness" section with soundness and composition claims

## Key Connections to murail Research

- **Stage 9 language design**: algebraic effects are a candidate mechanism for async, error propagation, and resource effects in murail's composition language -- the tail-resumption optimization means audio-rate state operations would have zero overhead
- **Concurrent systems**: the async-as-effect model directly addresses NRT/RT handoff patterns; provides explicit, inspectable continuations vs CSP's opaque compiled state machines
- **Formal methods**: Leijen's soundness proof (Lemma 4.b) is an instance of the kind of property murail's Lean proofs target -- static guarantee that resource operations are always handled
- **Compiler architecture**: selective CPS is directly analogous to murail's selectivity principle (pure math nodes vs effectful control flow nodes in the graph IR)

## Archive Location

`ops/queue/archive/2026-02-28-leijen-algebraic-effects/`
