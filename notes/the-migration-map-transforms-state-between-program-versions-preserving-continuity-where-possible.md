---
description: The migration map specifies per-equation how to populate new state from old: copy (name persists, compatible shape), reinit (new or incompatible), or gauge-transform (declared invariant)
type: property
evidence: strong
source: [[murail-substrate-v3]]
created: 2026-02-28
status: active
---

# the migration map transforms state between program versions preserving continuity where possible

When a program is live-edited, the new layout L' differs from the old L. The migration map μ specifies how to populate the new state region Σ_shadow from the current Σ_live:

| Case | Condition | Action |
|---|---|---|
| `copy(n)` | Name exists in both versions, shape and depth compatible | Copy full ring buffer from L(n) to L'(n) |
| `reinit` | Name is new, or shape/depth incompatible | Initialize to default element e_n |
| `gauge(g, n)` | Name exists, shape compatible, gauge transform declared | Apply g^{-1} to old state, write to new |

**Partial migration** (Definition 16.2) is the optimization: only equations affected by the edit (added, removed, modified, or transitively dependent on modified) are processed by the migration map. Unaffected segments are block-copied without interpretation.

**Gauge transforms** are the mechanism for seamless edits. A gauge annotation on an edit transaction asserts that the old and new programs are output-equivalent -- they differ only in internal parameterization. For example, changing a filter's internal representation (direct form I to direct form II) does not change the observable output if the state is correctly reparameterized. The gauge's repair function `repair_G: Σ → Σ` restores the invariant. Without a gauge annotation, migration uses copy-or-reinit, which is safe but may produce a discontinuity at the swap boundary (an audible click in audio).

**The migration map is a formal specification.** Compare to informal hot-reload implementations that typically copy "what they can" with ad-hoc heuristics. The Murail migration map is a function with defined behavior per equation, computed by the compiler from the edit transaction. This makes live editing auditable and testable.

## Connections

- The migration map populates Σ_shadow before the atomic swap in [[atomic-swap-enables-program-updates-at-tick-granularity-without-output-gaps]]
- Gauge transforms are domain-provided (Layer 3); the audio domain's gauge is phase continuity to avoid clicks at swap boundaries
- Partial migration is possible because the dependency graph (see [[the-causality-condition-requires-every-dependency-cycle-to-contain-a-delay-edge]]) makes "affected equations" a well-defined set
- The copy-or-reinit default without gauge is analogous to how [[compile-and-swap-preserves-audio-continuity-during-recompilation]] is described in practice, with the gauge as the formal mechanism for ensuring "no click"
