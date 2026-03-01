---
description: ChucK's "suspended animation" rule means now does not change unless the programmer explicitly advances it, making program timing deterministic and independent of hardware and OS scheduler variation
type: property
evidence: strong
source: [[wang-cook-2003-chuck]]
created: 2026-03-01
status: active
---

# suspending time until explicitly advanced gives deterministic reproducible timing across machines

ChucK's second rule -- "you always code in suspended animation" -- establishes that `now` (ChucK's first-class time value, of type `time`) does not advance unless the programmer explicitly advances it via a chuck-to-now operation:

```chuck
1:second => now;   // advance time by one second, blocking until that time has passed
```

Or by waiting on an event (wait-on-event):

```chuck
some_event => wait;  // blocks until the event fires, then continues
```

The consequences of this model are significant:

**Determinism across executions and machines.** Because program execution is gated on explicit time advancement, the sequence of operations is independent of the underlying hardware timing (processor speed, memory latency, bus bandwidth) and the kernel scheduler's non-deterministic wake-up times. A ChucK program executed twice on the same hardware, or on different hardware, follows an identical control flow relative to audio time.

**Amortized computation over time.** Since `now` is constant for an arbitrarily long block of code, all computation in that block executes "before" the audio advances. An envelope can be computed dynamically as time progresses -- not declared up-front and scheduled -- because the timing model guarantees the computation completes before the next time step.

**Code before time advancement executes first; code after executes after.** Statements before a `=> now` are guaranteed to evaluate before the time step; statements after evaluate only when the timing or synchronization condition is fulfilled. This gives the programmer precise causal ordering of operations relative to audio time.

This is the mechanism underlying ChucK's shred determinism (see [[user-space-cooperative-shreds-achieve-sample-accurate-deterministic-concurrency-without-os-scheduling]]): all shreds share the same time model, and a shred that advances time via `=> now` is automatically "shreduled" by the shreduler, yielding the processor. Shreds synchronize through shared time, not through explicit synchronization primitives.

The contrast with SuperCollider is direct: SC's client-server separation delegates timing to the scsynth server's internal scheduler, with the language side managing timing via OSC messages with timestamps. This provides real-time safety but makes precise timing dependent on OSC round-trip latency and server scheduling. ChucK's `now` model gives language-level timing control at the cost of running the language in the audio thread (via the VM).

For Murail, this connects to [[tick-boundary-precedence-is-a-substrate-requirement-not-an-implementation-suggestion]]: the murail fast thread's strict ordering (hold-slot writes, data swaps, program swaps, TICK) is the substrate-level analog of ChucK's "code before time advancement executes first" guarantee. The difference is that murail's ordering is enforced at the substrate implementation level, while ChucK's is encoded directly in the language semantics as a programmer-visible guarantee. ChucK's approach makes timing reasoning a language-level concern rather than an implementation detail hidden from the user.

The suspended-animation model is also the foundation for ChucK's reproducibility claim: since timing does not depend on hardware or OS, a ChucK program is, in principle, a reproducible artifact. This is the property that [[dataflow-languages-lack-explicit-formal-semantics-making-program-behavior-engine-dependent]] identifies as missing from Max/PD -- ChucK's `now` semantics provides a formal, language-level grounding for when things happen.

---

Topics:
- [[audio-dsp]]
- [[language-design]]
- [[concurrent-systems]]
