---
batch: 2026-02-06-fmVdfQNPzkE
date: 2026-02-28
source: /Users/morgan/code/murail/.design/references/transcripts/archive/2026-02-06-fmVdfQNPzkE.md
claims_created: 5
enrichments: 1
connections_added: 8
topic_maps_updated: 2
---

# Batch Summary: 2026-02-06-fmVdfQNPzkE

**Source:** "SuperCollider Behind The Scene" — James McCartney at Codefest 2021 (University of Torino)
**Duration:** 1:22:16
**Processed:** 2026-02-28

## Extraction Notes

This source had significant overlap with prior batches (2026-02-06-qmayIRViJms and mccartney-ideas-2026-02-15), which already captured SuperCollider version history, Pyrite, the client-server architecture, universal auto-mapping, lossless undo, compile-and-swap, and UGen elimination. Selectivity gate applied: only genuinely new content extracted.

## Claims Created

1. [[2026-02-06-fmVdfQNPzkE]] — Source reference file with full topic index
2. [[sapf-append-only-execution-log-provides-ten-year-session-provenance]] — SAPF's log as cross-session provenance mechanism distinct from undo/redo
3. [[sapf-was-factored-into-an-embeddable-c-library-by-replacing-the-parser-with-c-functions]] — existence proof for murail's embeddability goal
4. [[supercollider-3d5-applied-signal-graphs-to-pixel-synthesis-demonstrating-graph-generality-beyond-audio]] — intermediate SC version demonstrating domain-agnostic signal graph
5. [[concatenative-postfix-readability-breaks-when-argument-role-is-ambiguous]] — fundamental readability problem in postfix languages and McCartney's pipeline-style fix
6. [[lazy-infinite-lists-enable-sample-level-access-and-sonic-composting-in-signal-graph-languages]] — lazy list model enabling sample-level composition and sonic composting pattern

## Enrichments Applied

- [[universal-auto-mapping-eliminates-explicit-iteration-from-signal-processing-programs]] — Added live demo context from 2021 Codefest and connection to concatenative readability claim

## Backward Connections Added

- [[persistent-data-structures-make-lossless-undo-an-architectural-side-effect]] — linked to sapf-append-only-execution-log claim distinguishing undo vs. cross-session log
- [[supercollider-version-2-used-a-smalltalk-inspired-language-without-client-server-separation]] — linked to SC3D5 pixel synthesis claim filling in intermediate version
- [[library-languages-must-not-bundle-a-mandatory-runtime]] — linked to sapf-c-library claim as existence proof

## Topic Maps Updated

- [[language-design]] — Added "SAPF Language Design (2021 Codefest)" section with 3 new claims
- [[audio-dsp]] — Added 3 new claims to "Workflow and Embeddability" section
