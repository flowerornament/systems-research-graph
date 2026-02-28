---
description: Clojure's core.async CSP channels, implemented as a macro that compiles to state machines, hide channel depth and internal state from runtime inspection
type: claim
evidence: moderate
source: [[stop-writing-dead-programs-jack-rusher-2022]]
created: 2026-02-28
status: active
---

# Clojure CSP channels sacrifice introspectability

Rusher's critique of core.async: because it is implemented as a macro that transforms sequential CSP code into state machine callbacks, the resulting compiled form is opaque -- you cannot query a channel for how many items it contains, you cannot inspect the suspended goroutines awaiting it. The compilation step creates a dead artifact in the middle of what should be a live system.

Rich Hickey's own position (pre-core.async): use the JVM's built-in concurrent queues. Rusher agrees. The lesson is that abstractions that compile away their structure also compile away their debuggability.

Contrast with Clojure's immutable data structures and atoms, which preserve their structure at runtime and are therefore inspectable. The tradeoff: atoms give up the composability of CSP in exchange for remaining queryable.

For [[concurrent-systems]] in murail: the SPSC channel between NRT and RT threads is similarly a low-level primitive that doesn't support inspection by design (lock-free performance constraint). But the NRT side -- the graph compilation state -- should be fully inspectable because it runs outside RT constraints. This supports the design principle of keeping the RT path minimal and opaque while making the NRT coordination layer rich and introspectable.

Related to [[erlang-actor-model-enables-safe-process-kill]] (Erlang solves this by avoiding shared state rather than hiding it) and [[static-languages-prevent-runtime-introspection]] (Go has the same opacity problem in a static context).
