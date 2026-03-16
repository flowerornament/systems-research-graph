---
description: Optimizing a programming language for LLM code generation is not a distinct design goal -- the properties that make code readable to humans are the same properties that make code learnable by LLMs
type: claim
evidence: moderate
source: [[swift-to-mojo-chris-lattner]]
created: 2026-02-28
status: active
---

# LLM-friendly language design reduces to readability not LLM-specific features

Lattner rejects the framing "design your language to be easy for LLMs to write." His reasoning: AI has made writing code easier than ever; the constraint on software quality is no longer writing but reading. Code is read far more often than it is written, and this was true before LLMs. LLMs have amplified writing speed, not reversed the read/write ratio. Therefore, the important language design property remains: can a developer (or a future LLM) read and understand the code?

The practical implication: there are no "LLM-specific" language features to add. The same properties that make code readable to humans -- clear syntax, explicit semantics, good error messages, and a large body of open-source examples -- are the same properties that make code learnable by LLMs. Lattner cites Modular's 700,000 lines of open-source Mojo code as the most important LLM-readiness feature.

The error message question is particularly sharp: someone asked Lattner if Mojo should improve error messages specifically for LLM agents that feed errors back into coding loops. His answer: "Make it better for humans." If an error message is good for humans, it is good for agents. There is no separate agent-optimized error format.

This connects to Mojo's Python-syntax choice: Python syntax is readable, widely known, and well-represented in training data. Embracing it is simultaneously an LLM-readiness decision, a teachability decision, and a community accessibility decision -- all three are the same decision.

For [[language-design]]: this claim argues against any special-casing for AI-assisted development in murail's DSL design. The right design target is: can a new audio programmer (or an LLM assisting one) read a murail graph definition and understand what it does? The same readability properties that serve that goal will serve AI assistance.

Connects to [[programmer-time-dominates-computation-cost-in-the-post-scarcity-era]]: Sussman's framing that the binding constraint is programmer expressiveness maps onto Lattner's framing that the binding constraint is readability. Both argue that the measure of a good language is how well it serves the programmer's mental model, not raw execution throughput.
