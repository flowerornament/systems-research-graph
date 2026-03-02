---
description: Apple Core Audio interviews revealed that JUCE-trained developers knew how to write DSP inner loops but lacked understanding of threading, resource management, and audio engine architecture
type: claim
evidence: strong
source: [[2026-02-06-qmayIRViJms]]
created: 2026-02-28
status: active
---

# JUCE abstracts away audio engine fundamentals producing developers who cannot reason about threading and resource management

McCartney describes Apple's Core Audio hiring interviews: candidates who had learned audio programming through JUCE knew how to write the inner loop of a DSP program but did not understand what JUCE was doing for them. The Core Audio group needed engineers who understood threading models, resource management, and audio engine architecture -- the infrastructure that JUCE conceals. McCartney characterizes JUCE as "a crutch" for this reason.

The specific gap: JUCE handles the AudioWorklet/callback setup, thread management, buffer management, and format negotiation -- the parts of audio programming that are hardest to understand and most consequential to get wrong. A developer who only knows JUCE has learned how to fill the boxes JUCE provides without knowing why those boxes exist or what happens inside them. This is analogous to a web developer who knows React component lifecycle but cannot reason about the browser rendering pipeline.

The claim is directional, not absolute: there are JUCE developers who understand the underlying systems (and there are MATLAB algorithm developers who know both MATLAB and how to translate to efficient C). McCartney's point is that JUCE as a learning path does not force that understanding.

**For Murail's design:** If Murail's API conceals too much -- similar to how JUCE conceals thread management -- Murail users will face the same literacy gap when trying to understand performance problems or unexpected behavior. The API surface should be minimal enough to be comprehensible, not just convenient. This is a tension with the goal of ergonomic embedding: ergonomic APIs can be opaque ones. See [[library-languages-must-not-bundle-a-mandatory-runtime]] for the related constraint that embedding must be transparent.

The counterpoint is that a well-designed abstraction *should* hide the right things. Core Audio itself hides enormous complexity (kernel interaction, hardware driver routing, format negotiation) while remaining debuggable by experts. The question is whether the abstraction boundary is drawn at a level where the hidden things are genuinely safe to ignore.

Contrasts with [[audio-programming-education-requires-reading-production-engine-source-code-across-multiple-systems]] -- the positive prescription: if JUCE is the crutch, reading SC/Faust/PD/VCV source is the cure.
