---
batch: bencina-real-time-audio-programming-101
date: 2026-03-01
source: inbox/archive/bencina-real-time-audio-programming-101/bencina-real-time-audio-programming-101.md
claims_created: 5
enrichments: 2
connections_added: 22
topic_maps_updated: 2
existing_claims_updated: 2
---

# Batch Summary: bencina-2011-real-time-audio-programming-101

## Source

Ross Bencina. "Real-time audio programming 101: time waits for nothing." 2011.
http://www.rossbencina.com/code/real-time-audio-programming-101-time-waits-for-nothing

A web article synthesizing the practitioner consensus on RT audio callback safety for general-purpose OSes. Cross-platform (JACK, ASIO, ALSA, CoreAudio, WASAPI). Distinct from the Dannenberg-Bencina 2005 paper (of which Bencina is co-author) in emphasizing *why* the rules exist via mechanism-level explanations.

## Claims Created

1. [[bencina-2011-real-time-audio-programming-101]] (source-ref) -- provenance reference for this source
2. [[unbounded-execution-time-is-the-single-root-cause-of-all-audio-glitches-not-just-slowness]] -- cardinal rule: "if you don't know how long it will take, don't do it"; the unifying principle behind all RT prohibitions
3. [[priority-inversion-blocks-the-rt-thread-behind-a-lower-priority-task-on-general-purpose-oses]] -- three-step priority inversion mechanism; why mutexes are fatal even with high-priority callback scheduling
4. [[real-time-audio-code-must-be-designed-for-worst-case-not-amortized-average-case-execution-time]] -- amortized O(1) is not enough; std::vector::push_back is the canonical example of acceptable-looking RT-unsafe code
5. [[general-purpose-os-scheduler-interactions-from-the-rt-thread-have-hidden-priority-and-blocking-risks]] -- scheduler paranoia: condition variables and semaphores may internally acquire locks; pthreads on Windows used internal mutex for correct POSIX semantics
6. [[trylocks-cannot-guarantee-per-callback-resource-access-making-them-unsuitable-for-required-rt-operations]] -- trylocks avoid blocking but introduce guaranteed access failure under contention; only viable for optional operations

## Existing Claims Enriched

- [[audio-system-os-calls-violate-real-time-constraints-through-unpredictable-lock-acquisition-and-page-faults]] -- added Bencina 2011 as corroborating source; added forward links to the two new mechanism claims
- [[lock-free-queues-are-the-canonical-communication-primitive-between-real-time-and-non-real-time-threads]] -- added Bencina 2011 as corroborating source; added forward links to trylocks and priority inversion claims

## Topic Maps Updated

- [[concurrent-systems]] -- added "RT Principles and Failure Modes (Bencina 2011)" cluster with all 5 new claims; added Bencina 2011 to Source References
- [[audio-dsp]] -- added Bencina 2011 to Source References

## Notable Observations

The Bencina 2011 article adds genuine value despite overlapping thematically with Dannenberg-Bencina 2005:
- The "cardinal rule" formulation (unbounded execution time as root cause) is Bencina's own and was missing from the graph
- The priority inversion mechanism detail (three-step scheduler failure) was referenced but not fully explained
- Worst-case vs. amortized analysis is a new frame not present in the Dannenberg-Bencina patterns
- Scheduler paranoia (condition variables, pthreads implementation details) is new
- Trylock limitations are new

All five claims connect cleanly into the existing murail/concurrent-systems cluster. The cardinal rule claim in particular functions as the missing "why" that unifies the specific OS prohibition claims already in the graph.
