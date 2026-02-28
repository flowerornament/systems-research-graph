---
description: Lock-free communication, real-time scheduling, memory safety, and thread models
type: moc
created: 2026-02-27
---

# concurrent-systems

Concurrency and real-time systems research for murail. Covers the NRT/RT thread separation, lock-free data structures, real-time scheduling constraints, memory safety in audio contexts, and Rust's ownership model as enforcement mechanism.

## Key Sub-Areas
- NRT/RT thread separation (compile-and-swap, type-level enforcement)
- Lock-free communication (SPSC channels, ArcSwap, bounded queues)
- Real-time constraints (zero-allocation, no blocking, deterministic scheduling)
- Memory management (arena allocation, bumpalo, graceful load shedding)
- Rust ownership as safety mechanism (Send/Sync, lifetime enforcement)

## Claims

### Concurrency Models
- [[erlang-actor-model-enables-safe-process-kill]] -- shared-nothing actors with supervisor trees allow killing any process without lock leaks; the RT-node replacement analog in murail
- [[clojure-csp-channels-sacrifice-introspectability]] -- CSP channels compiled as macros lose channel depth and goroutine state from the runtime; inspectable NRT vs opaque RT as design principle
- [[long-running-servers-require-continuity-oriented-programming-models]] -- servers with thousands-of-days uptime and GUIs violate the batch-mode input-output transformer model that mainstream languages optimize for
- [[monotonic-information-cells-eliminate-synchronization-problems-in-parallel-propagator-networks]] -- Sussman/Radul: monotonic cell accumulation makes concurrent writes order-independent without locking; theoretical grounding for certain lock-free NRT-to-RT parameter update patterns

### Immutability as Concurrency Architecture
- [[pervasive-immutability-dissolves-concurrency-problems-rather-than-managing-them]] -- immutable-by-default with structural sharing eliminates GC write barriers, makes reference counting sufficient, and enables lock-free cross-thread sharing; McCartney's decade of SAPF experience as evidence
- [[persistent-data-structures-make-lossless-undo-an-architectural-side-effect]] -- preserving old versions costs only a pointer when data is immutable with structural sharing; lossless history and undo fall out for free
- [[reference-counting-becomes-viable-when-immutability-prevents-object-cycles]] -- in a non-lazy non-mutable language new objects can only reference old ones so cycles are structurally impossible; RC is pause-free and exact, making it suitable for language runtimes adjacent to RT audio
- [[thread-local-top-level-scope-with-copy-on-fork-achieves-actor-isolation-without-message-passing]] -- persistent-dictionary thread-local scope with pointer-copy fork achieves Erlang-style actor isolation without a message-passing runtime; no GIL required when all state is either immutable or thread-local
- [[value-semantics-allow-in-place-mutation-when-ownership-is-clear-making-them-strictly-more-powerful-than-purely-functional-copies]] -- ownership-proven in-place mutation is the concurrency-safe version of functional programming; Rust's model in the RT thread is value semantics enforced statically

### Rust Thread Safety -- Formal Foundations (RustBelt)
- [[rust-ownership-enforces-that-aliasing-and-mutation-cannot-coexist-on-any-location]] -- core type invariant eliminates data races, use-after-free, and iterator invalidation; formally proved, not just conventional
- [[send-and-sync-are-thread-independence-of-ownership-and-sharing-predicates]] -- T is Send if ownership predicate is thread-independent; T is Sync if sharing predicate is thread-independent; formal characterization of murail's NRT/RT safety requirements
- [[interior-mutability-is-safe-mutation-through-shared-references-enforced-by-controlled-api-surfaces]] -- Mutex and Arc are verified to safely encapsulate unsafe cross-thread mutation; murail's lock-free queue and arc-swap patterns derive safety from this
- [[mutexguard-lifetime-enforces-lock-release-before-deep-pointers-expire]] -- lock release tied to scope exit by lifetime system; no use-after-unlock possible without a compile error
- [[rust-provides-provably-memory-and-data-race-safe-programs-without-garbage-collection]] -- RustBelt adequacy theorem: memory safety and data-race freedom are proved without GC; the formal foundation of murail's real-time safety claims

### Memory Layout and Performance
- [[cache-hierarchical-hardware-makes-linked-lists-slower-than-arrays-for-most-practical-sizes]] -- contiguous memory layout keeps audio buffers hot in cache across the RT thread's tight render loop; pointer-chased structures scatter data across pages
- [[purely-functional-languages-fail-on-modern-hardware-because-pointer-boxing-destroys-cache-locality]] -- per-sample cache misses from boxed functional language data models are architecturally incompatible with RT audio requirements

## Cross-Domain: OTP in Agent Architectures

- [[otp-solves-the-hard-parts-of-agent-architecture-that-other-ecosystems-are-still-building]] -- OTP's actor model solves state residence, routing, and lifecycle for LLM agents the same way it solves them for audio engines; the patterns are identical

## Open Questions
- Can murail's NRT side expose ps/kill semantics for graph nodes, analogous to Erlang's Observer, while keeping the RT side opaque for performance?
- What would node-level state threading look like during compile-and-swap -- carrying oscillator phase, filter memory, etc. into replacement nodes?
- For Murail's composition language (Stage 9): Rust ownership vs. persistent immutable structures (McCartney/Clojure approach) as the data model? The two might combine: Rust engine, persistent structures for the language runtime.

---

Topics:
- [[index]]
