---
description: The denotational semantics of effect handling is unique homomorphism from the free model to a programmer-defined model -- handling is not pattern matching but algebraic folding
type: property
evidence: strong
source: [[plotkin-pretnar-2009-handlers-of-algebraic-effects]]
created: 2026-03-01
status: active
---

# handling a computation is composing it with the unique free-model homomorphism

Plotkin and Pretnar's central semantic insight (Section 2, formalized in Section 5.1): to handle a computation is to compose it with a unique homomorphism guaranteed by the universal property of the free model.

Concretely: computations are elements of the free model `FA` on a set of return values `A`. The free model is the canonical construction that satisfies the algebraic equations for the effects -- for exceptions, `FA = A + E`; for nondeterminism, `FA = F+(A)` (non-empty finite subsets). The computation monad `UF` that Moggi proposed to model effects is exactly this free-model monad.

A handler provides a programmer-defined *model* `M` of the same algebraic theory -- one that gives an interpretation for each operation. The **unique homomorphism theorem** (the universal property of free models) guarantees that any function `g : A → M` extends to a unique map `h : FA → M` that is a homomorphism -- meaning it preserves the operation interpretations.

This unique `h` is precisely what the handling construct computes:
```
try t with H(u; t') as x in t'   -- h applied to the computation t
```

The diagram commutes: `h ∘ η = g`, where `η` is the unit embedding `A → FA`. The handler provides `g` (what to do with return values) and the operation clauses (the model structure on `M`); the handling construct delivers `h`.

**Why this matters**: it explains exactly why handlers subsume exception handlers, state handlers, I/O handlers, nondeterminism handlers -- all are instances of the same morphism pattern. Exception handling, concretely: the free model for exceptions is `X + E`; a handler provides a model on some target set `M`; the unique homomorphism folds `inl(x)` through `g(x)` and `inr(e)` through the exception clause. The Benton-Kennedy handling construct `try x ⇐ t in g(x) unless {e → ye}` is exactly this unique homomorphism extended to an arbitrary target model.

**Duality with algebraic operations**: algebraic operations are the *constructors* of the free model (they build up computations); handlers are the *destructors* (they fold computations down via homomorphism). This is Plotkin and Pretnar's explicit framing: operations are "effect constructors," handlers are "effect deconstructors." The duality is categorical: operations are the co-unit morphisms (building up), handlers are the unit morphisms (folding down).

This provides the *categorical justification* for [[deep-handlers-differ-from-shallow-handlers-because-continuation-is-resumed-under-the-same-handler]]: deep handlers correspond precisely to this free-model fold because the continuation is re-wrapped in the same handler at each step, maintaining the homomorphism property. Shallow handlers break the fold after one step.

Connects to [[row-typed-effects-compose-freely-because-they-are-restricted-to-the-free-monad]]: the restriction to free monads (the algebraic restriction) is exactly what makes the unique homomorphism theorem applicable. Effects that violate algebraic laws (e.g., continuations -- see [[continuations-are-the-only-standard-computational-effect-that-cannot-be-represented-algebraically]]) do not have free models in this sense and therefore cannot be handled by this construction.

Relevance to [[language-design]] in murail: if the composition language adopts effect handlers for resource effects (RT safety, allocation, scheduling), the semantics of each handler is fully determined by the algebraic equations the handler satisfies. Correct handlers are models of the theory -- the algebraic equations are both the specification and the verification condition.
