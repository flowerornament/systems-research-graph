---
description: Lock-freedom ensures some operation always completes in finite steps system-wide, but an individual operation may be perpetually deferred while helping a sequence of conflicting operations
type: property
evidence: strong
source: "[[fraser-2004-practical-lock-freedom]]"
created: 2026-02-28
status: active
---

# lock-freedom guarantees system-wide progress but not per-operation progress

A data structure is lock-free if and only if *some* operation completes after a finite number of system-wide execution steps. This system-wide guarantee is typically implemented through recursive helping: when operation A is blocked by competing operation B, A helps B complete before resuming its own work. This ensures that every executing process is always advancing *some* operation — which prevents global deadlock and livelock.

However, this guarantee says nothing about whether any *particular* operation will ever complete. In theory, an operation may be perpetually deferred while its process helps an unbounded sequence of competing operations. This contrasts with wait-freedom, which guarantees that every individual operation completes in finite steps, and obstruction-freedom, which guarantees progress only in the absence of contention.

The three properties form a hierarchy of progress guarantees:
- **Wait-freedom** (strongest): every individual operation completes in finite steps
- **Lock-freedom**: some operation always completes in finite steps system-wide
- **Obstruction-freedom** (weakest): an operation completes if it runs without contention

Fraser argues lock-freedom is the appropriate target for practical systems: wait-freedom requires excessive software synchronization overhead on commodity hardware, while obstruction-freedom requires an out-of-band contention manager whose cost has not been empirically validated.

**Implications for murail:** The RT audio thread requires bounded execution — a lock-free structure provides no *per-operation* time bound. For the RT thread, even lock-free structures must be evaluated for worst-case contention behavior. The NRT→RT communication channel design must bound the number of concurrent writers to keep RT-side helping chains short.

Relates to [[erlang-actor-model-enables-safe-process-kill]] — Erlang's shared-nothing model eliminates helping chains entirely by preventing shared mutable state.
