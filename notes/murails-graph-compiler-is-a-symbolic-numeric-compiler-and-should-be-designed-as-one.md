---
description: Framing the graph compiler as a symbolic-numeric transformation pipeline opens up well-studied PL techniques -- algebraic simplification, partial evaluation, e-graph optimization -- that are directly applicable
type: claim
evidence: moderate
source: [[pl-research-landscape-2026-02-27]]
created: 2026-03-01
status: active
---

# Murail's graph compiler is a symbolic-numeric compiler and should be designed as one

Murail's compilation pipeline transforms high-level graph descriptions (symbolic) into flat schedules of buffer operations (numeric). The composition language describes audio symbolically: `y = sin(2 * pi * freq * t)` defines a signal relationship. The compiled schedule executes numerically: tight loops of floating-point arithmetic. The graph compiler operates at the boundary between these two representations.

Symbolics.jl (Gowda, Strange Loop 2022) shows this pipeline explicitly: write equations symbolically, let the system simplify using algebraic rules, compile to efficient numeric code. The compilation stages are: symbolic expression -> simplified symbolic expression (algebraic identities, CSE, term rewriting) -> generated code -> native machine code. Emmy (Colin Smith, Strange Loop 2023, implementing Sussman's SICMUtils) demonstrates that the same approach works at the scale of real physics computation -- the same code runs symbolically when given symbolic inputs and numerically when given numeric inputs.

Murail's "graph IR" is a symbolic expression -- a DAG of operations. The "optimization passes" are algebraic simplification. The "schedule compilation" is code generation. These are the same pipeline stages, described in different terminology. Recognizing the equivalence opens up techniques that are well-studied in the symbolic-numeric computing literature but underutilized in audio engine design:

- Algebraic simplification before numeric compilation can reduce the graph to fewer operations than any post-compilation pass would achieve (the symbolic form makes algebraic structure visible that the numeric form hides)
- Array operation fusion (combining multiple elementwise operations into a single loop) is exactly the block-processing optimization Murail needs for sample-level computation
- Symbolics.jl's broadcasting (automatically extending scalar operations to arrays) maps to Murail's universal auto-mapping (McCartney)
- Layout optimization (choosing memory layout for cache efficiency) maps to buffer placement in the slotmap (D51)

The framing also benefits library design. If the composition language's functions are simultaneously symbolic templates (defining graph structure) and numeric computations (executing sample processing), then the same function definition serves both purposes without duplication. This is the "functions as templates" axiom made explicit: the function is a symbolic program generator whose output (the graph equations) is compiled numerically.

Connects to [[the-rate-lattice-provides-exactly-the-static-dynamic-parameter-separation-that-partial-evaluation-requires]] -- the symbolic-numeric framing clarifies where the static/dynamic boundary lies: symbolic computation (graph construction) is the static stage, numeric computation (sample processing) is the dynamic stage. See [[equality-saturation-can-replace-hand-coded-rewrite-rules-with-automatically-discovered-provably-terminating-optimizations]] for the most powerful symbolic simplification technique applicable. Complements [[faust-programs-denote-mathematical-functions-enabling-semantics-driven-compilation]] -- FAUST uses the same framing and demonstrates its benefits.

---

Topics:
- [[audio-dsp]]
- [[compiler-and-adoption]]
- [[language-design]]
- [[formal-methods]]
