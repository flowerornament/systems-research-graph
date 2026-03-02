---
description: Connecting each claim to at least one topic map immediately after extraction prevents orphan accumulation; the health report confirmed 0 orphans at 248 claims
type: methodology
created: 2026-02-28
source: session-mining
---

# Connect claims to topic maps during extraction, not as a separate pass

The health report after the first day of vault use showed 0 orphan claims across 248 notes. This result came from consistently linking each extracted claim to at least one topic map during the extract phase, not deferring connection as a separate pass.

The discipline: when writing a claim file, always include at least one wiki-link to a topic map, and always add the claim (with a context phrase) to that topic map. The wiki-link creates the connection; without it, the claim is invisible to agents navigating via topic maps. A claim that exists in notes/ but is not linked from any topic map is structurally dead -- it will never be discovered through navigation.

For cross-disciplinary claims (the most valuable kind), linking to multiple topic maps is correct and expected. The `dsp-and-ml-are-structurally-identical-under-shape-driven-dispatch-in-the-murail-calculus` claim appropriately links to both `formal-methods` and `ai-ml` topic maps.

The health check's orphan detection validates this discipline. A non-zero orphan count after any extraction session indicates that the connect phase was skipped or incomplete. If orphans appear, running `/arscontexta:reweave` or manually adding topic map links is the correct remediation -- not adding backlinks from other individual claims (which does not satisfy the topic map navigation requirement).
