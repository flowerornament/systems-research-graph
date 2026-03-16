---
description: Because propagator cells only accumulate information (never retract), races between parallel propagators cannot corrupt cell state, removing the need for explicit synchronization
type: claim
evidence: strong
source: [[we-dont-know-how-to-compute-sussman-2011]]
created: 2026-02-28
status: active
---

# monotonic information cells eliminate synchronization problems in parallel propagator networks

Sussman identifies the monotonic accumulation property (from [[propagator-cells-hold-partial-information-that-accumulates-monotonically]]) as directly solving the synchronization problem for parallel machines. When multiple propagators deposit conclusions into the same cell concurrently, no locking is needed: since information only ever increases, any interleaving of writes produces a valid (though possibly suboptimal-ordering) accumulated state. The final state is order-independent.

This is in contrast to mutable shared state, where concurrent writes require mutual exclusion to avoid corruption. The monotone lattice structure is doing the same work as a lock, but without blocking.

Sussman's vision is a machine where every cell has a dedicated processor -- "if I had as much processor as I had memory" -- running continuously. All these propagators run independently, pushing conclusions in parallel, and the cell structure guarantees the system converges to a consistent state without coordination overhead.

For [[concurrent-systems]] in murail: the RT audio thread processes a graph of signal nodes where nodes push computed samples. If the graph architecture adopted monotonic partial-information semantics for inter-node state (not the audio signal path itself, but configuration/parameter state), NRT-to-RT parameter updates could be made lock-free by construction rather than by careful SPSC channel discipline. The model offers a theoretical grounding for why certain lock-free designs are correct.
