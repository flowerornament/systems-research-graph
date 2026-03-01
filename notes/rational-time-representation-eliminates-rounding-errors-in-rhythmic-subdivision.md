---
description: Tidal uses Haskell's Rational (arbitrary-precision fractions) for musical time; floating-point time accumulates rounding errors that corrupt rhythmic structures with non-power-of-two subdivisions
type: property
evidence: strong
source: [[mclean-2014-making-programming-languages-to-dance-to]]
created: 2026-03-01
status: active
---

# rational time representation eliminates rounding errors in rhythmic subdivision

Tidal defines `type Time = Rational` (arbitrary-precision rational numbers, i.e., exact fractions p/q). The motivation is musical: rhythm is fundamentally about subdivision of cycles, and many common rhythmic structures produce fractions that cannot be represented exactly in floating point.

The canonical example is triplets: a cycle divided into three equal parts gives 1/3, 2/3, 1 -- none of which have exact binary floating-point representations. Repeated arithmetic on floats accumulates errors that can cause beats to drift out of phase over time, or cause subdivision boundaries to land in the "wrong" audio buffer. In a 44100 Hz system running at 256 samples/buffer, a rounding error of 1e-6 in a time value corresponds to roughly 0.04 samples -- small, but observable when patterns run for hours and events are expected to land on exact boundaries.

With rational arithmetic, 1/3 + 1/3 + 1/3 == 1 exactly. Any meter that can be expressed as a ratio of integers (which covers all standard musical meters, including complex polyrhythmic structures) can be computed without accumulated error. The cost is performance: rational arithmetic requires arbitrary-precision integer operations, not hardware float. Tidal accepts this tradeoff because the pattern query results are consumed by a scheduler (not computed at sample rate), so the performance cost is paid at scheduling time rather than in the audio callback.

This connects to a general principle in music systems: floating-point sample position tracking is adequate for fixed-rate playback but breaks down for complex rhythmic programming. SuperCollider uses double-precision float for beat scheduling; this is adequate for most musical time scales but can introduce 1-sample jitter for very long patterns. ChucK uses rational time internally for its `now` mechanism ([[suspending-time-until-explicitly-advanced-gives-deterministic-reproducible-timing-across-machines]]).

For murail: the composition language's pattern scheduler should use rational time (or a fixed-denominator integer representation equivalent to rational time within a known maximum subdivision) rather than floating-point. The timed command kernel in the formal model (D69, sample-accurate scheduling) is the right target; the question is whether the user-facing API exposes rational beat fractions or requires the user to think in samples. Tidal's design suggests exposing rational beats as the primary user-facing time type, with sample-rate conversion handled inside the scheduler.

---

Topics:
- [[language-design]]
- [[audio-dsp]]
