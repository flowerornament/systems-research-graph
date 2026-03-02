---
description: Value semantics give logical composition like functional programming plus in-place mutation when ownership is proven, avoiding the O-notation destruction of immutable-copy approaches
type: claim
evidence: strong
source: [[llvm-creator-interview-chris-lattner]]
created: 2026-02-28
status: active
---

# value semantics allow in-place mutation when ownership is clear making them strictly more powerful than purely functional copies

Lattner's critique of purely functional programming, and his argument for why value semantics are strictly superior in practice:

The purely functional model manages state by creating a full copy of the data structure with the change applied to the copy. For an array of 100 elements, setting one element requires copying 100 elements (or at minimum the array's structural scaffolding). This destroys O-notation: an operation that should be O(1) becomes O(n). At scale this is not just slow -- it forces programmers to use complex immutable data structures (B-trees, finger trees, RRB vectors) to recover acceptable asymptotic performance. The resulting complexity offsets the clarity gains that motivated the functional approach.

Value semantics achieve the same logical property -- behavioral composition where a value's behavior is determined by its structure, not its identity -- while allowing in-place mutation when the compiler (or the programmer's ownership annotations) can prove that no other reference to the data structure exists. When you are the only owner, you can mutate in place, and the mutation is semantically invisible to any observer because there are no other observers.

Swift implements this via reference counting with copy-on-write: the runtime checks whether a reference count is 1 before writing; if so, it mutates in place. This is dynamic and automatic but requires RCounting overhead. Rust and Mojo implement it statically: the type system proves unique ownership at compile time, so no runtime check is needed and the mutation is guaranteed efficient.

Lattner's claim is that this is a strictly more powerful model than pure functional programming: you get everything functional programming gives you (logical separation of concerns, composability, reasoning about values rather than identities) and you also get performant mutation where it is safe.

For [[language-design]] and [[concurrent-systems]] in murail: [[pervasive-immutability-dissolves-concurrency-problems-rather-than-managing-them]] describes how McCartney's SAPF approaches this from the immutable side. [[reference-counting-becomes-viable-when-immutability-prevents-object-cycles]] is the memory management consequence when cycles are structurally ruled out. Rust's ownership model (which murail's engine already uses) is the static version of value semantics; Lattner's framing makes explicit why this is strictly better than functional alternatives rather than a lateral trade-off.

Related to [[purely-functional-languages-fail-on-modern-hardware-because-pointer-boxing-destroys-cache-locality]] which adds the hardware cache-miss dimension to the same argument.
