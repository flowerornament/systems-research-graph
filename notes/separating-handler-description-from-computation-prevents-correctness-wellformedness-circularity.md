---
description: Using two languages -- one for handler specification, one for computations -- avoids the circular dependency between handler correctness and computation wellformedness
type: decision
evidence: strong
source: [[plotkin-pretnar-2009-handlers-of-algebraic-effects]]
created: 2026-03-01
status: active
---

# separating handler description from computation prevents correctness-wellformedness circularity

Plotkin and Pretnar identify a subtle design problem at the start of Section 4: if you try to verify handler correctness (that the handler's operation redefinitions yield a valid model of the effect theory) inside the same language used to write computations, you get a circular dependency. Handlers reference computations; computations contain handlers; wellformedness and correctness entangle.

Their solution: **two languages**. One language (the handler language, Section 4) enables the language designer to *specify* handlers. A separate language (the computation language, Section 5) enables the programmer to *use* those handlers. Handler correctness is verified at the meta-level -- when a handler is added to the handler signature `Σ_hand`, its correctness is checked once and never re-examined in individual programs.

The practical effect: computation terms are typed against the *handler signature*, not against raw handler terms. The type rule for the handling construct `try t with H(u; t') as x in t'` requires only that `H` is a symbol in `Σ_hand` with the correct type -- not that the handler body satisfies the algebraic equations. The equations were already verified when `H` was added to `Σ_hand`.

**Why this matters**: without the separation, every use-site of a handler would need to re-verify that the handler's operation interpretations form a valid model. This is intractable in general -- verifying that a set of functions satisfies equational theory axioms requires either theorem proving or type-level encoding. The two-language approach delegates this to the designer, who verifies it once.

**The meta-level delegation principle**: "In this way the selection of correct handlers is delegated to the meta-level." This is an architectural principle analogous to how type-class instances in Haskell delegate law verification to the library author. Haskell's type checker verifies the instance *signature* (Functor, Monad, etc.) but not the *laws* (functor laws, monad laws). The laws are the programmer's responsibility, checked by testing or proof, not by the type checker. Plotkin and Pretnar formalize this as a structural feature of the language design.

**Connects to [[nominal-effect-types-keep-inferred-types-small-at-the-cost-of-requiring-complete-handlers]]**: Koka's nominal approach (handler names rather than structural handler terms) is a realization of this principle. By giving handlers names and checking their correctness once, Koka avoids re-verifying handler equations at every use site.

**Open question (from Section 9)**: Plotkin and Pretnar note that a possible alternative is "to give a single language and a mechanism limiting well-typed handlers to correct ones" via "a suitable type-theory." This is the direction that type-and-effect systems with structural effect types explore -- trying to collapse the meta-level check into the type system. The two-language approach trades expressiveness for tractability.

Relevance to [[language-design]]: if murail adopts algebraic effects, the two-language approach suggests that "built-in" effect handlers (for RT safety, allocation, scheduling) should be verified once by the runtime designers and exposed as named handler symbols -- not re-derivable by users from scratch. User-defined handlers would require a correctness argument, either informal (convention) or formal (a future type-theoretic extension).
