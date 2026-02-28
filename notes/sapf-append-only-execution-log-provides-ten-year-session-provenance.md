---
description: SAPF writes every executed expression to an append-only log file, giving McCartney a 10-year, 151k-line record of every sound he ever made and the code that produced it
type: claim
evidence: strong
source: [[2026-02-06-fmVdfQNPzkE]]
created: 2026-02-28
status: active
---

# SAPF append-only execution log provides ten-year session provenance

SAPF automatically logs every expression McCartney executes to an append-only log file. His log covers 10 years of work: 151,000 lines, 5.1 megabytes. He can look up any date, see what code he was running, and play it back. No session is ever lost.

This is architecturally distinct from undo/redo (see [[persistent-data-structures-make-lossless-undo-an-architectural-side-effect]]). Undo is navigating a branching history within a session. The execution log is an external append-only record that survives across sessions, machine restarts, and years. Undo gives you the last hour; the log gives you the last decade.

The log stores only executed expressions, not intermediate typing. Each entry is a complete, syntactically valid expression that produced audio. This means the log is not a keystroke record but a semantic record: every entry is replayable.

The consequence: exploration has no permanent cost. McCartney describes an ideal of being able to "manipulate audio as directly as possible, getting results as fast as possible." The execution log means every discarded idea is recoverable -- not just in principle but in practice, because the log entry IS the code.

This pattern is directly relevant to any interactive audio system: the question is not just how to undo, but how to preserve provenance across sessions. Undo is session-scoped; a log is workspace-scoped. They serve different recovery needs: undo recovers from mistakes in the last few minutes; the log recovers creative directions abandoned weeks ago.

**Murail implication:** Murail's current design separates compilation from execution. Each compile-and-swap preserves audio continuity but discards the prior graph definition (see [[compile-and-swap-preserves-audio-continuity-during-recompilation]]). An execution log at the composition language level -- recording every submitted expression that produced a valid graph -- would extend this to cross-session provenance. This is an editor feature, not a runtime feature. But the runtime must expose enough information (which graph was active when) for the log to be meaningful.

Connects to [[persistent-data-structures-make-lossless-undo-an-architectural-side-effect]] -- the two mechanisms compose: undo/redo for within-session navigation, append-only log for cross-session retrieval. Together they cover the full temporal range of a creative practice.
