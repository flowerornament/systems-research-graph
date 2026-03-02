---
description: Because provenance tracks which premises caused a contradiction, the system can eliminate the guilty premise and prune all its consequences without rewinding chronologically
type: claim
evidence: strong
source: [[we-dont-know-how-to-compute-sussman-2011]]
created: 2026-02-28
status: active
---

# dependency-directed backtracking prunes search using provenance rather than recency

In chronological backtracking (the default in logic programming and the sequence monad with failure), when a contradiction is discovered, the system undoes the most recent choice and tries the next alternative. The problem: the most recent choice may have nothing to do with the contradiction, while the actual culprit was a much earlier decision. Chronological backtracking may redo thousands of computations that were perfectly valid.

Dependency-directed backtracking (Stallman/Sussman) uses the provenance tracking from [[truth-maintenance-systems-enable-locally-consistent-reasoning-in-an-inconsistent-knowledge-base]] to identify *which premise caused the contradiction*. The system then jumps directly to that premise, eliminates it, and prunes all conclusions that depended on it -- without undoing anything that didn't depend on the bad premise.

Sussman gives the five-floor puzzle (Baker, Cooper, Fletcher, Miller, Smith on five floors with adjacency and ordering constraints): chronological backtracking would require ~3,000 backtracks. Dependency-directed backtracking reduces this substantially because each contradiction pinpoints exactly which constraint was violated, pruning the relevant subtree.

Key property: computations that are still valid (not in the dependency chain of the contradiction) are never redone. This makes the approach efficient even for a parallel machine where many computations have already been committed.

For murail: if the graph compiler performs constraint-based layout (e.g., scheduling UGen nodes with real-time deadline constraints), dependency-directed backtracking is a more efficient search strategy than chronological alternatives when a schedule constraint is violated.
