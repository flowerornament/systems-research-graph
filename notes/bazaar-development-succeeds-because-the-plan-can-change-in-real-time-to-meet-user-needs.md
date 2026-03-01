---
description: The bazaar development model's decisive advantage is not distributed labor or distributed design review but adaptability -- the plan changes in real time to match user needs, producing lasting user investment and buy-in
type: claim
evidence: strong
source: [[steele-1998-growing-a-language]]
created: 2026-03-01
status: active
---

# bazaar development succeeds because the plan can change in real time to meet user needs

Steele, drawing on Eric Raymond's "The Cathedral and the Bazaar" and Christopher Alexander, identifies the key distinction between bazaar and cathedral development: not that bazaar gets more contributors, not that bazaar gets distributed design input, but that the *plan itself changes in real time* to meet the needs of users.

"The plan can change in real time to meet the needs of those who work on it and use it. This tends to make users stay with it as time goes by; they will take joy in working hard and helping out if they know that their wants and needs have some weight and their hard work can change the plan for the better."

The Alexander quote supports this: master plans "alienate users" because "the very existence of a master plan means, by definition, that the members of the community can have little impact on the future shape of their community." Users under a master plan "realize that they are merely cogs in someone else's machine" and lose "any sense of identification with the community."

The bazaar model avoids this by *designing a way of doing rather than a thing*. Some choices are made now; other choices are left to be made later by users whose needs cannot be anticipated. This is the Alexander pattern concept applied to software: patterns have slots, and the slots are filled in by the people who instantiate the pattern.

Importantly, Steele is not advocating anarchy. The bazaar model requires "a person in charge who is a quick judge of good work and who will take it in and shove it back out fast." The role of the maintainer shifts from designer to curator. The curator's job is to make the community's distributed work coherent and usable.

This connects to [[language-feature-adoption-requires-governance-structures-not-just-technical-readiness]]: Steele describes the bazaar model from the success case; the SuperCollider governance failure describes what happens when the curator role is unclear or contested. Both claims point to the curator/governance function as the critical bottleneck.

For murail: the design question is not only what mechanisms to provide for growth but how to structure the curator/governance function. An open murail ecosystem needs: clear process for evaluating user-defined UGen libraries, transparent criteria for what gets promoted to the standard library, and a named curator who can make and ship decisions quickly. Without this, the bazaar devolves into incompatible forks.
