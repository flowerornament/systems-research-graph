---
description: AgentsMD targets specific LLM failure modes discovered empirically, not comprehensive coverage; it supplements model world knowledge without replacing human-facing docs
type: claim
evidence: strong
source: "[[keynote-elixirs-ai-future-chris-mccord-elixirconf-us-2025]]"
created: 2026-02-28
---

# agentsmd-is-gap-filling-for-llms-not-documentation-for-humans

AgentsMD (and CLAUDE.md / system prompt equivalents) is not documentation. It is a targeted patch file for the specific places where frontier models produce wrong output when working with a codebase. McCord's process: generate 100 applications, observe where the model makes dumb decisions, add the rule to the system prompt. The result (~300 lines) covers:
- List index-based access in Elixir (models trained on Python/JS will reach for `list[i]`)
- `elsif` vs `cond` in HEEx templates
- New Phoenix layout patterns not yet in training data
- Any other specific, observable failure modes

The file is for LLMs, not for humans. The comprehensive human docs are the actual documentation. The gap-fill file is a compact set of overrides for known model weaknesses.

## Design principle

This is a specific application of a general principle: **lean on model world-knowledge for everything it knows; only add instructions for what it consistently gets wrong**. Adding comprehensive documentation that the model already knows wastes context and adds noise. The value is in the targeted fix, not the coverage.

## Maintenance implication

Gap-fill files require active maintenance -- they encode the model's failure modes as of the time of writing. As models improve (see [[llm-agent-task-length-capacity-is-doubling-every-seven-months]]), some entries become unnecessary. But entries for genuinely new patterns (anything post-training-cutoff) remain valuable indefinitely.

## Relationship to dependency gap-filling

[[aggregating-dependency-agentsmd-files-makes-an-llm-an-expert-in-your-full-stack]] extends this pattern to transitive dependencies, allowing library authors to maintain their own gap-fill files that compose into a project-level file.

---

Topics:
- [[index]]
