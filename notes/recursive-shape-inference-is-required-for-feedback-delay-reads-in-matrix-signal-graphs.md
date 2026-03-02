---
description: When a delay is read before its write in a feedback loop, the matrix dimensions of the delay output are unknown at read time, requiring a separate recursive fixpoint pass during graph compilation
type: property
evidence: moderate
source: [[mccartney-ideas-2026-02-15]]
created: 2026-02-28
status: active
---

# recursive shape inference is required for feedback delay reads in matrix signal graphs

In McCartney's matrix signal IR, every node has a statically-known shape (rows × columns), element type, and rate. Shape is used to determine buffer allocation sizes and to validate that operations are dimensionally compatible. For feed-forward graphs (DAGs), shape inference is straightforward: process nodes in topological order; each node's output shape is determined by its inputs.

Feedback loops break this ordering. In a delay-based feedback loop:
1. The delay read node needs to know the output shape of the delay.
2. The output shape of the delay is determined by what is written to it.
3. What is written to it depends on a subgraph that includes the delay read.

This creates a circular dependency: `read_shape → write_shape → read_shape`. McCartney explicitly calls this out: "When you read a delay, you don't know what the matrix dimensions of that delay are yet because you haven't gotten to the write. So it has to do this recursive shape inference to figure out what the dimensions of arrays are, especially in feedback loops."

The resolution is a fixpoint computation: start with an assumed shape for the delay read (e.g., unknown/bottom), propagate through the subgraph to the write, update the delay shape, then re-infer until shapes stabilize. This is a separate compiler pass after the main graph is constructed and before loop formation.

This is not unique to McCartney's system -- any IR that supports arbitrary feedback and carries type information (matrix shape here, buffer type in LLVM) requires fixpoint type inference for back edges. What makes McCartney's case notable is that the "type" is matrix shape, not just element type, so the fixpoint has more dimensions to converge on.

**Implication for Murail:** Murail's spec (D51, graph IR) will need a shape inference pass if it adopts matrix-typed signals. If shapes are always scalar (single-sample or mono), this degenerates to trivial. If multi-channel or matrix signals are supported, the recursive shape inference pass should be specified as a mandatory compiler stage, not an optimization. The pass directly determines buffer allocation sizes -- getting it wrong causes runtime memory errors, not just performance issues.

This claim extends [[signal-shape-as-a-type-level-property-enables-compile-time-buffer-allocation-and-vectorization]] by specifying the algorithmic challenge that arises when shape is a type property and the graph contains feedback. Also connects to [[construction-time-graph-optimization-distributes-compiler-cost-across-node-creation]] -- construction-time optimization handles feed-forward cases; shape inference for feedback is necessarily deferred to whole-graph compilation.
