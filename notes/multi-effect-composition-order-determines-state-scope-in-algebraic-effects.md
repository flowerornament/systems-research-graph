---
description: Nesting state outside ambiguity gives shared global state across branches; nesting state inside ambiguity gives independent per-branch state; both are valid, type-checked, and programmer-controlled
type: claim
evidence: strong
source: [[leijen-2016-algebraic-effects-tr]]
created: 2026-03-01
status: active
---

# multi-effect composition order determines state scope in algebraic effects

Leijen's Section 2.4 provides a concrete demonstration of how algebraic effect handlers handle the non-commutativity of effect composition -- the same issue that makes monad transformers difficult. The `surprising` function uses both `state⟨int⟩` and `amb` effects:

```
fun surprising() : ⟨state⟨int⟩, amb⟩ bool {
  val p = flip()
  val i = get()
  put(i + 1)
  if (i ≥ 1 && p) then xor() else False
}
```

**Outer state, inner ambiguity** (`state(0, { amb(surprising) })`):
- State is shared across all ambiguous branches
- Result: `([False, False, True, True, False], 2)` -- the state counter is global, so branching point accumulates

**Outer ambiguity, inner state** (`amb({ state(0, surprising) })`):
- Each branch gets its own copy of the initial state
- Result: `[(False, 1), (False, 1), ...]` -- the counter resets for each branch independently

Both orderings typecheck. Neither is an error. The programmer chooses the semantics by choosing the handler nesting order. This is the algebraic effects solution to the monad transformer problem: rather than requiring the programmer to pick a fixed monad stack, the semantics is determined at the call site by handler ordering, and the type system allows both.

**Contrast with monad transformers**: `StateT ExceptT` and `ExceptT StateT` in Haskell give different semantics, but the choice is fixed at type-definition time and changing it requires rewriting the monad stack. With algebraic effects, the same effect-polymorphic program runs under either ordering.

**Why this is not surprising in retrospect**: the free monad restriction (which is what makes algebraic effects freely composable -- see [[row-typed-effects-compose-freely-because-they-are-restricted-to-the-free-monad]]) means that individual effects cannot observe each other's state. The interaction is mediated entirely through the handler nesting structure, making the semantics fully determined by the nesting order.

**Relevance to murail**: if audio graph execution uses algebraic effects for resource management (scheduling, buffer access, error recovery), composition order semantics is not a bug -- it is the mechanism by which programmers control resource scoping. An error handler nested inside a rate-conversion handler vs. outside it gives different error recovery semantics, and the type system makes both safe.
