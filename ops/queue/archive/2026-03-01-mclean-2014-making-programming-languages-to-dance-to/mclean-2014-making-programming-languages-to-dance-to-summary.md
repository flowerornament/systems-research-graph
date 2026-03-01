---
batch: mclean-2014-making-programming-languages-to-dance-to
type: summary
completed: 2026-03-01
claims_created: 9
enrichments: 2
connections_added: 31
topic_maps_updated: 4
existing_claims_updated: 2
---

# Batch Summary: mclean-2014-making-programming-languages-to-dance-to

**Source:** `/Users/morgan/code/arscontextica/inbox/archive/mclean-2014-making-programming-languages-to-dance-to/mclean-2014-making-programming-languages-to-dance-to.pdf`
**Paper:** Alex McLean, "Making Programming Languages to Dance to: Live Coding with Tidal," FARM 2014
**Processed:** 2026-03-01

## Claims Created (9)

| Title | Type | Logical ID |
|-------|------|-----------|
| live-coding-performance-requires-three-distinct-feedback-loops-that-together-define-being-in-time | claim | 350 |
| functional-paradigm-dominates-live-coding-practice-because-it-provides-terseness-and-composability-at-performance-speed | claim | 351 |
| representing-musical-pattern-as-a-function-from-time-to-events-unifies-discrete-and-continuous-patterns | property | 352 |
| rational-time-representation-eliminates-rounding-errors-in-rhythmic-subdivision | property | 353 |
| cyclic-time-with-rational-subdivision-provides-the-semantic-anchor-for-pattern-operations-in-electronic-music | claim | 354 |
| applicative-functor-lifts-binary-value-functions-to-pattern-combinators-by-matching-co-occurring-events | property | 355 |
| low-cognitive-load-and-high-viscosity-in-a-composition-language-enable-creative-flow-in-live-performance | claim | 356 |
| a-haskell-embedded-dsl-can-be-learned-and-used-creatively-without-any-functional-programming-background | claim | 357 |
| iterative-redesign-of-core-representations-through-live-performance-is-the-correct-evaluation-methodology-for-music-programming-languages | claim | 358 |

## Enrichments (2)

- `compile-and-swap-preserves-audio-continuity-during-recompilation` -- added McLean three-feedback-loop framing: compile-and-swap is not merely convenient but necessary to preserve the performance feedback loop
- `quantizing-live-code-swaps-to-musical-temporal-boundaries-makes-changes-deterministic-and-musically-predictable` -- added McLean corroboration: cyclic time model makes cycle boundary the natural swap boundary; feedback loop framing grounds the requirement

## Topic Maps Updated (4)

- `language-design` -- new "Tidal: Live Coding and Pattern Design (McLean 2014)" section with all 9 claims; source reference added
- `competing-systems` -- new "Tidal Cycles (McLean 2014): Functional Live Coding Language" section with 6 claims; source reference added
- `developer-experience` -- new Tidal claims added to "Live coding and always-running programs" section (4 claims)
- `audio-dsp` -- new "Tidal Cycles: Time Model and Pattern Representation (McLean 2014)" section with 3 claims; source reference added

## Source Reference Note Created

- `notes/mclean-2014-making-programming-languages-to-dance-to.md`

## Notable Findings

**Unexpected insight:** McLean's three-feedback-loop taxonomy is the cleanest articulation in the vault of *why* live coding imposes specific latency requirements at each layer of the system. The manipulation/performance/social triad maps directly onto murail's composition language / audio engine / deployment layers.

**Design candidate:** The unified `Pattern a = Arc -> [Event a]` type is a direct candidate for murail's composition language time-varying value abstraction. It eliminates the Behavior/Event split that would otherwise complicate pattern composition.

**Tension identified:** McLean's `type Time = Rational` is architecturally sound but creates an impedance mismatch with murail's sample-rate-based RT engine. The scheduler must bridge rational beat time to integer sample positions. No existing claim in the vault addresses this translation layer explicitly.
