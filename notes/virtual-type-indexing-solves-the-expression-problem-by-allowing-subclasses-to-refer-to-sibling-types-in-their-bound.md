---
description: The GJ mechanism that lets a type variable be indexed by inner classes of its bound enables co-evolution of mutually recursive types across class hierarchy extensions
type: pattern
evidence: strong
source: [[wadler-1998-expression-problem]]
created: 2026-03-01
status: active
---

# virtual type indexing solves the expression problem by allowing subclasses to refer to sibling types in their bound

The core mechanism in Wadler's GJ solution: a type variable `This` bounded by `LangF<This>` can be indexed by any inner class defined in that bound. So `This.Exp` and `This.Visitor` are valid type expressions -- they refer to the `Exp` and `Visitor` types as they exist in whichever concrete instantiation `This` resolves to.

Soundness requires that any type instantiating `This` must define inner classes extending those in the bound. `Lang2F<This>.Exp` extends `LangF<This>.Exp`; `Lang2F<This>.Visitor` extends `LangF<This>.Visitor`. This gives the type system enough information to accept the extension without knowing the concrete type at definition time.

The practical consequence: `Eval` in the second phase extends `LangF<This>.Eval` (picking up `forNum`) and implements `Lang2F<This>.Visitor<Integer>` (adding `forPlus`). Because `Visitor` is an interface (not an abstract class), both inheritance and interface implementation can coexist -- the solution *requires* `Visitor` to be an interface. This is the essential structural insight.

The mechanism is described in Wadler's prior note "Do parametric types beat virtual types?" Mads Torgersen and Kresten Krab Thorup passed on the key insight at OOPSLA: virtual types, as simulated by GJ, effectively support higher-order type parameters for free. Kim Bruce's alternative required genuine higher-order type constructors (parameterizing `Exp` on `Visitor`); GJ avoids this via `This.Visitor<R>`.

For murail's [[language-design]]: Rust's trait system provides a weaker but analogous mechanism. Associated types in traits allow a type to name a family of related types (`type Exp: ...`). However, Rust does not support the full virtual-type indexing that GJ's `This.Exp` enables. The closest Rust approximation is associated type families with GATs (Generic Associated Types), which were stabilized in Rust 1.65. This may be sufficient for murail's extensibility needs.
