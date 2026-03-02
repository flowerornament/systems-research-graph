---
description: Database-style transactional rollback is a handler that intercepts state operations and wraps each continuation with a function that restores the previous value if an exception is raised
type: pattern
evidence: strong
source: [[plotkin-pretnar-2009-handlers-of-algebraic-effects]]
created: 2026-03-01
status: active
---

# rollback is encodable as an effect handler that threads a revert function through state operations

Plotkin and Pretnar demonstrate (Section 6.8) that transactional rollback -- reverting all memory modifications when an exception is raised -- can be expressed as an algebraic effect handler combining state and exception effects:

```
H_rollback : X@(exc → X) handler
{
  update_l,d(z)@f  →  lookup_l(d'. update_l,d(z@(λe:exc. let x be f(e) in update_l,d'(x)))) ,
  lookup_l(z)@f    →  lookup_l(d. z(d)@f) ,
  raise_e()@f      →  f(e)
}
```

The threaded parameter `f : exc → X` is a revert function that accumulates the undo operations. When `update_l,d` is performed, the handler:
1. First reads the current value `d'` at `l`
2. Performs the update
3. Wraps the continuation so that if an exception `e` is later raised, it calls `f(e)` (the previous revert chain) and then restores `l` to `d'`

This builds a composed revert function incrementally -- each `update` adds one `lookup + restore` step to the revert chain. When an exception fires, `raise_e()@f → f(e)` triggers the entire accumulated revert chain in reverse order. The result is exactly the semantics of database transaction rollback.

**The key insight**: the handler separates *what to do on success* (proceed with the update) from *what to do on failure* (restore the previous state). The revert function parameter is the accumulated undo log. This is pure functional encoding of a concept usually implemented with mutable rollback logs or two-phase commit protocols.

**Prerequisite equation**: the effect theory for state must include `update_l,d(raise_e) = raise_e` for each unrecoverable exception `e`. Without this equation, the standard exception handler extended to state would be incorrect (it would not properly handle exceptions inside state operations). The rollback handler provides the correct model that satisfies this equation.

**Alternative variant**: Plotkin and Pretnar note that a variant that passes around "a list of changes to the memory, committed only after the computation has returned a value" is also derivable -- this corresponds to optimistic concurrency (collect all changes, then commit atomically).

**Connection to [[parameter-passing-handlers-simulate-stateful-handling-by-threading-state-through-operation-continuations]]**: rollback is an instance of the parameter-passing pattern. The `f : exc → X` parameter is the "state" threaded through operations, but it is a function (the accumulated revert logic) rather than a simple value.

**Connection to [[algebraic-operations-and-effect-handlers-are-categorically-dual-as-constructors-and-deconstructors]]**: the rollback handler demonstrates the deconstructor role concretely. The `update` operation *constructs* a stateful computation; the rollback handler *deconstructs* it by providing an alternative interpretation where each update is paired with its inverse.

Relevance to [[language-design]]: audio graph hot-swap -- replacing a running node with a new one while preserving audio state -- is structurally similar to transactional rollback. If the hot-swap fails (new node fails to initialize), the previous state should be restored. An effect handler approach would encode this as: each node-state-mutation operation builds a revert function; swap failure triggers the revert chain. This is more principled than ad-hoc exception handling in the audio engine.
