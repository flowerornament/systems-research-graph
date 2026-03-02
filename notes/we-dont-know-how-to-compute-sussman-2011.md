---
description: Gerald Sussman's 2011 Strange Loop talk on propagator models, truth maintenance, evolvability vs correctness, and the post-scarcity case for programmer-expressiveness-first design
type: claim
evidence: strong
source: https://www.youtube.com/watch?v=HB5TrK7A4pI
created: 2026-02-28
status: active
---

# we dont know how to compute sussman 2011

Strange Loop 2011. Gerald Sussman argues that the field of computing does not yet have adequate models for the kinds of computation we actually want to do -- not just in a theoretical sense, but in a practical design sense. The problems we actually need to solve (self-organizing systems, evolvable software, parallel computation without synchronization overhead) are not well-served by the language design traditions that dominate the field.

Rusher cites this talk directly in [[stop-writing-dead-programs-jack-rusher-2022]] as essential background for understanding propagator networks.

**Archive location:** `/Users/morgan/code/murail/.design/references/transcripts/we-dont-know-how-to-compute-sussman-2011.md`

## Central thesis
Correctness is not the primary problem. Evolvability is. Systems that cannot be modified without rebuilding from scratch are not useful for the long term. See [[evolvability-requires-trading-provability-for-extensibility]].

## Claims extracted from this source

### Post-scarcity design
- [[programmer-time-dominates-computation-cost-in-the-post-scarcity-era]] -- memory and compute are free; the bottleneck is now programmer expressiveness, making scarcity-oriented language design obsolete

### Generic operations and extensibility
- [[generic-operations-allow-extending-existing-code-over-new-types-without-modification]] -- runtime dispatch lets programs written for one type work over new types without touching existing code; demonstrated with symbolic algebra, automatic differentiation, and dimensional analysis
- [[evolvability-requires-trading-provability-for-extensibility]] -- tight specs enable proofs but make systems brittle; generic extensibility buys evolvability at the cost of formal verifiability

### Propagator model
- [[propagator-cells-hold-partial-information-that-accumulates-monotonically]] -- Radul's key contribution: cells hold information about values (not values), accumulating monotonically; enables redundant computation paths and graceful degradation
- [[monotonic-information-cells-eliminate-synchronization-problems-in-parallel-propagator-networks]] -- monotonic accumulation means concurrent writes cannot corrupt cell state; locks become unnecessary
- [[wiring-diagram-notation-names-every-intermediate-value-enabling-inspection-and-reuse]] -- unlike expression trees, wiring diagrams give names to every wire; makes every intermediate value inspectable and the diagram itself a queryable memory

### Truth maintenance
- [[truth-maintenance-systems-enable-locally-consistent-reasoning-in-an-inconsistent-knowledge-base]] -- TMSs maintain multiple locally consistent worldviews simultaneously; the system reasons soundly within each without requiring global consistency
- [[dependency-directed-backtracking-prunes-search-using-provenance-rather-than-recency]] -- provenance tracking lets the system jump directly to the guilty premise when a contradiction is found, rather than unwinding chronologically

See also [[propagator-networks-provide-provenance-for-computed-conclusions]] for the earlier secondhand account via Rusher.
