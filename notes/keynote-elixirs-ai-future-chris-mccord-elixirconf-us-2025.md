---
description: Chris McCord (Phoenix creator) on Elixir's fitness for the agentic era, agent architecture demystified, and agent development techniques
type: source-reference
created: 2026-02-28
---

# keynote-elixirs-ai-future-chris-mccord-elixirconf-us-2025

**Talk:** Keynote: Elixir's AI Future -- Chris McCord | ElixirConf US 2025
**Source:** https://www.youtube.com/watch?v=6fj2u6Vm42E
**Duration:** 1:02:15
**Archive:** /Users/morgan/code/herald/.design/references/transcripts/archive/keynote-elixirs-ai-future-chris-mccord-elixirconf-us-2025.md

## Summary

McCord argues that Elixir and OTP are accidentally the perfect platform for the agentic era: the state management, routing, and cleanup problems every agent framework must solve are already solved by OTP. He demystifies agents (just LLMs in a loop simulating chat), discusses Phoenix 1.8's AgentsMD for LLM gap-filling, and demonstrates concrete agent implementation techniques.

## Claims Extracted

### Agent Architecture
- [[an-agent-is-just-a-simulated-chat-in-a-loop]] -- the core demystification: tool calls, tool results, and memory are all just entries in a managed chat history
- [[otp-solves-the-hard-parts-of-agent-architecture-that-other-ecosystems-are-still-building]] -- routing, state, and lifecycle management already solved by OTP GenServers
- [[multi-agent-fan-out-adds-fragility-without-proportional-benefit-at-current-capability-levels]] -- prefer single main thread agents; fan-out adds failure modes faster than it adds capability

### LLM Capability Trajectory
- [[llm-agent-task-length-capacity-is-doubling-every-seven-months]] -- empirical trajectory with direct implications for what agent architectures are worth investing in
- [[llm-fatalism-about-elixir-inverts-the-actual-opportunity]] -- if language doesn't matter to LLMs then zero-barrier entry to any ecosystem is a net positive for less-popular languages

### AgentsMD and Gap-Filling
- [[agentsmd-is-gap-filling-for-llms-not-documentation-for-humans]] -- targets specific failure modes in frontier models without replacing comprehensive human documentation
- [[aggregating-dependency-agentsmd-files-makes-an-llm-an-expert-in-your-full-stack]] -- usage-rules collects transitive dependency gap-fill files at project sync time

### Agent Reliability Techniques
- [[pre-seeding-chat-history-with-agent-promises-reduces-rule-compliance-failures]] -- having the agent commit to rules before the task starts significantly reduces deviation
- [[rescue-model-forking-corrects-syntax-errors-without-poisoning-main-context]] -- route errors to a fast cheap model, rewrite the agent's memory to show it succeeded, preventing error propagation via next-token prediction
- [[agent-writes-minimal-programs-to-modify-code-rather-than-rewriting-full-files]] -- Lua scripts as minimal change specifications that run 80% reliably, with full-file rewrite fallback

---

Topics:
- [[index]]
