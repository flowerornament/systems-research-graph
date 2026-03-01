---
description: When an operation clause calls resume exactly once in tail position, no continuation capture is needed -- evaluation reduces to a direct call, giving zero overhead for the most common effect pattern
type: claim
evidence: strong
source: [[leijen-algebraic-effects]]
created: 2026-02-28
status: active
---

# tail-resumption optimization eliminates continuation capture for the common case

Leijen derives an important optimization directly from the operational semantics. When an operation clause has the form `op(x) → resume(e)` with `resume ∉ fv(e)` (resume called once, in tail position, with no capture), the full reduction:

```
handle{h}(Xop[op(v)])
→ resume(e)[x → v, resume → λy. handle{h}(Xop[y])]
→ (λy. handle{h}(Xop[y]))(e[x → v])
→* handle{h}(Xop[v'])
```

shows that the context `Xop` is never captured -- evaluation proceeds directly to `handle{h}(Xop[v'])` without materializing the continuation. This is equivalent to a direct function call.

The implication: stateful effects where the handler always resumes once in tail position (the common case for `get`, `put`, `yield` in non-breaking iterators, logging) compile to direct function calls. The continuation capture machinery -- which is the expensive part of algebraic effects -- is bypassed entirely.

Leijen's example: `always-there = handler { getstr() → resume("there") }` -- the `resume` is in tail position, so this handler compiles without any continuation overhead. It is equivalent to passing a parameter through a chain of function calls.

This property is critical for practical performance: most "effects" in a real program (logging, configuration access, simple state) fit the tail-resumption pattern. Only non-determinism, backtracking, and async (where resume is called zero or multiple times, or at a non-tail position) require the full continuation machinery. This optimization directly exploits the three-way classification from [[effect-handlers-are-resumable-exceptions-that-capture-delimited-continuations]]: the tail-resume case (case 2) avoids materializing the delimited continuation entirely.

Relevance to murail's [[language-design]]: if algebraic effects are used for audio graph effects (node state, parameter access, timing), these are tail-resumptive operations -- the handler reads or writes state and resumes exactly once in tail position. They would compile to direct calls. The performance concern for algebraic effects in audio-rate code is therefore specifically about non-tail and multiple-resume patterns, which can be statically identified and avoided in the inner loop.

The runtime mechanism that makes tail resumption zero-overhead is the trampoline runtime: [[a-trampoline-runtime-implements-tail-resumption-as-a-loop-eliminating-stack-growth-for-effect-handlers]] describes how operations return to the trampoline loop rather than growing the stack, enabling proper tail calls without native stack manipulation on any platform.
