---
description: ChucK has no fixed control rate; the control rate at any point in a program is the inverse of the programmer's chosen time-advancement interval, enabling per-shred and dynamically varying rates
type: property
evidence: strong
source: [[wang-cook-2003-chuck]]
created: 2026-03-01
status: active
---

# control rate as emergent product of time-advancement eliminates the fixed control-rate constraint

In most audio programming systems, the control rate is a fixed parameter: a configurable constant set at system startup that determines how often control-rate computations execute relative to the audio sample rate. SuperCollider's control rate, Nyquist's control period, and most unit generator frameworks treat it as a single global value.

ChucK eliminates the fixed control rate entirely. The "control rate" at any point in a ChucK shred is the inverse of the duration value the programmer uses in their time advancement. Since the programmer can choose any duration -- `1:samp` (sample rate), `1:ms` (1 kHz), `80:ms` (12.5 Hz), `1:minute` (one update per minute) -- the control rate is a natural consequence of the programming choices rather than a system configuration.

The implications are substantial:

**Multiple simultaneous control rates.** Because different shreds can advance time at different intervals, a single ChucK program can have arbitrarily many concurrent control rates. One shred computes audio at the sample rate; another sends MIDI at 12.5 Hz; a third polls a sensor once per minute. These coexist without conflict because the shreduler manages all shreds through the same timing mechanism.

**Dynamic control rate.** Since the programmer can compute the time-advancement value (rather than declaring a constant), the control rate can vary over time based on program logic. A synthesis algorithm might compute faster during attack transients and slower during sustained tones.

**Sample-accurate control.** The control rate can be as fine as one sample, enabling sample-level synthesis entirely from within the language. ChucK cites the Synthesis Toolkit (STK) as the practical inspiration for this capability: STK exposes a single-sample programming interface that ChucK generalizes to arbitrary granularity.

This is the language-semantic version of [[synthesis-function-specialization-by-input-rate-multiplies-performance-without-multiplying-algorithm-complexity]]: where SC1 specializes synthesis functions into variants for different input rates, ChucK makes the rate itself a programmer-controlled variable so no specialization is needed.

The contrasting systems: SuperCollider (McCartney 1996) and Nyquist (Dannenberg 1997) both use parameterized timing -- timing and duration are passed as arguments to synthesis entities. ChucK's criticism is that this approach prevents the programmer from managing "the timing of computation itself." The ChucK model inverts the relationship: timing is not a parameter to synthesis; it is the mechanism by which synthesis computation is scheduled.

For murail's rate system: the rate lattice (constant < init < reset < event < audio, per [[the-rate-lattice-provides-exactly-the-static-dynamic-parameter-separation-that-partial-evaluation-requires]]) is a static classification of computation rates. ChucK's dynamic control rate is the runtime analog: rates are not statically classified but continuously chosen by the programmer. These are complementary approaches. Murail's static rate classification enables compile-time optimization; ChucK's dynamic rates enable runtime expressiveness. A hybrid -- where murail's rate system provides compile-time safety and optimization, but the composition language exposes rate-varying patterns at the musical level -- would combine both properties.

---

Topics:
- [[audio-dsp]]
- [[language-design]]
