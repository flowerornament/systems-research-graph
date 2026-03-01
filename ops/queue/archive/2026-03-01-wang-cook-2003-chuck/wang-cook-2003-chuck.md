---
id: wang-cook-2003-chuck-extract
batch: wang-cook-2003-chuck
type: extract
status: done
source: /Users/morgan/code/arscontextica/inbox/archive/wang-cook-2003-chuck/wang-cook-2003-chuck.pdf
original_path: /Users/morgan/code/arscontextica/inbox/wang-cook-2003-chuck.pdf
archive_folder: ops/queue/archive/2026-03-01-wang-cook-2003-chuck
created: 2026-03-01
completed: 2026-03-01
next_claim_start: 344
claims_created: 6
enrichments: 2
connections_added: 14
topic_maps_updated: 3
existing_claims_updated: 2
---

# Extract claims from wang-cook-2003-chuck

## Source
Original: /Users/morgan/code/arscontextica/inbox/wang-cook-2003-chuck.pdf
Archived: /Users/morgan/code/arscontextica/inbox/archive/wang-cook-2003-chuck/wang-cook-2003-chuck.pdf
Size: 8 pages (PDF, 636 KB)
Content type: Academic conference paper (ICMC 2003)

## Summary
Wang and Cook (Princeton) present ChucK, a concurrent, on-the-fly audio programming language. ChucK's four foundational ideas are: (1) a massively overloaded `=>` operator that unifies left-to-right data flow; (2) a precise timing model based on the `now` keyword and suspended animation; (3) shreds -- deterministic user-space cooperative lightweight processes; and (4) on-the-fly programming via runtime compilation and shred assimilation/dissimilation. The paper is both a design document and a position statement about audio language design, contrasting ChucK's VM-based architecture with compiled systems like FAUST and parameterized-timing systems like SuperCollider and Nyquist.

## Scope
Full document. Extracted:
- Language design decisions: the `=>` operator, suspended animation timing, shred model
- Formal properties: deterministic timing across machines, emergent control rate
- Claims: VM performance tradeoff, live assimilation model
- Comparisons with SuperCollider and Nyquist timing models (used for enrichment)

## Acceptance Criteria
- Extract claims, decisions, properties relevant to murail's design space
- Duplicate check against notes/ during extraction
- Near-duplicates create enrichment tasks
- Connections to existing claims on live coding, timing, concurrency, competing systems

## Execution Notes

Extracted 2026-03-01. Full PDF read. No duplicate claims found in notes/ -- ChucK had no prior dedicated claims in the vault, only name mentions. Two enrichments added to existing claims (compile-and-swap, quantizing-live-code-swaps). Source reference file created at notes/wang-cook-2003-chuck.md.

## Outputs

**Claims extracted: 6** (notes/ IDs 344-349 logical)

| Claim | Type |
|-------|------|
| a single overloaded operator can unify assignment, signal routing, and synchronization in an audio language | decision |
| suspending time until explicitly advanced gives deterministic reproducible timing across machines | property |
| user-space cooperative shreds achieve sample-accurate deterministic concurrency without os scheduling | decision |
| control rate as emergent product of time-advancement eliminates the fixed control-rate constraint | property |
| live assimilation of shreds into a running vm enables coding, composing, and performing as a single activity | claim |
| vm-based audio runtimes trade raw performance for determinism and language-level flexibility | decision |

**Enrichments (backward connections added to existing claims): 2**
- [[compile-and-swap-preserves-audio-continuity-during-recompilation]] -- additive vs substitutive live coding distinction added
- [[quantizing-live-code-swaps-to-musical-temporal-boundaries-makes-changes-deterministic-and-musically-predictable]] -- ChucK immediate-assimilation alternative added

**Topic maps updated: 3**
- [[competing-systems]] -- ChucK section added with all 6 claims + source reference
- [[audio-dsp]] -- ChucK timing/concurrency section added with 4 claims + source reference
- [[language-design]] -- ChucK operator/live-coding section added with 3 claims + source reference

**Connections added: 14** (forward connections within new claims + backward connections to existing claims)
