---
description: The concern that LLMs will default to JavaScript because of training data volume inverts: if language doesn't matter to the LLM, zero-friction entry to any ecosystem is a net gain for minority languages
type: claim
evidence: moderate
source: "[[keynote-elixirs-ai-future-chris-mccord-elixirconf-us-2025]]"
created: 2026-02-28
---

# llm-fatalism-about-elixir-inverts-the-actual-opportunity

The fatalist argument: LLMs are trained mostly on JavaScript, so they will default to JavaScript, so the future is JavaScript, so Elixir is irrelevant. McCord's inversion: if language doesn't matter to LLMs -- if anyone can ask an agent to build a Phoenix app and get working code -- then the frustration gap that previously filtered newcomers away from less-popular ecosystems disappears. People who heard Elixir was good but were deterred by the learning curve can now just ask an agent to build the thing. Zero barrier to entry is a net positive for less-popular languages.

The argument has two parts:
1. **LLMs generalize**: a small gap-fill file (AgentsMD, ~300 lines) is sufficient to get frontier models to work effectively with Elixir. The world-knowledge problem is solved cheaply.
2. **Curiosity is the bottleneck**: people already admire Elixir and Phoenix (top-of-admired rankings). The blocker was the learning curve, not awareness. Agents dissolve that blocker.

## Connection to AgentsMD

This is the strategic justification for [[agentsmd-is-gap-filling-for-llms-not-documentation-for-humans]]: if gap-filling works, the LLM can onboard developers into Elixir who would previously have bounced. The investment in making LLMs effective with your ecosystem pays off not just for existing users but for community growth.

## Cross-domain relevance for herald

For herald specifically: the same logic applies. If LLMs can build effective herald applications with good gap-fill files, the relevant developer audience is anyone who wants to build real-time systems -- not just those already comfortable with Elixir.

---

Topics:
- [[index]]
