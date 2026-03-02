---
description: Classical algorithm analysis assumed uniform memory access; modern multi-level caches make contiguous array layout 100x faster than pointer-chased linked list traversal at practical sizes
type: claim
evidence: strong
source: [[llvm-creator-interview-chris-lattner]]
created: 2026-02-28
status: active
---

# cache-hierarchical hardware makes linked lists slower than arrays for most practical sizes

Classical algorithm analysis establishes that inserting into the middle of an array is O(n) (all subsequent elements must shift) while inserting into the middle of a linked list is O(1) (pointer surgery only). This analysis is technically correct but practically misleading on modern hardware.

Modern CPUs have multiple cache levels (L1/L2/L3) with dramatically different access latencies. L1 hit: ~1ns. L3 hit: ~30-40ns. Main memory: ~100ns. Cache lines load 64 bytes at a time. When you walk an array, successive elements are adjacent in memory; once the first cache line is loaded, subsequent elements are likely already cached. When you walk a linked list, each node's `next` pointer points to an arbitrarily located address; each dereference potentially misses the cache and waits for main memory. The result, as Lattner states: walking a linked list on a modern computer can be "100 times slower" than walking an equivalent array.

This matters not just for linked lists per se, but for any data structure that indirects through pointers: tree structures, hash tables with chaining, any heap-allocated object graph. The constant factor penalty from cache misses can easily swamp asymptotic advantages at realistic data sizes.

For [[language-design]] and murail's audio graph runtime: this is a concrete justification for arena allocation, contiguous buffer layouts, and the preference for flat data-oriented designs over pointer-chased object graphs in RT audio code. [[signal-shape-as-a-type-level-property-enables-compile-time-buffer-allocation-and-vectorization]] is a direct application: knowing buffer sizes statically means contiguous stack or arena allocation rather than heap-scattered objects.

For [[concurrent-systems]]: the argument for using lock-free SPSC ring buffers (contiguous circular arrays) over linked queues in the RT/NRT boundary is partly this cache argument -- a ring buffer's contiguous layout stays hot in cache across the RT thread's tight render loop.

Connects to [[purely-functional-languages-fail-on-modern-hardware-because-pointer-boxing-destroys-cache-locality]] which extends this argument to explain functional language performance in general.
