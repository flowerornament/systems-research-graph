---
description: Rust's multi-stage compilation and macro system provide the foundations for interactive programming, but the language shipped with batch-mode tooling that ignores this potential
type: claim
evidence: moderate
source: [[stop-writing-dead-programs-jack-rusher-2022]]
created: 2026-02-28
status: active
---

# Rust lacks interactive programming despite suitable foundations

Rusher identifies Rust as "a huge missed opportunity in terms of interactive programming." The language went "straight for the punch cards again" -- producing a static compile-run artifact despite having macro-based metaprogramming and multi-stage compilation that could have supported interactive development.

The practical consequence Rusher names: when choosing between Rust's 40+ memory allocation keywords (Box, Rc, Arc, Cell, RefCell, Cow, Pin, etc.), being able to explore the effect of each choice interactively would dramatically reduce the cognitive load. Instead, developers navigate a compile-test cycle to discover which ownership strategy works.

For [[language-design]] in murail: this is a known gap in the Rust ecosystem. Tools like `cargo watch`, `rust-analyzer` with inline type hints, and `evcxr` (Jupyter kernel for Rust) partially address it, but none provides the full interactive image that Lisp or Smalltalk environments offer. The practical implication for murail development: the graph compiler should be designed with a REPL-style exploration interface in mind even if the initial implementation uses conventional batch compilation.

Zig is Rusher's preferred alternative for systems programming (more to his taste than Rust), but he makes the same criticism: Zig has multi-stage compilation that could support interactivity, and also ignores it in favor of traditional tooling.

Contrasted with [[interactive-programming-eliminates-the-compile-run-cycle]] (the ideal) and [[library-languages-must-not-bundle-a-mandatory-runtime]] (Rust gets this right).
