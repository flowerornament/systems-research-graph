---
description: Nesting handlers in different orders gives semantically different programs -- outer state is global across branches, inner state is local to each branch -- but both orderings are valid and the type system tracks both
type: claim
evidence: strong
source: [[leijen-algebraic-effects]]
created: 2026-02-28
status: active
---

# handler composition order determines effect scope making semantics explicit and controllable

Leijen's `surprising` function combines state and ambiguity effects. The same function can be run with two handler orderings:

```
state(0, { amb(surprising) })   -- result: ([False,False,True,True,False], 2)
amb( { state(0,surprising) } )  -- result: [(False,1),(False,1)]
```

In the first case, `state` is the outer handler: state is shared across all ambiguous branches. The counter increments globally as each branch is explored. In the second case, `state` is inside `amb`: each branch gets its own independent copy of the state starting at 0.

This is the non-commutativity of effect composition made explicit and controllable. With monad transformers, discovering that `StateT ExceptT` vs `ExceptT StateT` have different semantics requires reading documentation or running code. With algebraic effects, the semantics is fully determined by handler nesting -- the programmer chooses it directly.

The type system does not distinguish these two orderings (both are valid types); the distinction is in the dynamic handler stack. This is a deliberate design choice: the type tracks *what* effects are present, not *how* they are nested. The programmer controls nesting order and thus controls the scoping semantics.

This matters for [[concurrent-systems]] in murail: concurrency effects (if modeled algebraically) would compose in the same way. An effect for "may allocate" composed with an effect for "may block" gives different runtime behavior depending on which is outer. Algebraic effects make this composition explicit rather than burying it in library semantics. Compare [[pervasive-immutability-dissolves-concurrency-problems-rather-than-managing-them]] -- McCartney's approach eliminates the composition problem by removing shared mutable state; algebraic effects solve it by making composition order a first-class program value.
