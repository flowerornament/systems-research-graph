---
description: Domain-specific effects separate what operations a computation invokes from how those operations are evaluated, enabling multiple handlers to give different semantics to the same program
type: pattern
evidence: strong
source: [[leijen-2016-algebraic-effects-tr]]
created: 2026-03-01
status: active
---

# algebraic effects implement domain-specific DSLs by separating the operation interface from evaluation strategy

Leijen's Section 2.6 demonstrates that algebraic effects are not just a mechanism for system effects (exceptions, state, async) -- they are a general pattern for domain-specific embedded languages. The parser combinator example is illustrative:

**Interface** (the `parse` effect): a single operation `satisfy : (string → maybe⟨(a, string)⟩) → parse a` that tests whether the current input satisfies a predicate. This is the abstract DSL surface.

**Handlers** (the evaluation strategy): the same `parse`-effect program can be evaluated under different handlers:
- `solutions` handler: returns all possible parses (like PEG with backtracking)
- `eager` handler: returns the first successful parse

A parser like `expr()` is written once, against the abstract effect interface. Swapping the handler changes the parsing strategy without touching the parser code.

This separation is more principled than traditional library embedding:
- A monadic parser library bakes the evaluation strategy into the `>>=` implementation; changing strategy requires a different monad type and rewriting all bind uses
- Effect handlers decouple the program (which only uses operations) from the evaluator (which is the handler); programs are effect-polymorphic and handlers are pluggable

The same pattern applies to other DSLs in the same paper: a `flip` operation with the `coinflip` handler gives randomized evaluation; the same `flip` with the `amb` handler gives all-branches enumeration. These are literally different semantics for the same operation.

**Implication for murail**: this pattern is directly applicable to audio DSL design. A `sample-read` effect could have multiple handlers: a real-time handler that reads from a ring buffer, a test handler that replays a fixture, a visualization handler that logs values. The same audio graph code runs under all handlers without modification. This is the extensibility benefit [[evolvability-requires-trading-provability-for-extensibility]] identifies, but achieved through type-safe effect handlers rather than runtime generic dispatch.

Connects to [[algebraic-effects-unify-exceptions-state-iterators-and-async-under-a-single-abstraction]]: the domain-specific case is the generalization of that claim. It is not just that algebraic effects unify known control-flow constructs -- they provide the abstraction mechanism for any new domain-specific computation pattern.

See also [[handler-composition-order-determines-effect-scope-making-semantics-explicit-and-controllable]] for how multiple effects interact in the same program.
