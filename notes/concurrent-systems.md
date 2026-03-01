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

### Real-Time Thread Separation
- [[thread-count-minimization-reduces-coordination-cost-but-requires-latency-partitioning-to-assign-tasks-to-threads]] -- Dannenberg & Bencina's Static Priority Scheduling pattern: minimize to 2-3 threads, assign tasks by latency requirement, verify feasibility analytically; the formal rationale for murail's binary fast/NRT split
- [[static-thread-pool-decouples-neural-inference-from-the-audio-callback-to-ensure-real-time-safety]] -- anira's shared static ThreadPool removes inference engine code from the audio callback entirely; the static (not per-instance) design solves oversubscription when multiple neural effects run concurrently
- [[hold-slots-prevent-fast-thread-blocking-on-slow-rate-values-without-locks]] -- the Murail substrate's mechanism for cross-rate reads: three lock-free protocols (atomic, sequence-counter, double-buffer) selected by data size; generalizes the hold semantics from ad-hoc practice to a formal substrate requirement
- [[tick-boundary-precedence-is-a-substrate-requirement-not-an-implementation-suggestion]] -- hold-slot writes, data swaps, program swaps, TICK must execute in fixed order; this is the formal substrate requirement underlying the RT/NRT coordination contract
- [[the-murail-fast-thread-never-halts-errors-degrade-quality-but-do-not-stop-evaluation]] -- output continuity as an axiom: the substrate formally specifies which error conditions must degrade gracefully vs. block; the `flag` overflow policy is excluded because it violates this axiom

### RT Safety and Glitch Freedom
- [[glitch-free-parameter-propagation-requires-topological-ordering-combined-with-per-node-version-counters-not-global-locks]] -- REScala's proof: topological propagation plus per-node version counters achieves glitch-freedom without global locks; the propagation ordering is the same topological ordering the audio scheduler already computes (D11)
- [[lattice-monotone-graph-operators-are-provably-confluent-enabling-safe-graph-transformation-without-global-locking]] -- Hydroflow: if operators are monotone on join-semilattices, the result is independent of evaluation order; concurrent RT and NRT operations on lattice-valued computations cannot produce conflicting results regardless of scheduling
- [[linear-types-can-make-audio-buffer-management-errors-type-errors-rather-than-runtime-bugs]] -- linear typing of audio buffers enforces write-before-read and no-aliasing statically; closes the gap between Rust's memory safety and full functional correctness of the buffer management protocol (D50)
- [[stable-node-identities-enable-adapton-style-incremental-recompilation-where-only-affected-subgraphs-are-recompiled]] -- slotmap NodeIds (D51) are the first-class names Nominal Adapton requires; incremental recompilation triggered by edit transactions (Definition 14.1) reduces Deep service level latency from graph-size-bound to edit-size-bound

### Concurrency Models
- [[erlang-actor-model-enables-safe-process-kill]] -- shared-nothing actors with supervisor trees allow killing any process without lock leaks; the RT-node replacement analog in murail
- [[clojure-csp-channels-sacrifice-introspectability]] -- CSP channels compiled as macros lose channel depth and goroutine state from the runtime; inspectable NRT vs opaque RT as design principle
- [[long-running-servers-require-continuity-oriented-programming-models]] -- servers with thousands-of-days uptime and GUIs violate the batch-mode input-output transformer model that mainstream languages optimize for
- [[monotonic-information-cells-eliminate-synchronization-problems-in-parallel-propagator-networks]] -- Sussman/Radul: monotonic cell accumulation makes concurrent writes order-independent without locking; theoretical grounding for certain lock-free NRT-to-RT parameter update patterns

