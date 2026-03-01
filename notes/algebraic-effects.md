---
description: Algebraic effect handlers as a unified abstraction for exceptions, state, async, and control flow, with compilation strategies
type: moc
created: 2026-02-28
---

# algebraic-effects

Algebraic effects as a language mechanism, drawn from Leijen's 2017 work and the Koka language. Effect handlers unify what most languages handle with five or more specialized constructs. Claims cover the core abstraction, type system design, compilation strategies, and performance characteristics.

## Claims

### Algebraic Effects for Murail
- [[effects-as-capabilities-can-encode-rt-safety-requirements-in-the-composition-language-type-system]] -- value-level capability tokens for I/O and allocation; RT functions lacking these tokens are statically RT-safe; lighter-weight than full effect type systems for the RT-safety use case specifically

### Algebraic Effects (Leijen 2017, Koka)
- [[algebraic-effects-unify-exceptions-state-iterators-and-async-under-a-single-abstraction]] -- one mechanism (effect handlers) subsumes exceptions, mutable state, iterators, async-await, and non-determinism; eliminates specialized language constructs and their interaction surface
- [[effect-handlers-are-resumable-exceptions-that-capture-delimited-continuations]] -- operational semantics: three-way classification (no resume, tail resume, non-tail/multiple resume) determines compilation strategy and overhead
- [[row-typed-effects-compose-freely-because-they-are-restricted-to-the-free-monad]] -- algebraic restriction to free monad makes composition automatic unlike monad transformers; nesting order controls scoping semantics explicitly
- [[type-directed-selective-cps-translation-eliminates-overhead-for-total-functions]] -- 80% of Koka stdlib functions avoid CPS transformation after type simplification; inner-loop code pays zero overhead
- [[effect-polymorphic-functions-require-dual-compilation-to-avoid-calling-convention-mismatches]] -- functions polymorphic over effects need CPS and non-CPS compiled versions plus a runtime wrapper; 20% code size increase in practice
- [[handler-composition-order-determines-effect-scope-making-semantics-explicit-and-controllable]] -- outer vs inner handler nesting gives global vs local state semantics; both are valid, type-checked, and programmer-controlled
- [[nominal-effect-types-keep-inferred-types-small-at-the-cost-of-requiring-complete-handlers]] -- Koka's nominal approach keeps types readable at 14,000 loc scale; structural approach (Links) is more expressive but verbose
- [[tail-resumption-optimization-eliminates-continuation-capture-for-the-common-case]] -- tail-position single resume (the common case for state, logging, simple I/O) compiles to a direct function call with zero overhead
- [[well-typed-algebraic-effect-programs-cannot-invoke-unhandled-operations]] -- effect soundness: type system statically guarantees every operation invocation has a handler; eliminates runtime equivalent of unhandled exceptions
- [[algebraic-effects-model-async-without-async-await-keywords-by-registering-the-continuation-as-a-callback]] -- handler registers resume continuation as OS callback; async-await as library code, not language syntax; multi-core OCaml uses this for concurrency

### Algebraic Effects -- Type System and Compilation (Leijen 2016 TR)
- [[open-and-close-type-rules-preserve-completeness-while-simplifying-effect-polymorphic-types]] -- open/close rules reduce 80% of stdlib functions to closed types without restricting typeable programs; completeness preserved by open re-introducing polymorphism at each use site
- [[deep-handlers-differ-from-shallow-handlers-because-continuation-is-resumed-under-the-same-handler]] -- deep handlers fold over the full effect algebra by re-entering the same handler on each resume; shallow handlers do one fold level and the continuation escapes
- [[algebraic-effects-implement-domain-specific-dsls-by-separating-the-operation-interface-from-evaluation-strategy]] -- the same effect program runs under different handlers giving different evaluation strategies; parser combinators as concrete example
- [[multi-effect-composition-order-determines-state-scope-in-algebraic-effects]] -- outer-state/inner-amb gives shared state; inner-state/outer-amb gives per-branch state; both valid, both type-checked, semantics determined by nesting
- [[a-trampoline-runtime-implements-tail-resumption-as-a-loop-eliminating-stack-growth-for-effect-handlers]] -- handler stack as trampolining loop enables proper tail calls without native stack manipulation on any target platform
- [[effect-type-absence-is-a-proof-of-non-interference]] -- a function typed with an empty effect row is statically proved to not invoke any user-defined effect; non-throwing guarantee is machine-checked, not convention

---

Topics:
- [[index]]
- [[language-design]]
