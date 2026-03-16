---
description: State residence, request routing, and lifecycle cleanup -- the unsolved problems of agent frameworks -- are trivially solved by OTP GenServers
type: claim
evidence: strong
source: "[[keynote-elixirs-ai-future-chris-mccord-elixirconf-us-2025]]"
created: 2026-02-28
---

# otp-solves-the-hard-parts-of-agent-architecture-that-other-ecosystems-are-still-building

The implementation of an agent loop is simple. The hard parts are organizational: where does the agent's state live in the cluster? How does an incoming request route to the process that holds that state? How is state cleaned up when a session ends? Every ecosystem building agent frameworks must answer these questions.

OTP answers them already:
- **State residence**: the chat history lives in GenServer state -- a map field
- **Routing**: the registry dispatches to the process by session ID; no separate routing infrastructure
- **Cleanup**: when the GenServer stops (normal or crash), state disappears automatically; no TTL-setting, no Redis eviction policies, no background garbage collectors

McCord's contrast case: other ecosystems' "obvious" solutions -- Redis for temporary state, a routing tier that knows which server has the session in memory, periodic garbage collection -- each require standing up additional infrastructure that Elixir simply does not need.

## Historical Pattern

This is the third time this pattern has occurred with Elixir/OTP: the platform solved a class of distributed systems problems before the problem became mainstream.
1. WebSockets scaling (2014 Phoenix Channels) -- CloudFlare claimed to solve the same problem in 2024
2. Real-time presence (2016 Phoenix Presence) -- still unusual in other frameworks a decade later
3. Agent state/lifecycle management (present) -- other ecosystems are still working out the architecture

This extends [[erlang-actor-model-enables-safe-process-kill]] from the concurrency safety domain to the agent orchestration domain.

---

Topics:
- [[index]]
