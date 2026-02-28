---
description: When compile-time and runtime code are written in the same language, metaprogramming is debuggable, composable, and learnable as one system rather than two incompatible sublanguages
type: claim
evidence: strong
source: [[swift-to-mojo-chris-lattner]]
created: 2026-02-28
status: active
---

# unifying program and metaprogram eliminates two-world complexity of templates

C++ has templates and `constexpr` as its metaprogramming system, but they are effectively a different language from the base C++ program. You cannot pass a string to a template in the general case. You cannot build a tree and pass it into a template. Debugging template errors requires understanding a completely separate mental model. The two worlds -- program and metaprogram -- are incompatible in fundamental ways.

Mojo (following Zig's lead, which Lattner credits explicitly) unifies these. You can write ordinary Mojo code and run it at compile time, with no syntactic distinction. Want to debug a compile-time computation? Run it at runtime and step through it in a debugger. The same type system, the same data structures, the same tools. You can use a list or dictionary with heap allocations at compile time, and the compiler will synthesize the appropriate initializations into your binary.

This design unlocks the core Mojo use case: expressing high-performance algorithms as library functions rather than compiler passes. Lattner's example: instead of a loop vectorizer heuristic in the compiler, you call `vectorize(fn, width)` in user code. This is possible only if the metaprogram (which does the code transformation) shares the full language's expressiveness.

Lattner credits Zig for this idea and describes Mojo as taking the concept further. He positions this as Mojo's key difference from Swift and other LLVM-based languages -- those languages have the same underlying infrastructure but did not unify the meta and base levels.

For [[language-design]] in murail: this is relevant to the DSL layer for murail's graph construction language. If murail's graph construction language is a thin layer over Rust, the two-world problem arises at the Rust/DSL boundary. A unified approach would allow graph construction code and synthesis logic to share one type system, as McCartney's new language does (see [[synthesis-graph-construction-is-a-regular-program-not-a-domain-specific-declaration]]).

Extends [[generic-operations-allow-extending-existing-code-over-new-types-without-modification]] -- that claim describes runtime generics; this is the compile-time analog. Both address the same underlying problem: extending behavior without fragmentation.
