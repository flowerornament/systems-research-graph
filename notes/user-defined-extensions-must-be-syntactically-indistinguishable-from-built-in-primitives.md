---
description: For user-driven language growth to work, calling user-defined operations must look identical to calling built-ins -- any visual seam prevents users from treating their extensions as first-class
type: claim
evidence: strong
source: [[steele-1998-growing-a-language]]
created: 2026-03-01
status: active
---

# user-defined extensions must be syntactically indistinguishable from built-in primitives

Steele's criterion for a language that can grow via user contribution: "the new words defined by a library should look just like primitives of the language." If user-defined operations look different from built-in operations -- whether in syntax, calling convention, or expressibility -- users cannot extend the language in a seamless way.

The asymmetry becomes a social and structural barrier: if a feature must be "promoted" by language maintainers from user-code appearance to glyph appearance (as in APL), the promotion process is slow, politically costly, and retroactively incompatible (existing user code must be rewritten). Users stop trying to extend the language because the path from user code to first-class feature is closed off.

The positive test: can a user write a library that a downstream user then uses, with no syntactic evidence that the library is not built-in? If yes, the seam test passes. If no -- if the downstream user must use different calling conventions, cannot use operator notation, or cannot rely on the same type inference -- the language has a seam, and user-driven growth will stall.

This criterion is the specific mechanism behind [[a-language-must-be-designed-to-grow-not-to-be-complete]]: a language designed to grow requires this seamlessness as a prerequisite. Without it, growth requires language maintainer action for every new concept, which is the bottleneck that killed APL's ecosystem.

The criterion applies to multiple syntactic dimensions simultaneously:
- **Call syntax**: user-defined functions should be callable exactly like primitives (Lisp: yes; APL: no)
- **Operator notation**: user-defined types should support operator notation if primitives do (Steele: Java should add this for user-defined numeric types)
- **Type system**: user-defined types should participate in the same type checking and inference as built-in types (requires generic types)
- **Storage model**: user-defined types should be able to match the performance characteristics of built-in types (Steele: requires value types / lightweight classes)

The [[the-minimum-extensibility-mechanism-for-user-driven-language-growth-is-generic-types-and-operator-overloading]] is precisely the minimal set that satisfies this criterion for numeric and collection types in Java.

For murail's DSL: if signal processing UGens defined in user code are second-class (different syntax, worse type inference, can't use operator notation), then murail will not grow. The language design must satisfy this criterion.
