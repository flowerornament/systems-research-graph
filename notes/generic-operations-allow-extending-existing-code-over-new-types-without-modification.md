---
description: Dynamically extensible generic operations let programs that were written for one data type run over new types by adding dispatch cases, not by changing existing code
type: claim
evidence: strong
source: [[we-dont-know-how-to-compute-sussman-2011]]
created: 2026-02-28
status: active
---

# generic operations allow extending existing code over new types without modification

Sussman demonstrates a sequence of increasingly radical applications of generic operator dispatch (as seen in Lisp, and in weaker forms as operator overloading in Haskell/Scala). The key property: dispatch happens at runtime, not compile time, and new dispatch cases can be registered while the program is running.

Concrete examples from the talk:
- A numerical computation written for integers extends to rationals, floats, complex numbers, and exact complex numbers by registering new methods for `+`, `*`, etc.
- The same generic `+` dispatches to function addition: `(+ sin cos)` produces a new function that adds their outputs -- classical algebraic extension, achieved by adding one dispatch case.
- Symbolic algebra: the same arithmetic dispatch produces symbolic expressions instead of numbers. A gear integrator uses symbolic differentiation to compile optimal Runge-Kutta coefficients at runtime as the step size changes.
- Automatic differentiation via hyper-real numbers: `x + dx` with appropriate dispatch rules implements the chain rule mechanically, producing full derivatives at numeric speed.
- Dimensional analysis: units attach to numbers as another dispatch layer, making unit mismatches detectable at runtime.

All of these use the *same* existing code. The numerical integrator written for floating-point numbers produces exact symbolic expressions when its inputs are symbolic -- without any changes to the integrator itself. This is the extensibility Sussman points to as one concrete direction toward evolvable systems, as argued in [[evolvability-requires-trading-provability-for-extensibility]].

For murail's [[language-design]]: the audio graph DSL's UGen type system could adopt a similar generic dispatch model for signal types. Instead of hard-coding which UGens work at which rates, rate dispatch could be registered generically -- a UGen written for control-rate signals might extend to audio-rate or block-rate without modification.

Wadler's [[the-expression-problem-names-the-tension-between-adding-new-cases-and-new-operations-without-recompiling]] formalizes exactly what Sussman's generic dispatch solves: the cases dimension (adding new types without recompiling existing code). However, [[the-expression-problem-requires-static-type-safety-and-independent-compilation-simultaneously]] identifies the cost Sussman accepts: Lisp-style runtime generic dispatch sacrifices static type safety to achieve extensibility, precisely the tradeoff Wadler's GJ solution avoids via virtual type indexing.
