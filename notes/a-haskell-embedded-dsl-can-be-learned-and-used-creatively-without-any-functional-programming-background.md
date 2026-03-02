---
description: A survey of 15 Tidal users found 12/15 had no functional programming experience, yet 14/15 could make music and 11/15 found it not difficult -- the DSL abstraction, not the host language, determines accessibility
type: claim
evidence: moderate
source: [[mclean-2014-making-programming-languages-to-dance-to]]
created: 2026-03-01
status: active
---

# a Haskell-embedded DSL can be learned and used creatively without any functional programming background

McLean conducted a small survey (N=15) of Tidal users via the Tidal online forum. The key demographic finding: 6/15 selected "No experience at all" with functional programming languages; 6/15 selected "Some understanding, but no real practical experience." Only 3/15 had written programs using functional techniques, and none had in-depth practical knowledge.

Despite this, the Likert-scale results showed:
- 14/15 could make music with Tidal
- 11/15 found it not difficult to learn
- 13/15 felt it had potential to help them be more creative
- 10/15 could learn Tidal just by playing with it
- 8/15 did not need theoretical understanding of Tidal's implementation to use it for music

Qualitative responses described Tidal as "the first music programming thingy that makes sense to me as a musician" (R8), and one user (R10) described achieving "flow" states through its immediacy. R15 noted that "the pattern syntax has changed how I think about digital representations of music" -- suggesting the DSL not only was accessible but actively reshaped musical cognition.

McLean's interpretation: "despite Haskell's reputation for difficulty, these users did not seem to have problems learning a DSL embedded within it, that uses some advanced Haskell features." The abstraction layer provided by the EDSL design is what makes this possible -- users interact with the Tidal API (pattern combinators, mini-notation strings), not with Haskell's type system or monad machinery.

**The design implication:** The distinction between EDSL and host language is the accessibility lever. Tidal uses Haskell's Functor/Applicative machinery internally, but users never see `<$>` or `<*>` unless they want to -- the string mini-notation parser (`"[red black, blue orange green] * 16"`) handles the common case. The advanced functional features are available for power users but not required.

This is direct evidence for the murail composition language strategy: Rust is a complex host language with a steep learning curve, but a well-designed EDSL on top of it can be accessible to musicians with no Rust knowledge. The key design principle is that the user-facing API must not expose host-language complexity -- users should compose musical patterns, not construct audio graphs manually.

Contrasts with SuperCollider, where the synthesis and scripting language are unified (see [[scripting-and-synthesis-in-the-same-language-eliminates-the-boundary-between-composition-and-sound-design]]): that unification is a power feature for expert users -- compositional algorithms can directly parameterize synthesis -- but a learning barrier for musicians whose goal is pattern expression, not synthesis design. The EDSL approach trades that power for accessibility. McCartney's design philosophy makes the language the primary affordance for synthesis exploration; Tidal's design makes the pattern language the primary affordance and treats synthesis as a black box driven by pattern outputs. The survey evidence here is direct argument that Tidal's abstraction boundary is correctly placed for its target users, though it forecloses the granular synthesis use case that motivated SC1's unified model.

The survey is small and self-selecting (forum members already using Tidal), so statistical generalization is limited. McLean acknowledges this but treats the qualitative responses as sufficient evidence for the design direction.

---

Topics:
- [[language-design]]
- [[developer-experience]]
