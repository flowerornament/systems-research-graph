---
description: Processing many sources in a single session by first generating all summaries in ops/queue/, then extracting claims in sequence, outperforms interleaved approaches
type: methodology
created: 2026-02-28
source: session-mining
---

# Batch extraction: summarize first, extract second

When processing a large backlog of sources, the effective pattern is two-phase: generate all summaries in `ops/queue/` first across the full batch, then run extraction on each summary in sequence. This was the approach that produced 160+ claims from 18 sources in a single extended session arc (2026-02-28, approximately 01:00-02:15).

The queue state in `ops/queue/queue.json` tracks which sources are pending, in-progress, and complete. Each source gets a summary file in `ops/queue/` (e.g., `ops/queue/naur-1985-001.md` through `naur-1985-006.md`) before any claims are extracted. Once all summaries exist, the extraction phase can proceed without re-reading the original sources.

This pattern matters because summarization and extraction are cognitively distinct tasks. Mixing them -- extract source A, then source B, then connect, then extract source C -- creates context-switching overhead and risks losing threading across a large source set. Generating all summaries first also makes the total work visible before committing to extraction, allowing selective processing if session time is limited.

The archive in `ops/queue/archive/` shows processed batches by date, which provides a durable record of what has been extracted and prevents re-processing.
