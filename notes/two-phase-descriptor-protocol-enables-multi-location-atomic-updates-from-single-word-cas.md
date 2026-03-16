---
description: MCAS and FSTM both use a two-phase descriptor pattern — acquire ownership of all locations then atomically commit or rollback — to simulate multi-location atomicity using single-word CAS
type: pattern
evidence: strong
source: "[[fraser-2004-practical-lock-freedom]]"
created: 2026-02-28
status: active
---

# two-phase descriptor protocol enables multi-location atomic updates from single-word CAS

Both of Fraser's core abstractions (MCAS and FSTM) share the same fundamental structural pattern for achieving apparent multi-location atomicity from single-word CAS:

**Phase 1 (Acquire):** Replace each target location's value with a pointer to an operation descriptor. The descriptor records the operation's intent (old value, new value, current status). While a descriptor is installed, any process can read the *logical* value of the location by consulting the descriptor, and can *help* the operation complete by participating in phase 2.

**Decision point:** Atomically update the descriptor's status field from UNDECIDED to either SUCCESSFUL or FAILED. This single CAS is the linearization point — the moment at which the multi-location update appears to atomically occur.

**Phase 2 (Release):** Replace each descriptor pointer with either the new value (on success) or the original value (on failure). This is idempotent — multiple processes can help without corrupting state.

The pattern's key insight: by installing a descriptor before modifying values, in-progress operations make themselves "describable" to any competing process. This enables recursive helping — if A is blocked by B, A can help B complete rather than spinning. The descriptor also provides the "undo" capability: a failed operation can revert all locations because the old values are recorded in the descriptor.

**Address ordering** is required in Phase 1: locations must be acquired in a globally consistent total order (typically by memory address) to prevent cycles in recursive helping chains. Without ordering, two operations could each hold a descriptor on a location the other needs, creating a helping loop.

**Applications in murail:** The compile-and-swap pattern for hot-swapping the audio graph is structurally similar — a "pending graph" descriptor is installed, then atomically swapped in at a decision point. See [[compile-and-swap-preserves-audio-continuity-during-recompilation]].
