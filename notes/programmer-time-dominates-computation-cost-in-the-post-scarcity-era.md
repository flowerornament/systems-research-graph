---
description: Sussman argues that since memory and computation are now effectively free, the dominant cost of software is programmer expressiveness, making scarcity-oriented language design obsolete
type: claim
evidence: strong
source: [[we-dont-know-how-to-compute-sussman-2011]]
created: 2026-02-28
status: active
---

# programmer time dominates computation cost in the post-scarcity era

Sussman opens with a hardware cost comparison: from 1961 (IBM 650, $500K, 10KB RAM) to 2011, a dollar buys roughly 50,000 PCs each with a gigabyte of RAM -- approximately 10^4 more machines and 10^6 faster per dollar. His conclusion: memory is free, computation is free. The intuitions developed in the era of scarcity -- minimize operations, minimize memory, optimize everything -- are wrong defaults for most modern software.

The actual dominant cost is now quoted from Evans of Glasgow: "almost all the cost of computing is you and me" -- that is, programmer time. The implication is that languages and architectures optimized for machine efficiency but not for human expressiveness are optimizing the wrong variable.

This reframes the design space for programming languages: the central question is not "what does this program cost to run" but "what does this program cost to write, maintain, and extend." Sussman uses this as motivation for the evolvability argument (see [[evolvability-requires-trading-provability-for-extensibility]]) -- if programmer time is the bottleneck, then a language design that trades machine efficiency for programmer expressiveness is making the right tradeoff.

Latency is the one remaining hardware constraint Sussman calls out explicitly: minimizing latency is still critical (the visual system example -- 100ms to recognize a Kanizsa triangle -- is a hard latency bound). But throughput and memory size have left the binding constraint regime.

This claim is relevant to murail's design context: murail is an audio graph engine where RT latency is a hard constraint (buffer size / sample rate), but NRT compilation, tooling, and DSL expressiveness are in the "programmer time dominates" regime. Design tradeoffs in the non-real-time layer should be optimized for expressiveness, not machine efficiency.
