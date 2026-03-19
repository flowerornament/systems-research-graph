---
description: Agent architecture, memory systems, tool design, orchestration, context management, evaluation, and business patterns for AI agent systems
type: moc
created: 2026-03-18
---

# agentic-design

Research domain for the design and engineering of AI agent systems. Covers architecture patterns (loops, dispatchers, multi-agent), memory (structured, salience-ranked, vector), tool/capability design (MCP, eval interfaces, trust boundaries), context management (assembly, budgets, handoff), agent identity, reliability engineering, evaluation, and business/adoption patterns.

Cross-cuts [[herald]] (Elixir/OTP agent platform) and bisque/Lobster (persistent Claude Code agents). Claims here are domain-agnostic; implementation-specific claims live in their project topic maps.

## Agent Architecture

### What Agents Are
- [[an-agent-is-just-a-simulated-chat-in-a-loop]] -- the core demystification: tool calls and memory are chat history entries; the model does the rest
- [[otp-solves-the-hard-parts-of-agent-architecture-that-other-ecosystems-are-still-building]] -- state residence, routing, lifecycle cleanup are the hard infrastructure problems; OTP solves them trivially

### Orchestration & Multi-Agent
- [[multi-agent-fan-out-adds-fragility-without-proportional-benefit-at-current-capability-levels]] -- N agents multiply failure modes faster than capability; prefer single main thread at current reliability

### LLM Capability Trajectory
- [[llm-agent-task-length-capacity-is-doubling-every-seven-months]] -- empirical doubling rate constrains which architectural bets are worth making now vs later

## Memory & Context

### Gap-Filling
- [[agentsmd-is-gap-filling-for-llms-not-documentation-for-humans]] -- targets specific failure modes, not comprehensive coverage
- [[aggregating-dependency-agentsmd-files-makes-an-llm-an-expert-in-your-full-stack]] -- transitive gap-fill aggregation gives agents library knowledge without manual curation

### Reliability Techniques
- [[pre-seeding-chat-history-with-agent-promises-reduces-rule-compliance-failures]] -- fabricated prior commitments exploit next-token prediction to improve rule following
- [[rescue-model-forking-corrects-syntax-errors-without-poisoning-main-context]] -- side-model error correction prevents error patterns from propagating through main context

## Tool & Capability Design

### Code as Interface
- [[agent-writes-minimal-programs-to-modify-code-rather-than-rewriting-full-files]] -- minimal change specifications (Lua scripts, edit commands) outperform full-file rewrites

## Language & Agent Interaction

- [[llm-friendly-language-design-reduces-to-readability-not-llm-specific-features]] -- optimizing for LLMs is optimizing for readability; no distinct design goal
- [[llm-fatalism-about-elixir-inverts-the-actual-opportunity]] -- if language is invisible to the LLM, minority ecosystems gain disproportionately
- [[vibe-coding-produces-unauditable-architectural-debt]] -- unaudited generation produces systems no one can safely modify

## Open Questions
- How should persistent agents handle context window pressure? (compaction strategies, what to evict, when)
- What is the right memory architecture? (herald's salience-ranked retrieval vs bisque's hybrid vector+keyword vs knowledge graphs)
- Where do eval-first interfaces (herald's H module) outperform tool-first interfaces (bisque's MCP tools)?
- How should multi-agent coordination work? (bisque's Louie coordinator, herald's single-thread preference, enterprise patterns)
- What verification gates prevent agents from marking tasks complete without actually completing them?
- How should agent identity/personality be separated from capability? (bisque's skins, herald's capability sets)
- What's the right model tiering strategy? (opus/sonnet/haiku by task type -- when does this matter?)
- How does user modeling change agent behavior over time? (bisque's 7-tool user modeling system)
- What enterprise adoption patterns exist? (consulting insights, organizational agent patterns)

## Pending Sources
- herald codebase -- eval-first agent, structured memory, salience system, capability sets, context assembler
- bisque/Lobster codebase -- persistent Claude Code sessions, 7-second rule, stateless dispatch, MCP-everywhere, user modeling
- Agent framework comparisons (langchain, autogen, crew, claude-code internals)
- Research papers on agent architectures (ReAct, chain-of-thought, tool use, multi-agent)

---

Topics:
- [[index]]
