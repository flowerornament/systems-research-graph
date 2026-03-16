---
description: Using LAION-CLAP cosine similarity between text and audio embeddings as the optimization target steers synthesis toward semantic alignment rather than acoustic reproduction
type: claim
evidence: strong
source: [[cherep-2024-text-to-audio-synthesizer]]
created: 2026-02-28
status: active
---

# CLAP similarity as synthesis objective decouples sound generation from acoustic realism

CTAG optimizes synthesizer parameters to maximize the cosine similarity between a LAION-CLAP audio embedding and a LAION-CLAP text embedding. CLAP was trained contrastively on audio-text pairs using a HTSAT audio encoder and a RoBERTa text encoder; it learns a shared embedding space where sounds and their descriptions are nearby.

The key property: CLAP similarity measures **semantic alignment**, not acoustic distance from any reference recording. A synthesized "train horn" that scores high CLAP similarity does not need to sound like a recorded train horn -- it needs to evoke the concept "train horn" as CLAP learned it from its training distribution.

This decoupling has two consequences:

1. **Creative freedom:** The optimizer is free to find synthesizer parameter settings that convey the concept through whatever acoustic means the synthesizer can produce. The result may be more abstract than a recording but still semantically legible.

2. **Metric gaming (limitation):** Because CTAG *directly* optimizes CLAP, its CLAP scores (0.573 on AudioSet-50, 0.585 on ESC-50) trivially exceed both other models and real audio (0.416). CLAP cannot serve as an independent quality signal for CTAG. This is the standard Goodhart's Law failure: optimizing the metric destroys its validity as an evaluation measure. See [[synthesis-by-optimization-directly-optimizes-its-own-evaluation-metric-making-clap-score-an-invalid-quality-signal]].

For murail: this technique is directly applicable as a "synthesis from description" capability. A user could specify "something like a distant siren with a metallic quality" and an optimization loop could search the synthesis graph's parameter space for a result that CLAP considers semantically aligned. The training-free nature (no model retraining needed, just a pretrained CLAP checkpoint) makes this feasible as a built-in capability.
