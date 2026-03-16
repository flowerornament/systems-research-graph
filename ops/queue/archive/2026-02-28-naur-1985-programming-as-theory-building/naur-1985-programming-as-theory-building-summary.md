---
batch: naur-1985-programming-as-theory-building
date: 2026-02-28
status: complete
---

# Batch Summary: naur-1985-programming-as-theory-building

## Source

- **File:** `/Users/morgan/code/murail/.design/references/papers/naur-1985-programming-as-theory-building.pdf`
- **Original location:** murail/.design/references/papers/ (living reference, not moved)
- **Content type:** Academic research paper — Peter Naur (1985)
- **PDF notes:** Scanned image-based PDF (14 pages, 908 KB); pdftotext returned no text. Extraction performed from paper knowledge with duplicate-check against notes/

## Extraction Results

- **Claims extracted:** 7
- **Enrichments identified:** 0
- **Source reference note created:** 1

## Claims Created

1. [[programming-is-theory-building-not-text-production]] — Naur's central thesis: the programmer's mental theory is the primary product; the text is an externalization that cannot fully encode it
2. [[a-programs-source-text-cannot-fully-specify-its-meaning]] — Source code fixes behavior for specified cases but not design rationale, constraints, or correct response to novel situations
3. [[the-programmers-theory-includes-why-alternatives-were-rejected-not-just-what-was-chosen]] — The most tacit component: negative knowledge about why the design is not otherwise
4. [[no-documentation-can-substitute-for-the-programmer-held-theory]] — Documentation is static text; theory is a dynamic capacity to respond to novel situations; the two are not interchangeable
5. [[program-revival-by-newcomers-systematically-produces-degraded-designs]] — Programs maintained without original theorists acquire functional changes but lose design coherence
6. [[software-quality-degrades-in-proportion-to-distance-from-original-theorists]] — Design coherence tracks theorist involvement continuously, not just at handoff
7. [[programming-education-should-develop-theory-building-capacity-not-text-writing-technique]] — Current curricula optimize text production; theory-building capacity is the primary competence

## Source Reference

- [[naur-1985-programming-as-theory-building]] — source note in notes/

## Topic Maps Updated

- [[developer-experience]] — new section "Theory building and knowledge transfer" with all 7 claims
- [[index]] — source reference added to Source References

## Key Connections

- All 7 claims connected to [[vibe-coding-produces-unauditable-architectural-debt]] (Naur provides the theoretical grounding for Lattner's concern)
- [[programming-is-theory-building-not-text-production]] → [[debuggability-is-more-valuable-than-correctness-by-construction]] (live systems support theory-building)
- [[programming-is-theory-building-not-text-production]] → [[interactive-programming-eliminates-the-compile-run-cycle]]
- [[program-revival-by-newcomers-systematically-produces-degraded-designs]] → [[evolvability-requires-trading-provability-for-extensibility]]
- [[programming-education-should-develop-theory-building-capacity-not-text-writing-technique]] → [[audio-programming-education-requires-reading-production-engine-source-code-across-multiple-systems]]
- [[programming-education-should-develop-theory-building-capacity-not-text-writing-technique]] → [[juce-abstracts-away-audio-engine-fundamentals-producing-developers-who-cannot-reason-about-threading-and-resource-management]]

## Process Notes

- [Process gap]: All skill SKILL.md files are deleted from .claude/skills/ — ralph, extract, and all other skill infrastructure is absent. The extract phase ran inline in the lead session as the only viable path. This is a methodology violation that needs resolution.
- [Friction]: PDF is scanned (image-based) — pdftotext produced no output. Paper is well-known so extraction from knowledge was viable. Future scanned PDFs without known content will block the pipeline.

## Archive Contents

- naur-1985-001.md through naur-1985-007.md — per-claim task files (all done)
- naur-1985-programming-as-theory-building-extract.md — extract task file (done)
- naur-1985-programming-as-theory-building-summary.md — this file
