---
description: The topics frontmatter field was specified but never adopted; wiki-links from topic maps serve the same purpose and are sufficient for navigation
type: methodology
created: 2026-02-28
source: session-mining
---

# The topics frontmatter field is redundant with wiki-links; skip it

The health report after 248 claims showed 240/252 (95%) were missing the `topics` field. This is not a schema violation that needs fixing -- it reflects that the field is redundant with the wiki-link graph.

Topic map membership is already expressed through wiki-links: the topic map file links to the claim with a context phrase, and the claim links back to the topic map. This bidirectional link structure fully captures membership without needing a separate frontmatter field. A future agent can find all claims in a topic map by reading the topic map file or by searching for backlinks.

The `topics` field was included in the schema template as a machine-readable index of topic membership, but in practice the wiki-link graph provides this information more richly (with context phrases) and the field was never populated systematically. Do not add `topics` fields to new claims. Do not run batch operations to backfill it. If the health check reports this as a warning, note the field as deprecated-in-practice and treat the warning as expected.

The fields that do matter and must be present: `description` (required, adds information beyond title), `type` (when classification helps query patterns), `evidence` (when source quality is relevant), `source` (wiki link to source reference), `created` (ISO date).
