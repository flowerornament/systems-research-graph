---
description: Combining an additive harmonic synthesizer with filtered noise captures the deterministic pitched component and the stochastic breathiness/texture of most acoustic instruments in one model
type: claim
evidence: strong
source: [[ddsp-2020]]
created: 2026-02-28
status: active
---

# harmonic plus noise model covers most natural instrument timbres with a deterministic plus stochastic decomposition

Natural acoustic sounds decompose into two components: a deterministic, quasi-periodic part (the harmonic content -- stable pitched oscillations at integer multiples of f0) and a stochastic part (the noise -- breathy, turbulent, or inharmonic residual). The harmonic plus noise (HPN) model, originating in Spectral Modeling Synthesis (SMS) by Serra and Smith (1990), formalizes this as:

```
output = additive_synthesizer(f0, A_k) + filtered_noise(H)
```

Where the additive synthesizer generates sinusoids in harmonic ratios of f0 with time-varying amplitudes, and the filtered noise synthesizer generates colored noise via a time-varying FIR filter applied to uniform white noise.

**Why this decomposition is powerful:**
1. **Generality:** The SMS model is expressive enough to serve as a general-purpose audio codec (MPEG-4 Parametric Audio Coding). Most monophonic acoustic instrument timbres are well-represented by HPN -- strings, brass, woodwinds, voice, mallet instruments.
2. **Overparameterization as a feature:** For 4 seconds of 16kHz audio, the HPN synthesizer coefficients have ~2.5x more dimensions than the waveform itself (165,000 vs 64,000). This overparameterization makes the parameter space amenable to neural network prediction -- each parameter dimension corresponds to an interpretable physical quantity.
3. **Separation of concerns:** The harmonic component handles pitch-coherent structure; the noise component handles the "air" and texture. Independent control of each is natural.

**Limitations acknowledged:** The HPN model does not natively handle inharmonicity (stiff strings, bells), polyphony, or transient-only sounds. Unconstrained sinusoidal oscillator banks (not constrained to harmonic ratios) are strictly more expressive but have more parameters and are harder to control.

**Murail implication:** The HPN model is a strong candidate for murail's primary high-level synthesis abstraction, particularly for instrument modeling and neural timbre transfer applications. The additive synthesizer maps cleanly to murail's oscillator primitives; the filtered noise maps to a filtered white noise UGen. Both can run in real time. The neural network predicting their parameters (f0, A, c, H) operates at control rate, not audio rate, keeping the real-time overhead manageable.

The overparameterization insight is relevant to murail's graph representation: when the parameter dimensionality of a synthesis algorithm exceeds the raw sample count, that algorithm is more naturally driven by learned control signals than by hand-authored envelopes. This supports the case for neural parameter prediction as the natural interface to complex synthesis algorithms.

Related to [[harmonic-oscillator-amplitude-factorization-separates-loudness-control-from-spectral-shape]] for the additive component's internal structure. See [[frequency-sampling-method-converts-network-outputs-into-interpretable-linear-phase-fir-filters]] for how the noise component's filter is designed. Contrasts with approaches like FM synthesis, wavetable, or physical modeling -- these are not covered by HPN but are equally valid targets for differentiable synthesis.

---

Topics:
- [[ai-ml]]
- [[audio-dsp]]
