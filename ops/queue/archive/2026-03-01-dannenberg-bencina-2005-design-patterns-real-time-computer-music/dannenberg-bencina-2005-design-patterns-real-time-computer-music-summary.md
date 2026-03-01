---
batch: dannenberg-bencina-2005-design-patterns-real-time-computer-music
date: 2026-03-01
status: complete
---

# Batch Summary: dannenberg-bencina-2005-design-patterns-real-time-computer-music

## Source

- **File**: `dannenberg-bencina-2005-design-patterns-real-time-computer-music.pdf`
- **Archive location**: `inbox/archive/dannenberg-bencina-2005-design-patterns-real-time-computer-music/`
- **Authors**: Roger B. Dannenberg and Ross Bencina
- **Venue**: ICMC 2005 Workshop on Real Time Systems Concepts for Computer Music, 4 September 2005

## Extraction Results

- **Claims created**: 7
- **Source reference note**: 1
- **Enrichments applied**: 3 (block-size, all-murail-program-state, compile-and-swap updated with back-links)
- **Connections added**: 26 (forward links from new claims; 3 backward links in existing claims)
- **Topic maps updated**: 2 (audio-dsp, concurrent-systems)

## Claims Created

1. [[thread-count-minimization-reduces-coordination-cost-but-requires-latency-partitioning-to-assign-tasks-to-threads]] -- the Static Priority Scheduling pattern; formal rationale for murail's binary fast/NRT split
2. [[audio-system-os-calls-violate-real-time-constraints-through-unpredictable-lock-acquisition-and-page-faults]] -- foundational rationale for the RT resource invariant: lock acquisition, priority inversion, page faults
3. [[real-time-safe-memory-strategies-form-a-spectrum-from-up-front-fixed-allocation-to-incremental-gc]] -- five RT memory strategies from preallocated free lists to incremental GC; murail uses strategy 1 at whole-program level
4. [[lock-free-queues-are-the-canonical-communication-primitive-between-real-time-and-non-real-time-threads]] -- the applied motivation for lock-free communication; five production systems as convergent evidence
5. [[ideal-time-scheduling-anchors-event-sequences-to-desired-times-rather-than-actual-execution-times]] -- prevents timing error accumulation by tracking ideal rather than actual wake-up times
6. [[pre-computed-event-buffers-with-constant-time-offset-trade-added-latency-for-reduced-jitter]] -- latency/jitter tradeoff; block rendering is this pattern at sample granularity
7. [[caching-ugen-graph-evaluation-order-decouples-topology-modification-from-concurrent-execution]] -- Synchronous Dataflow Graph pattern; the structural basis for compile-and-swap

## Source Reference

- [[dannenberg-bencina-2005-design-patterns-real-time-computer-music]]

## Existing Claims Enriched

- [[block-size-is-the-primary-latency-throughput-tradeoff-in-murail-execution]] -- added back-link to pre-computed-event-buffers naming block rendering as an instance of the event buffer pattern
- [[all-murail-program-state-fits-in-a-single-pre-allocated-contiguous-region]] -- added back-links to os-calls and memory-strategies providing foundational rationale for the pre-allocation axiom
- [[compile-and-swap-preserves-audio-continuity-during-recompilation]] -- added sentence connecting compile-and-swap to the cached-evaluation-order variant of the Synchronous Dataflow Graph pattern

## Context Notes

This paper is foundational practitioner literature for the RT audio design space. Most of its patterns are now established practice, but it provides authoritative provenance for:

1. **The name and structure** of patterns that existing claims (hold-slots, static-thread-pool, inference-violations) implement without naming their pattern-level context.

2. **The RT resource invariant rationale**: [[audio-system-os-calls-violate-real-time-constraints-through-unpredictable-lock-acquisition-and-page-faults]] provides the exact mechanism (lock acquisition, priority inversion, page faults) that [[all-murail-program-state-fits-in-a-single-pre-allocated-contiguous-region]] and Axiom 12.2 forbid. The existing graph had the conclusion (pre-allocate everything) without the precise mechanism.

3. **The synthesis graph / compile-and-swap connection**: [[caching-ugen-graph-evaluation-order-decouples-topology-modification-from-concurrent-execution]] formally names the pattern that compile-and-swap implements. The existing compile-and-swap claim described the mechanism but not its pattern-level name.

4. **The timing accuracy stack**: Ideal-time scheduling and event buffers form the temporal precision architecture. Block-based rendering is event buffering at sample granularity — this connection was not previously named in the graph.

Key gap resolved: the concurrent-systems topic map now has a "RT Memory and Communication Primitives" section grounding the resource invariant in applied practitioner literature, not just the formal substrate spec.
