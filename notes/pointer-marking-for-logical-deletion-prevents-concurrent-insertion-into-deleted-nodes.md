---
description: Setting a mark bit in a node's forward pointer before physical deletion prevents concurrent processes from inserting children under a logically-deleted node that will disappear
type: pattern
evidence: strong
source: "[[fraser-2004-practical-lock-freedom]]"
created: 2026-02-28
status: active
---

# pointer marking for logical deletion prevents concurrent insertion into deleted nodes

A subtle hazard in lock-free linked structures: a process may read a node's forward pointer and prepare to insert after it, but by the time the insertion CAS executes, the node has been physically deleted. The new node is then linked from a defunct node that no other process will traverse — the insertion is effectively lost.

Harris's pointer marking technique (2001) solves this for singly-linked lists, and Fraser extends it to skip lists. The technique marks a node's forward pointer (using a low-order bit of the pointer, since aligned allocations guarantee this bit is always zero in valid pointers) as a logical-deletion indicator before unlinking the node. Any process that encounters a marked pointer knows the preceding node is logically deleted:

1. **Logical deletion:** CAS the target node's next pointer to a "marked" version of the same pointer value
2. **Physical deletion:** Subsequently CAS the predecessor's pointer to skip the marked node
3. **Detection:** Any operation that reads a marked pointer backtracks or retries

By separating logical and physical deletion, a two-step process that cannot be made atomic with a single CAS becomes safe. The marking step is an atomic "intent to delete" that other operations can detect and respect.

**Extension to skip lists:** At each level of a skip list, a node can be independently logically deleted before physical removal. Searches automatically backtrack when they follow a marked pointer. This makes skip lists particularly amenable to lock-free implementation because multi-level operations decompose into per-level list operations.

**Alternative:** MCAS can atomically delete across multiple levels without pointer marking, at the cost of the MCAS overhead. Fraser presents both approaches to demonstrate the CAS complexity vs. MCAS overhead tradeoff.

See [[two-phase-descriptor-protocol-enables-multi-location-atomic-updates-from-single-word-cas]] for the heavier-weight alternative.
