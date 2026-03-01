---
description: Tidal's Applicative instance for Pattern matches events from the left pattern with events from the right pattern whose arcs contain the left event's onset, allowing any binary value function to operate on pattern pairs
type: property
evidence: strong
source: [[mclean-2014-making-programming-languages-to-dance-to]]
created: 2026-03-01
status: active
---

# applicative functor lifts binary value functions to pattern-combinators by matching co-occurring events

Tidal defines `Pattern` as both a Functor and an Applicative functor in Haskell's sense. The Functor instance (`fmap`) applies a function to all values in a pattern irrespective of their temporal positions -- enabling trivial transposition, amplitude scaling, and similar value transformations. The Applicative instance (`<*>`) is more nuanced and is where the interesting design work lives.

**The Applicative definition:**

```haskell
(Pattern fs) <*> (Pattern xs) = Pattern $ \a ->
  concatMap applyX (fs a)
  where applyX ((s,e),(s',e'),f) =
    map (\(_,_,x) -> ((s,e),(s',e'), f x))
        (filter (\(_,a',_) -> isIn a' s) (xs (s',e')))
```

The semantics: for each event `f` in the left pattern (queried with arc `a`), query the right pattern with the `f` event's arc, then filter the results to events whose active arc contains the onset of `f`. Apply `f` to each matching `x`.

In plain terms: left pattern events are matched with right pattern events that *co-occur* (specifically, right events whose active portion contains the left event's onset). The result maintains the temporal *structure* of the left pattern: the output event inherits the left event's arc. Where a left event matches multiple right events (when the right pattern has higher density), the left event's time slot is subdivided.

**Example from the paper:**

```haskell
blend 0.5 <$> "[ black grey white ]" <*> "red green"
```

`blend` is a function from two colours to a blended colour. `<$>` applies `blend 0.5` to each colour in the left pattern, producing a pattern of partially-applied functions. `<*>` then applies each such function to the co-occurring colour in the right pattern. `red` matches the onsets of `black` and `grey` (two events in one cycle), so the output is blends of `(red,black)` and `(red,grey)`. `green` matches `white`. The result is four blended events per cycle.

**Design consequence:** Any existing binary function `f :: a -> b -> c` can immediately be used as a pattern combinator via `f <$> p1 <*> p2`, without writing any pattern-aware code. This is a significant composability multiplier: the library's entire vocabulary of value operations becomes pattern operations for free.

The left-pattern-structure-preservation is a design choice. An alternative Applicative where the right pattern's structure is preserved would be equally valid mathematically but less useful musically: the temporal structure of the "main" pattern (the theme) is usually what the musician wants to preserve while varying the "decoration" (the values from the secondary pattern).

For murail: if the composition language exposes a parametric pattern type, making it Applicative in this sense would give all value-level operations automatic pattern-level promotion. This is a direct candidate design pattern. The matching semantics (co-occurrence by onset containment) would need adaptation to murail's signal-based model (where "onset containment" translates to "active at the same sample boundary"), but the structural insight is portable.

Extends [[representing-musical-pattern-as-a-function-from-time-to-events-unifies-discrete-and-continuous-patterns]] -- the Applicative instance only works cleanly because both patterns share the `Arc -> [Event a]` representation; mixing discrete and continuous patterns in the application is handled uniformly.

---

Topics:
- [[language-design]]
- [[formal-methods]]
