---
description: FAUST's symbolic propagation phase discovers the mathematical equations of each output signal, then normalizes them so that different block-diagrams computing equivalent results produce identical compiled code
type: property
evidence: strong
source: [[faust-2009-npcm]]
created: 2026-02-28
---

# FAUST symbolic propagation normalizes structurally different programs that compute identical functions

Before generating any code, the FAUST compiler performs *symbolic propagation*: it propagates symbolic signal expressions through the block-diagram, collecting the mathematical equation of each output signal. These equations are then normalized according to a set of algebraic rules.

The normalization rules include:
- Multiply-after-delay preference: it is better to apply a constant multiplier after a delay than before, because this lets multiple users share the same delay line
- Consecutive delay merging: `@(a) : @(b)` becomes `@(a+b)` — two sequential delays collapse into one
- Constant folding: arithmetic on compile-time constants is evaluated immediately

The practical result: `process = /(2) : @(10)` and `process = *(2) : @(7) : /(4) : @(3)` both normalize to `Y(t) = 0.5 * X(t-10)` and produce identical compiled code. The compiler compiles the normalized function, not the surface notation.

This normalization is what enables the [[faust-programs-denote-mathematical-functions-enabling-semantics-driven-compilation]] claim: the compiler has explicit access to the mathematical function, not just the program text.

For murail, the most directly applicable rule is delay merging — [[delay-merging-collapses-structurally-identical-delays-enabling-implicit-multi-tap-sharing]] is murail's equivalent, described as a first-pass graph optimization. The FAUST paper confirms that normalization at the symbolic equation level (before code generation) is more powerful than normalization at the graph node level, because it can detect semantic equivalences that structural graph rewrites cannot.

An open question: murail uses construction-time rewrites rather than a separate symbolic propagation phase. Whether symbolic propagation at compile time would find additional opportunities worth the added compiler complexity is unresolved.

## Connections
- Grounds [[faust-programs-denote-mathematical-functions-enabling-semantics-driven-compilation]] — symbolic propagation is the mechanism that extracts the mathematical function from the block-diagram
- Connects to [[delay-merging-collapses-structurally-identical-delays-enabling-implicit-multi-tap-sharing]] — murail's delay merging is a structural instance of what FAUST achieves symbolically
- Connects to [[construction-time-graph-optimization-distributes-compiler-cost-across-node-creation]] — murail applies rewrites at construction; FAUST applies them in a separate compilation phase; different tradeoffs
