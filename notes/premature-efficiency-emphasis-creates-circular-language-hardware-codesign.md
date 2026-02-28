---
description: Designing languages to match current hardware capabilities and hardware to match current language patterns creates a lock-in cycle that prevents notation from evolving toward better thought tools
type: claim
evidence: moderate
source: [[iverson-1980-notation-as-tool-of-thought]]
created: 2026-02-28
status: active
---

# premature efficiency emphasis creates circular language-hardware codesign

Iverson's closing argument in Section 5.4: "overemphasis of efficiency leads to an unfortunate circularity in design: for reasons of efficiency early programming languages reflected the characteristics of the early computers, and each generation of computers reflects the needs of the programming languages of the preceding generation."

The circularity is a ratchet: language L1 is designed to run efficiently on hardware H1; hardware H2 is designed to run L1-style code efficiently; language L2 is designed to run efficiently on H2; and so on. Each iteration optimizes for the previous generation's constraints, preventing the notation from evolving toward what would be a better tool for thought. APL's array operations were considered inefficient on 1980 hardware; implementers added efficient support for heavily-used boolean operations (`^/B`, `v/B`) precisely because the notation attracted users who wrote that code.

The counterexample Iverson cites: "because functions on booleans (such as `^/B` and `v/B`) are found to be heavily used in APL, implementers have provided efficient execution of them." Use patterns driven by expressive notation drive hardware/implementation improvements -- the causal arrow runs from notation to efficiency, not the other way.

This is a design governance argument as much as a technical one. Efficiency concerns should not veto notation decisions in early design phases. The question "is this efficient?" only makes sense relative to a specific hardware/implementation target; the question "does this serve thought?" is more durable. This is a direct corollary of the foundational claim that [[notation-shapes-thought-not-merely-expresses-it]] -- if notation determines which problems are conceivable, then constraining notation to match current hardware constrains thought itself.

Connects to [[programmer-time-dominates-computation-cost-in-the-post-scarcity-era]]: Sussman's argument that programmer expressiveness is now the binding constraint is the contemporary form of Iverson's 1980 argument. The scarcity that justified language-hardware co-optimization (limited memory, slow CPUs) has been removed; the circularity should break. And Iverson's companion argument in the same paper -- that [[clear-algorithms-are-the-necessary-foundation-for-efficient-ones]] -- provides the constructive alternative: write for clarity first, then derive efficient variants from the clear form. The circularity is not just harmful; it is unnecessary.

The argument also explains APL's influence on array languages (J, K, Q, Julia) -- each generation freed from the original hardware constraints found that the notational properties Iverson identified were worth recovering. The thought-tool value was latent in the design; efficiency was a temporary obstacle.

**Contemporary instances of the circularity.** The ratchet Iverson identified in 1980 is still active. [[purely-functional-languages-fail-on-modern-hardware-because-pointer-boxing-destroys-cache-locality]] documents a concrete case: Lisp and OCaml were designed when memory access was uniform, so they box values and chase pointers freely; hardware evolved deep cache hierarchies that punish pointer indirection; new languages (Rust) then optimize for cache hierarchies -- but this locks notation into contiguous-memory idioms. The circularity continues, just at a different level of the stack. [[ai-hardware-stack-fragmentation-mirrors-pre-gcc-compiler-era]] shows the pattern at industrial scale: every AI hardware vendor builds a vertical software stack optimized for their silicon, producing the exact language-hardware lock-in Iverson warned about. Lattner's GCC analogy -- a neutral compiler layer that decouples software from hardware -- is an explicit attempt to break the ratchet.

**Breaking the circularity through compiler design.** Lattner's Mojo work offers two strategies. First, [[sufficiently-smart-compilers-produce-leaky-abstractions-not-reliable-performance]] argues that the traditional compiler approach (pattern-match source code to trigger optimizations) is itself a form of the circularity: the source is constrained to match the compiler's expectations, which are constrained by hardware targets. Mojo's response -- making optimizations explicit as library calls -- breaks this by giving the programmer direct control. Second, [[compiler-generality-beats-human-specialization-at-scale-because-compilers-can-enumerate-configurations-humans-cannot]] demonstrates that a sufficiently general compiler can enumerate hardware configurations rather than special-casing them, inverting the causal direction Iverson diagnosed: instead of language conforming to hardware, the compiler absorbs hardware diversity.

For murail: the implication is that graph compiler design should prioritize notational clarity in the signal composition language, even when the notation does not map directly to current hardware execution models. The compiler's job is to bridge notation and hardware; constraining notation to match hardware is ceding the design to the ratchet.
