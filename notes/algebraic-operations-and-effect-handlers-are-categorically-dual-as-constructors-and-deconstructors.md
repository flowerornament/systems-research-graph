---
description: Effect operations construct computations (intro rules); handlers deconstruct them via homomorphism (elim rules) -- the same intro/elim duality that structures type theory
type: property
evidence: strong
source: [[plotkin-pretnar-2009-handlers-of-algebraic-effects]]
created: 2026-03-01
status: active
---

# algebraic operations and effect handlers are categorically dual as constructors and deconstructors

Plotkin and Pretnar make the duality explicit in Section 2: algebraic operations "could be called *effect constructors* as they give rise to the effects; the latter [handlers] could be called *effect deconstructors* as they depend on the effects already created."

This is not merely a metaphor -- it is a precise categorical duality:

- **Operations as constructors**: an algebraic operation `op : n` is interpreted by maps `op_X : TX^n → TX` (for the computation monad `T`). These are the *co-unit* morphisms -- they inject structure into the free model. When you write `or(return true, return false)`, you are building an element of the free model by applying the `or` constructor.

- **Handlers as deconstructors**: a handler provides a model `M` and the handling construct computes the unique homomorphism `h : FA → M` that folds the free model into `M`. This is the *folding* direction -- it takes a computation apart according to how each operation is interpreted in `M`.

The duality is exactly the introduction/elimination duality of type theory. Operations are like `Λ` (introduction) -- they form terms of type `FA`. Handlers are like case analysis (elimination) -- they examine those terms and extract a value. This is the same duality as:
- Constructors/match in algebraic data types
- `inl`/`inr` (injection) and case analysis for sum types
- `η` (unit) and `Kleisli composition` in monad theory

**Filinski's connection**: Plotkin and Pretnar note that "Filinski's reflection and reification [12] are closely related general concepts." Filinski's reflection converts a monadic value into a direct-style computation; reification goes back. This is the same constructor/destructor polarity in a different setting.

**Why this matters for language design**: the duality clarifies when effects can be handled at all. If an effect has an algebraic representation (operations + equations with a free model), it can be handled -- the unique homomorphism theorem guarantees a handler exists for any model. If it does not (like [[continuations-are-the-only-standard-computational-effect-that-cannot-be-represented-algebraically]]), the destructor/handler does not exist in this framework.

**Practical consequence for [[language-design]]**: designing an effect system for murail's composition language means designing pairs of operations + handlers. The operations specify what a computation can *do*; the handlers specify what those actions *mean* in a given context. RT safety ([[effects-as-capabilities-can-encode-rt-safety-requirements-in-the-composition-language-type-system]]) is then: define an `alloc` operation; the RT context has no handler for `alloc`; so any computation that invokes `alloc` cannot typecheck in the RT context. The constructor/destructor duality makes the absence of a handler as meaningful as its presence.

This is the foundational explanation for [[handling-a-computation-is-composing-it-with-the-unique-free-model-homomorphism]]: the unique homomorphism exists precisely because operations are constructors of the free model, and the universal property of free models guarantees that any model provides a unique fold.
