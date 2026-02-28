---
description: Obstruction-freedom permits operations to abort conflicting peers and retry later rather than helping them complete, eliminating the helping infrastructure at the cost of requiring an out-of-band livelock avoidance mechanism
type: claim
evidence: moderate
source: "[[fraser-2004-practical-lock-freedom]]"
created: 2026-02-28
status: active
---

# obstruction-freedom allows conflict abort instead of recursive helping reducing implementation complexity

Obstruction-freedom (Herlihy et al., 2003) is a weaker non-blocking property than lock-freedom: an operation is guaranteed to complete only if it runs for long enough without contention. A stalled process still cannot block all others indefinitely (unlike mutual exclusion), but two operations that continually conflict may abort each other without either making progress — livelock remains possible.

The key practical advantage: obstruction-free designs can *abort* a conflicting operation and retry later, rather than implementing the recursive helping machinery that lock-free designs require. The helping infrastructure in MCAS and FSTM is the primary source of complexity in those designs — ensuring an in-progress operation leaves sufficient state for another process to help it to completion requires careful engineering.

**Fraser's assessment:** The helping mechanism is also the primary source of contention in lock-free designs — excessive helping generates memory traffic. Obstruction-freedom avoids this but pushes the problem to the out-of-band contention manager, whose cost and effectiveness had not been empirically evaluated at the time of writing. Exponential backoff on retry is a common approach, but it is unclear whether a universal "sweet spot" for the backoff factor exists across all applications.

**Herlihy et al.'s DSTM** (an obstruction-free STM that Fraser evaluates) demonstrates this tradeoff: it has attractive properties (dynamic sizing, CAS-based, disjoint-access parallel) but requires the caller to implement contention management. Fraser's lock-free FSTM eliminates this burden at the cost of the helping infrastructure.

**Relevance:** As of 2024, obstruction-freedom has largely been superseded by hardware transactional memory (HTM) in practice. The contention management question Fraser identified was never fully resolved for software OFM, but HTM provides hardware fallback paths that make the problem moot in many cases.

See [[lock-freedom-guarantees-system-wide-progress-but-not-per-operation-progress]] for comparison with the stronger progress guarantees.
