---
description: Notation is suggestive when expressions arising in one domain suggest structurally analogous expressions that find application elsewhere, enabling discovery rather than just recording known results
type: claim
evidence: strong
source: [[iverson-1980-notation-as-tool-of-thought]]
created: 2026-02-28
status: active
---

# suggestive notation enables discovery through structural analogy

Iverson defines suggestivity as a property of notation, not of the programmer: "a notation will be said to be suggestive if the forms of the expressions arising in one set of problems suggest related expressions which find application in other problems." The notation itself generates the discovery by making structural analogies visible.

His key example: the expression `x/MpN ÷÷ N*M` (product of M copies of N is N to the Mth power) suggests `+/MpN ÷÷ NxM` (sum of M copies of N is N times M) -- the structural parallelism between power and multiplication becomes visible through the notation. This extends further: scan and reduction show similar dualities, and DeMorgan's laws, multiplication by logarithms, and min/max dualities all collapse into a single general identity form `IG F/G V` (where IG is the inverse of G). The notation does not just express these identities; it *reveals* their common structure.

A second example: Iverson demonstrates how identity `+/ιN ÷÷ ((N+1)×N)÷2` is first discovered visually (triangular numbers and their rectangle interpretation) and then formally provable because the same notation supports both graphical intuition and algebraic manipulation. The suggestive pattern leads to the formal proof.

Part of the suggestive power resides in the ability to represent identities in brief, general, easily-remembered forms. Long ad hoc expressions cannot be remembered; cannot be generalized; cannot be analogized. Brevity is not an aesthetic preference but an epistemological necessity.

For [[language-design]]: this is the argument for [[universal-auto-mapping-eliminates-explicit-iteration-from-signal-processing-programs]] -- APL-style rank polymorphism (which McCartney explicitly traces to APL) makes the structural analogy between scalar operations and array operations *visible*, not just available. When `sqrt(9)` and `sqrt([4,9,16])` have the same form, the programmer naturally discovers array-level patterns. When they require different syntax, the connection is hidden.

Contrasts with verbose imperative iteration: when structure is hidden in loops, no pattern is available for analogy. Notation that makes structure explicit enables the cognitive process Iverson calls suggestivity.
