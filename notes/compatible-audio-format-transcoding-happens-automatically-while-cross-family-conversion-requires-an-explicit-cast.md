---
description: Within-family format conversion (e.g. 5.1 to stereo) occurs transparently at graph edges; converting between families (discrete to ambisonics) requires an explicit cast node with a configured policy
type: decision
evidence: strong
source: [[channel-agnosticism-metasounds-aaron-mcleran-adc]]
created: 2026-02-28
status: active
---

# compatible audio format transcoding happens automatically while cross-family conversion requires an explicit cast

MetaSounds CAT design separates two kinds of format conversion:

**Implicit/automatic transcoding** -- when the source and destination are in the same family, the graph handles conversion transparently. A 5.1 source connected to a stereo mixer downmixes automatically using standard matrices. An 8th-order ambisonics source connected to a 1st-order consumer decodes automatically. The sound designer sees a single wire; the format negotiation is invisible.

**Explicit cast nodes** -- when crossing family boundaries (discrete to sound field, or either to composite), the graph requires a deliberate cast node. The node exposes configuration: transcode method, decode policy, custom channel maps. This makes cross-family conversion legible and auditable -- a sound designer cannot accidentally discard spatial information.

The guiding principle: "if the format conversion is compatible, it kind of automatically happens under the hood. But if you need to go from one subtype to another, you have to do a deliberate manual transcode."

In the UI, a "make" node constructs a CAT type from mono buffers (for legacy nodes or manual processing), and a "break" node deconstructs it back. The explicit casting node is shown in the demo with a details panel exposing transcode method options.

This two-tier approach is a clean API design decision: common operations are automatic (reduce friction), unusual operations are explicit (preserve auditability). It echoes the principle in [[truth-maintenance-systems-enable-locally-consistent-reasoning-in-an-inconsistent-knowledge-base]] that explicit justification chains matter -- here, cross-family conversions have explicit, inspectable justification.

For murail: the same principle applies to any multi-representation type system. A block-rate signal automatically adapts to audio-rate contexts through a defined up-conversion; explicit cast nodes would be required for moving between rate classes that are structurally incompatible.
