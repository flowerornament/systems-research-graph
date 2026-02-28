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

## Open Questions
- Can murail's NRT side expose ps/kill semantics for graph nodes, analogous to Erlang's Observer, while keeping the RT side opaque for performance?
- What would node-level state threading look like during compile-and-swap -- carrying oscillator phase, filter memory, etc. into replacement nodes?

---

Topics:
- [[index]]
