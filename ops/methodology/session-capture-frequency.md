---
description: Session captures fire on every session stop, including very short sessions; 79 captures in 8 hours is normal for an active processing session with frequent context resets
type: methodology
created: 2026-02-28
source: session-mining
---

# High session capture counts are normal and expected

The first full day of active vault use produced 79 session capture commits across ~8 hours of work. Sessions ranged from under 1 minute (the cluster at 02:13-02:16) to over 30 minutes. The stop hook fires on every Claude Code session end, regardless of session length, creating a capture for each context reset.

This means the sessions directory accumulates rapidly. A day of active use easily produces 30-80 sessions depending on how many times context is reset. This is not a malfunction -- it reflects the hook architecture where every session boundary is recorded.

Practical implications:
- The 30-day archive policy will rarely be triggered for date-based archiving since the vault is relatively new. In the steady state, expect 30-100 sessions per week for active users.
- Session captures are mostly operational metadata (vault state counts and recent git activity). They do not contain transcript content useful for methodology mining unless the agent explicitly adds handoff notes.
- The 72-session threshold in the health check (`sessions: 72 unprocessed`) triggers a mining prompt that is worth running periodically but is not urgent -- session data is primarily useful for tracking claim growth trajectory, not for discovering insights.
- To get value from session data, look at claim count trajectories across captures and git log patterns, not at individual session files (which are structurally minimal).
