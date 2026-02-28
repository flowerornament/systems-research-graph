---
description: SC2 was a Smalltalk-inspired language with Ruby-like syntax; the scripting language still ran in the real-time thread, making it the intermediate step between SC1 and the SC3 client-server model
type: claim
evidence: strong
source: [[2026-02-06-qmayIRViJms]]
created: 2026-02-28
status: active
---

# SuperCollider version 2 used a Smalltalk-inspired language without client-server separation

McCartney describes SuperCollider version 2 as "Smalltalk with a kind of a Ruby syntax" -- though he notes he did not know Ruby at the time. SC2 was not client-server: the scripting language ran in the real-time thread alongside synthesis, the same architecture as SC1.

SC3 introduced the client-server separation. The progression: SC1 (Pyrite + Synthomatic merged, real-time, scripting in RT thread), SC2 (new Smalltalk-influenced language, real-time, scripting still in RT thread), SC3 (client-server split: sclang + scsynth as separate processes, language fully decoupled from audio RT).

The Smalltalk influence in SC2 (and likely carried forward) is relevant to McCartney's broader PL philosophy: see [[smalltalk-image-model-prevents-source-runtime-drift]] for why image-based development is relevant, and [[interactive-programming-eliminates-the-compile-run-cycle]] for the interactive ideal Smalltalk represents. SC2 was closer to the Smalltalk model (scripting inline with execution) but not close enough to eliminate RT pauses.

Between SC2 and the SC3 server, McCartney built an intermediate version (SC3D5) with dual virtual machines and pixel synthesis. See [[supercollider-3d5-applied-signal-graphs-to-pixel-synthesis-demonstrating-graph-generality-beyond-audio]] for what this intermediate version established about signal graph generality.
