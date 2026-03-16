---
description: The critical set (backward closure of outputs under instantaneous dependencies) is never shed; non-critical equations may hold their last value under deadline pressure, providing graceful degradation
type: property
evidence: strong
source: [[murail-substrate-v3]]
created: 2026-02-28
status: active
---

# load shedding preserves the critical set exactly while degrading non-critical equations

When the tick function overruns its deadline, the substrate provides load shedding as the degradation mechanism. Rather than dropping output frames, it skips evaluation of low-priority equations. The structural guarantee:

**The critical set C** is the backward closure of the output equations under instantaneous dependencies:
`C = π_out ∪ {n | ∃ m ∈ C : n ∈ deps(m) ∩ E_inst}`

Equations in C are never shed. This means the output equations and all their instantaneous dependencies always produce their correct values, regardless of load. Only equations outside C may be shed.

**What shedding means.** When an equation is shed, its evaluation is skipped and its state holds the last computed value. Ring buffer heads still advance; the held value is copied forward to maintain valid `@d` reads across skip boundaries. Recovery is rate-limited: at most k_resume equations resume per tick to prevent recovery-induced overrun.

**Determinism under shedding is lost.** This is the key consequence: Theorem 7.2 (determinism) holds for the unshed performance, but a degraded performance is not deterministic in general. Two runs of the same program with the same inputs may produce different degraded performances because shedding decisions depend on runtime timing. The substrate guarantees only that (a) the critical set is never degraded and (b) each shed equation holds a value that was correct at some prior tick.

The shedding class system (`never`, `may`, `eager`) allows programmers to influence shedding priority. A shedding policy equation -- itself an equation at slow rate -- receives timing data and adjusts priorities dynamically. The substrate provides the mechanism; the domain configures the policy.

## Connections

- Shedding is governed by the output continuity axiom ([[the-murail-fast-thread-never-halts-errors-degrade-quality-but-do-not-stop-evaluation]]): the fast thread never stops, but it may produce degraded output
- The shedding class `never` is automatic for the critical set; this connects to the DAG structure established by [[the-causality-condition-requires-every-dependency-cycle-to-contain-a-delay-edge]] which makes the backward closure well-defined
- The loss of determinism under shedding is a direct consequence of the tradeoff in [[the-murail-fast-thread-never-halts-errors-degrade-quality-but-do-not-stop-evaluation]]: maintaining output takes priority over maintaining determinism
