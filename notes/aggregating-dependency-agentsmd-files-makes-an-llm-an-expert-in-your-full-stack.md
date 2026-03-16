---
description: Usage-rules collects AgentsMD gap-fill files from all transitive dependencies at sync time, giving LLM agents knowledge of libraries they lack training data for
type: claim
evidence: strong
source: "[[keynote-elixirs-ai-future-chris-mccord-elixirconf-us-2025]]"
created: 2026-02-28
---

# aggregating-dependency-agentsmd-files-makes-an-llm-an-expert-in-your-full-stack

Zach Daniel (Ash Framework creator) built the `usage-rules` Elixir library to extend [[agentsmd-is-gap-filling-for-llms-not-documentation-for-humans]] to the transitive dependency graph. Library authors add a `AGENTS.md` or equivalent to their repos. Running `mix usage_rules.sync` in a project collects all such files from installed dependencies and aggregates them into the root-level system prompt file.

The result: an LLM agent working on your project automatically has gap-fill knowledge for every library that has provided a rules file -- Ash, Ecto, LiveView, custom libraries, etc. -- without the developer needing to manually curate comprehensive system prompts for each dependency.

## Implications

- **Ecosystem leverage**: quality of agent experience scales with the number of library authors who maintain gap-fill files, creating an ecosystem-level incentive to maintain them
- **Composability**: individual gap-fill files can be maintained and tested by library owners who understand the failure modes better than application developers
- **Discoverability**: the problem of knowing which libraries need gap-filling is solved automatically; `mix usage_rules.sync` discovers what's available

## Relationship to Elixir community strategy

This is a concrete example of the [[llm-fatalism-about-elixir-inverts-the-actual-opportunity]] argument in action: the Elixir community owns the quality of LLM experience with Elixir through maintained gap-fill files, not through lobbying frontier labs to include more Elixir in training data.

---

Topics:
- [[index]]
