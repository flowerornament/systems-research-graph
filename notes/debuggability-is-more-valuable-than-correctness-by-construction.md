---
description: Because software specs are always wrong and all software is continuous change, the ability to debug and modify running systems outweighs the value of proving static properties of code that will be thrown away
type: claim
evidence: moderate
source: [[stop-writing-dead-programs-jack-rusher-2022]]
created: 2026-02-28
status: active
---

# debuggability is more valuable than correctness by construction

Rusher's argument: programming is a design discipline where you discover what you are building as you build it. Buggy approximations are not failures -- they are the method. Proving theorems about code you will discard wastes time. The spec is always wrong; the only complete spec for a non-trivial system is its source code. All software is continuous change.

Consequence: correctness-by-construction tools (dependent types, formal verification) impose upfront costs that are only justified when (1) the cost of failure is catastrophic, or (2) the spec is genuinely stable. For most software, including audio engines under active development, the return on investment is negative.

Supporting evidence Rusher cites: Lisp-programmed space probes (Deep Space 1) were debugged and patched in flight after launch. A formally verified but incorrectly specified probe would have been dead metal on Mars. Live patching capability was more valuable than static correctness.

For [[formal-methods]] in murail: this supports a tiered approach -- verify mathematical invariants in the formal model (the Named Sparse Recurrence System), but don't attempt to prove the correctness of the full graph engine. The Lean 4 proofs are appropriate precisely because they target the stable core formalism, not the application code. Runtime verification (loom, miri, property-based tests) fits the debuggability-first philosophy better than full formal verification at the engine level.

Follows from [[type-systems-have-not-empirically-reduced-defect-rates]] and [[interactive-programming-eliminates-the-compile-run-cycle]] (live systems can be debugged; dead batch artifacts cannot).
