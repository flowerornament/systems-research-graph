---
description: Tidal's Pattern = Arc -> [Event a] representation handles both discrete sequences (return events in arc) and continuous signals (sample midpoint of arc) within the same datatype, enabling free composition
type: property
evidence: strong
source: [[mclean-2014-making-programming-languages-to-dance-to]]
created: 2026-03-01
status: active
---

# representing musical pattern as a function from time to events unifies discrete and continuous patterns

Tidal 0.4's core type signature:

```haskell
type Time  = Rational
type Arc   = (Time, Time)
type Event a = (Arc, Arc, a)
data Pattern a = Pattern (Arc -> [Event a])
```

A `Pattern a` is a function from a time arc (a query window) to a list of events. Each event associates a value with two arcs: the event's onset/offset, and the "active" portion within the query window (used when an event is cut across a query boundary). This design choice -- function from arc rather than function from point -- is what makes the unification work.

**For discrete patterns**: querying with an arc returns all events that are active during that window. Events have definite onset and offset; polyphony is handled naturally (multiple events with the same onset, each with its own offset, without grouping them into a single multi-value event).

**For continuous patterns**: querying with an arc samples the midpoint of the arc to get the value. There is no "event" in the discrete sense; instead, each query produces a single-event list with the arc's duration as the granularity of the sample.

The crucial property: both kinds of patterns have the same type `Pattern a`. This means *all combinators work on both*. `overlay`, `cat`, `density`, `slowcat`, and the Functor/Applicative instances work identically whether the patterns are discrete event sequences or continuous signals. McLean notes this allows "discrete and continuous patterns to be straightforwardly combined, allowing expressive composition of music through composition of functions."

This is novel relative to FRP (Functional Reactive Programming, Elliott 2009, which inspires Tidal). FRP typically has separate `Behavior` (continuous, time-varying) and `Event` (discrete, occurrences) types. Tidal collapses these into one type by using time arcs rather than points: a continuous pattern is just a discrete pattern where the "events" are arc-samples rather than onset/offset pairs.

**The design iteration history** (Section 6 of the paper) makes the value of this convergence visible. Earlier Tidal representations used separate `Sequence` and `Signal` constructors, which caused "great complexities in the supporting code." The insight that discrete sequences could also be represented as functions from time ranges to events -- with continuous signals as a degenerate case -- eliminated the impedance mismatch.

For murail: this is a direct candidate design pattern for the composition language's time-varying value type. The murail substrate uses a signal graph of fixed-rate buffers; the composition language needs to express patterns that may be discrete (note sequences), continuous (LFOs), or hybrid (pattern-of-parameters applied to a continuously running voice). Tidal's unified `Pattern` type shows how to avoid the Behavior/Event split that would otherwise complicate murail's composition API. The tension is that murail's RT engine requires fixed-size buffers, while Tidal's pattern queries are lazy infinite functions -- bridging these requires a scheduler layer, which Tidal externalizes (its tempo clock and event scheduler are not the pattern type itself).

Extends [[faust-programs-denote-mathematical-functions-enabling-semantics-driven-compilation]] -- Tidal's pattern-as-function is a similar "represent the meaning, not the execution" design philosophy, but applied to *temporal structure* rather than signal processing.

---

Topics:
- [[language-design]]
- [[audio-dsp]]
