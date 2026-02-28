---
description: Aaron McLeran (Epic Games) ADC talk on MetaSounds channel-agnostic types (CAT) -- polymorphic audio format abstraction for reusable graph topologies
type: claim
source: https://www.youtube.com/watch?v=CbjNjDAmKA0
created: 2026-02-28
status: active
---

# channel-agnosticism-metasounds-aaron-mcleran-adc

ADC talk by Aaron McLeran, Principal Audio Programmer at Epic Games. Covers the problem of rigid channel formats in MetaSounds' initial design (mono-buffer assumption), the design and rationale for Channel Agnostic Types (CAT), comparison with Max 8 MC signal bundles, and MetaSounds' broader architecture (JIT compilation, instanced graphs, enforced interfaces).

## Key Claims Extracted
- [[mono-buffer assumption locks audio graph topology to a specific channel configuration]]
- [[channel format metadata encapsulation enables audio graph reuse across channel configurations]]
- [[channel-agnostic audio types require three polymorphic subtypes to cover all known and future formats]]
- [[compatible audio format transcoding happens automatically while cross-family conversion requires an explicit cast]]
- [[audio format type must be resolved at graph compile time not during execution]]
- [[max MSP mc signal bundles lack format metadata making them unsuitable for plug-and-play graph interoperability]]
- [[JIT graph compilation enables context-aware channel format inference at playback time]]
- [[sample-accurate triggering in block-based audio requires splitting render blocks into sub-block execution lambdas]]
- [[metasounds instanced graph model requires compositional thinking rather than singleton patch design]]
- [[enforced data interfaces enable plug-and-play interoperability between independently authored audio subsystems]]

## Speaker Background
Aaron McLeran: physics + music undergrad, media arts graduate degree (UCSB), procedural music on Spore (PD patches), sound designer on Dead Space, Epic Games audio programmer for 11 years.
