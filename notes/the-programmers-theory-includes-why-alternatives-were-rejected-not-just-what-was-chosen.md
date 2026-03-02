---
description: The theory held by a programmer contains the design space explored and rejected paths, not only the chosen solution; this negative knowledge cannot be recovered from source text
type: claim
evidence: strong
source: [[naur-1985-programming-as-theory-building]]
created: 2026-02-28
status: active
---

# the programmer's theory includes why alternatives were rejected not just what was chosen

Naur identifies a specific class of tacit knowledge that cannot survive team turnover: the knowledge of what was *not* done and why. A programmer holding the theory knows "we tried a lock-based queue here and it deadlocked under load, so the lock-free ring buffer is non-negotiable." The source text shows the ring buffer. It does not show the lock-based queue that was tried and discarded.

This negative knowledge matters because:

1. **It prevents reinvention of rejected solutions.** When a newcomer reads the code and finds the ring buffer "unnecessarily complex," they are missing the context for why the simpler approach was rejected. They may simplify it, reintroduce the deadlock, and debug the same problem the original team already solved.

2. **It constrains the design space for new requirements.** A new requirement that looks like it could be solved by "just adding a mutex" may be impossible to add without violating a constraint the original team knew. Without the theory, the newcomer does not know which constraints are load-bearing.

3. **It holds the cost model.** Why is this function 40 lines instead of 10? The theory might hold: "the 10-line version has O(n²) behavior in the pathological case we hit in production." The source text shows 40 lines with a comment saying "handles pathological case." Whether that comment is sufficient depends on whether the reader understands what kind of pathological case warrants 40 lines.

For murail: this is the direct motivation for ops/derivation.md and per-decision rationale in ops/observations/. The derivation file attempts to capture rejected paths, not just chosen ones. Every "we could have done X but..." entry in a session handoff is an answer to Naur's problem.

This claim extends [[programming-is-theory-building-not-text-production]] with a specific anatomy of what the theory contains. It connects to [[program-revival-by-newcomers-systematically-produces-degraded-designs]] as the mechanism: without rejected-alternative knowledge, revivals systematically re-explore known-bad paths.

See [[evolvability-requires-trading-provability-for-extensibility]]: the tradeoffs Sussman describes (correctness vs. extensibility) are themselves examples of rejected alternatives -- the design space that was considered. Naur's point is that knowing the tradeoff was considered matters for evolution.
