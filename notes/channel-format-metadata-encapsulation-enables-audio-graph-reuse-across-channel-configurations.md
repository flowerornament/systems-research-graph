---
description: Bundling audio buffers with format metadata (channel count, spatial layout, family type) into a single typed abstraction lets one graph wire work for mono, stereo, Atmos, and custom formats
type: claim
evidence: strong
source: [[channel-agnosticism-metasounds-aaron-mcleran-adc]]
created: 2026-02-28
status: active
---

# channel format metadata encapsulation enables audio graph reuse across channel configurations

MetaSounds' Channel Agnostic Types (CAT) solve the [[mono-buffer-assumption-locks-audio-graph-topology-to-a-specific-channel-configuration]] problem by making format part of the type. A CAT value bundles:
- The actual audio buffer(s)
- Metadata describing what it is: channel count, family type (discrete/sound field/composite), and spatial channel locations (azimuthal degrees for each channel)

With this design, a single graph wire -- one connection -- carries whatever format the source produces. A mixer node accepts one input regardless of whether that input is mono, 5.1, or Atmos. A filter processes all channels in the format without per-channel node replication.

The stated goals from the talk:
1. "One wire, but supports any format" -- one type instead of per-channel types
2. Simplify graphs and graph authoring
3. Performance scalability -- downscaling channel formats for lower-end platforms without graph reauthoring
4. Forward compatibility -- custom formats that "we can't even imagine"

The insight is a type-level move: mono buffer was an untyped chunk of samples; CAT is a typed description of spatial audio content. The graph becomes declarative about what it processes, not structural about how many channels it happens to have.

This pattern generalizes: whenever a primitive carries implicit context that forces callers to track it manually, lifting that context into the type eliminates a class of structural duplication. Connects to [[generic-operations-allow-extending-existing-code-over-new-types-without-modification]]: a graph node written for "audio" (the base type) automatically extends to all CAT subtypes via polymorphic dispatch without modification -- the exact generic operations pattern.
