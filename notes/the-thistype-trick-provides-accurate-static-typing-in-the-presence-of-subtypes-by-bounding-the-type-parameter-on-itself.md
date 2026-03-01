---
description: F-bounded polymorphism (sometimes called MyType or ThisType) lets a class refer to the type of its own concrete subclass, enabling covariant return types and accurate inheritance typing
type: pattern
evidence: strong
source: [[wadler-1998-expression-problem]]
created: 2026-03-01
status: active
---

# the thistype trick provides accurate static typing in the presence of subtypes by bounding the type parameter on itself

Wadler's solution uses F-bounded polymorphism: `class LangF<This extends LangF<This>>` and `class Lang2F<This extends Lang2F<This>>`. This is what Wadler calls "the standard trick to provide accurate static typing in the presence of subtypes (sometimes called MyType or ThisType)."

The trick encodes self-reference in the type: `This` is a type parameter bounded by the class being defined, so `This` always refers to the actual concrete subtype, not just the supertype. When `Lang` extends `LangF<Lang>`, `This` resolves to `Lang` throughout. When `Lang2F<Lang2>` is instantiated, `This` resolves to `Lang2`. The type `This.Exp` therefore refers to `Lang.Exp` in the first context and `Lang2.Exp` in the second.

This is why the fixpoints `Lang` and `Lang2` are necessary: even though `Lang2F` extends `LangF`, the instantiated classes `Lang` and `Lang2` are *unrelated*. Wadler notes this follows from requiring contravariant extension (Cartwright's approach) or, equivalently, from the semantics of this type parameter pattern. The classes are unrelated by design -- it is the best available under standard subtyping.

The F-bounded self-reference pattern appears throughout typed OO programming: Java's `Comparable<T extends Comparable<T>>`, Rust's trait bounds that mention `Self`, Scala's `this.type`. Each is a variant of the same trick. In Rust, `Self` is the native spelling; every trait method can refer to `Self` to achieve the same accurate self-referential typing that Wadler's `This` provides in GJ.

For murail's [[language-design]]: Rust's `Self` type in traits provides this capability natively. A `UGen` trait whose methods return `Self` rather than `dyn UGen` enables the same covariant typing that Wadler's `This` trick achieves in GJ. The question is whether Rust's static dispatch (monomorphization) or dynamic dispatch (trait objects) is appropriate for murail's graph nodes -- and whether the extension flexibility of virtual-type indexing ([[virtual-type-indexing-solves-the-expression-problem-by-allowing-subclasses-to-refer-to-sibling-types-in-their-bound]]) is achievable via GATs without sacrificing performance.
