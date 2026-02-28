---
description: Declaring that a new language will break source compatibility removes the "one-way door" risk for executives and lets early adopters be volunteers rather than conscripts
type: claim
evidence: strong
source: [[llvm-creator-interview-chris-lattner]]
created: 2026-02-28
status: active
---

# source incompatibility as explicit commitment converts forced migration to opt-in experiment

Lattner's key insight in getting Swift approved at Apple was reframing source instability as a feature rather than a defect.

The blocking concern from Apple's executive review was: if we launch Swift and it is in any way defective, developers who have adopted it cannot go back. We have walked into a trap. The usual response to this concern is to promise stability -- "we will not break your code." But Swift in 2014 had four years of development and perhaps 200 internal users. Promising source stability on a four-year-old language with ~200 users was not credible.

Lattner's resolution: explicitly commit to breaking source compatibility. Tell developers: "You can use Swift, you can ship to the App Store, and we will break your code because we have not gotten enough mileage on this yet. Our goal is to make it good, not to nail it down." This transformed the risk profile:

1. Developers who wanted stability could stay on Objective-C. No forced migration.
2. Developers who wanted to experiment could adopt Swift and accept churn as the price of early access.
3. Executive risk was bounded: if Swift turned out to have problems, they had not walked into a trap.
4. The Swift team could optimize for correctness rather than for preserving a compatibility surface they were not confident in.

The organizational mechanism here is what Lattner calls a "relief valve": by making the new thing explicitly opt-in and explicitly unstable, you remove the catastrophic failure mode (everyone is forced to migrate to something broken) and replace it with a recoverable experiment (early adopters accept churn, late adopters wait for stability).

Swift 3.0 to Swift 5.0 continued breaking source compatibility -- Lattner counts this as partially responsible for Swift's unusually rapid community transition despite the churn. Mechanical migration tools (migrators) that automatically updated 90% of broken code reduced the cost of each break.

For [[language-design]] in murail's composition language context: this is an organizational and adoption-phase principle, not a technical one. But it is relevant to how murail's public API and DSL stability should be communicated. Explicitly marking features as unstable and providing migration paths is more honest and more adoptable than promising stability the implementation cannot yet support.

Contrasts with [[incremental-migration-between-languages-requires-binary-level-interoperability-not-just-semantic-compatibility]] which describes the technical mechanism; this claim describes the organizational/framing mechanism that complements it.
