---
description: Propagator wiring diagrams give explicit names to every intermediate wire, unlike expression trees where interior nodes are anonymous, making each value inspectable and reusable
type: claim
evidence: strong
source: [[we-dont-know-how-to-compute-sussman-2011]]
created: 2026-02-28
status: active
---

# wiring diagram notation names every intermediate value enabling inspection and reuse

Sussman identifies a structural deficit in expression-based languages: expressions are trees where intermediate nodes have no names. In the computation `(a + b) * c`, the sub-expression `a + b` has no persistent identity -- it cannot be inspected, queried, or reused without re-evaluation. In a circuit diagram or propagator wiring diagram, every wire is a named cell and every junction is an addressable point.

The payoff: Sussman's circuit analysis program (written with Richard Stallman in 1975) works by writing propagator conclusions to specific named nodes in the circuit diagram. When you ask "why does node X have this voltage?", the system can answer because every intermediate value was deposited by a propagator with a named source. The *diagram is the memory* -- a structured external store where intermediate computations live at named locations.

This connects to [[visual-representation-exposes-structure-text-notation-obscures]]: text notation forces all intermediate values through unnamed tree structure. A wiring diagram makes structure explicit and values addressable. Sussman argues named intermediate values are especially valuable for the kind of "filling in details" computation he thinks underlies fast cognition -- the Kanizsa triangle illusion suggests the visual system is completing a wiring diagram where most nodes are already known and a few need inference.

Sussman notes that lambda calculus "glue" (naming via let-binding) is the available tool before a proper wiring-diagram language exists. The square root propagator example shows lambda-calculus binding being used explicitly to name every intermediate cell -- an approximation to the notation he wants.

For murail's [[language-design]]: audio graph DSLs already use wiring diagrams implicitly (SuperCollider's `.ar` message chains, Faust's `~` feedback operator). Making every intermediate signal a named, inspectable cell -- rather than an anonymous expression tree node -- would align murail's DSL with propagator-style architecture and enable debugging tools of the kind Sussman's circuit analyzer provides.
