---
description: Orlarey, Fober & Letz (2009): FAUST's functional DSP model, block-diagram algebra, semantics-driven compiler, scalar/vector/parallel code generation, and performance benchmarks
type: source-reference
created: 2026-02-28
---

# faust-2009-npcm

**Orlarey, Y., Fober, D., & Letz, S. (2009). FAUST: An Efficient Functional Approach to DSP Programming. In *New Computational Paradigms for Computer Music*, pp. 65-96. Editions DELATOUR FRANCE.**

HAL ID: hal-02159014 | https://hal.science/hal-02159014v1

## Summary

FAUST (Functional Audio Stream) is a compiled DSP language built on a denotational model: a FAUST program denotes a mathematical function from input signals to output signals. The compiler compiles this function, not the program text, enabling algebraic normalizations and optimizations impossible in C/C++. The language combines algebraic block-diagram composition with functional programming; five operators (sequential, parallel, recursive, split, merge) define a closed algebra over signal processors.

The paper covers: language overview, compiler architecture (symbolic propagation, type inference, occurrence analysis, scalar/vector/parallel code generation), and performance benchmarks across 7 DSP programs on 3 machines with 2 compilers.

## Claims Extracted

- [[faust-programs-denote-mathematical-functions-enabling-semantics-driven-compilation]]
- [[faust-block-diagram-algebra-unifies-functional-programming-with-visual-patch-notation]]
- [[purely-functional-dsp-semantics-enables-compiler-optimizations-impossible-in-C]]
- [[faust-separates-dsp-specification-from-host-architecture-enabling-multi-target-retargeting]]
- [[faust-recursive-composition-with-implicit-one-sample-delay-is-the-primitive-for-all-feedback]]
- [[faust-signal-type-inference-classifies-computation-rate-to-enable-appropriate-caching]]
- [[faust-vectorized-code-generation-splits-sample-loop-into-multiple-simpler-loops-to-expose-simd]]
- [[memory-bandwidth-is-the-binding-constraint-for-audio-dsp-parallelism-on-smp-machines]]
- [[faust-symbolic-propagation-normalizes-structurally-different-programs-that-compute-identical-functions]]
- [[dataflow-languages-lack-explicit-formal-semantics-making-program-behavior-engine-dependent]]
- [[faust-compiler-discovers-parallelism-automatically-but-expressing-it-efficiently-remains-hard]]
