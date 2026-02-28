---
description: Generating production code without maintaining developer understanding produces systems that cannot be safely modified because no one knows how they work or where the structure duplications are
type: claim
evidence: moderate
source: [[swift-to-mojo-chris-lattner]]
created: 2026-02-28
status: active
---

# vibe coding produces unauditable architectural debt

Lattner's concern about vibe coding (using LLM agents to generate code without reviewing the output or maintaining architectural understanding): AI coding tools tend to duplicate things in different places. When you want to change something, you update two out of three copies and introduce bugs. This is a known failure mode of generated code. For a prototype, this is acceptable; for production systems it is a quality and security risk.

The deeper problem: if a developer has not maintained understanding of how their system works, they cannot safely evolve it. Six months from now, when the architecture needs to change, no one can reason about the system. The tool that built it is not a substitute for a mental model.

Lattner's formulation: "Vibe coding terrifies me. Not just because of what it does for jobs, but what does it mean six months from now when you want to change the architecture of something?" He distinguishes between using AI to handle mechanical work (a productivity gain that keeps the developer in the loop) vs. using AI to drive the entire implementation (which produces systems no one understands).

His proposed guard: require developers to understand what the agent produced before committing it. The Addy Osmani approach -- verbose agent output that the developer reads before accepting -- preserves the mental model without requiring the developer to type every character.

The claim is specific to production systems; Lattner explicitly carves out prototypes as a different category where vibe coding's productivity gain outweighs the architectural risk.

Relevant to [[developer-experience]] in murail's context: if murail's graph compiler or DSL is used with AI coding assistance, the architectural invariants (RT safety, memory layout, graph compilation correctness) cannot be delegated to an agent that has no model of the constraints. This is not a reason to avoid AI tools; it is a constraint on how they should be used in safety-critical audio contexts.

Connects to [[an-agent-is-just-a-simulated-chat-in-a-loop]] from the herald domain: the architectural review problem Lattner identifies is a version of the same problem the herald system faces -- agent actions that are individually plausible can collectively produce incoherent state.
