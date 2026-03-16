---
description: Sussman's propagator model tracks the provenance of every conclusion through truth maintenance, making it possible to explain where a computed result came from
type: claim
evidence: strong
source: [[we-dont-know-how-to-compute-sussman-2011]]
created: 2026-02-28
status: active
---

# propagator networks provide provenance for computed conclusions

Sussman's propagator model (MIT, early 1970s, expanded with Alexey Radul) is a dataflow abstraction with truth maintenance that records the provenance of every conclusion -- which inputs and rules produced each output value. This differs from ordinary dataflow in that you can ask "why does this cell have this value" and get a traceable dependency chain.

The circuit analyzer Sussman wrote with Stallman in 1975 demonstrates this: given a transistor amplifier wiring diagram, the program can explain the bias voltage at any node by tracing the chain of propagator inferences that produced it. "Why do you believe the emitter potential is X?" produces a proof trace. This makes the system's reasoning inspectable at the level of the model's assumptions.

Rusher connects this to VisaCalc's origins in [[stop-writing-dead-programs-jack-rusher-2022]] (the first spreadsheet was implemented by a grad student using the propagator model as its foundation) and to explainable AI: as ML systems produce conclusions, propagator-style provenance becomes a mechanism for tracing how a conclusion was reached.

For deeper architecture: see [[propagator-cells-hold-partial-information-that-accumulates-monotonically]] (the monotonic cell model) and [[truth-maintenance-systems-enable-locally-consistent-reasoning-in-an-inconsistent-knowledge-base]] (how TMS works as a lattice type for cells).

For [[formal-methods]] in murail: propagator semantics are a potential foundation for murail's own dataflow model. The formal model already treats signal flow as a "Named Sparse Recurrence System" -- a recurrence system has natural provenance properties (each sample depends on prior samples and inputs in a traceable way). Encoding provenance explicitly would enable debugging tools that trace audio artifacts back to their causal signal path.

For [[ai-ml]]: explainability in neural audio synthesis is an open problem. If murail's graph engine tracks which UGen nodes contributed to an output, that provenance could be used to attribute audio characteristics to their generating nodes -- a form of the explainability Sussman describes for AI systems.
