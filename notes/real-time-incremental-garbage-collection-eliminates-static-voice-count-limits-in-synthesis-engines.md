---
description: An RT GC that never halts processing enables dynamic synthesis voice instantiation, removing the need to declare a maximum polyphony at engine startup
type: claim
evidence: strong
source: "[[mccartney-1996-supercollider-icmc]]"
created: 2026-03-01
status: active
---

# real-time incremental garbage collection eliminates static voice count limits in synthesis engines

Traditional software synthesizers require declaring maximum voice counts at startup because voice objects must be pre-allocated. Any synthesis system that allocates during the audio callback risks unbounded allocation latency, triggering the OS memory manager in the hot path. The standard workaround is fixed-size object pools with a voice stealing algorithm when the pool is exhausted.

SuperCollider 1 (1996) addressed this with real-time incremental garbage collection (citing Wilson 1992: "Uniprocessor Garbage Collection Techniques"). The key property of an RT GC is that it never needs to halt processing: collection work is interleaved with normal execution in small increments, bounded per increment. With this guarantee, allocation does not imply unbounded pause, and the synthesis engine can instantiate voices dynamically without declaring a ceiling.

The consequence: "no static allocation for maximum numbers of voices are necessary." Voice stealing is still provided as an option (for user preference or performance management), but it is no longer a structural necessity. The voice limit becomes a performance budget constraint rather than a hard architectural constraint.

This is a stronger claim than "GC is RT-safe with careful design." It is a claim about what GC *enables* architecturally: dynamic instantiation patterns that are structurally impossible in statically-allocated systems. Granular synthesis is the paradigm case: grains are short-lived synthesis voices, potentially hundreds per second, with unpredictable lifetimes. Static allocation for granular synthesis requires either a very large pool (wasting memory) or grain stealing (artifacts). RT GC makes the grain simply an allocated value with a natural lifetime.

The design tradeoff McCartney accepted: RT GC adds overhead (per-object header, collection work interleaved with audio processing, memory fragmentation over time). The 1996 SC1 choice was to accept that overhead in exchange for dynamic programming flexibility. The 2001 SC3 client-server split (see [[supercollider-client-server-architecture-moved-the-scripting-language-out-of-the-real-time-audio-thread]]) moved GC to the client, accepting a different tradeoff: scsynth (server) has no GC at all and uses fixed allocation; sclang (client) handles all dynamic allocation. This is the architectural evolution: RT GC in SC1 -> separation of dynamic client from static server in SC3.

For murail, the relevant insight is the endpoint of this evolution: [[all-murail-program-state-fits-in-a-single-pre-allocated-contiguous-region]] takes the SC3 server model to its logical limit. Murail's compile step plays the role that SC1's RT GC played: it converts dynamic structure (the synthesis graph) into static structure (the state region) before the audio callback fires. The dynamic instantiation problem is solved at compile time rather than runtime, eliminating both the GC overhead and the voice limit while preserving the programming convenience.

Contrast with [[real-time-safe-memory-strategies-form-a-spectrum-from-up-front-fixed-allocation-to-incremental-gc]], which enumerates this as one end of the strategy spectrum. SC1 is the incremental GC end; murail's substrate is the fixed-allocation end.

McCartney's reference to Wilson 1992 places this in historical context: RT-viable GC was recognized as feasible by 1992, and SC1 was among the first audio systems to depend on it as a core design assumption.

---

Topics:
- [[audio-dsp]]
- [[language-design]]
- [[concurrent-systems]]
- [[mccartney-language-design]]
