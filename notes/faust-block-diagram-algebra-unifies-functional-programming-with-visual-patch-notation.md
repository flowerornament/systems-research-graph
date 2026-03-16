---
description: FAUST's five composition operators (sequential, parallel, recursive, split, merge) define a closed algebra over signal processors, making block-diagram construction equivalent to function composition
type: property
evidence: strong
source: [[faust-2009-npcm]]
created: 2026-02-28
---

# FAUST block-diagram algebra unifies functional programming with visual patch notation

FAUST defines five block-diagram composition operators that form a closed algebra over signal processors:

| Operator | Syntax | Description |
|----------|--------|-------------|
| Sequential | `f : g` | output of f feeds input of g |
| Parallel | `f , g` | f and g run independently, side by side |
| Recursive | `f ~ g` | feedback loop with implicit one-sample delay |
| Split | `f <: g` | one output fans out to multiple inputs |
| Merge | `f :> g` | multiple outputs merge into one |

The key insight is that block-diagram construction *is* function composition — these operators generalize the mathematical function composition operator `∘` to multi-input/multi-output signal processors. This means a FAUST program is not "wired up" visually the way Max/PD patches are; it is composed algebraically via text operators that happen to have an unambiguous block-diagram interpretation.

This unification has a critical consequence: because every composition is a mathematical operation with known type (input count, output count), the compiler can statically verify wiring correctness and derive the arity of any composite processor without running the program.

For murail, this algebra is the model for [[synthesis-graph-construction-is-a-regular-program-not-a-domain-specific-declaration]] — composition operators can be first-class language functions rather than special syntax, since they have precise mathematical semantics.

The recursive operator `~` specifically is the mechanism discussed in [[faust-recursive-composition-with-implicit-one-sample-delay-is-the-primitive-for-all-feedback]].

## Connections
- Grounds [[faust-programs-denote-mathematical-functions-enabling-semantics-driven-compilation]] — the algebra is the surface form; denotational semantics is what the algebra means
- Contrasts with [[visual-representation-exposes-structure-text-notation-obscures]] — FAUST is textual but has unambiguous visual semantics; the algebra is the bridge
- Extends [[synthesis-graph-construction-is-a-regular-program-not-a-domain-specific-declaration]] by showing a prior art for algebraic graph construction without special DSL syntax
