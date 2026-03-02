---
description: Daan Leijen's 2017 paper presenting end-to-end algebraic effects in Koka: row-typed inference, direct operational semantics, and type-directed selective CPS compilation
type: source-reference
created: 2026-02-28
---

# leijen-algebraic-effects

**Full title:** "Type Directed Compilation of Row-Typed Algebraic Effects"
**Author:** Daan Leijen, Microsoft Research
**Venue:** POPL 2017 (inferred from contemporaneous citations)
**Source file:** `/Users/morgan/code/murail/.design/references/papers/archive/leijen-algebraic-effects/leijen-algebraic-effects.pdf`

## What This Paper Argues

An end-to-end account of algebraic effect handlers as a practical language feature, demonstrated in the Koka language. The paper covers: language design (effects subsume exceptions, state, iterators, async-await), type system (row-polymorphic effect inference with scoped labels), operational semantics (direct style, not continuation calculus), and compilation (type-directed selective CPS to JavaScript/JVM/.NET).

## Claims Extracted

- [[algebraic-effects-unify-exceptions-state-iterators-and-async-under-a-single-abstraction]] -- core thesis: one mechanism replaces many specialized constructs
- [[effect-handlers-are-resumable-exceptions-that-capture-delimited-continuations]] -- operational semantics as captured delimited continuations; three-way resume classification
- [[row-typed-effects-compose-freely-because-they-are-restricted-to-the-free-monad]] -- algebraic restriction to free monad makes composition automatic unlike monad transformers
- [[type-directed-selective-cps-translation-eliminates-overhead-for-total-functions]] -- 80% of Koka stdlib functions avoid CPS after type simplification
- [[effect-polymorphic-functions-require-dual-compilation-to-avoid-calling-convention-mismatches]] -- polymorphic code duplication to handle CPS/non-CPS call sites
- [[handler-composition-order-determines-effect-scope-making-semantics-explicit-and-controllable]] -- nesting handlers in different orders gives different semantics; both are valid and controlled
- [[nominal-effect-types-keep-inferred-types-small-at-the-cost-of-requiring-complete-handlers]] -- nominal vs structural effect types tradeoff; Koka's empirical success with nominal approach
- [[tail-resumption-optimization-eliminates-continuation-capture-for-the-common-case]] -- stateful effects with tail-position resume compile to direct function calls
- [[well-typed-algebraic-effect-programs-cannot-invoke-unhandled-operations]] -- effect soundness: type system statically guarantees every operation has a handler
- [[algebraic-effects-model-async-without-async-await-keywords-by-registering-the-continuation-as-a-callback]] -- async-await as library code; handler registers resume as OS callback

## Key References in Paper
- Plotkin and Power (2002): algebraic effects as algebraic model
- Plotkin and Pretnar (2009): effect handlers
- Leijen (2005): extensible records with scoped labels (the type system substrate)
- Koka language implementation: http://bit.do/kokabook

---

Topics:
- [[language-design]]
- [[formal-methods]]
