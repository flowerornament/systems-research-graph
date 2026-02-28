---
description: Languages that succeed beyond their initial domain do so because they were designed with generality from the start; JavaScript running web servers is a consequence of the design, not an accident
type: claim
evidence: strong
source: [[swift-to-mojo-chris-lattner]]
created: 2026-02-28
status: active
---

# new language success requires designing for expansion to adjacent domains

Lattner's heuristic for defining language success: a language succeeds when it gets naturally adopted in domains its designers never anticipated. JavaScript was designed for onclick handlers; it now runs web servers. Objective-C was designed for desktop application development; its limitations only became visible when iPhone brought it into a new domain with new constraints (memory, performance, teachability to a generation of new developers).

The design implication: when starting a new language, don't optimize for the first-win domain. Think through what domains natural success would bring the language into, and make sure the language can scale there without fracturing. For Swift, this meant: scaling from embedded systems all the way up to scripting-friendly interactive use, rather than being a better Objective-C replacement only.

Lattner contrasts this with the Python situation: Python is a beautiful language for objects built on top of C and C++. Python has a "two-world problem" (scripting level vs. native extension level) that was not designed for from the start. This is exactly the same two-world problem that Objective-C had -- and it is still present in Python today. History rhymes.

The positive example is Swift's success in enabling app developers who could not use Objective-C. That expanding access -- not just doing existing things better -- is what Lattner names as his proudest moment. The same dynamic (CUDA gatekeeping GPU programming) is what Mojo targets.

For murail: the [[language-design]] question of who murail's language is for has expansion implications. If murail starts as a Rust-embedded audio DSL for systems programmers, it should be designed to eventually be usable by composers and DSP researchers without those users needing to understand Rust. See [[creative-workflow-friction-should-determine-audio-engine-architecture]] for McCartney's equivalent design constraint.
