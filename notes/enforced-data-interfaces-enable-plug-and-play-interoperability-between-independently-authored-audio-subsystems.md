---
description: MetaSounds' typed interface system lets gameplay subsystems declare required graph contracts that any compliant MetaSound can satisfy, enabling audio authors to work independently of each system's implementation
type: pattern
evidence: strong
source: [[channel-agnosticism-metasounds-aaron-mcleran-adc]]
created: 2026-02-28
status: active
---

# enforced data interfaces enable plug-and-play interoperability between independently authored audio subsystems

MetaSounds graphs expose typed data interfaces: declared inputs and outputs that can be connected to game data. A vehicle system, for example, can declare a required interface -- "I need a MetaSound that accepts RPM (float), gear (int), and terrain (enum) as inputs." Any MetaSound that implements this interface can be plugged in.

The interface is enforced: the system rejects graphs that don't implement the required contract. This means:
- Audio authors can create a vehicle MetaSound independently, knowing only the interface spec
- The vehicle gameplay programmer doesn't need to know how the sound is implemented -- only that the interface is satisfied
- Graphs can be swapped out (different vehicle sound designers' implementations) without modifying game code

McLeran: "your meta sound that you've made for a particular subsystem or gameplay system could theoretically be plugged into a gameplay system that you didn't even know about, but maybe there's an enforced interface that allows those two systems to talk to each other."

This is structural typing at the audio authoring level. The "sounds of the metaverse" concept -- McLeran's stated product vision -- extends this: if audio content can be authored to satisfy typed interfaces, it can potentially be reused across games, experiences, or platforms that declare compatible interfaces.

Bidirectionality: interfaces support both input (game -> MetaSound) and output (MetaSound -> game). A MetaSound can notify gameplay systems of events (grain triggered, threshold crossed) through the output interface.

Connection to [[channel-format-metadata-encapsulation-enables-audio-graph-reuse-across-channel-configurations]]: CAT types enable reuse across channel configurations; interface enforcement enables reuse across gameplay contexts. Together they define the two axes of MetaSounds' interoperability claim.

For murail: this pattern suggests that murail's graph API could benefit from a typed interface layer above the raw UGen connection graph -- a contract system that lets host environments specify what they need without coupling to graph internals.
