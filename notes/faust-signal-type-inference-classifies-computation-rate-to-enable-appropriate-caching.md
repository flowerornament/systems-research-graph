---
description: FAUST's type system classifies each signal expression as constant, init-time, UI-rate, or audio-rate, enabling the compiler to cache slow expressions and avoid recomputing them in the audio loop
type: property
evidence: strong
source: [[faust-2009-npcm]]
created: 2026-02-28
---

# FAUST signal type inference classifies computation rate to enable appropriate caching

FAUST's type inference assigns each signal expression a *computation speed* along a lattice with four levels:
1. **Constant** — computed at compile time, never recomputed
2. **Init-time** — computed once at initialization (e.g., filter coefficients from sample rate)
3. **UI rate** — computed once per audio buffer block (user interface parameters like sliders)
4. **Audio rate** — computed every sample

The type system then applies a caching rule: if a UI-rate expression appears in an audio-rate context, it is automatically cached in a variable so it is not recomputed per-sample. Similarly, a constant expression in a UI-rate context is cached at init time.

This is purely an optimization mechanism — from the user's perspective, every expression is a full-rate audio signal. The programmer does not annotate rates (unlike CSound's k-rate/a-rate distinction). The compiler infers the fastest rate at which any consumer of the expression runs, and promotes accordingly.

The occurrence analysis that follows discovers shared subexpressions: if `(input0[i] + input1[i])` appears on two output paths, it is cached in `float fTemp0` and both outputs reference the variable. This prevents redundant computation.

For murail, this is relevant to [[construction-time-graph-optimization-distributes-compiler-cost-across-node-creation]]: murail's compile-time rate inference (constant < init < reset < event < audio) is structurally the same mechanism. The FAUST paper confirms this approach works in practice and that the user-facing simplification (no explicit rate annotation) is desirable.

The contrast with CSound's explicit a-rate/k-rate annotations makes the point: a type system that infers rates and handles promotion automatically is strictly better UX with no loss of optimization opportunity.

## Connections
- Extends [[construction-time-graph-optimization-distributes-compiler-cost-across-node-creation]] — rate inference is one of murail's construction-time passes; FAUST confirms this is standard practice
- Connects to [[signal-shape-as-a-type-level-property-enables-compile-time-buffer-allocation-and-vectorization]] — both treat type-level properties as inputs to the code generator, not runtime metadata
- Grounds [[faust-programs-denote-mathematical-functions-enabling-semantics-driven-compilation]] — rate classification is only possible because expressions are pure functions with no hidden state dependencies
