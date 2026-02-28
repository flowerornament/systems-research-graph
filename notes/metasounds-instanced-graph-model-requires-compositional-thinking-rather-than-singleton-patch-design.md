---
description: MetaSounds graphs are instantiated hundreds of times concurrently -- one per sound source -- forcing a shift from "make a piece" singleton design to small, composable, spatially-aware graph components
type: claim
evidence: strong
source: [[channel-agnosticism-metasounds-aaron-mcleran-adc]]
created: 2026-02-28
status: active
---

# metasounds instanced graph model requires compositional thinking rather than singleton patch design

Max MSP's dominant design paradigm is the singleton patch: one patch = one piece. The patch is a whole-program artifact that may be complex, interconnected, and stateful in ways that assume exclusive ownership of the audio environment.

MetaSounds inverts this: graphs are instanced. Hundreds of MetaSound graphs run simultaneously -- one per sound source. Each instance is independently spatialized. The graph is a reusable template, not a unique artifact. McLeran: "kind of have to rethink of your idea in terms of smaller pieces of code working together or graphs working together."

Consequences for graph design:
- **Scope**: a MetaSound graph should model one sound source's behavior (a footstep, a weapon impact, an engine layer), not the entire audio mix
- **State**: each instance maintains its own state independently; there is no shared mutable state between instances (unless explicitly connected through buses or interfaces)
- **Composability**: graphs reference other graphs (patches within patches), building complexity through composition rather than monolithic expansion
- **Spatialization**: each instance has spatial context baked in; the graph doesn't manage "where in the room is this?" -- the engine does

The preset system reinforces this: a base graph defines a template; sound designers create hundreds of presets as variations on it. When the base graph changes, presets propagate updates automatically. This is a graph versioning + template instantiation model.

The instancing model makes the [[mono-buffer-assumption-locks-audio-graph-topology-to-a-specific-channel-configuration]] problem more severe -- if you're instantiating 200 footstep sounds across all output configurations (mono headphone, stereo speakers, 7.1 theatre), graph topology locking means 200 instances times N channel variants.

Contrast with [[competing-systems]]: SuperCollider also instantiates SynthDefs (they become Synths), but its group-tree model and direct OSC messaging to individual instances creates a different compositional grain. MetaSounds' interface enforcement is more structured than SC's message-passing approach.
