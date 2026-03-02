---
description: Slotmap node IDs provide the first-class names Nominal Adapton requires; each edit transaction triggers incremental recompilation of only the transitively affected subgraph
type: claim
evidence: moderate
source: [[pl-research-landscape-2026-02-27]]
created: 2026-03-01
status: active
---

# stable node identities enable Adapton-style incremental recompilation where only affected subgraphs are recompiled

Nominal Adapton (Hammer et al. OOPSLA 2015) is a framework for demand-driven incremental computation: computations are memoized, and when inputs change, only the transitively affected outputs are recomputed. The "nominal" extension adds first-class names, which stabilize memoization across structural changes. Without names, inserting a node invalidates memo entries for all subsequent nodes (because structural positions shift). With names, each computation has a stable identity; only truly affected computations are invalidated.

Murail's formal model provides exactly this structure. Audio graph nodes have stable identities: their NodeId in the slotmap (D51) persists across edits. Edit transactions (Definition 14.1) already decompose edits into add/modify/remove operations -- precisely the granularity at which incremental recompilation should fire. When a node is added or a connection changes, the transitively downstream nodes need recompilation; upstream nodes are unaffected.

The compilation phases most amenable to incrementalization are: topological sorting (only the changed subgraph needs re-sorting; the rest of the topological order is preserved), buffer allocation (only buffers serving affected nodes need reassignment), and schedule generation (only affected blocks need reordering). Each of these computations is a function of the local subgraph -- they do not need global graph information for unaffected nodes.

The payoff is largest for the Deep compilation service level (D65, P99 <= 500ms). Full recompilation of a large graph can approach the 500ms budget; incremental compilation of a single node addition could bring this down to single-digit milliseconds for typical edits. LiveFast (P99 <= 2 audio blocks, ~2.9ms) may require incremental compilation as an architectural prerequisite for large graphs.

The compile-swap-retire lifecycle (Section 35) currently implies full recompilation: build the new graph, compile it, swap it in. Incremental compilation would modify this to: identify the affected subgraph, recompile only that portion, merge with the unchanged compiled state, swap in the merged schedule. The atomic swap mechanism ([[atomic-swap-enables-program-updates-at-tick-granularity-without-output-gaps]]) remains the same; only the scope of recompilation changes.

Directly extends [[compile-and-swap-preserves-audio-continuity-during-recompilation]] by addressing the compile-latency question that claim leaves open. Connects to [[construction-time-graph-optimization-distributes-compiler-cost-across-node-creation]] -- both are strategies for making compilation costs proportional to edit size rather than graph size. See also [[the-migration-map-transforms-state-between-program-versions-preserving-continuity-where-possible]] for the state-threading mechanism that must work correctly with incremental recompilation.

---

Topics:
- [[audio-dsp]]
- [[compiler-and-adoption]]
- [[concurrent-systems]]
