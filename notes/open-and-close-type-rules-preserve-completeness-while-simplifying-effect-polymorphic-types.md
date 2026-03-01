---
description: The open and close rules simplify inferred effect types without restricting the set of typeable programs because open can always re-introduce polymorphism at each use site
type: property
evidence: strong
source: [[leijen-2016-algebraic-effects-tr]]
created: 2026-03-01
status: active
---

# open and close type rules preserve completeness while simplifying effect-polymorphic types

Leijen's type simplification strategy (Section 3.2) addresses a practical usability problem: the most general type for the identity function `id = λx.x` is `∀α µ. α → µ α` (polymorphic in both the result type and the effect), but programmers expect to see `∀α. α → α`. Writing effect polymorphism everywhere makes types verbose and difficult to read.

The solution is two derived rules:

**Open rule**: A function with a closed effect type `τ₁ → ⟨l₁,...,lₙ⟩ τ₂` can be treated as having the open type `τ₁ → ⟨l₁,...,lₙ | ε'⟩ τ₂` at any call site. This allows calling a total function in an effectful context without type error.

**Close rule**: Before let-binding, if a function has type `∀µα. τ₁ → ⟨l₁,...,lₙ | µ⟩ τ₂` and µ does not appear free, close it to `∀α. τ₁ → ⟨l₁,...,lₙ⟩ τ₂`. This removes the obvious polymorphism from the stored type.

**Why this preserves completeness**: At every use site of a let-bound variable, `open` can be applied (possibly surrounded by `inst`/`gen`) to recover the most general instantiation. The set of typeable programs is unchanged -- only the written types are simplified. Leijen reports that this reduced the set of CPS-translated functions in Koka's standard library by over 80%, because many functions that would otherwise have open polymorphic effect types are now stored as closed (total), and `H(θ, ⟨⟩) = false` keeps them out of the CPS translation.

The `open` rule is also essential for the CPS translation itself: the `open-cps` case in Figure 7 handles the situation where opening a type changes the calling convention, inserting a wrapper that lifts a direct-style function into CPS at the use site. This is the statically-determined coercion point between the two calling conventions.

Connection to [[type-directed-selective-cps-translation-eliminates-overhead-for-total-functions]]: the open/close simplification is what makes the 80% reduction possible. Without it, type inference assigns open polymorphic types to most higher-order functions, forcing CPS translation on nearly everything.

Relevance to [[language-design]] for murail: any language with effect polymorphism needs a principled simplification strategy to keep inferred types readable at scale. Leijen's approach shows that completeness is preserved by the open rule at use sites -- the simplification is purely presentational.
