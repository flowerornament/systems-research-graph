---
description: In McCartney's system, a synthesis definition is built by calling ordinary functions that create graph nodes; there is no distinct synthdef syntax -- the full language is available for graph construction
type: claim
evidence: moderate
source: [[mccartney-ideas-2026-02-15]]
created: 2026-02-28
status: active
---

# synthesis graph construction is a regular program not a domain-specific declaration

In SuperCollider, synth definitions are constructed with `SynthDef { ... }` -- a block syntax that delimits synthesis code from language code. In Faust, the graph is described in a minimalist block-diagram algebra that is itself a small language. In both systems, there is a syntactic or semantic boundary between "graph construction" and "ordinary programming."

McCartney eliminates this boundary. In his system, a synth definition is built by calling functions that return graph nodes. Functions compose as normal functions. The full language -- higher-order functions, conditionals, loops, data structures, multimethods, modules -- is available during graph construction. McCartney demonstrates this with the bubbles patch as a one-liner using the pipe operator (`|>`, borrowed from F#) to thread the signal through oscillators, scaling, and a comb delay.

Unit generators (filters, oscillators, envelopes) are library functions: they call the primitive node creation API and return graph node values. McCartney says explicitly: "In this language you're compiling whole synthesis to one thing. You can create functions that act as unit generator generators by writing code using the built-in sort of nodes."

A one-pole filter is written as a function that creates a delay node, writes the feedback equation to it, and returns the node. A fade-in envelope is a function that creates a delay, writes a ramp accumulation to it, cubes it, and multiplies it by the input. These are regular functions; they can be parameterized, combined with other functions, mapped over arrays via auto-mapping, and composed with all other language features.

**Contrast with Murail's current approach:** Murail's composition language (Stage 9) is planned as a separate layer. This claim argues that the right design has no distinction: the language is the DSL. Auto-mapping (every function transparently maps over sequences) and the piping operator are the two ergonomic features that make single-sample-level code feel high-level without a distinct graph-construction sublanguage.

**Murail implication:** If Stage 9's composition language is designed so that calling a function creates a graph node and returns a node value, and the language has auto-mapping and piping, the DSL is the language and no separate graph-construction syntax is needed. This simplifies the language design and extends Murail's composition capabilities to the full language feature set.

Related to [[eliminating-unit-generators-exposes-synthesis-graphs-to-cross-boundary-compiler-optimization]] -- eliminating UGens as objects and making them library functions is the necessary precondition for synthesis construction to be a regular program. Extends [[universal-auto-mapping-eliminates-explicit-iteration-from-signal-processing-programs]] by showing how auto-mapping makes regular function calls sufficient for synthesis programming without explicit vectorization or graph-construction DSL syntax.
