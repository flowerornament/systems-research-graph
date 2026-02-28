---
description: Algebraic effect handlers subsume exceptions, mutable state, iterators, async-await, and non-determinism as instances of one mechanism, eliminating specialized language constructs for each
type: claim
evidence: strong
source: [[leijen-algebraic-effects]]
created: 2026-02-28
status: active
---

# algebraic effects unify exceptions state iterators and async under a single abstraction

Leijen demonstrates in the Koka language that a single well-founded abstraction -- algebraic effect handlers -- subsumes what most languages implement as separate, ad-hoc mechanisms:

- **Exceptions**: the `raise` operation with a handler that does not call `resume`
- **Mutable state**: `get`/`put` operations with a parameterized handler threading state through each `resume`
- **Iterators / yield**: the `yield` operation with handlers that either collect all results or break on condition -- the `foreach` handler is written once and works over any iterator
- **Async-await**: the `readline` operation with a handler that registers the continuation as an OS-level callback, re-entering when ready
- **Non-determinism / ambiguity**: `flip()` with a handler that resumes twice (once with `False`, once with `True`), collecting all outcomes
- **Parser combinators**: `fail`, `flip`, and `satisfy` composed into a complete parser combinator library with swappable evaluation strategies

The key insight: each of these previously required specialized syntax (generators with `yield`, `async`/`await` keywords, exception handling blocks) and separate compilation rules. Algebraic effects eliminate the need for each special case -- the language designer implements one general mechanism and derives all others as library code.

Leijen's framing: these constructs "can lead to subtle interactions with other features and require complex compilation mechanisms." Algebraic effects eliminate the interaction surface by grounding them in a single semantics.

This matters for [[language-design]] in murail's composition language context: if the Stage 9 language ever needs async (network calls, user input), pause/resume semantics, or error propagation, algebraic effects provide a single mechanism rather than three distinct protocol layers. It also matters for [[first-class-control-flow-nodes-in-synthesis-graphs-enable-conditional-and-demand-rate-execution]] -- the "pause" and demand-rate patterns McCartney struggles to implement in audio graphs are structurally similar to algebraic effects where an operation suspends and resumes on demand.
