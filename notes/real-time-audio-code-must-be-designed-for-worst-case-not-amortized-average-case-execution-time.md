---
description: Algorithms that run fast 99.9% of the time but spike occasionally are standard in general computing but fatal in RT audio — worst-case bounds, not amortized averages, determine RT safety
type: claim
evidence: strong
source: "[[bencina-2011-real-time-audio-programming-101]]"
created: 2026-03-01
status: active
---

# real-time audio code must be designed for worst-case not amortized average-case execution time

General computing optimizes for throughput: an algorithm that runs super-fast 99.9% of the time but occasionally takes 1000x longer may be considered "the fastest algorithm available" in amortized terms. This is normal and acceptable for non-RT code.

In real-time audio, this tradeoff is inverted. The buffer period is a hard deadline — typically 1–5ms on modern systems. If code takes 1000x longer even once, the audio glitches. The 99.9% of callbacks that complete in time are irrelevant; the 0.1% that miss the deadline are catastrophic.

**Concrete examples of acceptable-looking but RT-unsafe patterns:**
- `std::vector::push_back()` is O(1) amortized but O(n) on capacity exhaustion (reallocates and copies all elements). The spike is bounded but can be milliseconds for large vectors.
- `memset()` on a large delay line looks like a single function call but takes time proportional to the buffer size. Resetting a 1-second delay line at 44.1kHz involves clearing 44,100 floats — measurably long.
- Many C++ STL container operations (sort, map rebalancing) are average-case optimized, not worst-case optimized.
- General-purpose memory allocators have variable-time search algorithms for free blocks; even without OS calls, the allocator itself may have poor worst-case behavior.

**The correct design response:**
- Prefer O(1) worst-case algorithms.
- Where O(1) is not possible, know the exact bound and verify it fits within the buffer period.
- Spread amortized cost across many callbacks rather than allowing spikes.
- If an operation has a large bounded worst case, check whether multiple worst cases can coincide — summed spikes may still miss the deadline.

**Connection to [[unbounded-execution-time-is-the-single-root-cause-of-all-audio-glitches-not-just-slowness]]:** This claim is a specialization. "If you don't know how long it will take, don't do it" applies even to algorithms where *you do know* how long it takes but that bound is incompatible with the buffer period.

**Murail:** The substrate's preference for O(1) operations in the TICK loop follows from this. The state region Σ uses a fixed-layout array (O(1) indexed access) rather than any dynamic structure. The load-shedding mechanism ([[load-shedding-preserves-the-critical-set-exactly-while-degrading-non-critical-equations]]) addresses the case where the worst-case computation time of a full TICK exceeds the deadline — degrading rather than missing the deadline.

## Connections

- [[unbounded-execution-time-is-the-single-root-cause-of-all-audio-glitches-not-just-slowness]] -- this claim specializes that principle: worst-case matters because the worst case is what causes glitches, not the average
- [[audio-system-os-calls-violate-real-time-constraints-through-unpredictable-lock-acquisition-and-page-faults]] -- OS calls violate both the unbounded-time and worst-case principles simultaneously
- [[real-time-safe-memory-strategies-form-a-spectrum-from-up-front-fixed-allocation-to-incremental-gc]] -- the memory strategies in that spectrum differ precisely by their worst-case time behavior: fixed allocation is O(1), per-thread pools are O(n) worst case, GC pauses are bounded only with real-time GC
- [[load-shedding-preserves-the-critical-set-exactly-while-degrading-non-critical-equations]] -- murail's response when the worst-case TICK computation time exceeds the deadline: shed non-critical work rather than miss the deadline
- [[anira-latency-formula-derives-minimum-required-buffering-from-worst-case-inference-time-and-buffer-size-mismatch]] -- anira explicitly uses worst-case inference time I_max (not average) in its latency formula; direct application of this principle to neural inference buffering
