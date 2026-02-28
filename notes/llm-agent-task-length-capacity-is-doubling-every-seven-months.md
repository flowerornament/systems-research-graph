---
description: Empirical trajectory claim: agent task-completion duration without derailing doubles every ~7 months, with direct implications for architecture investment decisions
type: claim
evidence: moderate
source: "[[keynote-elixirs-ai-future-chris-mccord-elixirconf-us-2025]]"
created: 2026-02-28
---

# llm-agent-task-length-capacity-is-doubling-every-seven-months

McCord cites a published paper (unattributed in transcript) showing that the duration of tasks agents can complete without going off the rails doubles approximately every seven months. This is a Moores-Law-style empirical trajectory claim, not a theoretical bound.

The implication is not just "agents get better" but that specific architectural decisions have different payoffs depending on whether you expect the trajectory to hold:
- **Context window compaction** -- if context length capacity is growing fast, heavy investment in custom compaction logic risks being overtaken by native model improvements
- **Multi-agent fan-out** -- if single-thread capacity is doubling every 7 months, the parallelism case weakens proportionally (see [[multi-agent-fan-out-adds-fragility-without-proportional-benefit-at-current-capability-levels]])
- **Gap-fill files** -- if models are improving their Elixir knowledge faster than the AgentsMD file is maintained, the value of extensive gap-filling decreases; but gap-fills for new-to-training-set patterns (like Phoenix layout changes) will remain valuable longer

## Epistemic Note

The source is a keynote talk, not a research presentation. The paper citation is second-hand and unverified. Treat as "strong enough to inform architecture decisions, weak enough to verify before staking the whole approach on."

---

Topics:
- [[index]]
