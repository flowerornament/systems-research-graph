---
description: A synthesized sound that conveys the concept of an event without acoustic literalism is the auditory equivalent of a line drawing -- abstract yet recognizable and often more evocative
type: claim
evidence: strong
source: [[cherep-2024-text-to-audio-synthesizer]]
created: 2026-02-28
status: active
---

# abstract sound synthesis captures conceptual essence in the way visual sketching captures form

Suzanne Ciani's Coca Cola pour sound for 1970s advertising was not recorded from a real bottle -- it was synthesized on a Buchla synthesizer to convey the *concept* of refreshment, not its acoustic reality. The paper formalizes this as "abstract synthesis": generating sounds that capture the semantics of a concept while deliberately departing from realistic acoustic recreation.

The visual analog is instructive: monochromatic line drawings strip away color, texture, and shading but retain geometric structure and conceptual identity. CLIPasso generates minimal SVG sketches that remain recognizable. CTAG generates sounds that are similarly non-photorealistic: they are classified correctly by human listeners at rates comparable to AudioGen (56% vs 59.5%) while being rated significantly more artistic (3.54/5 vs 2.32/5 for AudioGen).

The user study finding is striking: despite lower confidence ratings (listeners are more uncertain), CTAG sounds are identified nearly as accurately as AudioGen. This mirrors the sketch analogy -- a sketch may take longer to decode, but decoding succeeds because the semantic content is preserved.

For murail, this is a design space dimension: synthesis systems can target a **realism-abstraction axis** rather than always maximizing acoustic accuracy. Procedural game audio often wants abstract sounds that work across varied contexts without sounding recorded. A synthesis graph that intentionally abstracts may have higher reuse value than one that precisely recreates one acoustic event.

This connects to [[creative-workflow-friction-should-determine-audio-engine-architecture]] -- Ciani's principle that "you can create the concept of a sound and it seems real" is a direct statement that creative intent, not acoustic fidelity, drives the value of synthesized sound.
