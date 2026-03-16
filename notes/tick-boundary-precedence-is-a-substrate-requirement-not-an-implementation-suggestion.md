---
description: Hold-slot writes, data swaps, program swaps, and TICK must occur in this fixed order; any other ordering creates ambiguity in the interaction between live edits and parameter updates
type: property
evidence: strong
source: [[murail-substrate-v3]]
created: 2026-02-28
status: active
---

# tick-boundary precedence is a substrate requirement not an implementation suggestion

At each tick boundary, four operations may need to occur. The substrate specifies a fixed execution order:

1. Hold-slot writes from slow threads (slow-rate values become visible)
2. External data swaps (new weights, lookup tables, recorded buffers installed atomically)
3. Program swaps (new compiled program takes effect, live editing)
4. TICK (equation evaluation)

This ordering is mandatory. The substrate document states: "This ordering is a substrate requirement, not an implementation suggestion. Without it, the interaction between hold-slot updates and program swaps is ambiguous."

**The ambiguity being prevented.** If hold-slot writes and program swaps could interleave, a new program might start with stale hold-slot values (the swap executed before the hold-slot write) or a hold-slot write could arrive for an equation that no longer exists in the swapped-in program. Either case produces undefined behavior. The fixed order eliminates this: hold slots are committed first, so the new program reads the current slow-rate values on its first tick.

**This is a global contract.** Every implementation of the Murail substrate must respect this ordering, regardless of threading model. The multi-thread extension (Definition 13.3) generalizes the swap protocol to require all faster threads to observe the swap flag before any of them proceeds -- the same ordering principle applied to N threads.

The tick-boundary precedence is an example of how the substrate formalizes what might otherwise be "obvious" implementation decisions. Making it explicit allows implementations to be verified against the spec and prevents subtle bugs from interleaving.

## Connections

- The program swap that occupies position 3 is specified in detail by [[atomic-swap-enables-program-updates-at-tick-granularity-without-output-gaps]]
- Position 1 (hold-slot writes) requires the hold-slot protocols from [[hold-slots-prevent-fast-thread-blocking-on-slow-rate-values-without-locks]]
- This ordering is what makes [[compile-and-swap-preserves-audio-continuity-during-recompilation]] semantically precise: the old program runs tick t, then the swap fires at the boundary, and the new program runs tick t+1
