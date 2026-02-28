---
description: Visual dataflow languages like Max and PureData hide their semantic model inside the dataflow engine; global patch behavior requires deep engine knowledge and resists long-term preservation
type: claim
evidence: strong
source: [[faust-2009-npcm]]
created: 2026-02-28
---

# Dataflow languages lack explicit formal semantics making program behavior engine-dependent

Max, PureData, and similar visual dataflow languages achieve real-time performance by working on vectors of samples — but this means sample-level computations like recursive filters must be provided as primitives or external plugins, not composed from the language itself. More fundamentally, the semantics of the full dataflow model depends on many engine-level choices that are not part of the language specification:

- Synchronous or asynchronous computation
- Deterministic or non-deterministic behavior
- Bounded or unbounded communication FIFOs
- Firing rules for when a node executes

Because these choices are embedded in the engine rather than specified in the language, the vast majority of dataflow-inspired music languages have no explicit formal semantics. The semantic model is hidden in the implementation. Understanding the global behavior of a complex patch requires understanding the engine internals.

This has two concrete consequences:
1. **Embedding**: Max and PD programs depend on a runtime environment; embedding them in other systems requires bringing the engine, unlike self-contained compiled DSP code
2. **Preservation**: Long-term preservation of musical pieces is threatened when the meaning of a program is inseparable from a specific engine version

FAUST was explicitly designed to address both: its formal semantics are stated (a FAUST program is a function from signals to signals), making program meaning independent of any particular engine.

This is relevant to murail in two ways: (1) murail's graph IR should have formal semantics (at least at the execution model level), so that murail programs can be understood without knowing the executor; and (2) the runtime embedding problem — [[library-languages-must-not-bundle-a-mandatory-runtime]] — is precisely the problem Max/PD demonstrate.

## Connections
- Contrasts with [[faust-programs-denote-mathematical-functions-enabling-semantics-driven-compilation]] — FAUST's formal semantics solve exactly the problem dataflow languages have
- Extends [[library-languages-must-not-bundle-a-mandatory-runtime]] — Max/PD illustrate the cost of mandatory runtime coupling
- Connects to [[static-languages-prevent-runtime-introspection]] — hidden-in-engine semantics is the opposite failure mode: the program is dynamic but its meaning is opaque
- The Murail substrate ([[the-murail-substrate-is-instantiated-by-a-domain-configuration-without-modifying-layers-0-through-2]]) is the architecture that solves both embedding and semantics simultaneously: a domain-independent substrate with formally-specified execution semantics (Layer 1) that can be embedded without requiring a full runtime
