---
id: fraser-2004-practical-lock-freedom-extract
batch: fraser-2004-practical-lock-freedom
type: extract
status: pending
source: /Users/morgan/code/systems-research-graph/inbox/archive/fraser-2004-practical-lock-freedom/fraser-2004-practical-lock-freedom.txt
archive_folder: /Users/morgan/code/systems-research-graph/inbox/archive/fraser-2004-practical-lock-freedom/
created: 2026-02-28
next_claim_start: 1
---

# Extract Task: fraser-2004-practical-lock-freedom

**Source:** Keir Fraser, "Practical lock-freedom" (PhD dissertation, UCAM-CL-TR-579, University of Cambridge, 2004)

**Scope:** Full dissertation — 7 chapters on lock-free programming abstractions (MCAS, FSTM), lock-free search structures (skip lists, BSTs, red-black trees), implementation issues (memory management, epoch-based reclamation, relaxed memory consistency), and performance evaluation.

**Primary relevance to murail:** concurrent-systems domain — lock-free communication patterns, epoch-based reclamation as an alternative to hazard pointers, the MCAS/FSTM abstraction tradeoffs, and the argument that existing hardware primitives suffice for practical lock-free systems.

**Extraction scope:** Claims, properties, patterns, and open questions relevant to:
- Lock-free progress guarantees (lock-freedom vs. wait-freedom vs. obstruction-freedom)
- MCAS and STM as practical programming abstractions
- Epoch-based memory reclamation
- Descriptor-based two-phase commit patterns
- Performance tradeoffs between CAS/MCAS/STM/locks
- Memory barrier placement in relaxed consistency models
- Linearisability and disjoint-access parallelism as formal properties
