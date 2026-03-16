---
description: In a non-lazy language without mutation, new objects can only reference existing ones, making reference cycles structurally impossible and reference counting sufficient to replace garbage collection
type: pattern
evidence: moderate
source: [[mccartney-ideas-2026-02-15]]
created: 2026-02-28
status: active
---

# reference counting becomes viable when immutability prevents object cycles

Garbage collectors exist primarily to handle reference cycles: A points to B points to A, neither reachable from roots but neither collectible by reference counting. The standard engineering response is a tracing or generational GC. McCartney's response is to make cycles structurally impossible.

The argument is tight: in a non-lazy language, every new object must be created from already-existing objects. An existing object cannot reference a new object that has not yet been constructed. Therefore, in a non-lazy, non-mutable language, the reference graph is always a DAG -- cycles require mutual reference at construction time, which cannot happen. Reference counting on a DAG is exact: any object whose reference count drops to zero is unreachable and can be freed immediately.

McCartney validates this with unit tests checking for leaks after arbitrary programs: "it's always zero." The runtime represents all values as a tagged slot (integer, float, nil, bool, or reference-counted smart pointer). The smart pointer handles reference count management, so individual methods don't need to manage counts -- they just use value objects.

The only exception is explicit mutable `Ref` objects. These are mutex-protected and can, in principle, be arranged into cycles. McCartney reports that practice with SAPF shows this is rare enough not to be a concern: mutable refs are typically used for inter-thread communication (bounded queues, shared control values), not for self-referential data structures.

**Implication for Murail Stage 9 composition language:** If the composition language adopts persistent immutable data structures (as McCartney's work suggests is ergonomically viable), the memory model for the language runtime could use RC rather than a GC. This is significant because a GC would introduce stop-the-world pauses that are incompatible with audio RT requirements if the composition runtime is ever resident on the RT side. RC with immutable data is pause-free by construction.

Related to [[pervasive-immutability-dissolves-concurrency-problems-rather-than-managing-them]], which documents the full set of consequences; this claim isolates the memory management mechanism specifically. Contrasts with [[erlang-actor-model-enables-safe-process-kill]], which addresses shared-nothing concurrency through process isolation rather than immutable data.
