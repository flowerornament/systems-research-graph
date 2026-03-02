---
description: A language cannot be validated against real usage by an internal team under NDA; production use by diverse external programmers is the only source of the feedback needed to make quality decisions
type: claim
evidence: strong
source: [[swift-to-mojo-chris-lattner]]
created: 2026-02-28
status: active
---

# language quality validation requires production use not internal development

Lattner's diagnosis of the Swift 1.0 launch: only ~250 people at Apple knew about Swift at the time of launch, almost all of them on Lattner's team. It was impossible to know whether the language was ready because the team was too small and too aligned to produce the diversity of usage patterns that expose real problems. "You can't build a good programming language in a vacuum with an NDA you had to sign to get access to it."

This is why Swift launched with the explicit announcement that source code would break in future versions. The decision was deliberate: get the language into production use, accept the feedback, and make breaking changes based on real usage. The alternative -- waiting until it was "perfect" internally -- would have produced a product that was internally consistent but externally wrong in ways the team couldn't predict.

Mojo is applying this lesson: Lattner explicitly says they are being "thoughtful and learning from the previous journey" and want to provide stability before calling it 1.0. The Mojo community has been developing against pre-1.0 versions precisely to accumulate the production feedback that Swift's internal development phase could not generate.

The corollary: any design decision made without production usage is tentative. This is not a quality failure; it is an epistemological constraint. The right response is to design the system to be changeable, communicate the change policy explicitly, and use real usage to drive convergence.

Relevant to murail's development strategy: if murail's graph compiler and DSL are developed in isolation (the current phase), they will not have been validated against the diversity of audio programming patterns that real users will bring. The implication is to get something into external hands early, even if incomplete, rather than perfecting an internal design. Connects to [[creative-workflow-friction-should-determine-audio-engine-architecture]] as the principle that real creative use is the ultimate quality oracle.
