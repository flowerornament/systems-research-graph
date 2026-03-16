---
description: The vault generator over-expands CLAUDE.md; manual slimming to concise directives with manual/ pointers is required after setup
type: methodology
created: 2026-02-28
source: session-mining
---

# CLAUDE.md must be slimmed after vault generation

The initial vault generation produces a CLAUDE.md that fully expands all feature blocks at maximum verbosity. This creates a file that is too large for efficient use as a context document. In the first session arc (2026-02-27), the generated CLAUDE.md was 61.5k characters and was slimmed 78% to 13.5k characters.

The slimming principle: keep full text for philosophy, discovery-first design, guardrails, pipeline compliance, self-improvement, and the operational learning loop -- these are behavioral directives that must be present verbatim. Condense everything else (session rhythm, atomic claims, wiki-links, topic maps, processing pipeline, schema, maintenance) to concise summaries with pointers to the relevant manual/ page. Remove detailed examples, JSON schemas, taxonomy tables, and graph analysis scripts entirely -- these live in manual/ and ops/queries/.

After running `/arscontexta:setup` or `/arscontexta:reseed`, check CLAUDE.md size. If it exceeds ~15k characters, it needs slimming. The content already exists in manual/ -- CLAUDE.md should be the index to that content, not a copy of it. A bloated CLAUDE.md wastes context budget on every session without adding behavioral value.
