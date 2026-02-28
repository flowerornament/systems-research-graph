---
description: McCartney's intermediate SC3D5 version ran unit generators that produced pixels instead of audio samples, demonstrating that a signal graph execution model is domain-agnostic
type: claim
evidence: strong
source: [[2026-02-06-fmVdfQNPzkE]]
created: 2026-02-28
status: active
---

# SuperCollider 3D5 applied signal graphs to pixel synthesis demonstrating graph generality beyond audio

Between SC2 (single-process Smalltalk-inspired language) and what became SC3 (client-server model), McCartney built an intermediate version he called SC3D5. It had two virtual machines -- one handling real-time audio, one handling non-real-time tasks like UI and file loading -- and it included an image synthesis subsystem where unit generators produced pixels instead of audio samples.

The pixel synthesis system was not a separate engine: it reused the signal graph model. Unit generators wired together produced a pixel stream rather than an audio stream. This is not metaphorical similarity -- McCartney explicitly describes "you would run unit generators, but instead of producing audio samples, they were producing pixels."

The same graph-wiring execution model that synthesizes audio can synthesize pixels by changing the output interpretation. This demonstrates that the signal graph model is domain-agnostic: the primitive operations (constant, math, delay, control flow) are not inherently about audio. They describe a class of computation that happens to include both audio and image synthesis.

SC3D5 also included an "animated user interface" -- presumably driven by the same signal graph. McCartney notes he "got pretty close to inventing immediate mode user interfaces" at this stage, though he didn't quite get there (immediate mode UI was not a recognized paradigm yet).

SC3D5 was abandoned because running on macOS 9 was becoming obsolete and the RT virtual machine was "too heavyweight." What emerged instead was the SC3 client-server model.

**Murail implication:** Murail's graph IR -- signals as typed matrices (shape × element type × rate) -- is structurally the same domain-agnostic computation model. The SC3D5 example provides historical evidence that this generality was independently discovered and validated in 2001-era practice. If murail's signal graph model becomes stable, pixel-space or other non-audio domains are natural extensions of the same architecture rather than separate design efforts. The constraint is only the output interpretation layer, not the graph execution model itself.

Connects to [[synthesis-graph-construction-is-a-regular-program-not-a-domain-specific-declaration]] -- if graph construction is ordinary programming, then what the graph computes (audio, pixels, other) is just a parameter, not a fundamental architectural boundary. Extends the historical arc of [[supercollider-version-2-used-a-smalltalk-inspired-language-without-client-server-separation]] by filling in the intermediate SC3D5 version that the earlier claim does not mention.
