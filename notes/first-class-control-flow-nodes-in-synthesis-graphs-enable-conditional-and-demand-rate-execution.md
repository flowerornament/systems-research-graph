---
description: Treating if/switch/for as primitive graph nodes equal to arithmetic and delay creates genuinely conditional multi-rate synthesis with pause and demand-rate patterns no other audio language supports
type: claim
evidence: moderate
source: [[mccartney-ideas-2026-02-15]]
created: 2026-02-28
status: active
---

# first-class control-flow nodes in synthesis graphs enable conditional and demand-rate execution

McCartney's synthesis graph has four types of primitive nodes: constants, math operators, delays, and control flow (if/switch/for). Control flow nodes are not special cases or workarounds -- they are fundamental to the graph IR on equal footing with arithmetic. An `if` node conditionally evaluates subgraphs (enabling pause-like behavior); `switch` selects between subgraphs; `for` iterates (enabling demand-rate patterns).

In SuperCollider, conditional execution existed through special `Pause` UGens and demand-rate UGens -- special-case behavior with special-case implementation. In Faust, there is no runtime conditionality at all. Kronos (multi-rate, reactive) and Yann Orlarey's Faust extensions approach it but cannot do demand-driven or pause-style subgraphs. McCartney: "you can't do [pause] in Faust."

Making conditionality a graph primitive has a direct consequence for the scheduler: the synthesis graph is not a simple dataflow DAG where every node runs every block. It is a conditional dataflow graph where subgraphs activate and deactivate. The scheduler must handle variable-rate execution, gate propagation, and potentially different block sizes for different subgraphs.

McCartney explicitly lists "event codegen" and "scheduler" as unfinished work and calls them hard. This is not incidental -- conditional multi-rate execution is the hardest scheduling problem in audio. The primitives are defined; the compiler infrastructure to lower them to efficient machine code is the unsolved problem.

**Question for Murail:** The spec has control-rate and audio-rate as explicit properties but does not define conditional subgraphs or demand-rate execution. McCartney's experience says this is both essential (expressive synthesis) and extremely difficult (event codegen is his unsolved problem). Designing these in later is much harder than planning for them now; but shipping a working scheduler for the simpler case first has obvious value. The design question is whether the scheduler's data model can accommodate conditional subgraphs without requiring a full redesign when they are eventually added.

Directly relevant to [[sample-accurate-triggering-in-block-based-audio-requires-splitting-render-blocks-into-sub-block-execution-lambdas]] -- sub-block splitting is one mechanism for handling conditional execution at sample-accurate boundaries; McCartney's control-flow nodes require a more general solution that handles arbitrary subgraph activation. See also [[interactive-programming-eliminates-the-compile-run-cycle]] for context on why pause/demand-rate matters: stopping and restarting subgraphs is part of the interactive, exploratory workflow McCartney targets.

Cross-language note: [[algebraic-effects-unify-exceptions-state-iterators-and-async-under-a-single-abstraction]] shows that pause/demand-rate execution is structurally similar to algebraic effects where an operation suspends and resumes on demand. McCartney is solving the same problem in the graph scheduler that Leijen solves in the effect system -- the difference is that effect handlers make the resumption point explicit and typed, while McCartney's approach buries it in the compiler infrastructure. This may be relevant if murail's Stage 9 composition language eventually needs to model scheduler-level suspension as an effect.

The distinction between deep and shallow handlers is relevant here: [[deep-handlers-differ-from-shallow-handlers-because-continuation-is-resumed-under-the-same-handler]] -- for audio-rate iteration patterns (demand-rate execution), deep handlers (which re-enter the same handler on each yield) are the correct default. Shallow handlers would require explicit re-installation of the handler for each yield step.
