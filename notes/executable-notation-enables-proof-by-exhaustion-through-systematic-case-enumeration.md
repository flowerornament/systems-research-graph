---
description: When notation is executable and supports array operations over finite domains, proof by exhaustion becomes a practical computational act rather than a tedious manual enumeration
type: property
evidence: strong
source: [[iverson-1980-notation-as-tool-of-thought]]
created: 2026-02-28
status: active
---

# executable notation enables proof by exhaustion through systematic case enumeration

Iverson demonstrates a technique available only in executable notation: "proof by exhaustion consists of exhaustively examining all of a finite number of special cases. Such exhaustion can often be simply expressed by applying some outer product to arguments which include all elements of the relevant domain."

For DeMorgan's law, the outer product `Do.^D` where `D←0 1` generates the complete truth table for AND over all boolean pairs. Comparing this with `~(~D)o.v(~D)` and verifying element-wise equality proves the law exhaustively. The executable assertion `^/,(Do.^D)=(~(~D)o.v(~D))` is a runnable proof step.

Associativity is verified by comparing rank-3 tables: `(Do.^D)o.^D` versus `Do.^(Do.^D)`. The notation for the verification statement is barely longer than the notation for the property being verified. Non-associativity of NAND is demonstrated by the analogous comparison producing a non-all-ones table.

The important structural point: the proof obligation becomes an array computation. When the domain is finite and the function is executable, the proof is reduced to running the program and checking the result. This is not informal testing -- it is formal verification by complete enumeration of cases, expressed in the same notation as the algorithm being proved.

This connects directly to [[faust-programs-denote-mathematical-functions-enabling-semantics-driven-compilation]]: FAUST's denotational semantics enable the compiler to reason about algebraic properties (commutativity, associativity of composition operators) at compile time. The mechanism is different (formal semantics vs. exhaustive execution) but the goal is the same: make formal properties mechanically checkable through the notation.

The technique is limited to finite domains -- it cannot replace inductive proofs for properties over arbitrary N. Iverson provides both types: exhaustion for boolean laws, induction for vector generalizations. The notation supports both proof styles in a unified framework, documented in Section 4 of the paper.
