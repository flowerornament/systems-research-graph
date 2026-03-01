---
description: Tidal models time as an infinite spiral where whole numbers are successive downbeats (sam) and rational points are subdivisions; this cyclic assumption is the semantic anchor for all pattern transformations
type: claim
evidence: moderate
source: [[mclean-2014-making-programming-languages-to-dance-to]]
created: 2026-03-01
status: active
---

# cyclic time with rational subdivision provides the semantic anchor for pattern operations in electronic music

McLean makes a structural claim about what makes Tidal's pattern operations coherent: the underlying assumption that musical time is organized in *metric cycles* (not linear time), with each cycle indexed by a whole number (the "sam" beat in Indian classical terminology). All pattern operations -- reversal, phase-shifting, density changes, every-N-cycles transformations -- derive their meaning from this cyclic structure.

The model is visualized as a spiral: time both repeats (cyclic structure) and progresses (each cycle has a distinct index). The number line of integers represents successive downbeats. Any point within a cycle is a rational number (where the cycle duration is normalized to 1). This is not linear time with a tempo applied; it is a *semantic model* of time where the cycle is the fundamental unit and tempo is an external parameter (managed by the scheduler, not the pattern).

**Why this matters for language design:**

1. *Reversal* only makes sense at cycle boundaries. Reversing an infinite linear timeline is undefined; reversing each cycle within it is well-defined: `rev "blue grey orange"` plays the pattern backwards within each cycle.

2. *Phase shifting* (`<~` and `~>`) is defined as angular offset within the cycle -- "turn clockwise/anticlockwise." The metaphor is literal: the cycle is a circle, and shifting is rotation. This would be meaningless without the cyclic anchor.

3. *Conditional transformations* (`every 3 rev`) require a cycle count. The cycle number provides the countable unit.

4. *Polyrhythm vs. triplet* (square vs. curly bracket syntax in Tidal's mini-notation) is defined by whether subpatterns share cycle boundaries or share element duration. Both definitions reference "cycle" as the semantic unit.

McLean grounds this in musical tradition: Indian classical music's sam concept, and the downbeat of electronic dance music. The claim is that these traditions have independently converged on the same perceptual structure because metric cycles are a *perceptual phenomenon* underlying diverse musical traditions, not merely a Western convention.

For murail: the composition language needs a time model with a similar cyclic anchor if it is to support the same class of pattern operations. The formal model's "section" concept and the timeline model may serve this role, but the question is whether cycles are user-visible or implicit. Tidal makes them explicit (every pattern has a cycle, every transformation is relative to the cycle) and McLean reports this as a design success. Contrasts with linear sequencers (MIDI step sequencers, DAW piano rolls) that use absolute time positions and cannot express "every third cycle, reverse the pattern" without explicit loop counting.

The cyclic model also connects to [[a-single-overloaded-operator-can-unify-assignment-signal-routing-and-synchronization-in-an-audio-language]] (ChucK): ChucK's suspended-animation timing creates a cycle-like structure by letting the programmer advance time explicitly, but ChucK does not provide a named cycle concept -- the "cycle" in ChucK is whatever period the programmer chooses. Tidal makes cycles the universal semantic unit.

---

Topics:
- [[language-design]]
- [[audio-dsp]]
