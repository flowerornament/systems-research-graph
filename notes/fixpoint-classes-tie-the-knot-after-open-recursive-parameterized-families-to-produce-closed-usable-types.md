---
description: F-bounded open families like LangF<This> cannot be used directly; fixpoint classes (Lang extends LangF<Lang>) close the recursion and produce concrete instantiable types
type: pattern
evidence: strong
source: [[wadler-1998-expression-problem]]
created: 2026-03-01
status: active
---

# fixpoint classes tie the knot after open recursive parameterized families to produce closed usable types

Wadler's solution separates two concerns: the *open recursive structure* (which admits extension) from the *closed usable type* (which can be instantiated). The open families `LangF<This extends LangF<This>>` and `Lang2F<This extends Lang2F<This>>` cannot be used directly -- they are parameterized by their own subtype and require resolution.

The fixpoint classes resolve this: `final class Lang extends LangF<Lang>` and `final class Lang2 extends Lang2F<Lang2>`. By instantiating `This = Lang` (or `Lang2`), the fixpoint class closes the recursion. The result is a concrete, directly instantiable class. "As usual, we tie the knot with fixpoint classes Lang and Lang2."

This is a direct application of the Y combinator principle to class hierarchies: the open recursive structure is the lambda, the fixpoint class is the application of Y. The two resulting classes `Lang` and `Lang2` are *unrelated* in the subtype hierarchy (neither extends the other), even though `Lang2F` extends `LangF`. The fixpoint operation loses the hierarchy relationship because the fixpoint argument differs.

The pattern generalizes beyond this particular problem. Any family of mutually recursive types that must remain open for extension while also providing closed usable instantiations follows this two-level structure: define the open parameterized family, then tie the knot with a fixpoint. This is common in Scala (F-bounded abstractions + concrete companion classes) and appears in Haskell's recursion schemes.

For murail's [[language-design]]: if the composition language adopts a similar open-family structure for extensible node types, the two-level pattern provides a clean separation between the extension point and the concrete registry. The UGen type hierarchy could be parameterized over a `This`-bounded type representing the full set of UGen types, with fixpoint instantiation used to produce the concrete engine context. This maps naturally to Rust's associated types in traits combined with concrete `impl` blocks that close the recursion.

Companion to [[the-thistype-trick-provides-accurate-static-typing-in-the-presence-of-subtypes-by-bounding-the-type-parameter-on-itself]] -- the thistype trick opens the hierarchy; the fixpoint class closes it.
