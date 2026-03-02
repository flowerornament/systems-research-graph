---
description: When classes impose no required instance variables, every object of a class can carry arbitrary fields, making classes pure type-dispatch labels and enabling flexible metadata without subclassing
type: pattern
evidence: moderate
source: [[mccartney-ideas-2026-02-15]]
created: 2026-02-28
status: active
---

# classes as type tags allow per-instance field variation

In conventional OO languages, a class defines the fields its instances must have. A `Point` has `x` and `y`; instances of `Point` have exactly those fields. In McCartney's new language, classes are type tags only: they carry no required instance variables. Any instance of any class can have any fields.

McCartney states this explicitly: "The classes are just type tags, really. There's no instance variables required if you have a certain class. Every instance, it's kind of unusual, but you can give whatever instance variables you want in any instance of a class. So if you want to add extra metadata to an instance of a class, you can do that just by adding more instance variables. Dynamically."

This design has two primary consequences:

**For dispatch:** Multimethods dispatch on the class (type tag), not on the fields. So the dispatch mechanism still works as expected -- a method that accepts `Shape` will fire on any value whose class tag is `Shape`. But the method body cannot assume any particular field exists without checking.

**For extensibility:** Code that receives an object of a class can attach additional metadata to it without subclassing or creating a wrapper. This is unusual -- it is closer to JavaScript's prototype model or Python's `__dict__` than to Java or Rust's field-declared structs. The tradeoff is that field presence is a runtime concern, not a compile-time guarantee.

McCartney uses this in his signal model: `Shape` instances always have `rows` and `columns`, but the flexibility to add more is part of the design. In the synthesis graph context, this allows expression nodes to carry arbitrary metadata (rewrite history, source location, optimization annotations) without schema changes.

**Murail relevance:** This pattern is specific to dynamically-typed interpreted languages. Rust's struct layout is statically defined. However, the concept of "type as dispatch label, not as field contract" can be approximated in Rust with enum variants (each variant carries different data) or with trait objects (dispatch on capability, not shape). The question for Murail's composition language (Stage 9) is whether to treat data as structurally typed (field contract) or nominally typed (class tag only).

Related to [[multimethods-allow-code-generation-backends-to-be-organized-by-concern]] -- both address the expression problem, but from opposite directions: this claim allows types to carry unexpected state; the multimethods claim allows operations to dispatch on multiple type dimensions. Together they form the type system approach of McCartney's language.