### RT Memory and Communication Primitives (Dannenberg & Bencina 2005)
- [[audio-system-os-calls-violate-real-time-constraints-through-unpredictable-lock-acquisition-and-page-faults]] -- OS allocator calls from the RT thread can acquire kernel locks, cause priority inversion, or trigger page faults; explains why the resource invariant (no allocation, no locks) is necessary rather than conventional
- [[real-time-safe-memory-strategies-form-a-spectrum-from-up-front-fixed-allocation-to-incremental-gc]] -- five RT-safe memory strategies from preallocated free lists to incremental GC; murail uses up-front fixed allocation at the whole-program level via the state region Σ
- [[lock-free-queues-are-the-canonical-communication-primitive-between-real-time-and-non-real-time-threads]] -- the standard solution the computer music community converged on by 2005; five production systems (SC3, AudioMulch, JSyn, Aura, PortMIDI) as evidence; provides applied motivation for the lock-free theory in Fraser 2004
- [[ideal-time-scheduling-anchors-event-sequences-to-desired-times-rather-than-actual-execution-times]] -- schedulers that track ideal wake-up times prevent error accumulation across event sequences even under CPU overload; the foundation of all computer music event scheduling
- [[pre-computed-event-buffers-with-constant-time-offset-trade-added-latency-for-reduced-jitter]] -- computing events ahead of their delivery time and forwarding via a higher-priority channel reduces timing variance; block rendering is this pattern at sample granularity

### Lock-Free Systems (Fraser 2004)
- [[existing-hardware-cas-primitives-suffice-for-practical-lock-free-data-structures]] -- CAS alone is sufficient for practical lock-free skip lists, BSTs, and red-black trees; refutes the assumption that DCAS or strong LL/SC is required
- [[lock-freedom-guarantees-system-wide-progress-but-not-per-operation-progress]] -- lock-freedom ensures some operation always completes, not that any particular operation completes; the hierarchy: wait-freedom > lock-freedom > obstruction-freedom
- [[two-phase-descriptor-protocol-enables-multi-location-atomic-updates-from-single-word-cas]] -- descriptor-based acquire/decide/release pattern simulates multi-location atomicity from single-word CAS; shared structural pattern across MCAS and FSTM; structural analog to compile-and-swap
- [[epoch-based-reclamation-amortizes-garbage-collection-across-concurrent-operations]] -- global epoch counter allows safe memory reclamation with three limbo lists and no per-access overhead; lower cost than hazard pointers but not strictly lock-free
- [[read-only-lock-operations-cause-cache-coherency-traffic-even-on-unmodified-data]] -- acquire/release generates cache line writes even for read-only critical sections; bottleneck at heavily-read structures like tree roots
- [[mcas-and-stm-trade-performance-for-programmability-at-a-quantifiable-cost]] -- CAS > MCAS > STM in throughput; STM enables mechanical derivation from sequential algorithms at 2-4x overhead; multi-reader locks worst at shared entry points
- [[linearisability-makes-concurrent-operations-reason-about-as-sequential-executions]] -- linearisable operations appear to execute instantaneously; enables local reasoning; the key correctness criterion for concurrent data structures
- [[obstruction-freedom-allows-conflict-abort-instead-of-recursive-helping-reducing-implementation-complexity]] -- abort-and-retry replaces helping infrastructure; requires out-of-band contention manager whose effectiveness is unvalidated
- [[pointer-marking-for-logical-deletion-prevents-concurrent-insertion-into-deleted-nodes]] -- mark bit in forward pointer as logical deletion intent; prevents lost insertions under concurrently-deleted nodes
- [[skip-lists-decompose-multi-level-updates-enabling-higher-lock-free-parallelism-than-trees]] -- per-level independent insertability makes skip lists more amenable to lock-free implementation than trees; preferred NRT-side concurrent ordered map structure
- [[memory-barrier-placement-in-lock-free-algorithms-is-manual-and-architecture-specific]] -- no automatic method for optimal barrier placement; manual analysis per architecture validated by offline linearisability checking against execution logs

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

## Source References
- [[fraser-2004-practical-lock-freedom]] -- primary source for the lock-free data structures cluster: CAS-only construction, epoch-based reclamation, MCAS/STM performance, and linearisability as correctness criterion

---

Agent Notes:
- 2026-02-28: static-thread-pool is the bridge between this map and ai-ml. For RT safety questions about neural inference, enter via static-thread-pool; follow to inference-engines-violate for violation data, or to existing-hardware-cas-primitives for the atomic synchronization substrate. The oversubscription problem (why the pool is static) connects to memory-bandwidth-is-the-binding-constraint — same root cause, different framing.

Topics:
- [[index]]
