---
description: Tidal underwent 5+ major representation rewrites over multiple years, each motivated by and informally evaluated through live performance; McLean argues performance pressure is the correct evaluation environment for music language design
type: claim
evidence: moderate
source: [[mclean-2014-making-programming-languages-to-dance-to]]
created: 2026-03-01
status: active
---

# iterative redesign of core representations through live performance is the correct evaluation methodology for music programming languages

McLean's paper includes a developmental history of Tidal's internal pattern representation across at least five major versions, by request of a peer reviewer. This history is unusually candid about the failures:

1. **Tree structure (Atom/Cycle/Polymetry)**: supported infinite-length patterns via Haskell laziness, but had no random access -- replacing a pattern required either restarting event generation or replaying the entire performance history.

2. **Function from discrete time**: used for an earlier publication (McLean & Wiggins 2010); worked for step-sequencer-style electronic dance music, but discrete time made it unsuitable for free jazz and compound meters.

3. **Float-offset hack on discrete time**: added floating-point time offsets to the discrete model; allowed freer timing but broke compound meter support.

4. **Tree with arcs and float onset/duration**: a tree structure with floating-point Arc nodes plus a `Signal` constructor for continuous patterns. Worked better but had the two-type impedance mismatch problem.

5. **Sequence/Signal two-constructor**: separate `Sequence {arc :: Range -> [Event a]}` and `Signal {at :: Rational -> [a]}` types. Used rational numbers. Worked well but "trying to deal with these quite different forms as equivalent caused great complexities in the supporting code."

6. **Current representation (Arc -> [Event a])**: the insight that both discrete sequences and continuous signals could be the same type (Pattern), with continuous patterns handled by sampling the midpoint of the query arc. This eliminated the two-type complexity.

**The methodology observation:** Each version was "motivated by and informally evaluated through live performance." This is not academic benchmark-driven design; it is practitioner-driven iteration. The criterion was: does this representation feel right in performance? Does it support the transformations musicians actually need? The free jazz genre failure (version 2) was discovered *in performance*, not in a test suite.

This methodology has a name in HCI research: Research-through-Practice or PBR (Practice-Based Research). McLean does not use this term explicitly, but the design history demonstrates it: language design for a performance domain requires performance as the evaluation context.

**For murail:** The composition language (Stage 9) should be developed with a similar performance-evaluation loop. Design decisions that look clean in abstract type terms may fail when a musician is trying to use them under performance pressure. The Kolmogorov complexity criterion ([[kolmogorov-complexity-provides-a-measurable-criterion-for-composition-language-design-quality]]) provides a quantitative proxy, but it cannot substitute for actual performance use. This also validates the iterative, "develop through dozens of high-profile performances to diverse audiences" approach McLean used -- the language cannot be fully designed in advance.

Connects to [[creative-workflow-friction-should-determine-audio-engine-architecture]]: McCartney's methodology for SC architecture is the same -- each design decision traced to felt friction in creative practice. McLean applies the same methodology to representation design. Both suggest that performance and studio use are not post-design validation phases but the design process itself.

The developmental history also illustrates the value of the unified representation: complexity in "supporting code" is a signal of a representation mismatch. When two kinds of patterns required two kinds of operations with explicit type-case handling, that was friction the representation was imposing on every downstream combinator. Eliminating the mismatch simplified all downstream code simultaneously -- a structural benefit, not just an aesthetic one.

---

Topics:
- [[language-design]]
- [[developer-experience]]
