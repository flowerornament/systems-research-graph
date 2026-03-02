---
description: Gabriel's thesis endorsed by Steele: the deployable small language with warts wins the race against the right-but-late large language; escape requires growable design, not perfect design
type: claim
evidence: strong
source: [[steele-1998-growing-a-language]]
created: 2026-03-01
status: active
---

# worse is better because small languages with warts reach users before well-designed large languages

Steele endorses Dick Gabriel's "Worse is Better" thesis (from "Lisp: Good News, Bad News, How to Win Big", 1991): in a race between a small, cheap, fast-to-deploy language with warts and a carefully designed language that is still being built, the small language wins. Users will not wait for "The Right Thing." They will use what is available and put up with the warts.

Once a small language fills a niche, it is hard to displace: users have invested in it, have built up vocabulary and tools around it, and switching costs are high. The well-designed language arrives to find the niche occupied.

Steele's addition to Gabriel's thesis: the race does not necessarily go permanently to the wart-laden language. Users will not put up with warts forever -- they will demand changes. The small language will grow. The warts will be shaved off or patched. The outcome is not predetermined; it depends on whether the small language can grow effectively once it has captured the niche.

The caveat: the language that wins the race must be *growable*. A small language that cannot grow is stuck with its warts permanently (APL, Pascal). A small language that can grow (C → C++, Java) can patch the warts and evolve. This is why designing for growth is not optional even in the "Worse is Better" framework.

Steele applies this to Scheme: "I guess it could be done [to make a small, wart-free language], but I, for one, am not that smart. But in fact I think it can not be done." Scheme was his best shot at "The Right Thing" as a small language -- and modern user needs (GUI, networking, threads, multiple platforms) make a Scheme-sized language insufficient regardless of its design quality.

This enriches [[experts-resist-new-languages-because-their-prior-investment-is-invalidated]] (Lattner): the "Worse is Better" dynamic and the expert resistance dynamic interact -- once early adopters are invested in the wart-laden language, even experts who recognize its flaws resist switching because their expertise in the wart-laden language has economic value.

Connects to [[language-quality-validation-requires-production-use-not-internal-development]]: production use is the validation gate, but "Worse is Better" suggests that production use does not automatically select the best design. It selects the fastest-to-deploy design that can hold a niche.

The "Worse is Better" dynamic is precisely what [[the-expression-problem-names-the-tension-between-adding-new-cases-and-new-operations-without-recompiling]] cannot prevent: Wadler's correct formulation of the problem and the GJ solution satisfying all constraints were published in 1998, but Java's OO model (which solves only one dimension) had already captured the niche. Knowing the right answer did not displace the deployed answer. The expression problem's theoretical resolution (virtual types, multimethods, algebraic effects) remains niche precisely because the wart-laden OO approach arrived first and grew into an ecosystem.

For murail: the design implication is that shipping a smaller, deployable murail with known gaps is better than waiting for a complete design. The caveat is that the gaps must not include the growth mechanism itself -- a murail with no user extensibility cannot evolve past its initial design.
