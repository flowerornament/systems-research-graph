---
description: Max 8 MC bundles group multi-channel audio without encoding what the channels mean spatially, limiting them to single-context use; MetaSounds CAT adds semantic metadata to enable cross-context reuse
type: contradiction
evidence: moderate
source: [[channel-agnosticism-metasounds-aaron-mcleran-adc]]
created: 2026-02-28
status: active
---

# max MSP mc signal bundles lack format metadata making them unsuitable for plug-and-play graph interoperability

Max 8's Multi-Channel (MC) signal bundle is a type that groups multiple audio channels into a single wire, solving the graph complexity problem. McLeran discovered the resemblance after CAT was already in internal development and investigated whether Max had "beaten them to the punch."

The MC bundle's model: it is a flat array of channels. It does not encode what those channels *are* spatially. A consumer receiving an MC bundle must know externally that "channel 0 is left, channel 1 is right" or "channels 0-3 are first-order ambisonics B-format." The meaning is implicit, contextual, and fragile.

McLeran's assessment: "similar motivations, but there's differences. The MC signal bundle doesn't have metadata about what it is, it just assumes like a flat discrete channel, and it's up to you to know what's in it and how to deal with it."

The consequence: MC bundles work well in single-author contexts where the producer and consumer of the bundle agree on channel semantics. They do not support the MetaSounds use case where a graph authored for one gameplay system needs to plug into another system the author didn't know about at authoring time.

CAT's metadata (family type, channel spatial positions, encoding order) is what makes plug-and-play possible. The receiving node can read the type and make an informed transcoding decision without out-of-band knowledge.

Analog to MC in Super Collider: channel expansion in SuperCollider achieves a similar simplification effect (one line applies a filter to all channels), but with the same flat-channel limitation. Neither SC expansion nor Max MC bundles are typed in the semantic sense.

This is a meaningful distinction for murail: if murail wants graph patches to be reusable across different engine configurations, signal types need semantic metadata, not just buffer arrays. Bare buffer slices are equivalent to MC bundles -- useful for local use, insufficient for interoperability.
