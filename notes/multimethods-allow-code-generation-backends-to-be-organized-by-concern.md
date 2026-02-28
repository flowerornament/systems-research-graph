---
description: Dispatching on both the code generator type and the expression type lets all code generation for one backend live in one place, preventing the concern-spreading that the visitor pattern only partially solves
type: claim
evidence: moderate
source: [[mccartney-ideas-2026-02-15]]
created: 2026-02-28
status: active
---

# multimethods allow code generation backends to be organized by concern

In a single-dispatch language, code that logically belongs together gets spread across classes. To generate code from multiple expression types across multiple backends (C, Rust, WASM), you either scatter codegen methods across every expression class or use the visitor pattern -- which shifts the spreading to visitor implementations.

McCartney's new language uses multimethods (dispatch on multiple arguments), which allow code generation to be organized by backend rather than by expression type:

```
fn emit(gen: CCodeGen, expr: SinOsc) = ...;
fn emit(gen: CCodeGen, expr: OnePole) = ...;
fn emit(gen: RustCodeGen, expr: SinOsc) = ...;
```

All C backend code lives together; all Rust backend code lives together. Adding a new backend adds a new set of `emit` methods, not modifications to every expression class. Adding a new expression type adds one method per backend -- the expression problem is still present, but the backend dimension is solved cleanly.

McCartney traces this to Dylan and CLOS, not novel in PL theory but novel in audio language design. His motivation is explicit: "if you're in a single dispatch language, then you're spreading out code generation all over all the classes, and maybe you want a different code generator."

The same principle applies to any concern that crosses type boundaries: type conversion (`as_signal` for Float, Array, Signal), pretty-printing, serialization. Single-dispatch forces the responsibility into the types; multimethods let responsibility live where the concern originated.

**Question for Murail:** This matters most for the composition language and code generation pipeline. If multiple backends are planned (native, WASM, hardware), multimethod-style organization prevents concern spreading. Rust traits are single-dispatch, but the same organization can be achieved with enum dispatch or trait objects at the cost of explicit boilerplate. For Murail's optimizer/compiler, the question is whether the concern-organization benefit justifies a non-idiomatic Rust pattern or whether Rust's enum approach is sufficient.

Related to [[generic-operations-allow-extending-existing-code-over-new-types-without-modification]] -- both address the expression problem but from different directions: Sussman/Lisp extend over types at runtime; McCartney extends over operations at the source level via multimethod dispatch. See also [[evolvability-requires-trading-provability-for-extensibility]], where the extensibility concern is the same but the mechanism differs.
