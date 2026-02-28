---
description: Skip list nodes are independently insertable at each level, making multi-level updates decomposable into single-level linked-list operations — a property that makes skip lists more amenable to lock-free implementation than trees
type: claim
evidence: strong
source: "[[fraser-2004-practical-lock-freedom]]"
created: 2026-02-28
status: active
---

# skip lists decompose multi-level updates enabling higher lock-free parallelism than trees

A key structural property that makes skip lists particularly suited to lock-free implementation: a skip list node is "visible" (accessible to lookups) as soon as it is linked into the *lowest* level. Insertion at higher levels is required only to maintain O(log n) expected search time, but these higher-level insertions are correctness-independent — they can be performed concurrently with other operations and can even be delayed or omitted without violating the data structure's functional contract.

This property allows lock-free skip list implementations to decompose complex multi-level updates into sequences of single-level linked-list operations, each of which requires only one CAS. Binary search trees and red-black trees lack this property — tree rotations during deletion require coordinated updates to multiple nodes simultaneously, which forces use of MCAS or FSTM for clean implementation.

Fraser demonstrates three skip list designs with increasing complexity and performance:
1. **FSTM-based**: Mechanically derived from the sequential algorithm; trivially correct
2. **MCAS-based**: Uses MCAS to batch multi-level updates; moderate complexity
3. **CAS-based**: Directly uses pointer marking for logical deletion; highest performance, most complex

The CAS-based design exploits the per-level decomposability — deletion marks each level's forward pointer independently using Harris's pointer marking technique, then physically unlinks the node level by level. Concurrent operations detect marked pointers and backtrack correctly.

**Implication:** For NRT-side concurrent data structures in murail where O(log n) lookup is needed (parameter maps, node registries), a lock-free skip list is likely preferable to a lock-free BST due to its natural decomposability. Rust's `crossbeam-skiplist` crate implements this pattern.

See [[pointer-marking-for-logical-deletion-prevents-concurrent-insertion-into-deleted-nodes]] for the deletion technique and [[mcas-and-stm-trade-performance-for-programmability-at-a-quantifiable-cost]] for the abstraction performance hierarchy.
