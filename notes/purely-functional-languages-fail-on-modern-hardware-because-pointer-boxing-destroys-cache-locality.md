---
description: OCaml, Lisp, and similar languages box and indirect through pointers as a core design decision; on multi-level-cache hardware this structural choice produces persistent cache-miss overhead
type: claim
evidence: strong
source: [[llvm-creator-interview-chris-lattner]]
created: 2026-02-28
status: active
---

# purely functional languages fail on modern hardware because pointer boxing destroys cache locality

Lattner's structural diagnosis of why OCaml, Lisp, and similar functional languages underperform on modern hardware, despite their elegance and correctness properties.

These languages were designed when memory access was approximately uniform -- before the development of deep multi-level cache hierarchies. Their core data model boxes values: even primitive integers are often wrapped in heap-allocated objects, and data structures are typically built from pointer-linked heap nodes. Every data access involves one or more pointer indirections, each of which is a potential cache miss.

On modern hardware with L1/L2/L3 caches and ~100ns main memory latency, this "everything ends up being boxed and indirected through pointers" architecture produces structural cache-miss overhead on nearly every data access. The hardware characteristic that makes this so damaging is exactly [[cache-hierarchical-hardware-makes-linked-lists-slower-than-arrays-for-most-practical-sizes]]: contiguous memory layout (arrays, Rust structs on the stack) keeps data hot in cache, while pointer indirection (linked structures, boxed values) scatters data across heap pages.

OCaml is attempting to address this with the "Oxidizing OCaml" project (locality and ownership extensions to enable stack allocation instead of heap allocation). Rust achieves it structurally: stack allocation and contiguous layout are the default; heap allocation requires explicit choice (`Box<T>`, `Vec<T>`). The Rust model inverts the functional language default: contiguous unless you opt into indirection, rather than indirected unless you optimize away the boxes.

For [[language-design]] in murail: this is part of the design argument for using Rust as the engine language. The RT audio thread runs tight loops over audio buffers; a language that boxes values by default would impose per-sample cache miss overhead that is architecturally incompatible with real-time audio requirements.

Connects to [[value-semantics-allow-in-place-mutation-when-ownership-is-clear-making-them-strictly-more-powerful-than-purely-functional-copies]] which frames the same argument from the mutation/ownership side rather than the memory layout side.
