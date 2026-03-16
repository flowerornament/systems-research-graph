---
description: Birkedal, Møgelberg, Schwinghammer, Støvring (2012) — introduces the topos of trees as a model of guarded recursion and synthetic guarded domain theory
type: claim
source: /Users/morgan/code/murail/.design/references/papers/archive/birkedal-2012-guarded-domain-theory/birkedal-2012-guarded-domain-theory.pdf
created: 2026-02-28
status: active
---

# birkedal-2012-guarded-domain-theory

Lars Birkedal, Rasmus Ejlers Møgelberg, Jan Schwinghammer, Kristian Støvring. "First Steps in Synthetic Guarded Domain Theory: Step-Indexing in the Topos of Trees." *Logical Methods in Computer Science* 8(4:1), 2012, pp. 1–45. Originally published at LICS'11.

The paper introduces the **topos of trees** S = Set^{ω^op} (presheaves on the natural numbers ordered by inclusion) as a model for **guarded recursion**, and proposes the internal logic of S as a setting for **synthetic** construction of step-indexed models of programming languages.

Key contributions:
- Two "later" modalities: ◮ (functor on types) and ✄ (operator on predicates), with associated Löb rule
- Internal Banach fixed-point theorem and recursive domain equation solver for locally contractive functors
- Full example: synthetic model of Fµ,ref (impredicative polymorphism, recursive types, ML references) inside S's internal logic
- Axiomatic treatment: any topos of sheaves Sh(A) over a well-founded complete Heyting algebra A is a model of synthetic guarded domain theory
- Relationship to BiCBUlt (bisected complete bounded ultrametric spaces) as co-reflective subcategory

This paper is a direct mathematical precursor to the **Iris** program logic framework, which extends this approach to a concurrent separation logic used by RustBelt and subsequent Rust formal verification work.
