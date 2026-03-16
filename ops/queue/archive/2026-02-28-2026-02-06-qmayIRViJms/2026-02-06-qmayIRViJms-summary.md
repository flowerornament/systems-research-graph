---
batch: 2026-02-06-qmayIRViJms
created: 2026-02-28
source_title: "Podcast 350: James McCartney"
---

# Batch Summary: 2026-02-06-qmayIRViJms

## Source

- **File:** `2026-02-06-qmayIRViJms.md` (Darwin Gross podcast, 42:01)
- **Original location:** `/Users/morgan/code/murail/.design/references/transcripts/2026-02-06-qmayIRViJms.md`
- **Archived to:** `/Users/morgan/code/murail/.design/references/transcripts/archive/2026-02-06-qmayIRViJms.md`
- **Speaker:** James McCartney (SuperCollider creator, ex-Apple Core Audio)
- **Host:** Darwin Gross (cycling74.com)

## Extraction

- **Claims created:** 7
- **Existing claims enriched:** 3
- **Topic maps updated:** 4 (competing-systems, language-design, developer-experience, index)
- **Connections added:** ~15 cross-claim wiki links

## Claims Created

1. [[supercollider-version-1-merged-a-scripting-language-with-a-software-synthesizer-when-hardware-reached-real-time-speed]]
2. [[supercollider-client-server-architecture-moved-the-scripting-language-out-of-the-real-time-audio-thread]]
3. [[supercollider-version-2-used-a-smalltalk-inspired-language-without-client-server-separation]]
4. [[core-audio-low-latency-performance-traces-to-an-architectural-insight-made-at-the-projects-inception]]
5. [[juce-abstracts-away-audio-engine-fundamentals-producing-developers-who-cannot-reason-about-threading-and-resource-management]]
6. [[audio-programming-education-requires-reading-production-engine-source-code-across-multiple-systems]]
7. [[pyrite-introduced-closures-into-max-patching-enabling-separation-of-ui-and-logic]]

## Source Reference Added

- [[2026-02-06-qmayIRViJms]] -- source reference claim created in notes/

## Enrichments Applied

- [[compile-and-swap-preserves-audio-continuity-during-recompilation]] -- added ICMC paper detail and "before Faust" context
- [[universal-auto-mapping-eliminates-explicit-iteration-from-signal-processing-programs]] -- added Stanley Jordan APL MIDI sequencer reference
- (competing-systems topic map) -- added SuperCollider history section and audio education section

## Notable Findings

This transcript is a primary source for SuperCollider's complete version history (SC1 -> SC2 -> SC3) directly from McCartney. The C-emit pipeline that became compile-and-swap is dated here as "before Faust" and confirmed to have been presented at ICMC. The JUCE-as-crutch framing is unusually explicit and directly applicable to Murail's API design decisions.

The Core Audio architectural insight claim is moderate-evidence (McCartney declines to specify the insight) but the causal claim -- foundational architecture determines long-term latency performance -- is well-supported by the 20+ years of Core Audio's market position.
