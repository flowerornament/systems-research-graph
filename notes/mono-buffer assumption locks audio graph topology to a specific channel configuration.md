---
description: When mono buffer is the only audio type, graphs bake channel count into their structure -- changing format requires structural rewiring, making reuse across configurations impossible
type: claim
evidence: strong
source: [[channel-agnosticism-metasounds-aaron-mcleran-adc]]
created: 2026-02-28
status: active
---

# mono-buffer assumption locks audio graph topology to a specific channel configuration

MetaSounds' initial design used mono audio buffers as the fundamental type -- the same approach as Max MSP out of the box. The consequence is what McLeran calls "topological locking": a graph built for a stereo wave player cannot be reused for a 7.1 player without manual rewiring. Every processing node (filters, mixers, panners) must be replicated once per channel. Sound designers end up maintaining separate graph variants for every channel configuration they support.

McLeran's examples of what this looks like in practice:
- A stereo wave player feeding a mixer requires manually routing each output to its corresponding stereo mixer input
- Applying a filter to all channels means adding one filter node per channel -- "an endless nightmare"
- Teams maintain libraries of patch variants (mono version, stereo version, 5.1 version) that share underlying logic but differ only in channel wiring

The root cause: mono buffer is a type that knows nothing about its spatial or format context. It is a value, not a typed description. The graph's topology becomes the only place where format intent is expressed.

"The audio channel problem was severely underestimated when we started building MetaSounds." -- McLeran

Contrast: [[channel format metadata encapsulation enables audio graph reuse across channel configurations]] addresses this directly by lifting format into the type.

Related to [[visual-representation-exposes-structure-text-notation-obscures]]: audio signal graphs suffer from the same structural exposure problem McLeran identifies topologically -- graphs with many parallel channels are visually complex in ways that obscure the underlying processing logic, just as cyclic structure obscures graph topology in text notation.
