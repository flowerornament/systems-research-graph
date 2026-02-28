---
description: FAUST's architecture file system decouples the DSP algorithm from its host environment, allowing one .dsp source to compile to JACK, CoreAudio, LADSPA, VST, Max/MSP, PD, and SuperCollider from the same source
type: pattern
evidence: strong
source: [[faust-2009-npcm]]
created: 2026-02-28
---

# FAUST separates DSP specification from host architecture enabling multi-target retargeting

FAUST's architecture file system cleanly separates two concerns: (1) the DSP algorithm expressed in the FAUST language, and (2) the host environment that provides audio I/O, GUI, and plugin lifecycle. An architecture file is a C++ wrapper that includes the compiler-generated DSP class and wires it to a specific host API. The same `noise.dsp` source produces a JACK/GTK application, a CoreAudio/QT4 application, a LADSPA plugin, a VST plugin, a Max MSP external, a PureData external, or a SuperCollider plugin simply by selecting a different architecture file.

This is not incidental — it is the design intent. The generated C++ DSP class is self-contained and has no runtime dependencies; it implements a minimal interface (`getNumInputs()`, `getNumOutputs()`, `init()`, `buildUserInterface()`, `compute()`). Any host can wrap this interface.

The `buildUserInterface()` method is particularly notable: it emits abstract GUI commands (addSlider, addButton, openGroup) independent of any toolkit. A command-line architecture file ignores graphical details and exposes only parameter names and ranges; a QT architecture file renders full visual controls. The DSP code is unaffected.

For murail, this is the prior art for [[library-languages-must-not-bundle-a-mandatory-runtime]]. FAUST demonstrates that a DSP specification language *can* generate genuinely embeddable code by making the architecture file the site of all host coupling. The generated murail audio graph should similarly have no mandatory host dependencies — only an interface that host code can wrap.

## Connections
- Strengthens [[library-languages-must-not-bundle-a-mandatory-runtime]] — FAUST's architecture file system is the concrete mechanism for achieving this in DSP languages
- Contrasts with [[juce-abstracts-away-audio-engine-fundamentals-producing-developers-who-cannot-reason-about-threading-and-resource-management]] — FAUST exposes the interface; JUCE hides it
- Extends [[faust-programs-denote-mathematical-functions-enabling-semantics-driven-compilation]] — clean separation is only possible because the DSP semantics are host-independent
