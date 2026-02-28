---
description: Synthesized sound is not limited by what physically exists -- it can construct concepts that evoke experiences more effectively than any recording could capture
type: claim
evidence: strong
source: [[cherep-2024-text-to-audio-synthesizer]]
created: 2026-02-28
status: active
---

# procedural sound design transcends acoustic plausibility by constructing concepts rather than recording events

Ciani's principle: "Of course, bubbles don't make sound, but this is the magic of sound design...you can create the concept of a sound and it seems real." The Coca Cola Buchla sound was not recorded because the desired concept -- a sound that makes the listener feel the refreshing opening of a soda -- does not cleanly correspond to any single physical acoustic event.

Procedural sound design (creating sounds algorithmically using manipulable parameters) extends this: by operating in parameter space rather than recording space, designers can:

1. **Exceed physical plausibility** -- generate sounds that have never existed in nature but that convey meaning more powerfully than any recording
2. **Control every dimension** -- adjust attack sharpness, spectral brightness, rhythmic density independently, tuning each to the desired emotional effect
3. **Generate variation on demand** -- the same parameter space, sampled with slight perturbations, produces a family of related sounds rather than a single fixed recording

This is not about lower quality. CTAG's spectral measurements show significantly higher high-frequency content (HFC: 427 vs 152 for AudioLDM), higher spectral flux, and greater complexity than neural synthesis methods. The abstract character is intentional, not a limitation of the synthesis engine.

For murail, this establishes a design principle: the synthesis graph should be designed to make parameter-space exploration ergonomic. Named parameters, physically intuitive mappings (attack time in seconds, not raw buffer offsets), and smooth continuity across the parameter space all serve the procedural design workflow. The goal is not to reproduce recordings but to give designers fine-grained control over the conceptual properties of sound.

This connects to [[abstract-sound-synthesis-captures-conceptual-essence-in-the-way-visual-sketching-captures-form]] which establishes the theoretical basis, and [[synthesis-by-optimization-produces-an-interpretable-parameter-space-that-neural-synthesis-cannot-offer]] which shows how optimization can search that space.
