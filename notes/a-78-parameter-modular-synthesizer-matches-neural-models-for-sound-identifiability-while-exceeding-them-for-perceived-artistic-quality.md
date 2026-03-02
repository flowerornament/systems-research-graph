---
description: Human listeners identify CTAG sounds at 56% accuracy vs AudioGen's 59.5%, while rating CTAG as significantly more artistic (3.54/5 vs 2.32/5) -- comparable utility, distinct creative character
type: claim
evidence: strong
source: [[cherep-2024-text-to-audio-synthesizer]]
created: 2026-02-28
status: active
---

# a 78-parameter modular synthesizer matches neural models for sound identifiability while exceeding them for perceived artistic quality

The CTAG user study (10 participants, 60 sounds each, 600 observations per metric) produced the following results:

| Method    | Accuracy | Confidence | Artistic Interpretation |
|-----------|----------|------------|------------------------|
| AudioGen  | 59.5%    | 3.48       | 2.32                   |
| AudioLDM  | 34.0%    | 2.95       | 2.90                   |
| CTAG      | 56.0%    | 2.99       | 3.54                   |

CTAG is statistically indistinguishable from AudioGen for accuracy (odds ratio = 0.85, p = 1) while significantly exceeding both AudioGen (contrast = 1.22, p < .0001) and AudioLDM (contrast = 0.65, p < .0001) on artistic interpretiveness.

The confidence result is important: despite similar accuracy, listeners are less confident about CTAG sounds. This reflects the abstract character of CTAG's outputs -- they convey the concept while departing from acoustic expectation, creating genuine uncertainty about the source even after correct identification. This uncertainty-with-accuracy pattern directly supports [[procedural-sound-design-transcends-acoustic-plausibility-by-constructing-concepts-rather-than-recording-events]] -- the sounds are not acoustically literal, yet listeners correctly identify them.

The implication is that synthesis-by-optimization with a small modular synthesizer is not a second-rate substitute for neural synthesis -- it occupies a distinct position in the creative space. The artistic quality advantage arises because [[synthesis-by-optimization-produces-an-interpretable-parameter-space-that-neural-synthesis-cannot-offer]] -- the 78 parameters map to physical synthesis properties, and the optimization process navigates that space toward semantically legible but acoustically non-literal outputs. For contexts where artistic abstraction is valuable (game audio, experimental music, advertising), CTAG-style synthesis is a superior tool. For contexts requiring maximum acoustic realism (foley replacement, dataset augmentation), neural synthesis remains preferable.

This quantifies the claim in [[abstract-sound-synthesis-captures-conceptual-essence-in-the-way-visual-sketching-captures-form]] with experimental evidence and provides a concrete benchmark for where modular synthesis-by-optimization stands relative to state-of-the-art neural methods circa 2024.

The competitiveness of a 78-parameter system is less surprising in light of [[dsp-inductive-biases-reduce-model-size-by-encoding-prior-knowledge-about-periodic-audio]] -- DDSP demonstrates that DSP components carry generative burden that neural networks otherwise need millions of parameters to learn. A modular synthesizer is the extreme case: all generative capacity is DSP, and the optimization loop only needs to find the right parameter settings. The user study result here validates that approach, adopted after [[differentiable-synthesizer-gradients-are-unstable-making-gradient-free-optimization-the-practical-choice]] led to gradient-free methods, as producing results competitive with far larger neural systems.

For murail: this result strengthens the case for a unified DSP/ML substrate where synthesis graphs with named, typed, addressable parameters are first-class citizens alongside neural components. The quality ceiling is set by synthesis architecture, not parameter count.
