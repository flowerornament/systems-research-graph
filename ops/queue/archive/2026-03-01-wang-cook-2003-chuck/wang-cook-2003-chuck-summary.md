---
batch: wang-cook-2003-chuck
date: 2026-03-01
source: /Users/morgan/code/arscontextica/inbox/archive/wang-cook-2003-chuck/wang-cook-2003-chuck.pdf
claims_created: 6
enrichments: 2
connections_added: 14
topic_maps_updated: 3
existing_claims_updated: 2
---

# Batch Summary: wang-cook-2003-chuck

**Source:** "ChucK: A Concurrent, On-the-fly, Audio Programming Language"
Ge Wang and Perry R. Cook, Princeton University
ICMC 2003 (International Computer Music Conference)

## Claims Created

1. [[a-single-overloaded-operator-can-unify-assignment-signal-routing-and-synchronization-in-an-audio-language]] (decision)
2. [[suspending-time-until-explicitly-advanced-gives-deterministic-reproducible-timing-across-machines]] (property)
3. [[user-space-cooperative-shreds-achieve-sample-accurate-deterministic-concurrency-without-os-scheduling]] (decision)
4. [[control-rate-as-emergent-product-of-time-advancement-eliminates-the-fixed-control-rate-constraint]] (property)
5. [[live-assimilation-of-shreds-into-a-running-vm-enables-coding-composing-and-performing-as-a-single-activity]] (claim)
6. [[vm-based-audio-runtimes-trade-raw-performance-for-determinism-and-language-level-flexibility]] (decision)

## Source Reference

- [[wang-cook-2003-chuck]] -- source reference file in notes/

## Enrichments (Existing Claims Updated)

- [[compile-and-swap-preserves-audio-continuity-during-recompilation]] -- additive vs. substitutive live coding distinction added; ChucK's assimilation model positioned as the additive alternative to murail's substitutive swap
- [[quantizing-live-code-swaps-to-musical-temporal-boundaries-makes-changes-deterministic-and-musically-predictable]] -- ChucK's immediate-assimilation model (no musical-boundary quantization) added as contrasting design point

## Topic Maps Updated

- [[competing-systems]] -- new ChucK section with all 6 claims and source reference
- [[audio-dsp]] -- new ChucK timing/concurrency section with 4 claims and source reference
- [[language-design]] -- new ChucK operator/live-coding section with 3 claims and source reference

## Notable Learnings

- ChucK introduces the "additive vs. substitutive" framing for live audio coding models that was missing from the vault. ChucK is additive (assimilation adds concurrent voices); murail's compile-and-swap is substitutive (replaces the running program). This framing is now in two existing enriched claims and available for future connection.
- The "suspended animation" timing model is the language-semantic version of what murail encodes at the substrate level (tick-boundary precedence). Having both in the vault enables a design comparison: language-semantic vs. substrate-contract approaches to deterministic audio timing.
- ChucK sits at one extreme of the performance-flexibility tradeoff (VM, maximum flexibility), FAUST at the other (AOT, maximum performance). This spectrum was previously described but lacked the ChucK endpoint as a concrete data point.
