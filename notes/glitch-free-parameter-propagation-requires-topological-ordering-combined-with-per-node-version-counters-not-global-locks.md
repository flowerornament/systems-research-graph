---
description: REScala proves glitch-freedom without global locks by combining topological propagation order with per-node version counters that detect and resolve transient inconsistencies locally
type: property
evidence: strong
source: [[pl-research-landscape-2026-02-27]]
created: 2026-03-01
status: active
---

# glitch-free parameter propagation requires topological ordering combined with per-node version counters not global locks

A "glitch" in reactive propagation is a transient inconsistency: if node A depends on nodes B and C, and both B and C change simultaneously, A might briefly observe the new B with the old C before both updates propagate. In audio, a glitch is an audible artifact -- a click, pop, or momentary wrong value resulting from an inconsistent intermediate state being rendered to the DAC.

REScala (Drechsler et al. OOPSLA 2018) proves that glitch-free reactive propagation is achievable without global locks, using two mechanisms: (1) topological ordering of propagation -- updates propagate from sources to sinks in topological order, so A never sees B's update before C's if both are topological predecessors of A; (2) per-node version counters -- each node tracks the version of each of its inputs, detecting when it has seen only part of a simultaneous update and deferring evaluation until all updates arrive.

Murail's audio graph requires glitch-freedom at every parameter-change event. The topological ordering that REScala computes for propagation is the same topological ordering that the audio scheduler computes for node execution (D11). This is not coincidental -- both are computing the evaluation order that respects data dependencies. REScala proves that this ordering, combined with lightweight per-node versioning, achieves glitch-freedom without the global locks that would violate RT-safety (D53).

The connection to D60 (determinism profiles) is direct. REScala's glitch-freedom guarantee maps to "no audible artifacts during parameter changes" in Murail -- the Strict determinism profile requires that simultaneous parameter updates produce the same audio result as sequential updates in a fixed order. Per-node version counters provide exactly this: simultaneous updates produce the same topologically-ordered propagation as sequential updates.

This extends the existing analysis of lock-free communication (D13) beyond the SPSC queue between RT and NRT threads to the parameter propagation problem within the audio graph. Lock-free queue delivery is necessary but not sufficient for glitch-freedom; the propagation ordering is the additional requirement.

Connects to [[hold-slots-prevent-fast-thread-blocking-on-slow-rate-values-without-locks]] -- both address lock-free parameter delivery, but hold slots address the rate-crossing (control to audio) while this claim addresses the topology-ordering requirement within a single rate level. See [[the-causality-condition-requires-every-dependency-cycle-to-contain-a-delay-edge]] -- the causality condition that makes the graph a DAG (for instantaneous dependencies) is the prerequisite for the topological ordering that glitch-freedom requires. Also connects to [[murails-rate-inference-is-a-monotone-propagator-network-and-therefore-converges-to-a-unique-fixpoint]]: convergence and glitch-freedom are both consequences of the lattice-theoretic structure.

---

Topics:
- [[audio-dsp]]
- [[concurrent-systems]]
- [[formal-methods]]
