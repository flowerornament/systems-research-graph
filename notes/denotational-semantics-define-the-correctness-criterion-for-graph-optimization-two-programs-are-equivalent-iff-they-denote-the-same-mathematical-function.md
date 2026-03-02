---
description: StreamQL and Conal Elliott's FRP both establish that two stream programs are equivalent when they denote the same mathematical function, giving the graph optimizer a formal correctness criterion
type: property
evidence: strong
source: [[pl-research-landscape-2026-02-27]]
created: 2026-03-01
status: active
---

# denotational semantics define the correctness criterion for graph optimization: two programs are equivalent iff they denote the same mathematical function

StreamQL (OOPSLA 2020) provides algebraic stream transformations with denotational semantics: streams are first-class values with combinators for windowing, aggregation, filtering, and transformation. The denotational semantics assigns meaning to stream programs as mathematical functions on sequences, enabling equational reasoning. Two stream programs are equivalent if and only if they denote the same mathematical function on signal sequences.

Conal Elliott's LambdaJam 2015 talk grounds FRP in the same foundation: a signal is a function from time to value; a signal transformation is a function from functions to functions. Elliott argues that most "FRP" implementations have lost this denotational grounding, replacing it with operational mechanisms (event loops, push/pull propagation) that don't compose cleanly. The denotational semantics is both the correctness criterion and the compositional foundation.

For Murail's graph optimizer (D67), this provides the formal correctness criterion for rewrite rules. The 120+ rewrite rules in the Tier U optimization contract are sound if and only if each rewrite produces a program that denotes the same mathematical function as the original. Two graphs are interchangeable if they produce the same sequence of sample values for all inputs. This is not a statement about implementation equivalence -- two graphs can have completely different structure and still be semantically equivalent.

The formal model (Definition 3.1) already defines signal values as elements of rated tensor spaces, and the operational semantics (scheduling, compilation) are required to preserve the denotational meaning. This is Elliott's methodology applied to audio: define meaning first (what does a signal *mean* mathematically?), then prove the implementation preserves that meaning (the compilation is correct if the compiled schedule denotes the same function as the graph IR).

The practical implication for the graph optimizer is that equivalence proofs are required, not just intuitive arguments. "This rewrite looks correct" is not sufficient; "this rewrite preserves the denotational function" is the required standard. Equality saturation ([[equality-saturation-can-replace-hand-coded-rewrite-rules-with-automatically-discovered-provably-terminating-optimizations]]) discovers rewrites that are correct by construction -- the e-graph only adds equivalences, never removes them, so extracted programs always denote the same function as the original.

The denotational approach also gives the composition language a clean semantics that survives implementation changes. If the compiler changes -- from Cranelift to LLVM, from a scheduled graph to a JIT-compiled kernel -- the denotational semantics remain the specification. A program that denotes a particular function on signals always denotes that function, regardless of how it is compiled.

Connects to [[faust-programs-denote-mathematical-functions-enabling-semantics-driven-compilation]] -- FAUST demonstrates this methodology in practice for audio; this claim generalizes the principle. Extends [[purely-functional-dsp-semantics-enables-compiler-optimizations-impossible-in-C]] by specifying the correctness criterion those optimizations must satisfy. See [[equality-saturation-can-replace-hand-coded-rewrite-rules-with-automatically-discovered-provably-terminating-optimizations]] for the optimization technique that naturally satisfies this criterion.

---

Topics:
- [[formal-methods]]
- [[language-design]]
- [[audio-dsp]]
