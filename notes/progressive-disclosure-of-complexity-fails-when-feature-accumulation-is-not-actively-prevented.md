---
description: Progressive disclosure requires refusing well-intentioned features until a rigorous subsystem can subsume them; piecemeal addition compounds into inescapable complexity
type: claim
evidence: strong
source: [[llvm-creator-interview-chris-lattner]]
created: 2026-02-28
status: active
---

# progressive disclosure of complexity fails when feature accumulation is not actively prevented

Lattner defines progressive disclosure as a UI paradigm: powerful features are available but not thrust in the programmer's face; simple use cases are simple, and power users discover depth progressively. Swift was designed around this principle. It failed.

The failure mechanism: Swift found product-market fit extremely quickly after its 2014 launch, leaving the team perpetually behind. Instead of fixing the core, the team repeatedly added special-case syntax to enable urgent use cases (result builders for SwiftUI, property decorators, ad-hoc metaprogramming constructs). Each addition was locally well-intentioned. The compound effect was a "gigantic bag of special cases" with no unifying structure. Swift compile times degraded as a result.

Lattner's Mojo response is twofold. First, scope limitation before addition: Mojo currently lacks classes and list comprehensions by deliberate choice, not implementation lag. The principle is "make this subset really really good before we move on." Second, powerful metaprogramming from day one: if you have a proper metaprogramming system, many language features that would otherwise require special syntax can be expressed as library-level constructs. Special cases become instances of a general mechanism rather than one-off language additions.

The Go counterexample on generics reinforces this: Go refused generics for years, accumulated practical experience, then implemented them once with extreme deliberation ("measured 200 times, cut once"). The result was a generics system that actually integrates well, unlike Java's bolted-on generics.

For [[language-design]] in murail's composition language (Stage 9): this is a design-phase constraint. The risk is that user requests for convenience syntax accumulate before the underlying type theory is stable. [[evolvability-requires-trading-provability-for-extensibility]] describes one structural tension; progressive disclosure failure is the complementary adoption-phase risk.

Connected to [[programmer-time-dominates-computation-cost-in-the-post-scarcity-era]]: programmer time is the constraint, and language complexity directly multiplies programmer cognitive load. A language that requires holding many special cases in mind is optimizing against the dominant constraint.

Contrasts with Mojo's explicit design goal of remaining simpler in practice than Swift by using generic metaprogramming mechanisms to subsume what would otherwise become special cases.
