---
description: Iterative parameter search over a fixed-width synthesizer produces fully inspectable and tweakable controls; neural synthesis offers no equivalent audit trail
type: claim
evidence: strong
source: [[cherep-2024-text-to-audio-synthesizer]]
created: 2026-02-28
status: active
---

# synthesis-by-optimization produces an interpretable parameter space that neural synthesis cannot offer

CTAG generates sound by iteratively adjusting a 78-parameter modular synthesizer (implemented via SYNTHAX) to maximize CLAP similarity with a text prompt. Every parameter -- ADSR segments, LFO rates, VCO shapes, mixer weights -- is directly readable and editable by a human after generation. Neural synthesis models (AudioLDM, AudioGen) operate over latent spaces of millions to billions of uninterpretable parameters; there is no mechanism to retrace the decisions made en route to an output.

This interpretability gap has concrete consequences for creative practice:

- **Tweakability:** A sound designer can inspect a CTAG result, identify which ADSR parameter governs the attack, and manually raise it. There is no equivalent operation in AudioLDM.
- **Interpolation:** Linear interpolation between two CTAG parameter vectors produces semantically coherent intermediate sounds (see [[synthesizer-parameter-space-interpolation-produces-semantically-coherent-intermediate-sounds]]). Neural latent interpolation requires care to avoid degenerate trajectories.
- **Auditability:** Rerunning CTAG with the same parameters produces the same output. Neural generation with sampling introduces irreducible non-determinism.

The trade-off is expressive range: 78 parameters cannot span the acoustic space that billions can. But for creative sound design where editability matters more than photorealism, the constraint is a feature rather than a limitation. This connects to [[creative-workflow-friction-should-determine-audio-engine-architecture]] -- interpretability is a form of friction removal; being unable to inspect what the system did creates friction when iterating.

The insight is directly applicable to murail: a synthesis graph whose parameters are named, typed, and addressable is always preferable to one whose parameters are opaque, even at a cost in expressive range.
