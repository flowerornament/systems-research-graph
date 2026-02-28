---
description: Erlang's shared-nothing actor model with supervisor trees allows killing any process at any time without lock leaks, because processes own no shared mutable state
type: claim
evidence: strong
source: [[stop-writing-dead-programs-jack-rusher-2022]]
created: 2026-02-28
status: active
---

# Erlang's actor model enables safe process kill

Rusher identifies Erlang as "getting almost everything right" for long-running server systems. The key: shared-nothing state + supervisor trees means any process can be killed without leaking locks held by other threads. The JVM and Go both prohibit process kill because their runtimes assume shared memory -- killing a goroutine or JVM thread can orphan locks needed by other threads.

Erlang provides `Observer` for runtime introspection of the actor graph and process states -- what Rusher calls an essential tool that users of other platforms should be jealous of. It implements ps and kill semantics at the language level.

This is directly relevant to [[concurrent-systems]] design for murail: the RT/NRT thread separation already achieves a weaker form of this (the RT thread is isolated from NRT mutations via compile-and-swap). But the claim points to a deeper design principle -- audio graph nodes that share no mutable state across the RT boundary can be safely replaced or killed without synchronization, because there is nothing to orphan.

Contrasted with [[clojure-csp-channels-sacrifice-introspectability]] which shows how Go-style CSP in Clojure loses the introspection property. See also [[long-running-servers-require-continuity-oriented-programming-models]] for the broader context of why this matters.
