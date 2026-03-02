---
description: MetaSounds CAT defines three base families -- discrete, sound field, composite -- covering speaker-based, ambisonics, and hybrid/custom audio formats under a single polymorphic type
type: decision
evidence: strong
source: [[channel-agnosticism-metasounds-aaron-mcleran-adc]]
created: 2026-02-28
status: active
---

# channel-agnostic audio types require three polymorphic subtypes to cover all known and future formats

MetaSounds' CAT (Channel Agnostic Types) design settled on three polymorphic base families after "endless debate like Greek philosophers":

**Discrete** -- speaker-assigned channels. Stereo L/R, 5.1, 7.1, Atmos height channels, and object-based formats (where each object has spatial coordinates). This is the common case and covers most existing game audio content.

**Sound field** -- encoded representations. First-order to higher-order ambisonics. Rather than discrete speaker positions, sound field formats encode the full spherical audio field; decoding to speakers happens at playback. Ambisonics is natural for 6DOF VR audio where the listener's orientation changes at runtime.

**Composite** -- hybrid and custom formats. Ambisonics with an LFE channel attached. Custom stereo layering systems. "Stuff we can't even comprehend in the future." The composite family is the escape hatch -- it allows arbitrary combinations and custom definitions that the discrete/sound field dichotomy doesn't cover.

Each family carries its audio buffers plus metadata sufficient to describe spatial meaning: channel azimuthal positions, encoding order (for ambisonics), etc. Polymorphism means a graph node receiving a base CAT type works with any subtype; it processes "audio" without needing to know the family.

Transcoding between families:
- Discrete -> discrete: standard upmix/downmix matrices (automated or custom)
- Discrete <-> sound field: encode/decode from spatial channel metadata
- Composite: custom transcoding logic provided per-instance

This three-family ontology mirrors established spatial audio practice (speaker-based, ambisonics, object-based) while adding structural openness via the composite escape hatch. Contrast with [[max-MSP-mc-signal-bundles-lack-format-metadata-making-them-unsuitable-for-plug-and-play-graph-interoperability]]: MC bundles have no family concept at all.
