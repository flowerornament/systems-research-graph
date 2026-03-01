---
description: CCS parallel and Unix pipe require a binary fold over two simultaneous computations -- a structure effect handlers cannot provide since primitive recursion folds one structure at a time
type: property
evidence: strong
source: [[plotkin-pretnar-2009-handlers-of-algebraic-effects]]
created: 2026-03-01
status: active
---

# parallel composition cannot be expressed as an effect handler because it requires folding two structures simultaneously

Plotkin and Pretnar identify this as the primary open question in their paper (Section 9, mentioned also in Sections 6.3 and 6.7): "The most important [question] is how to simultaneously handle two computations to describe parallel operators, e.g., that of CCS or the UNIX pipe combinator."

The problem is structural: an effect handler provides a fold over *one* computation. Parallel composition requires coordinating *two* computations -- deciding at each step which one advances, how they communicate, what happens when they synchronize. This requires a binary recursive structure over *two* free models simultaneously, not a unary fold over one.

Concretely: in CCS, the parallel combinator `P | Q` is defined recursively on the structure of *both* `P` and `Q`. At each step, either `P` moves, or `Q` moves, or both synchronize on a shared action. The handler for `P` would need to observe the current state of `Q` to decide what to do, and vice versa. This mutual dependency cannot be expressed as a unary homomorphism `FA → M`.

Plotkin and Pretnar note: "primitive recursion is inherently defined on a single structure" -- so even if one extended handlers to binary cases, it would require a new general mechanism that the current framework does not have.

**What can be expressed**: CCS *renaming* and *hiding* are expressible (Section 6.3), because they transform *one* computation without needing to observe another. Similarly, Unix output redirection (`proc > outfile`) and input redirection (`proc < infile`) are expressible -- they intercept one stream. But `proc1 | proc2` is not expressible with current handlers.

**Connection to [[algebraic-effects-unify-exceptions-state-iterators-and-async-under-a-single-abstraction]]**: algebraic effects unify many concurrent patterns, but *true parallelism* (simultaneous execution with communication) falls outside the unification. Async (registering a callback to resume when one event fires) is expressible; concurrent communication channels (where two processes must rendezvous) are not.

**Implication for [[language-design]]**: if murail's composition language ever models audio-graph concurrency (nodes running in parallel, communicating via shared buffers), the algebraic effects framework as described by Plotkin and Pretnar does not provide a direct mechanism. The audio engine's concurrency model would require either: (a) a sequential simulation of parallel execution (e.g., running nodes in topological order), (b) an extension to the handler framework (binary handlers), or (c) a separate concurrency primitive outside the effect system.

This is a known limitation and the subject of ongoing research. It does not undermine the value of the framework for sequential effects (exceptions, state, I/O, scheduling) -- but it is the boundary of the algebraic approach.
