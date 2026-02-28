---
description: CTAG paper: synthesis-by-optimization via SYNTHAX + LAION-CLAP + LES evolutionary strategy; 78-parameter modular synth matches neural synthesis for identifiability and exceeds it for artistic perception
type: source
created: 2026-02-28
---

# cherep-2024-text-to-audio-synthesizer

Cherep, M., Singh, N., & Shand, J. (2024). Creative Text-to-Audio Generation via Synthesizer Programming. *Proceedings of the 41st International Conference on Machine Learning*, Vienna, Austria. PMLR 235.

MIT Media Lab. ctag.media.mit.edu

## Method Summary

CTAG (Creative Text-to-Audio Generation) uses three components:
- **SYNTHAX** -- a fast JAX modular synthesizer (the "Voice" architecture: 78 parameters, two LFOs, six ADSR envelopes, sine VCO, square-saw VCO, noise generator, VCAs, mixers)
- **LAION-CLAP** -- audio-language embedding model used as optimization objective
- **LES** (Learned Evolution Strategies) -- gradient-free optimizer via Evosax library

The optimization loop iteratively adjusts synthesizer parameters to maximize cosine similarity between the synthesized audio's CLAP embedding and the input text prompt's CLAP embedding.

## Key Claims from This Source

- [[synthesis-by-optimization-produces-an-interpretable-parameter-space-that-neural-synthesis-cannot-offer]]
- [[differentiable-synthesizer-gradients-are-unstable-making-gradient-free-optimization-the-practical-choice]]
- [[abstract-sound-synthesis-captures-conceptual-essence-in-the-way-visual-sketching-captures-form]]
- [[clap-similarity-as-synthesis-objective-decouples-sound-generation-from-acoustic-realism]]
- [[synthesis-by-optimization-directly-optimizes-its-own-evaluation-metric-making-clap-score-an-invalid-quality-signal]]
- [[synthesizer-parameter-space-interpolation-produces-semantically-coherent-intermediate-sounds]]
- [[a-78-parameter-modular-synthesizer-matches-neural-models-for-sound-identifiability-while-exceeding-them-for-perceived-artistic-quality]]
- [[les-outperforms-gradient-free-alternatives-for-low-dimensional-synthesizer-parameter-optimization]]
- [[procedural-sound-design-transcends-acoustic-plausibility-by-constructing-concepts-rather-than-recording-events]]
