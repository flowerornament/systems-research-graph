---
description: Deep handlers wrap the captured continuation under the same handler so each resumption re-enters the fold; shallow handlers do one level of the fold and the continuation escapes
type: claim
evidence: strong
source: [[leijen-2016-algebraic-effects-tr]]
created: 2026-03-01
status: active
---

# deep handlers differ from shallow handlers because continuation is resumed under the same handler

Leijen's operational semantics (Figure 4, the `handle` rule) reveals a design choice that is invisible syntactically but semantically decisive. When an operation clause captures the execution context, the `resume` variable is bound to:

```
resume = λy. handle{h}(Xop[y])
```

The `handle{h}` wrapper inside the lambda is the critical detail. Every time `resume` is applied, evaluation re-enters the *same* handler `h`. This means the handler performs a *fold* over the entire effect algebra -- it handles all operations in the computation, not just the first one.

**Shallow handlers** (the alternative, used in some systems) bind `resume` without the handler wrapper: `resume = λy. Xop[y]`. After the first operation is handled, the continuation runs without the handler. The computation can issue subsequent operations that escape to an outer context. This is analogous to a `case` statement -- one level of the fold, not a recursive one.

**Why deep handlers are the default**: deep handlers correspond to the original categorical interpretation of effect handlers as a fold over the free monad algebra (Plotkin and Pretnar 2009). Per [[handling-a-computation-is-composing-it-with-the-unique-free-model-homomorphism]], handling is the unique homomorphism from the free model; deep handlers maintain this homomorphism property at every resumption. They give cleaner semantics for recursive effect processing -- an iterator that yields values is naturally modeled as a deep handler (each yield goes to the same foreach logic, not escaping). Shallow handlers are useful when the handler needs to inspect what effect is issued and then delegate to a different handler.

**Practical consequence**: the `surrounding-by-same-handler` property is what makes multi-level effects work correctly. In the ambiguity handler `amb`, each `flip` invocation resumes into the same `amb` handler, which collects all results in a list. If `resume` were not wrapped, the second and subsequent flips would escape to the outer context and be mishandled.

This connects to [[effect-handlers-are-resumable-exceptions-that-capture-delimited-continuations]]: the continuations in Leijen's system are deep by construction. The shift/reset equivalence (`reset0(e) ≡ handle{ shift0(f) → f(resume) }(e)`) holds because shift0 also captures the continuation up to the nearest reset0, which stays in place for subsequent uses.

Relevance to [[language-design]]: if murail's composition language adopts effect handlers for control flow (pause/resume, demand-rate switching), the deep vs shallow choice determines whether a handler can process a sequence of operations or only the first. Deep is the right default for audio-rate scheduling contexts.
