---
batch: mccartney-1996-supercollider-icmc
date: 2026-03-01
source: inbox/archive/mccartney-1996-supercollider-icmc/mccartney-1996-supercollider-icmc.md
status: complete
---

# Batch Summary: mccartney-1996-supercollider-icmc

**Source:** McCartney, James. "SuperCollider: A New Real Time Synthesis Language." ICMC, 1996. https://www.audiosynth.com/icmc96paper.html

## Statistics

- Claims extracted: 5
- Source reference created: 1
- Existing claims enriched: 5 (backlinks added)
- Topic maps updated: 3 (audio-dsp, language-design, mccartney-language-design)
- Connections added: ~22
- All verify checks: PASS (zero dangling links)

## Claims Created

- [[signal-buffers-as-a-type-amortize-interpreter-overhead-making-high-level-languages-viable-for-real-time-dsp]]
- [[closures-encapsulate-unit-generator-state-making-ugen-creation-a-function-call-not-a-class-definition]]
- [[real-time-incremental-garbage-collection-eliminates-static-voice-count-limits-in-synthesis-engines]]
- [[scripting-and-synthesis-in-the-same-language-eliminates-the-boundary-between-composition-and-sound-design]]
- [[synthesis-function-specialization-by-input-rate-multiplies-performance-without-multiplying-algorithm-complexity]]
- [[mccartney-1996-supercollider-icmc]] (source reference)

## Existing Claims Enriched

- [[block-size-is-the-primary-latency-throughput-tradeoff-in-murail-execution]] -- added connection to signal-buffer amortization as foundational precedent
- [[eliminating-unit-generators-exposes-synthesis-graphs-to-cross-boundary-compiler-optimization]] -- added closure opacity as the mechanism being replaced
- [[synthesis-graph-construction-is-a-regular-program-not-a-domain-specific-declaration]] -- added SC1 closure UGens as origin of the "UGen = function call" design principle
- [[construction-time-graph-optimization-distributes-compiler-cost-across-node-creation]] -- added rate specialization as the manual precursor to automatic rate inference
- [[supercollider-client-server-architecture-moved-the-scripting-language-out-of-the-real-time-audio-thread]] -- added that GC migration was also resolved by the client-server split
- [[supercollider-version-1-merged-a-scripting-language-with-a-software-synthesizer-when-hardware-reached-real-time-speed]] -- added reference to 1996 ICMC paper as the published source

## Notable Learnings

- The 1996 ICMC paper is the primary published record of SC1's architecture; prior extractions from McCartney interview transcripts referenced "the ICMC paper" without having processed it. This batch fills that gap.
- The signal-buffer amortization insight from 1996 is directly foundational to murail's block-size decision; the connection was not previously documented.
- The GC -> dynamic voice instantiation -> no static polyphony limit chain is distinct from the GC strategy spectrum claim and needed its own claim.
- The 12-variant specialization pattern (Aoscilia) is the manual precursor of murail's construction-time rate inference; making this connection explicit strengthens the historical justification for murail's rate lattice.
