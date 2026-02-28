---
description: Applying constant folding, CSE, rate inference, and 120+ algebraic rewrite rules at node creation time rather than in a post-construction pass distributes optimization cost and delivers a pre-simplified graph to the compiler
type: claim
evidence: moderate
source: [[mccartney-ideas-2026-02-15]]
created: 2026-02-28
status: active
---

# construction-time graph optimization distributes compiler cost across node creation

In McCartney's system, graph optimization is not a separate pass that runs after construction. Every node creation immediately triggers four operations: (1) constant folding -- if all inputs are constants, compute the result now; (2) rate inference -- determine output rate from input rates (constant < init < event < audio); (3) common subexpression elimination -- hash the expression, reuse if identical already exists; (4) algebraic rewriting -- apply 120+ pattern-matched rules (double negation, multiply-by-zero, domain-specific signal identities). If rewriting produces new nodes, those nodes recurse through all four steps. This is a fixpoint computation embedded in every constructor.

The effect is that the graph handed to the compiler is already substantially simplified. The compiler then handles operations requiring global information: delay merge, topological sort, delay length calculation, recursive shape inference, graph-to-tree cutting, loop formation, rate separation, code emission. The two-phase split means each phase sees the input it is suited to process.

This approach resembles how symbolic algebra systems work -- simplification is eager and pervasive rather than batched. The cost is a more complex graph builder; the benefit is distributed optimization cost and a leaner final compilation step.

McCartney traces this to the expense of whole-graph optimization passes on large graphs: build big, then optimize, pays the cost all at once. Incremental construction-time optimization makes the cost proportional to the *local* subgraph at each step, not to the full accumulated graph.

**Question for Murail:** The spec's NRT thread handles graph compilation into schedules but does not specify when optimization occurs relative to construction. Eager optimization (distributed cost, local subgraph at each step) versus lazy optimization (simpler builder, single optimization point, potentially better global optimization). The eager approach has a termination question -- McCartney claims his rewrite rules terminate but has not proved it. The lazy approach has a latency question -- will the compiler be fast enough on an unoptimized raw graph?

The rate lattice used during rate inference is: constant < init-time < reset < event < audio. For most operators, if inputs have different rates the output is promoted to the highest. Control-flow nodes (if/switch/for) are exceptions that can produce rate demotions or mixed-rate subgraphs.

Related to [[eliminating-unit-generators-exposes-synthesis-graphs-to-cross-boundary-compiler-optimization]] -- both concern when optimization happens and what the compiler sees. Connects to [[interactive-programming-eliminates-the-compile-run-cycle]] since distributed construction-time optimization supports the compile-and-swap interactivity goal by keeping final compilation fast. See [[graph-compiler-loop-formation-groups-same-dimension-trees-to-enable-vectorization]] for the subsequent passes that build on the pre-optimized graph, and [[recursive-shape-inference-is-required-for-feedback-delay-reads-in-matrix-signal-graphs]] for the shape inference pass that runs after whole-graph construction.
