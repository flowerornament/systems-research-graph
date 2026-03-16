---
description: Claims are typically updated 2-5 times across a session as context and connections accumulate; this is correct behavior, not rework
type: methodology
created: 2026-02-28
source: session-mining
---

# Claim refinement across a session is expected, not a sign of error

Examining the git log across 72 sessions shows that individual claims are frequently updated multiple times -- often 3-5 times -- within a single extended session arc. For example, `compile-and-swap-preserves-audio-continuity-during-recompilation` was updated 5 times across sessions, `the-guardedness-condition-on-recursive-definitions...` was updated at least 4 times.

This is correct behavior, not wasted effort or proof that the initial extraction was poor. Claims grow in precision as:
- Connections to other claims reveal overlaps or tensions that sharpen the proposition
- Later sources provide stronger or contradicting evidence
- Topic map integration reveals where a claim needs to be more specific to fit cleanly

The practical implication: do not expect a claim to be "done" after initial extraction. The first pass captures the core proposition; subsequent passes add connections, refine the description, update evidence ratings, and tighten the title. The claim is done when it passes the composability test (standalone, specific, cleanly linkable) -- which may take multiple sessions for complex cross-disciplinary claims.

Topic map files (like `language-design`, `audio-dsp`, `concurrent-systems`) also see repeated updates as claims are added and their context entries are refined. This is the normal maintenance overhead of a growing graph.
