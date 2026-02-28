---
description: A FAUST program is a mathematical function from input signals to output signals; the compiler compiles the function, not the source text, enabling optimizations impossible in C
type: claim
evidence: strong
source: [[faust-2009-npcm]]
created: 2026-02-28
---

# FAUST programs denote mathematical functions enabling semantics-driven compilation

A FAUST program denotes a *signal processor* — a mathematical function mapping input signals to output signals, where signals are discrete functions of time. The compiler does not compile the block-diagram literally; it compiles the mathematical function the diagram denotes. This distinction is the source of FAUST's optimization power: semantically equivalent but structurally different programs compile to identical output, and the compiler can freely rearrange, factor, and normalize operations that preserve the mathematical function while improving efficiency.

The practical consequence is that `process = /(2) : @(10)` and `process = *(2) : @(7) : /(4) : @(3)` both compile to `Y(t) = 0.5 * X(t-10)` — the compiler discovers they are the same function and emits the same code.

This contrasts sharply with C/C++ compilers, which cannot optimize freely because side effects and pointer aliasing prevent semantic-equivalence reasoning. Since [[purely-functional-dsp-semantics-enables-compiler-optimizations-impossible-in-C]], FAUST's denotational model is the precise mechanism enabling this. The semantics-driven approach also enables automatic mathematical documentation generation and long-term program preservation — since the meaning is explicit, future compilers can regenerate equivalent implementations.

For murail's graph IR, this is the core argument for [[eliminating-unit-generators-exposes-synthesis-graphs-to-cross-boundary-compiler-optimization]]: opaque UGen objects block the compiler from reasoning about mathematical equivalence across node boundaries.

## Connections
- Extends [[eliminating-unit-generators-exposes-synthesis-graphs-to-cross-boundary-compiler-optimization]] by identifying denotational semantics as the specific mechanism that enables cross-boundary optimization
- Extends [[construction-time-graph-optimization-distributes-compiler-cost-across-node-creation]] — murail's construction-time rewrites are a partial instance of this: semantic normalization at graph build time
- See also [[faust-block-diagram-algebra-unifies-functional-programming-with-visual-patch-notation]] for the surface language that expresses these mathematical functions
