---
description: In Sussman/Radul's propagator model, cells contain not values but information about values; new information merges in monotonically and never retracts
type: claim
evidence: strong
source: [[we-dont-know-how-to-compute-sussman-2011]]
created: 2026-02-28
status: active
---

# propagator cells hold partial information that accumulates monotonically

Alexey Radul's key contribution to Sussman's propagator model (doctoral thesis, c. 2009): cells do not hold values -- they hold *information about* values. Information only flows in one direction: the cell's knowledge state is a monotonically increasing lattice element. When two propagators deposit conclusions into the same cell, the cell merges them, accumulating a tighter and tighter approximation.

Sussman's building-height example illustrates this concretely: three independent measurement strategies (similar triangles, freefall timing, superintendent's report) each deposit interval estimates into the same cell. The cell accumulates all three, and combined evidence produces a tighter bound than any single measurement alone -- while also propagating the improvement backward to refine the input estimates.

This is distinct from ordinary dataflow (which pushes values through a DAG). Propagator cells can receive information from multiple upstream sources in any order and produce a running best estimate. The lattice structure defines what "more information" means for each cell type: intervals, interval arithmetic, symbolic constraints, or truth-maintenance systems.

This directly refines [[propagator-networks-provide-provenance-for-computed-conclusions]], which describes the model from Rusher's secondhand account. This claim draws on Sussman's own 2011 talk.

For murail: a [[formal-methods]] connection -- if murail's signal graph models cells as partial-information accumulators rather than pure-value transformers, the graph can absorb redundant computation paths (degenerate computation in Sussman's vocabulary) and remain consistent when one path fails.
