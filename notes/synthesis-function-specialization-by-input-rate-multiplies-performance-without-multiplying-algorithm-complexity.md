---
description: Implementing a single synthesis algorithm in multiple variants specialized for each combination of audio-rate, control-rate, and static inputs yields maximum performance without requiring the programmer to choose
type: pattern
evidence: strong
source: "[[mccartney-1996-supercollider-icmc]]"
created: 2026-03-01
status: active
---

# synthesis function specialization by input rate multiplies performance without multiplying algorithm complexity

A synthesis function typically receives inputs that vary at different rates: some parameters are fixed for a note (static), some change at control rate (~100 Hz), and some are audio-rate signals (44.1 kHz). The optimal implementation differs significantly depending on input rate:

- A static frequency input allows the oscillator's phase increment to be precomputed as a constant.
- A control-rate frequency requires updating the phase increment once per buffer, not per sample.
- An audio-rate frequency requires computing a new phase increment every sample.

Naive implementation handles the most general case (audio-rate everything), paying the full per-sample cost even when inputs are static. Maximum-performance implementation writes separate inner loops for each case.

McCartney's SC1 solution: "The synthesis functions have been multiply special-cased to provide maximum performance whether the inputs are audio rate, control rate or static." The concrete example is Aoscilia (an interpolating wavetable oscillator with amplitude modulation) implemented 12 different ways based on input rate combinations: frequency (3 rates) × amplitude modulation (4 variants including no modulation) = 12 specializations. The signal pipeline (whether inputs are audio, control, or static) switches between implementations to maintain minimum CPU load.

This is a performance engineering pattern at the synthesis primitive level. The programmer writes the algorithm once (conceptually); the engine dispatches to the appropriate specialized implementation. The user sees a uniform interface; the engine sees rate-classified inputs and routes to the right variant.

The same idea appears in murail's rate lattice and construction-time optimization: see [[faust-signal-type-inference-classifies-computation-rate-to-enable-appropriate-caching]] (FAUST classifies rates at compile time, enabling cache optimization) and [[construction-time-graph-optimization-distributes-compiler-cost-across-node-creation]] (rate inference at construction time produces a pre-classified graph). FAUST and murail achieve the same goal through AOT compilation and static analysis; SC1 achieved it through runtime dispatch tables.

The 12-variant approach is also a specific instance of the general tension in DSP library design: generality vs. performance. A single function handles all cases but pays the worst-case cost; specialization handles each case optimally but multiplies implementation burden. SC1's resolution: specialization is hidden from the user (dispatch is automatic), so the implementation burden falls on the library author, not the user. This is the same resolution murail's primitive-level optimization (see [[eliminating-unit-generators-exposes-synthesis-graphs-to-cross-boundary-compiler-optimization]]) pursues: expose a general interface, pay the specialization cost in the compiler rather than in runtime dispatch.

Murail's rate system formalizes the discrete categories McCartney handled with manual specialization: constant, init, reset, event, audio. The compiler generates appropriate code for each rate combination; the programmer does not select variants. This is the compiler-driven formalization of what SC1 did with programmer-written dispatch tables.

---

Topics:
- [[audio-dsp]]
- [[language-design]]
- [[mccartney-language-design]]
