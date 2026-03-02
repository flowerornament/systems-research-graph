---
description: Batch processing summary for ddsp-2020.pdf pipeline run
batch: ddsp-2020
date: 2026-02-28
---

# ddsp-2020 Batch Summary

## Source
- **Original path:** `/Users/morgan/code/murail/.design/references/papers/ddsp-2020.pdf`
- **Archive path:** `/Users/morgan/code/murail/.design/references/papers/archive/ddsp-2020.pdf`
- **Paper:** DDSP: Differentiable Digital Signal Processing -- Engel, Hantrakul, Gu & Roberts (Google Brain, ICLR 2020)

## Pipeline Statistics
- Claims extracted: 10 (from ddsp-2020.pdf directly)
- Hook-generated enrichments: 2 (rave-2021 source note + parallel-non-autoregressive claim from PostToolUse hooks)
- Total new notes: 13 (10 claims + 1 source reference + 1 hook claim [differentiable-synthesizer-gradients] + 1 hook source [cherep cross-reference])
- Connections added: 22+ (inline wiki links across new claims and existing notes)
- Topic maps updated: 3 (ai-ml, audio-dsp, index)
- Existing claims enriched: 1 (differentiable-dsp-components enriched by hook with Cherep 2024 counterpoint)
- Verify: PASS -- all links resolve, all descriptions present

## Claims Created

### Core DDSP Claims (from ddsp-2020.pdf)
- [[time-and-frequency-domain-neural-synthesis-impose-a-phase-alignment-prior-that-conflicts-with-periodic-audio-structure]]
- [[differentiable-dsp-components-make-classical-synthesis-knowledge-available-as-structural-priors-for-neural-networks]]
- [[harmonic-oscillator-amplitude-factorization-separates-loudness-control-from-spectral-shape]]
- [[frequency-sampling-method-converts-network-outputs-into-interpretable-linear-phase-fir-filters]]
- [[multi-scale-spectral-loss-is-perceptually-better-than-pointwise-waveform-loss-for-audio-synthesis]]
- [[explicit-reverb-factorization-enables-blind-dereverberation-as-a-modular-architectural-side-effect]]
- [[disentangled-synthesis-latents-enable-pitch-loudness-and-timbre-control-independent-of-each-other]]
- [[dsp-inductive-biases-reduce-model-size-by-encoding-prior-knowledge-about-periodic-audio]]
- [[harmonic-plus-noise-model-covers-most-natural-instrument-timbres-with-a-deterministic-plus-stochastic-decomposition]]
- [[ddsp-autoencoder-achieves-high-fidelity-synthesis-without-autoregressive-or-adversarial-losses]]

### Source Reference
- [[ddsp-2020]]

### Hook-Generated (cross-reference enrichments)
- [[differentiable-synthesizer-gradients-are-unstable-making-gradient-free-optimization-the-practical-choice]] (from Cherep 2024 cross-reference, sourced from [[cherep-2024-text-to-audio-synthesizer]])
- [[rave-2021]] source reference note (from PostToolUse hook on ddsp source note)
- [[parallel-non-autoregressive-audio-decoders-match-autoregressive-quality-when-combined-with-adversarial-training]] (from RAVE hook)

## Key Forward Connections Made
- DDSP -> RAVE: multi-scale spectral loss used by both; RAVE adds adversarial stage where DDSP relies on DSP priors
- DDSP -> CTAG/Cherep: DDSP's gradient stability derives from constrained architecture, not general differentiability
- DDSP -> McCartney/Murail IR: differentiable primitive functions as analogue to DDSP differentiable DSP components
- DDSP -> channel format architecture: both are orthogonal-concern factorizations

## Methodology Notes
- PostToolUse hooks were active and enriched notes with cross-references to already-processed papers (Cherep 2024, RAVE 2021)
- Hook modification of differentiable-dsp-components introduced a [[differentiable-synthesizer-gradients-are-unstable...]] link -- file was verified to exist before proceeding
- The pipeline instruction to use subagent skills (ralph) was executed manually as skills were not loaded; quality gates applied directly
