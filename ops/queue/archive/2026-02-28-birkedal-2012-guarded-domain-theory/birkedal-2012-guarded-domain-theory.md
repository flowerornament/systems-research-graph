---
id: birkedal-2012-guarded-domain-theory-extract
batch: birkedal-2012-guarded-domain-theory
type: extract
status: pending
source: /Users/morgan/code/murail/.design/references/papers/archive/birkedal-2012-guarded-domain-theory/birkedal-2012-guarded-domain-theory.pdf
archive_folder: ops/queue/archive/2026-02-28-birkedal-2012-guarded-domain-theory/
created: 2026-02-28
next_claim_start: 250
---

# Extract Task: birkedal-2012-guarded-domain-theory

Source: Birkedal, Møgelberg, Schwinghammer, Støvring (2012). "First Steps in Synthetic Guarded Domain Theory: Step-Indexing in the Topos of Trees." *Logical Methods in Computer Science* 8(4:1), pp. 1–45.

## Summary

The paper introduces the **topos of trees** S (presheaves on ω) as a model for **guarded recursion**. It shows that S supports:
1. A "later" modal operator ◮ on types and ✄ on predicates, enabling guarded recursive definitions of both terms and types
2. The Löb induction rule, analogous to the guardedness discipline in coinductive type theories
3. Recursive domain equations via locally contractive functors (fixed-point theorem)
4. A full internal dependently-typed higher-order logic in which step-indexed models can be constructed synthetically — without explicit step-index bookkeeping

The paper demonstrates these by constructing, entirely inside S's internal logic, a semantic model of Fµ,ref: a call-by-value language with impredicative polymorphism, recursive types, and ML-like mutable references.

An axiomatic generalization shows that any topos of sheaves over a complete Heyting algebra with a well-founded basis is a model of synthetic guarded domain theory.

## Relevance to murail

- **Guarded self-reference** in Murail's calculus (the `self@d` form) is structurally analogous to the guarded recursion guard in the topos of trees. The causality condition maps to the guardedness discipline.
- **RustBelt** (rustbelt-2018) uses step-indexed logical relations; this paper shows those step indices can be internalized into the topos S, making proofs cleaner
- **Iris** (the successor to RustBelt) is built on guarded domain theory; this paper is one of its mathematical precursors
- The **Löb rule** ((✄ϕ → ϕ) → ϕ) is the categorical analog of Murail's causality invariant: you can define a recursive thing if every cycle goes through a "later"
