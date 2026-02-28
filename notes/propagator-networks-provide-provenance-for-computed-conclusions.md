---
description: Sussman's propagator model tracks the provenance of every conclusion through truth maintenance, making it possible to explain where a computed result came from
type: claim
evidence: moderate
source: [[stop-writing-dead-programs-jack-rusher-2022]]
created: 2026-02-28
status: active
---

# propagator networks provide provenance for computed conclusions

Sussman's propagator model (MIT, early 1970s, expanded with Alexey Radul) is a dataflow abstraction with truth maintenance that records the provenance of every conclusion -- which inputs and rules produced each output value. This differs from ordinary dataflow in that you can ask "why does this cell have this value" and get a traceable dependency chain.

Rusher connects this to VisaCalc's origins (the first spreadsheet was implemented by a grad student using the propagator model as its foundation) and to explainable AI: as ML systems produce conclusions, propagator-style provenance becomes a mechanism for tracing how a conclusion was reached.

Related talk: Sussman's 2011 Strange Loop talk "We Still Don't Know How to Compute" (which Rusher references directly -- murail's reference archive has this transcript as [[we-dont-know-how-to-compute-sussman-2011]]).

For [[formal-methods]] in murail: propagator semantics are a potential foundation for murail's own dataflow model. The formal model already treats signal flow as a "Named Sparse Recurrence System" -- a recurrence system has natural provenance properties (each sample depends on prior samples and inputs in a traceable way). Encoding provenance explicitly would enable debugging tools that trace audio artifacts back to their causal signal path.

For [[ai-ml]]: explainability in neural audio synthesis is an open problem. If murail's graph engine tracks which UGen nodes contributed to an output, that provenance could be used to attribute audio characteristics to their generating nodes -- a form of the explainability Rusher describes for AI systems.
