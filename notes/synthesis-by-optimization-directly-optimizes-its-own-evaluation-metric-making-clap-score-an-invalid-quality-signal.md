---
description: When CLAP similarity is both the synthesis objective and the evaluation metric, CTAG trivially wins -- the same pathology that makes accuracy an invalid metric when you train on the test set
type: claim
evidence: strong
source: [[cherep-2024-text-to-audio-synthesizer]]
created: 2026-02-28
status: active
---

# synthesis-by-optimization directly optimizes its own evaluation metric making CLAP score an invalid quality signal

CTAG achieves CLAP scores of 0.573 (AudioSet-50) and 0.585 (ESC-50), compared to AudioGen's 0.249/0.277, AudioLDM's 0.166/0.173, and even real audio at 0.416. The paper acknowledges this directly: "CTAG trivially achieves a higher score... This highlights the ability of our optimization strategy to effectively maximize the CLAP score, and also the importance of finding alternative and distinct evaluation metrics."

This is a clean instance of Goodhart's Law: when a measure becomes a target, it ceases to be a good measure. CTAG directly maximizes CLAP at inference time; any evaluation using CLAP as the metric is measuring how well the optimizer does its job, not how good the resulting sounds are.

The consequence for evaluation design is important: **methods that incorporate the evaluation metric into their training or inference cannot be fairly compared on that metric.** The paper handles this correctly by centering the user study and classifier accuracy as primary evidence, using CLAP scores only as a sanity check.

For murail's context: if a synthesis-by-optimization loop uses CLAP as its objective, CLAP scores on that loop's outputs cannot be used to compare against baselines that did not use CLAP as an objective. Independent evaluation (human study, classifier accuracy, spectral descriptors) is required. This is a general principle for any system that adapts to its own evaluation metric.

This connects to [[clap-similarity-as-synthesis-objective-decouples-sound-generation-from-acoustic-realism]] which explains the mechanism, and contrasts with evaluation methodology where the metric is genuinely independent of the training objective.
