---
description: Wang & Cook 2003 ICMC paper introducing ChucK: concurrent on-the-fly audio programming language with operator-unified syntax, deterministic timing, and live code modification
type: claim
source: /Users/morgan/code/arscontextica/inbox/archive/wang-cook-2003-chuck/wang-cook-2003-chuck.pdf
created: 2026-03-01
status: active
---

# wang-cook-2003-chuck

Source reference for "ChucK: A Concurrent, On-the-fly, Audio Programming Language," Ge Wang and Perry R. Cook, Princeton University. In Proceedings of the 2003 International Computer Music Conference (ICMC).

Primary source: `/Users/morgan/code/arscontextica/inbox/archive/wang-cook-2003-chuck/wang-cook-2003-chuck.pdf`

## Key Topics

- The ChucK operator (`=>`): a massively overloaded left-to-right operator that unifies assignment, signal routing, synchronization, and data flow
- Timing model: `now` as a first-class language value; time does not advance unless explicitly advanced by the programmer (suspended animation)
- Shreds: deterministic user-space lightweight processes that synchronize via the timing mechanism rather than OS primitives
- Dynamic control rate: control rate is an emergent product of time-advancement choices, not a fixed parameter
- On-the-fly programming: live assimilation and dissimilation of shreds into a running VM without stopping audio
- Performance tradeoff: VM approach sacrifices raw performance for determinism, flexibility, and sample-accurate control

## Claims Extracted

- [[a-single-overloaded-operator-can-unify-assignment-signal-routing-and-synchronization-in-an-audio-language]]
- [[suspending-time-until-explicitly-advanced-gives-deterministic-reproducible-timing-across-machines]]
- [[user-space-cooperative-shreds-achieve-sample-accurate-deterministic-concurrency-without-os-scheduling]]
- [[control-rate-as-emergent-product-of-time-advancement-eliminates-the-fixed-control-rate-constraint]]
- [[live-assimilation-of-shreds-into-a-running-vm-enables-coding-composing-and-performing-as-a-single-activity]]
- [[vm-based-audio-runtimes-trade-raw-performance-for-determinism-and-language-level-flexibility]]

## Cross-Referenced In

- [[competing-systems]] -- ChucK listed as one of five production audio engines McCartney recommends for source-level study
- [[audio-programming-education-requires-reading-production-engine-source-code-across-multiple-systems]] -- ChucK as canonical example of architecture-visible audio engine design
