---
description: Type information identifies which functions can have user-defined effects, so CPS applies only where needed, leaving pure and built-in-effect functions unmodified and avoiding full-program overhead
type: claim
evidence: strong
source: [[leijen-algebraic-effects]]
created: 2026-02-28
status: active
---

# type-directed selective CPS translation eliminates overhead for total functions

Leijen's practical finding: a full CPS translation of algebraic effects imposes unacceptable overhead. The Koka Madoko markdown processor (a large real program, written in Koka itself) became too slow to run reliably in the browser with full CPS. A selective approach was necessary.

The selectivity criterion comes directly from the type system. Define `H(θ, ε)` -- "does this effect require CPS?" -- recursively:
- `H(θ, ⟨l | ε⟩) = H(l) ∨ H(θ, ε)` -- any user-defined effect label triggers CPS
- `H(θ, ⟨⟩) = false` -- empty effect (total function) needs no CPS
- `H(θ, μ) = μ ∉ θ` -- polymorphic effect variable is CPS unless forced closed

Built-in effects (exceptions, non-determinism, I/O) are provided by the target platform (JavaScript, JVM) and do not need CPS. Only user-defined algebraic effect operations require CPS translation.

The practical result: in Koka's standard library, type simplification (closing open polymorphic effect types wherever possible) reduced the set of CPS-translated functions by over 80%. The vast majority of functions -- arithmetic, data structure operations, all purely functional code -- are compiled as ordinary direct-style functions. CPS overhead only appears in functions that actually invoke effect handlers.

Implication for [[language-design]] in murail: this is the compilation model required to make algebraic effects practical in a performance-sensitive context. An audio graph language's inner loops (buffer fills, sample arithmetic) must remain zero-overhead; effects (event scheduling, parameter updates, error handling) can absorb CPS cost at the boundary. The 80% reduction figure is encouraging for practical use.

Connects to [[eliminating-unit-generators-exposes-synthesis-graphs-to-cross-boundary-compiler-optimization]] -- the selectivity principle is similar: identify the boundary between effectful and total code structurally (via types), then apply expensive transformations only to the effectful part.

The open/close type rules are what make the 80% reduction achievable: [[open-and-close-type-rules-preserve-completeness-while-simplifying-effect-polymorphic-types]] explains how closing open polymorphic effect types converts many higher-order functions to closed (total) types, which H(θ, ⟨⟩) = false then excludes from CPS translation entirely.
