---
description: Leijen's 2016 Microsoft technical report giving end-to-end algebraic effects in Koka: language design, row-type inference, direct operational semantics, and selective CPS compilation
type: source-reference
created: 2026-03-01
---

# leijen-2016-algebraic-effects-tr

**Full title:** "Algebraic Effects for Functional Programming (Type Directed Compilation of Row-typed Algebraic Effects)"
**Author:** Daan Leijen, Microsoft Research
**Venue:** Microsoft Technical Report, August 2016
**Source file:** `/Users/morgan/code/murail/.design/references/papers/archive/leijen-2016-algebraic-effects-tr/leijen-2016-algebraic-effects-tr.pdf`

## Relationship to Prior Processing

This is the technical report version of the same paper processed as [[leijen-algebraic-effects]] (the POPL 2017 conference version). The TR is a longer, more formal presentation including complete proofs, additional language design examples, and a worked-out comparison to delimited continuations. Claims extracted here are distinct from the conference paper batch -- they cover material in depth not represented in the prior extraction.

## What This Paper Argues

An end-to-end account of algebraic effect handlers in the Koka language targeting common runtime platforms (JavaScript, JVM, .NET). Key contributions:

1. **Language design**: effects subsume exceptions, state, iterators, async-await, non-determinism, and domain-specific effects (parser combinators) via a single handler construct
2. **Type system**: row-polymorphic effect inference with scoped labels; `open`/`close` rules simplify types while preserving completeness
3. **Operational semantics**: five-rule direct semantics using syntactic evaluation contexts; formal equivalence to shift/reset delimited continuations
4. **Soundness**: semantic soundness theorem with subject reduction and faulty-not-typeable proofs
5. **Compilation**: type-directed selective CPS to JavaScript; polymorphic code duplication for effect-polymorphic functions; trampoline runtime for tail-call optimization

## Claims Extracted

- [[open-and-close-type-rules-preserve-completeness-while-simplifying-effect-polymorphic-types]] -- type simplification is observable as sound; open/close rules do not restrict typeable programs
- [[deep-handlers-differ-from-shallow-handlers-because-continuation-is-resumed-under-the-same-handler]] -- the wrap-under-same-handler property (deep) versus one-level fold (shallow) has semantic consequences for recursive effects
- [[algebraic-effects-implement-domain-specific-dsls-by-separating-the-operation-interface-from-evaluation-strategy]] -- parser combinators, name supply, warning effects: same effect, different handler semantics; the interface/semantics separation is the mechanism
- [[multi-effect-composition-order-determines-state-scope-in-algebraic-effects]] -- outer-state/inner-amb gives shared state; inner-state/outer-amb gives per-branch state; both valid, both type-checked, semantics determined by nesting
- [[a-trampoline-runtime-implements-tail-resumption-as-a-loop-eliminating-stack-growth-for-effect-handlers]] -- handler stack as trampolining loop: operations return to the loop rather than growing the call stack; enables proper tail calls without native stack manipulation
- [[effect-type-absence-is-a-proof-of-non-interference]] -- a function typed `() → ⟨⟩ int` is provably total and non-throwing; effect types are not just documentation, they eliminate a class of runtime errors by construction

## Key References in Paper

- Plotkin and Power (2002): algebraic effects as algebraic model of computational effects
- Plotkin and Pretnar (2009): algebraic effect handlers
- Leijen (2005): extensible records with scoped labels (the type system substrate)
- Kammar et al. (2013): handlers in action (Template Haskell library implementation)
- Nielsen (2001): selective CPS transformation for callcc (the compilation basis)
- OCaml multicore (Dolan et al. 2015): one-shot effects for concurrency

---

Topics:
- [[language-design]]
- [[formal-methods]]
