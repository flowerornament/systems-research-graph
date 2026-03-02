---
description: Announcing planned breaking changes at launch and following through is better than deferring breakage, because early users can plan for instability while the design space is still open
type: claim
evidence: strong
source: [[swift-to-mojo-chris-lattner]]
created: 2026-02-28
status: active
---

# early breaking changes with public commitment are preferable to locking in mistakes

Swift's strategy at 1.0 launch: explicitly tell the community that source code will break in future versions, help them migrate when it happens, and use that freedom to correct design mistakes discovered through production use. Swift 1 through Swift 3 broke the language three times. Only at Swift 3 did stability get committed. Lattner says this was the right call: "Can you imagine if it's still Swift One? We'd be left with all these mistakes."

The constraint that forced this: Apple cannot launch software labeled "0.5" or "beta" for a production developer tool. Something shipped to developers is a 1.0 by institutional convention. Therefore the choice was not "ship a stable 1.0 or a beta" -- the choice was "ship a 1.0 that is known to be rough and say so, or delay indefinitely." Given [[language-quality-validation-requires-production-use-not-internal-development]], delaying indefinitely is not actually available as an option.

The public commitment component is critical. Saying "we will break your code" before someone has written any code is a different contract than breaking code with no warning. The community can plan: they know this is a risk, they evaluate whether the bet on Swift's trajectory is worth the churn. Many Uber engineers made exactly this calculation in 2016 for Swift 1.2 -- they knew it was rough, they knew it would improve, they made the bet.

The lesson Lattner is applying to Mojo: don't call it 1.0 until it's stable, because the 1.0 label creates expectations of stability. Mojo is explicitly pre-1.0 while building production usage feedback. Targeted 1.0 for early summer 2026.

For murail's development: this is the argument for a pre-1.0 API policy on murail's graph construction DSL. Breaking the API while the design is still being validated (against real audio workloads) is the right time to break it. Waiting until after adoption locks in every mistake. Connects to [[creative-workflow-friction-should-determine-audio-engine-architecture]]: you only know which design choices create friction after real use.
