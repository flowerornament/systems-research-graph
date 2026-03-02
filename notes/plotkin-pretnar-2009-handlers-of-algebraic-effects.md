---
description: Source reference for Plotkin & Pretnar 2009 -- the foundational paper introducing handlers for algebraic effects as free-model homomorphisms
type: source-reference
created: 2026-03-01
---

# plotkin-pretnar-2009-handlers-of-algebraic-effects

Plotkin, G. and Pretnar, M. (2009). "Handlers of Algebraic Effects." In: ESOP 2009, LNCS 5502, pp. 80–94. Edinburgh.

The original paper introducing effect handlers. Establishes that handling a computation amounts to composing it with the unique homomorphism from the free model of the effect theory to a programmer-defined model. Generalizes Benton and Kennedy's exception-handling construct. Introduces the two-language separation (handler description vs. computation) to avoid well-formedness/correctness interdependence. Shows handlers unify exceptions, state, I/O, nondeterminism, CCS renaming, timeout, rollback, and input redirection; demonstrates that parallel composition cannot be expressed this way.

Source: `/Users/morgan/code/systems-research-graph/inbox/archive/plotkin-pretnar-2009-handlers-of-algebraic-effects/plotkin-pretnar-2009-handlers-of-algebraic-effects.pdf`

---

Topics:
- [[algebraic-effects]]
- [[language-design]]
