---
description: Handlers on function types σ → χ simulate handlers that maintain and pass mutable state parameters without requiring a separate state effect, using handler application notation @v
type: pattern
evidence: strong
source: [[plotkin-pretnar-2009-handlers-of-algebraic-effects]]
created: 2026-03-01
status: active
---

# parameter-passing handlers simulate stateful handling by threading state through operation continuations

Plotkin and Pretnar introduce a syntactic sugar (Section 6.5) for handlers that need to maintain a running parameter across operations -- the `@` notation for parameter-passing handlers:

```
(x_p : σ; z_p : χ). {op_x(z)@x → h'_op} : (σ; χ) → χ@σ handler
```

where `χ@σ` abbreviates a handler on the function type `σ → χ`. The `@x` on the left binds the current parameter value; the handler clause `h'_op` can refer to the current parameter and produce a new one when invoking continuations.

**Concrete example -- timeout (Section 6.6)**:
```
(z_p : X). {delay(z)@T → delay(if T > 0 then z@(T-1) else z_p)}
```
The `T` parameter is the remaining time budget. Each `delay` operation decrements `T` by 1 and continues; if `T` reaches 0, the default value `z_p` is returned instead of continuing. The parameter `T` threads through every continuation without any explicit state effect.

**What this achieves**: stateful behavior (a counter, a budget, a list of changes) is encoded purely through continuation passing -- no separate `state` effect is needed. The function type `σ → χ` models the "current state is an implicit argument" pattern. The `@` sugar eliminates the boilerplate of manually threading the parameter through each continuation call.

**Input redirection (Section 6.7)**:
```
{in(z)@ℓ → if ℓ = nil() then in(a.z(a)@nil()) else z(head(ℓ))@tail(ℓ)}
```
A string `ℓ` is threaded through the handler: each `in` request takes the head of the remaining string and passes the tail as the new parameter. When the string is exhausted, fall back to actual input.

**Rollback (Section 6.8)**: the rollback handler threads a revert function `f : exc → X` through state operations. Each `update_l,d(z)@f` wraps the continuation to restore the old value if an exception is later raised, building a composed rollback function. This implements transactional memory semantics without a separate transaction effect.

**Connection to [[handler-composition-order-determines-effect-scope-making-semantics-explicit-and-controllable]]**: parameter-passing handlers are an alternative to composing a `state` effect with another effect. Instead of nesting a `state` handler around an `I/O` handler (which gives one scoping), you thread the state parameter through the I/O handler's continuations directly. The semantics is equivalent to the nested approach with state inside I/O, but encoded in a single handler.

**Practical implication for [[language-design]]**: parameter-passing handlers provide a way to implement handlers that carry context (current buffer position, remaining quota, revert log) without exposing a separate state effect in the type. For murail's composition language, this could simplify handlers that need to track position in a signal sequence or maintain a rolling budget -- encoding the state in the handler parameter rather than requiring an explicit `state` effect in the computation type.
