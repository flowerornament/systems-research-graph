---
description: McCartney's prescription for learning audio programming: read the source code of CSound, VCV Rack, SuperCollider, Chuck, and Pure Data, because each solves the same engine problems differently
type: claim
evidence: moderate
source: [[2026-02-06-qmayIRViJms]]
created: 2026-02-28
status: active
---

# Audio programming education requires reading production engine source code across multiple systems

McCartney's explicit prescription for someone who wants to learn audio programming: read the source code of CSound, VCV Rack, SuperCollider, Chuck, and Pure Data. These are all open-source audio engines that solve the fundamental problems -- RT scheduling, thread safety, buffer management, UGen/module design, graph compilation or patching -- in different ways. Reading across all of them reveals the problem space, not just one solution.

The specific insight: each of these systems is "solving them in a slightly different way." A developer who only reads one engine learns one approach; a developer who reads five learns the design space. The variation matters because audio engine design involves real tradeoffs (latency vs. safety vs. expressiveness vs. extensibility) that only become visible when compared across systems that made different choices.

This is the counterprescription to the JUCE-only path. See [[juce-abstracts-away-audio-engine-fundamentals-producing-developers-who-cannot-reason-about-threading-and-resource-management]]. JUCE is a production system but hides its internals behind an API; CSound, VCV Rack, SuperCollider, Chuck, and PD are all production systems whose internals are the learning target.

**For Murail documentation and design:** The competing-systems analysis in [[competing-systems]] is executing exactly this prescription at the research level. McCartney's advice affirms the methodology: understanding SC's group tree, Faust's algebraic semantics, MetaSounds' JIT graph compilation, and VCV Rack's module API as a set reveals Murail's design space. The risk is the same as McCartney implies for individual developers: reading only one or two systems produces false confidence about the solution space.

Note that McCartney's list is notable for what it omits: JUCE, Web Audio API, and commercial DAW plugin frameworks. His list is entirely open-source, academically-rooted, and architecture-visible. Bias toward academically-rooted audio engines reflects McCartney's background but also reflects where the interesting architectural diversity lives.
