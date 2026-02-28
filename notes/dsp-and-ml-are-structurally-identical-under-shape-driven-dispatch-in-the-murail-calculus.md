---
description: The equation y = a·y@1 + b·x is a one-pole filter at scalar shape and a recurrent neural layer at shape (16) with matrix a; only the dispatch target differs between DSP and ML
type: property
evidence: strong
source: [[murail-substrate-v3]]
created: 2026-02-28
status: active
---

# dsp and ml are structurally identical under shape-driven dispatch in the murail calculus

Appendix C of the substrate specification presents this as the "key structural result motivating the substrate":

> The equation `y = a · y@1 + b · x` at scalar shape is a scalar recurrence (e.g., a one-pole filter). At shape `(16)` with `a` as a `(16 × 16)` matrix, it is a recurrent neural layer. The substrate treats both identically -- only the dispatch target differs. This is not a metaphor; it is a consequence of shape-driven dispatch over the same recurrence calculus.

The same equation form `y = a · y@1 + b · x`:
- Shape `()`, scalar a: one-pole IIR filter → dispatched to CPU_scalar
- Shape `(16)`, matrix a: one layer of an RNN → dispatched to GPU or CPU_SIMD
- Shape `(512, 512)`, matrix a: a large recurrent layer → dispatched to GPU

The substrate treats them identically through the compile pipeline: dependency analysis, causality check, shape inference, rate assignment, layout, dispatch. The dispatch function (domain-provided) selects the hardware target based on shape and operation. The same recurrence semantics apply in all cases.

**Why this matters for Murail.** The project intersection of audio-dsp and ai-ml is not just an application overlap -- it is a formal consequence of the substrate. Neural audio processing (DDSP, RAVE, neural synthesis) uses the same execution model as classical DSP, with dispatch to different hardware. The substrate handles both without special-casing either.

**The unification is not accidental.** It follows from two independent design decisions: (1) shapes are finite tuples of positive integers with no domain-specific interpretation, and (2) dispatch is shape-driven and domain-configured. Neither decision was made with DSP/ML unification as the explicit goal; the unification emerges.

## Connections

- Directly connects the [[ai-ml.md]] and [[formal-methods.md]] topic maps through a single formal result
- [[differentiable-dsp-components-make-classical-synthesis-knowledge-available-as-structural-priors-for-neural-networks]] (DDSP) approaches this from the ML side; Murail's substrate approaches it from the formal model side -- they are complementary perspectives on the same structural convergence
- [[signal-shape-as-a-type-level-property-enables-compile-time-buffer-allocation-and-vectorization]] (McCartney) identifies shape as a type-level property for static allocation; Murail's substrate formalizes this through shape inference and dispatch
- The substrate factoring ([[the-murail-substrate-is-instantiated-by-a-domain-configuration-without-modifying-layers-0-through-2]]) is what makes this unification possible: a substrate with audio hardcoded could not unify with ML
