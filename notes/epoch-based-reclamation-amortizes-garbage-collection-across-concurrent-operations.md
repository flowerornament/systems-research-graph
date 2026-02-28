---
description: A global epoch counter allows safe reclamation of lock-free garbage once all processes have observed the current epoch, requiring only three limbo lists and no per-object reference counting
type: pattern
evidence: strong
source: "[[fraser-2004-practical-lock-freedom]]"
created: 2026-02-28
status: active
---

# epoch-based reclamation amortizes garbage collection across concurrent operations

Lock-free data structures cannot safely free memory when an object is logically removed, because other processes may hold private references to it that were acquired before the removal. The epoch-based reclamation scheme (EBR) solves this without per-object reference counting:

**Core mechanism:**
- A global epoch counter is shared by all processes
- When a process starts a shared-memory operation, it records the current epoch as its "observed epoch"
- When an object is logically removed (e.g., a node deleted from a skip list), it is placed on the *current epoch's limbo list* rather than freed immediately
- When all processes have observed an epoch ≥ e, the limbo list from epoch e−2 can safely be freed — no process holds a reference to it from a previous operation

Only three limbo lists are needed at any time: current epoch (being populated), previous epoch (processes may still hold references), and two-epochs-ago (safe to reclaim once all processes advance).

**Reclamation trigger:** Probabilistically, when a process starts an operation, it scans the process list to check whether all active processes have observed the current epoch. If so, it reclaims the oldest limbo list and increments the epoch.

**Trade-off vs. hazard pointers (SMR):** EBR has much lower per-traversal overhead — no memory barrier required per pointer dereference. Fraser reports that adding SMR-style hazard pointer barriers to his BST increased execution time by ~25%. However, EBR is not strictly lock-free: a stalled process prevents epoch advancement, potentially causing unbounded limbo list growth.

**Trade-off vs. reference counting:** EBR defers reclamation but requires no atomic increment/decrement per access. Reference counting has immediate reclamation but creates contention bottlenecks when many processes read from shared objects.

**Implications for murail:** For the NRT side (non-real-time), EBR is appropriate — the NRT thread can stall without catastrophe, and the low per-operation overhead is valuable. For the RT side, neither EBR nor SMR are suitable since both require periodic scanning. The preferred pattern is to avoid dynamic allocation on the RT thread entirely.

See [[reference-counting-becomes-viable-when-immutability-prevents-object-cycles]] for a complementary approach in immutable systems.
