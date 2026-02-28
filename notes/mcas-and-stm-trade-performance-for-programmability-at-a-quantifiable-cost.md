---
description: Fraser's evaluation shows CAS > MCAS > STM in throughput under low contention; STM's programmability advantage comes at 2-4x overhead that may be acceptable when complexity dominates performance
type: claim
evidence: strong
source: "[[fraser-2004-practical-lock-freedom]]"
created: 2026-02-28
status: active
---

# MCAS and STM trade performance for programmability at a quantifiable cost

Fraser's empirical results on a 106-processor Sun Fire server establish a clear performance hierarchy among lock-free synchronization abstractions:

**Under low contention (the common case for well-sized data structures):**
- **CAS-based designs** are fastest but require manual coordination of related multi-location updates, making them extremely difficult to implement correctly
- **MCAS-based designs** perform comparably or slightly worse, but dramatically reduce implementation complexity
- **FSTM-based designs** have 2-4x overhead due to shadow copying, object handle list management, and double-read of object headers during commit
- **Multi-reader locks** often perform *worst* due to cache coherency bottlenecks at shared entry points

**Under high contention:**
- CAS-based designs excel *if* carefully implemented to do minimal work on conflict
- MCAS degrades because locations are likely modified before MCAS even starts
- FSTM also degrades as an optimistic technique, but less than MCAS at high contention because it acquires fewer locations
- Write-locks outperform both optimistic techniques under very high contention due to serialization overhead spreading amortization

**Key programmability insight:** FSTM allows a sequential algorithm to be mechanically wrapped in transactions — Fraser shows that the FSTM-based skip list in Figure 4.2 is trivially derivable from the sequential algorithm, while the CAS-based design in Figure 4.4 requires deep understanding of lock-free pitfalls.

**Implications for murail:** For NRT-side data structures (graph topology, parameter maps), STM-style optimistic concurrency is a viable programming model when contention is expected to be low. The performance cost is acceptable at NRT latencies. For structures accessed by the RT thread, even simple CAS operations should be preferred for their bounded, minimal overhead. See [[two-phase-descriptor-protocol-enables-multi-location-atomic-updates-from-single-word-cas]] for the shared structural pattern.
