---
description: Program languages communicate the mapping from what a program means in the problem domain to how the machine executes it; this gap is the content the program language carries
type: claim
evidence: moderate
source: [[baniassad-myers-2009-program-as-language]]
created: 2026-03-01
status: active
---

# program languages bridge the gap between program semantics and code semantics

Baniassad & Myers distinguish two kinds of meaning in code:

**Code semantics**: what the code means to the machine. `num_seconds += 1` means "add one to an integer variable." This is fully determined by the programming language definition.

**Program semantics**: what the code means to the programmer. `num_seconds += 1` means "advance the clock." This requires knowing how `num_seconds` is used and interpreted throughout the program -- knowledge the programming language cannot supply.

The program language is the medium through which programmers communicate program semantics to one another. It does this through identifier naming (variables whose names imply intended use), idiomatic patterns (locking before accessing shared state communicates that the data structure is shared and mutation-sensitive), abstraction organization (separating variables conveys independence; grouping them into a struct conveys relatedness), and code arrangement (which preconditions are checked before a key call communicates which invariants are assumed to hold at that call site).

The gap varies by programming language expressiveness. For abstractions with a close fit between program and code semantics -- a message buffer implemented as a queue -- the type system handles most of the communication, leaving little for the informal program language. For complex abstractions with poor code-semantics fit -- a "user session" concept spread across fifteen classes and three subsystems -- extensive program language work is required to communicate the boundaries, invariants, and usage rules.

This gap is the structural source of [[a-programs-source-text-cannot-fully-specify-its-meaning]]: source text fully specifies code semantics but only partially specifies program semantics. The informal program language fills in the rest, but imperfectly and with loss across programmer turnover.

For murail: designing the composition language is precisely a gap-closing exercise. Every type constructor, capability annotation, or named abstraction that murail formalizes is a piece of program semantics that moves from the informal program language layer into the formal layer. [[effects-as-capabilities-can-encode-rt-safety-requirements-in-the-composition-language-type-system]] is an example: RT safety was previously program language knowledge ("don't call malloc in the audio thread") that this design moves into the type system.
