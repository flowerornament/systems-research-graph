---
description: The operational semantics of algebraic effect handlers is equivalent to resumable exceptions where the resume continuation is captured up to the nearest enclosing handler
type: claim
evidence: strong
source: [[leijen-algebraic-effects]]
created: 2026-02-28
status: active
---

# effect handlers are resumable exceptions that capture delimited continuations

Leijen's direct operational semantics (Figure 4) makes the relationship concrete: when an operation `op(v)` is evaluated, the evaluation context `Xop[op(v)]` up to the nearest enclosing handler for `op` is captured as a continuation `resume = λy. handle{h}(Xop[y])`. The handler clause then runs with that continuation bound to the `resume` identifier.

This is exactly delimited continuation capture: `Xop` is the context up to the delimiter (the handler), and `resume` is the reified continuation from the operation invocation point back to -- and through -- the same handler. Crucially, the continuation is re-wrapped under the same handler (`handle{h}` appears in the captured lambda), which distinguishes *deep* handlers (fold over the entire effect algebra) from *shallow* handlers (one level of the fold).

The equivalence to delimited continuations is formal: `reset0(e) ≡ handle{ shift0(f) → f(resume) }(e)`. Any algebraic effect handler can be encoded with `shift0`/`reset0`, and vice versa -- though the latter requires mutable state to implement a global handler stack.

Concrete implication for control flow design: the three cases are
1. **No resume**: exception-like (abort), no stack capture needed
2. **Tail resume**: resume at tail position, reduces to a direct function call (no capture needed)
3. **Non-tail or multiple resume**: requires capturing the delimited continuation

This three-way classification matters for [[language-design]] because tail resumptions (case 2) are the common case in audio-rate state operations (get/put in a counter) and can be compiled to ordinary function calls -- zero continuation overhead. Only non-deterministic or interleaved effects require the expensive capture.

Connects to [[clojure-csp-channels-sacrifice-introspectability]]: CSP channels implement a form of delimited continuation (the goroutine suspends at a channel read and resumes when a value arrives) but compile it away entirely, losing introspectability. Effect handlers provide the same resumption model while keeping the handler stack inspectable and the continuation explicit.
