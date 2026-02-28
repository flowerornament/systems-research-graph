---
description: When modification creates a new version with structural sharing, old versions cost only a pointer and undo branches are never lost -- lossless history becomes a side effect rather than a designed feature
type: claim
evidence: strong
source: [[mccartney-ideas-2026-02-15]]
created: 2026-02-28
status: active
---

# persistent data structures make lossless undo an architectural side effect

SAPF logs every expression McCartney has executed over 10 years: 151,000 lines, 5.1 megabytes. He can replay any session. His new system goes further: unlimited undo/redo where undo branches are never destroyed. If you undo several steps and make changes, the undone branch is saved -- you can navigate history linearly (undo/redo) or jump to any point. The implementation is persistent data structures (HAMTs with structural sharing): each historical state is a pointer, not a copy.

The key insight is that lossless history is not an additional feature requiring additional design -- it is what falls out of a persistent data structure architecture at no extra cost. McCartney: "Doing undo is just saving a pointer to the previous thing." The cost of *not* providing full history would be actively throwing away information that the architecture already preserves.

This reframes composition as temporal exploration: you don't build sequentially; you wander through a space of possibilities, branching and backtracking. The history *is* the composition notebook. The ideal McCartney describes -- "I'm just manipulating the audio as directly as possible, and I'm getting results as fast as possible" -- requires that no attempt is lost, because the value of a discarded direction may only become apparent later.

The structural sharing means overhead is proportional to the change, not the data size. A small parameter tweak creates a new version sharing most of the previous state. A large restructuring creates more divergence, proportionally.

**Question for Murail:** Should the composition language have built-in undo/versioning semantics? If the graph IR uses persistent data structures (enabled by [[pervasive-immutability-dissolves-concurrency-problems-rather-than-managing-them]]), graph versioning comes almost for free. But "almost free" at the data structure level still needs UX design for navigating history, comparing versions, and branching. Is this a core language feature or an editor feature? McCartney's experience suggests framing it as a data model property rather than a UI feature -- the data model should make history navigation possible; the editor builds on top.

Extends [[pervasive-immutability-dissolves-concurrency-problems-rather-than-managing-them]] -- undo is one of five architectural consequences that flow from the immutability decision. Together with [[compile-and-swap-preserves-audio-continuity-during-recompilation]], these describe the two forms of continuity McCartney targets: audio continuity during recompilation, and history continuity across exploratory iterations.

Undo/redo is complemented by a separate mechanism in SAPF: see [[sapf-append-only-execution-log-provides-ten-year-session-provenance]]. The log covers cross-session provenance (years, not minutes); undo covers within-session branching. The two mechanisms serve different temporal scales of recovery.
