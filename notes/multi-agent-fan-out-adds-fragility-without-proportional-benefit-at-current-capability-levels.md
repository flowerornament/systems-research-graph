---
description: Spawning many sub-agents to parallelize work multiplies failure modes faster than it multiplies capability at current LLM reliability levels
type: claim
evidence: moderate
source: "[[keynote-elixirs-ai-future-chris-mccord-elixirconf-us-2025]]"
created: 2026-02-28
---

# multi-agent-fan-out-adds-fragility-without-proportional-benefit-at-current-capability-levels

The appealing vision -- a main agent thread spawning dozens of sub-agents that fan out, complete parallel work, and recombine -- runs into reliability realities. Each agent fork is an opportunity for a model error, a provider failure (occasional 200 OK with empty body), or an unexpected edge case. Merging N parallel threads requires all N to succeed; failure handling and result reconciliation add significant complexity.

Additional pressure from capability improvement velocity: a highly optimized N-agent architecture designed for cost-efficiency today may be worse than a single-call to a better model in six months. Frontier model capability is improving fast enough that architectural complexity can be rendered obsolete before it ships.

McCord's recommendation: stay within the single main thread plus one-level-deep sub-agent (for tasks like rescue model error correction -- see [[rescue-model-forking-corrects-syntax-errors-without-poisoning-main-context]]). Even Claude Code -- built by Anthropic, the company most invested in multi-agent architectures -- uses one main thread.

## Relationship to LLM Trajectory

This is directly connected to [[llm-agent-task-length-capacity-is-doubling-every-seven-months]]. If the single-thread agent can stay on task for twice as long every seven months, the case for fan-out complexity weakens further: the task that required parallelism today may be completable in a single thread soon.

---

Topics:
- [[index]]
