---
description: Audio, robotics, and games each instantiate the substrate by supplying a domain configuration tuple; Layers 0-2 are unchanged across all domains, validating the four-layer factoring
type: property
evidence: strong
source: [[murail-substrate-v3]]
created: 2026-02-28
status: active
---

# the murail substrate is instantiated by a domain configuration without modifying layers 0 through 2

Layer 3 defines what a domain must provide to make the substrate useful. The domain configuration is a tuple:

`D = (R_base, O, T, G, π_out, U, X_schema, E, S)`

- **R_base**: base rates with frequencies (audio: init/control/audio at 48kHz; robotics: config/planning/control at 1kHz; games: load/frame/physics at 240Hz)
- **O**: operation table (arithmetic is substrate-provided; transcendentals, FFT, convolution are domain-provided)
- **T**: dispatch target profile (audio: CPU_scalar + CPU_SIMD; ML: CPU_SIMD + GPU; embedded: CPU_scalar)
- **G**: gauge invariant for live editing (audio: phase continuity; robotics: position/velocity consistency)
- **π_out**: which equations are observable output
- **U**: external input schema (shape and rate per input)
- **X_schema**: external data schema (lookup tables, model weights)
- **E**: default elements per equation (the error substitution value)
- **S**: default smoothing mode for hold-slot reads

The validation criteria (Appendix B) make this concrete:
1. **No domain references in Layers 0-2.** The words "audio," "sample," "MIDI," "sensor," "entity," "pixel," "FFT" do not appear in the substrate specification.
2. **Three-domain test.** Audio, robotics, and games can each be instantiated from Layer 3 without modifications to Layers 0-2.
3. **Toy-domain test.** A trivial domain (e.g., a live-editable spreadsheet with real-time constraints) validates the core before any real domain is built.
4. **Monotonic extension.** Adding a new domain never requires changes to the substrate.

**What this factoring achieves.** The substrate is the invariant -- the formal object that is true across all real-time recurrence systems. The domain is the variable -- what changes between audio and robotics. This separation makes the substrate independently verifiable (Lean proofs can cover Layers 0-2 without knowing about audio) and makes domain-specific testing possible without re-testing the substrate.

## Connections

- The three-domain test is a structural argument for why the factoring is at the right level of generality -- same argument as [[faust-separates-dsp-specification-from-host-architecture-enabling-multi-target-retargeting]] but applied one level deeper (substrate factored from domain, not DSP factored from host)
- Lean formal verification of the substrate (mentioned in [[formal-methods]] open questions) is enabled precisely by the domain-independence of Layers 0-2
- The substrate concept is related to the "minimal formal object" design philosophy in [[dataflow-languages-lack-explicit-formal-semantics-making-program-behavior-engine-dependent]]: the substrate provides what those languages lack
- [[dsp-and-ml-are-structurally-identical-under-shape-driven-dispatch-in-the-murail-calculus]] is an emergent consequence of the domain-independent substrate -- the same equations instantiate differently just by changing the dispatch target profile
