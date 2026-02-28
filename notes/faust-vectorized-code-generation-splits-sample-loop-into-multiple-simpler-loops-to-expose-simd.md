---
description: FAUST's vector code generator decomposes the single-sample computation loop into multiple independent section loops, producing code that C++ auto-vectorizers can target with SIMD instructions
type: pattern
evidence: strong
source: [[faust-2009-npcm]]
created: 2026-02-28
---

# FAUST vectorized code generation splits sample loop into multiple simpler loops to expose SIMD

Modern C++ compilers can auto-vectorize loops using SIMD instructions (SSE, AVX) — but only if the loop body is simple enough. Complex loops with mixed computation paths, pointer aliasing, or recursion defeat the vectorizer.

FAUST's vector code generator (`-vec` flag) addresses this by splitting the single sample-computation loop into multiple simpler "sections," each performing a distinct kind of computation. These sections communicate via intermediate vectors. The result is several simple, SIMD-friendly loops rather than one complex one.

The RMS benchmark demonstrates the impact concretely: the scalar code achieves 129 MB/s; the vectorized code achieves 359 MB/s with Intel icc — a 2.8x speedup using the same computation. The loops are more complex structurally, but each individual loop is amenable to SIMD because it operates on a single type of computation.

The vectorized code generator is built on top of the scalar generator: whenever a shared or recursive subexpression is identified, the compiler places it in a separate loop rather than inlining it. The result is a directed graph of computation loops; a topological sort determines execution order.

This architecture has a direct implication for murail: [[graph-compiler-loop-formation-groups-same-dimension-trees-to-enable-vectorization]] is murail's analogue. The FAUST paper confirms that this separation — treating each loop as a computation section with typed inputs/outputs — is the correct abstraction for exposing SIMD opportunities to a downstream C++ compiler.

A critical caveat from the benchmarks: GCC 4.3.2 failed to vectorize this code; Intel icc 11.0 succeeded. The opportunity exists in the generated code structure, but realizing it requires a vectorization-capable compiler. For murail targeting Rust/LLVM, LLVM's auto-vectorizer is the relevant downstream tool.

## Connections
- Extends [[purely-functional-dsp-semantics-enables-compiler-optimizations-impossible-in-C]] — vectorization is one payoff of the semantic freedom functional languages enable
- Extends [[graph-compiler-loop-formation-groups-same-dimension-trees-to-enable-vectorization]] — FAUST's section-based loop splitting is the prior art for murail's SIMD-targeting loop formation
- Connects to [[memory-bandwidth-is-the-binding-constraint-for-audio-dsp-parallelism-on-smp-machines]] — vectorization helps; parallelism may not, because both hit the same memory bus
