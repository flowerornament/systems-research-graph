---
description: Programs modified by teams distant from the original theory-builders degrade in design quality over time even when individual changes are locally correct
type: claim
evidence: strong
source: [[naur-1985-programming-as-theory-building]]
created: 2026-02-28
status: active
---

# software quality degrades in proportion to distance from original theorists

Naur's systemic claim: as time passes and teams change, programs tend toward lower design quality even when each individual modification is technically sound. The degradation is proportional to the distance (organizational, temporal) from the programmers who held the original theory.

"Distance" has two dimensions:

**Temporal distance**: The longer since the original theorists were active, the more tacit knowledge has been lost. Early handoffs lose little; handoffs after many years of intermediate ownership may have lost nearly all of it through successive approximation errors accumulating across each revival.

**Organizational distance**: The degree of knowledge transfer during handoff determines how much theory is preserved. A team that overlaps with the original for months transfers more theory than one that inherits an abandoned project with only documentation.

The mechanism is [[program-revival-by-newcomers-systematically-produces-degraded-designs]] operating over time. Each revival adds some incoherence. The incoherence compounds. Eventually the program no longer reflects any coherent design -- it reflects the overlay of many partially-informed modifications.

This is distinct from the technical debt framing. Technical debt implies the choices were made knowingly under time pressure. Naur's degradation occurs even when each programmer does their best: they simply do not have the theory and cannot know what constraints their modifications are violating.

The pattern predicts: (1) large-scale refactors will fail if they don't rebuild the theory first; (2) "legacy" systems are often not poorly-written original code but well-written original code buried under accumulated incoherence; (3) rewriting from scratch sometimes succeeds not because the new code is technically superior but because the new team holds a theory.

For murail: the design rationale system is a hedge against this pattern. Each session handoff attempts to preserve enough theory that the next session can make coherent decisions. The explicit acknowledgment in [[no-documentation-can-substitute-for-the-programmer-held-theory]] is that this hedge is partial.

Connects to [[vibe-coding-produces-unauditable-architectural-debt]] as an accelerated version: vibe coding skips the theory-building step entirely, putting the codebase immediately into the degraded state that normally takes years to reach. Also connects to [[program-revival-by-newcomers-systematically-produces-degraded-designs]] as the temporal extension: each revival is a step on the degradation curve.
