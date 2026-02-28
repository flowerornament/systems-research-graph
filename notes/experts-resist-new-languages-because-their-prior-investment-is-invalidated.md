---
description: Expert practitioners resist language transitions because switching resets their competitive advantage to zero; their resistance is rational protection of accrued expertise, not irrationality
type: claim
evidence: strong
source: [[swift-to-mojo-chris-lattner]]
created: 2026-02-28
status: active
---

# experts resist new languages because their prior investment is invalidated

Lattner names this as "counterintuitive" but structurally predictable: an expert Objective-C programmer of five to ten years has learned all the arcane edge cases, the bag of tricks, the weird failure modes. They are the person others turn to for help. When Swift arrives, they are reset to day one -- their expertise is invalidated. They share the same starting point as the most junior developer. This is not irrational: they are protecting a genuine prior investment.

The framing Lattner uses: it's about being "king of the hill of the old thing." The expert does not want the new thing to succeed because their value derives from the old thing's dominance. Some experts are intellectually flexible and cross over; they become early adopters. But the majority require a high-value forcing function (like SwiftUI being Apple's strategic direction) before switching.

This pattern, which Lattner explicitly names as technology diffusion and S-curve adoption, means that new language uptake is not correlated with quality -- it follows a curve where early adopters lead, most practitioners follow only when a forcing function arrives, and a tail of hold-outs may never convert.

Lattner connects this directly to the AI/LLM transition: "This is the exact same thing happening with GPUs right now." Engineers expert in CUDA-era C programming face the same invalidation dynamic when Mojo-style high-level GPU programming arrives.

Relevant to [[competing-systems]]: understanding the adoption dynamics of SuperCollider, JUCE, Max/MSP, and other competing audio systems requires applying this model. Expert SC programmers resist metasounds-style graph models not because the models are worse but because their expertise is threatened. This is the sociological constraint murail must navigate.

Connects to the practical note in [[juce-abstracts-away-audio-engine-fundamentals-producing-developers-who-cannot-reason-about-threading-and-resource-management]]: JUCE experts are particularly locked in because JUCE's abstractions have made their knowledge domain-specific.
