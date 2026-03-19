---
description: Agent architecture, LLM integration, Elixir/OTP fitness for the agentic era, and herald-specific design research
type: moc
created: 2026-02-28
---

# herald

Research area for herald: a real-time application platform built on Elixir/OTP. Covers agent architecture design, LLM integration patterns, OTP fitness for agentic workloads, and implementation techniques.

## Key Sub-Areas
- Agent architecture (what agents actually are, OTP as agent infrastructure) -- see also [[agentic-design]] for domain-agnostic agent claims
- LLM capability trajectory (what assumptions are safe to build on)
- Gap-fill strategies (AgentsMD, usage-rules, dependency-level gap-filling)
- Agent reliability techniques (chat history manipulation, rescue models, self-modifying code)
- Herald product design (tbd)

## Core Architecture Claims

### What Agents Are
- [[an-agent-is-just-a-simulated-chat-in-a-loop]] -- demystification: tool calls, memory, and state are all entries in a managed chat history; the model does the rest
- [[otp-solves-the-hard-parts-of-agent-architecture-that-other-ecosystems-are-still-building]] -- state residence, routing, and lifecycle cleanup already solved by OTP; Elixir leapfrogs other ecosystems on infrastructure

### Architecture Constraints
- [[multi-agent-fan-out-adds-fragility-without-proportional-benefit-at-current-capability-levels]] -- N agents multiply failure modes faster than they multiply capability; prefer single main thread at current reliability levels

## LLM Capability Trajectory

- [[llm-agent-task-length-capacity-is-doubling-every-seven-months]] -- empirical trajectory with direct implications for which architectural bets are worth making
- [[llm-fatalism-about-elixir-inverts-the-actual-opportunity]] -- if language doesn't matter to LLMs, the frustration gap disappears and minority ecosystems gain disproportionately

## Gap-Filling Strategy

- [[agentsmd-is-gap-filling-for-llms-not-documentation-for-humans]] -- targets specific failure modes empirically, not comprehensive coverage; for LLMs, not developers
- [[aggregating-dependency-agentsmd-files-makes-an-llm-an-expert-in-your-full-stack]] -- usage-rules collects transitive dependency gap-fill files, giving agents knowledge of libraries without manual curation

## Agent Reliability Techniques

- [[pre-seeding-chat-history-with-agent-promises-reduces-rule-compliance-failures]] -- inject fabricated prior commitments to reduce rule-following failures
- [[rescue-model-forking-corrects-syntax-errors-without-poisoning-main-context]] -- route errors to a fast side-model, rewrite main history to show success
- [[agent-writes-minimal-programs-to-modify-code-rather-than-rewriting-full-files]] -- Lua scripts as minimal change specifications; code that writes code

## Open Questions
- What does herald's own AgentsMD look like? What are the specific failure modes for herald's patterns?
- How should herald's GenServer agent loop handle context window pressure and compaction?
- Does herald's architecture benefit from any multi-agent patterns (e.g., specialist agents per domain), or does single-thread simplicity dominate at this capability level?
- What is the herald-specific answer to routing: how does a herald application route an incoming trigger to the right agent process?

## Source References
- [[keynote-elixirs-ai-future-chris-mccord-elixirconf-us-2025]] -- Chris McCord, ElixirConf US 2025: Elixir's fitness for the agentic era, agent architecture, Phoenix 1.8 AgentsMD, implementation techniques

---

Topics:
- [[index]]
