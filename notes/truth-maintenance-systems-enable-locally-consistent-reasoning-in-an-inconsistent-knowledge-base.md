---
description: A TMS maintains multiple locally consistent worldviews simultaneously, so a system can reason soundly within each without collapsing when one premise is retracted
type: claim
evidence: strong
source: [[we-dont-know-how-to-compute-sussman-2011]]
created: 2026-02-28
status: active
---

# truth maintenance systems enable locally consistent reasoning in an inconsistent knowledge base

Sussman describes truth maintenance systems (TMSs), originally developed with Richard Stallman and named by John Doyle, as a mechanism for managing a collection of facts with their dependencies such that a system can find the best consistent subset of its knowledge at any time.

The key insight: the real world is almost always inconsistent. Medical literature is mostly wrong. Engineering models are useful lies. Scientific premises conflict. A TMS does not demand global consistency -- it maintains multiple *locally* consistent worldviews (contingent value sets) in parallel. Each cell holds a collection of contingent values, each tagged with the premises they depend on. When premises conflict, the system can enumerate the consistent sub-worldviews and reason within each independently.

In Sussman's building-height example: the superintendent's measurement, shadow triangles, and freefall timing each form a premise. If two measurements conflict, the TMS identifies which assumptions are jointly inconsistent and can present results conditioned on each subset. The user can then decide which premises to trust.

This extends [[propagator-cells-hold-partial-information-that-accumulates-monotonically]] by specifying that TMS cells are one valid lattice type: the "more information" ordering is the subsumption of consistent subsets.

For [[formal-methods]] in murail: audio DSP involves many "useful lies" -- linear approximations, bandlimited models, quantization noise models. If murail's analysis tools tracked which physical model was assumed to derive a result, switching between model assumptions could be done cleanly, with the provenance of each conclusion tracked through the model dependency.
