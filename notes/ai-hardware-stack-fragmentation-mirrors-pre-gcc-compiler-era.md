---
description: Every AI hardware vendor builds a complete vertical software stack (CUDA, ROCm, XLA, MLX) with almost no shared code, replicating the pre-GCC state where every chipmaker had its own incompatible C compiler
type: claim
evidence: strong
source: [[swift-to-mojo-chris-lattner]]
created: 2026-02-28
status: active
---

# AI hardware stack fragmentation mirrors pre-GCC compiler era

Lattner's explicit framing for why Modular and Mojo exist: before GCC, every hardware vendor (HP, Intel, others) maintained their own C compiler with different bugs, different missed features, and no interoperability. GCC standardized the compiler surface and allowed software to decouple from hardware. The pre-GCC world was "a gigantic nightmare" resolved by a neutral, modular compiler infrastructure.

AI hardware is in the same pre-GCC state today. NVIDIA has CUDA. Google TPUs have XLA. AMD has ROCm. Apple has Metal/MLX. Each is a complete vertical stack with minimal shared code between them. The consequence: a team like Anthropic trains models that must be reimplemented three times over -- once per hardware vendor -- by separate engineering teams. These implementations diverge, produce different quality outputs, and cause outages when they disagree. Lattner cites an Anthropic engineering blog post documenting this exact problem.

Mojo/Modular's stated goal is to be the GCC of AI: a neutral infrastructure layer that hardware vendors implement into once, giving the ecosystem a shared, portable abstraction above the hardware diversity.

This frames a competitive systems pattern directly relevant to murail's domain. Audio DSP faces a smaller-scale version: JUCE, as noted in [[juce-abstracts-away-audio-engine-fundamentals-producing-developers-who-cannot-reason-about-threading-and-resource-management]], is a partial abstraction but not a neutral compiler-level infrastructure. Murail's graph compiler is closer in spirit to what Modular is attempting -- a composable, hardware-agnostic foundation.

Connects to [[competing-systems]] and specifically provides a historical analogy for why a neutral infrastructure layer eventually wins over vertical stacks: the GCC precedent.

Enriches [[language-design]] by providing Lattner's explicit framing for what Mojo is solving -- not just "a better Python" but "the missing LLVM for AI hardware."
