---
description: An asynchronous effect handler registers the captured resume continuation as the OS-level callback, implementing async-await semantics in library code without any special language syntax or compiler pass
type: claim
evidence: strong
source: [[leijen-algebraic-effects]]
created: 2026-02-28
status: active
---

# algebraic effects model async without async-await keywords by registering the continuation as a callback

Leijen's async example shows that async-await -- which requires dedicated compiler infrastructure in C#, JavaScript, and Python -- falls out of algebraic effects without any special language support:

```
effect async { readline() : string }

val outer-async = handler {
  readline() → prim-readline(resume)
}
```

The `readline()` operation clause returns immediately to the NodeJS event loop, having registered `resume` as the callback for `prim-readline`. When input arrives, `resume(input)` is called -- continuing the program exactly where `readline()` was invoked, with the input as its result.

The program using this effect looks like direct, sequential code:
```
fun ask-age() {
  println("what is your name?")
  val name = readline()   // suspends here, resumes when input arrives
  println("hello " + name)
}
```

The inferred type `() → ⟨async, console⟩ ()` makes asynchronicity explicit without requiring `async` keyword annotations at every call site. Leijen's point: in async-await style, every async function needs the `async` keyword and every await point needs `await`. With effects, the type signature carries the information once; the body reads as sequential code.

Leijen mentions multi-core OCaml (effects for concurrency via one-shot effects) as a system using the same technique.

This has direct relevance to [[concurrent-systems]] in murail: the NRT-to-RT handoff (compile-and-swap, parameter updates) involves exactly this pattern -- an operation on the NRT side that suspends until the RT thread acknowledges. If modeled as an algebraic effect, the NRT composition code could write sequential logic while the handler manages the actual thread coordination. Compare [[clojure-csp-channels-sacrifice-introspectability]]: channels implement suspension and resumption but compile it away; algebraic effects keep the continuation explicit and inspectable. The handler stack shows what is waiting.
