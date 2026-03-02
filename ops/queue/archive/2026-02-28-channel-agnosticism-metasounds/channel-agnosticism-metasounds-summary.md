---
batch: channel-agnosticism-metasounds
date: 2026-02-28
source: /Users/morgan/code/murail/.design/references/transcripts/archive/channel-agnosticism-metasounds.md
claims_created: 10
enrichments: 1
---

# Batch Summary: channel-agnosticism-metasounds

**Source:** ADC talk by Aaron McLeran (Epic Games) on MetaSounds' Channel Agnostic Types (CAT) system
**URL:** https://www.youtube.com/watch?v=CbjNjDAmKA0
**Duration:** 39:48

## Claims Created (10)

1. [[mono-buffer-assumption-locks-audio-graph-topology-to-a-specific-channel-configuration]] -- type: claim
2. [[channel-format-metadata-encapsulation-enables-audio-graph-reuse-across-channel-configurations]] -- type: claim
3. [[channel-agnostic-audio-types-require-three-polymorphic-subtypes-to-cover-all-known-and-future-formats]] -- type: decision
4. [[compatible-audio-format-transcoding-happens-automatically-while-cross-family-conversion-requires-an-explicit-cast]] -- type: decision
5. [[audio-format-type-must-be-resolved-at-graph-compile-time-not-during-execution]] -- type: decision
6. [[max-MSP-mc-signal-bundles-lack-format-metadata-making-them-unsuitable-for-plug-and-play-graph-interoperability]] -- type: contradiction
7. [[JIT-graph-compilation-enables-context-aware-channel-format-inference-at-playback-time]] -- type: property
8. [[sample-accurate-triggering-in-block-based-audio-requires-splitting-render-blocks-into-sub-block-execution-lambdas]] -- type: pattern
9. [[metasounds-instanced-graph-model-requires-compositional-thinking-rather-than-singleton-patch-design]] -- type: claim
10. [[enforced-data-interfaces-enable-plug-and-play-interoperability-between-independently-authored-audio-subsystems]] -- type: pattern

## Source Reference Created
- [[channel-agnosticism-metasounds-aaron-mcleran-adc]]

## Enrichments (1)
- [[interactive-programming-eliminates-the-compile-run-cycle]] -- added note about MetaSounds JIT as a partial interactive programming case, bounded by RT stability requirements

## Topic Maps Updated
- [[audio-dsp]] -- added Channel Format Architecture section and Block-Based DSP section (4 claims + 1 claim)
- [[competing-systems]] -- added MetaSounds Architecture section and Channel Format Comparison section (9 entries total)
- [[index]] -- added source reference entry

## Connections Added
- New claims link into existing claims: [[generic-operations-allow-extending-existing-code-over-new-types-without-modification]], [[visual-representation-exposes-structure-text-notation-obscures]], [[truth-maintenance-systems-enable-locally-consistent-reasoning-in-an-inconsistent-knowledge-base]], [[long-running-servers-require-continuity-oriented-programming-models]], [[interactive-programming-eliminates-the-compile-run-cycle]], [[batch-processing-incurs-avoidable-cognitive-overhead]]
- Primary cluster: 10 new claims form a cohesive subgraph centered on the CAT type system design

## Notable Insights
- CAT types are essentially an application of the generic operations / polymorphic dispatch pattern ([[generic-operations-allow-extending-existing-code-over-new-types-without-modification]]) to audio format types
- MetaSounds' explicit rejection of mid-execution format mutation is a meaningful data point for murail's RT safety constraints
- The distinction between Max MC bundles and MetaSounds CAT (semantic metadata vs. flat array) is directly relevant to murail's signal type design
- Sample-accurate block-splitting pattern is concrete implementation guidance for murail's UGen trigger system
