---
description: Glitches are caused not by code that is generally slow but by code with unpredictable or unbounded execution time — the cardinal RT rule follows directly from this
type: claim
evidence: strong
source: "[[bencina-2011-real-time-audio-programming-101]]"
created: 2026-03-01
status: active
---

# unbounded execution time is the single root cause of all audio glitches not just slowness

Bencina's foundational observation is that the real enemy is not "slow code" but *unpredictable* code. A slow algorithm that is fast enough and has a known worst case is fine. A moderately fast algorithm with unbounded worst-case execution time is fatal.

This leads directly to Bencina's cardinal rule of real-time audio programming:

> **If you don't know how long it will take, don't do it.**

The rule is not "optimize your code." It is about predictability. Memory allocation takes unpredictable time (the allocator may need to ask the OS for pages, may block on a heap lock, may scan for a free block using a variable-time algorithm). Mutexes take unpredictable time (the holder may be preempted). File I/O takes unpredictable time (disk seek times are stochastic). System API calls take unpredictable time (the implementation may change between OS versions with no notice).

The rule applies recursively: calling any function whose timing you do not understand is calling a function whose timing is unbounded from your perspective. Library functions, OS APIs, and 3rd-party code are black boxes unless they explicitly document real-time guarantees. The safe assumption is that none of them have such guarantees.

This formulation is more precise than simply listing prohibited operations. It explains *why* each operation is prohibited and provides a decision criterion for evaluating code that isn't on any canonical "do not call" list: if you cannot bound its execution time, it is forbidden.

**Contrast:** This is distinct from the pattern-level description in [[audio-system-os-calls-violate-real-time-constraints-through-unpredictable-lock-acquisition-and-page-faults]], which enumerates the specific mechanisms by which OS calls violate RT constraints. This claim provides the unifying principle: all those mechanisms are instances of unbounded execution time.

**Murail:** The resource invariant (Axiom 12.2: no heap allocation during TICK, no blocking operations) is the formal statement of this cardinal rule applied to the murail substrate. [[all-murail-program-state-fits-in-a-single-pre-allocated-contiguous-region]] and [[the-murail-fast-thread-never-halts-errors-degrade-quality-but-do-not-stop-evaluation]] both derive from this principle.

## Connections

- [[audio-system-os-calls-violate-real-time-constraints-through-unpredictable-lock-acquisition-and-page-faults]] -- enumerates the specific mechanisms (lock acquisition, page faults) that make OS calls unbounded; this claim is the principle that unifies all of them
- [[real-time-audio-code-must-be-designed-for-worst-case-not-amortized-average-case-execution-time]] -- the algorithmic consequence: worst-case matters, not average; follows directly from this principle
- [[all-murail-program-state-fits-in-a-single-pre-allocated-contiguous-region]] -- murail's structural implementation of the "no unbounded operations" rule: all allocations happen before the first TICK, making per-tick allocation time zero
- [[the-murail-fast-thread-never-halts-errors-degrade-quality-but-do-not-stop-evaluation]] -- the formal axiom that encodes this rule at the substrate level: even error handling must not block
- [[inference-engines-violate-real-time-principles-on-every-inference-not-just-initial-ones]] -- a concrete measurement of what happens when this rule is violated: inference engines call malloc and pthread_mutex_lock on every inference, exactly the operations this rule forbids
