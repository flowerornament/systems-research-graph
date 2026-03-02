---
description: Hold-slot reads produce stepped staircases; the substrate applies smoothing filters automatically at every cross-rate read so no domain has to reinvent parameter interpolation
type: decision
evidence: strong
source: [[murail-substrate-v3]]
created: 2026-02-28
status: active
---

# cross-rate smoothing eliminates staircase discontinuities from hold-slot reads

A hold slot's value changes only when the slow thread writes a new one. From the fast thread's perspective, the value is a staircase: constant within a slow-rate period, then jumping discontinuously to the next value. In audio, such jumps are zipper noise -- audible artifacts from abrupt parameter changes.

The substrate addresses this by making smoothing an automatic part of every hold-slot read. Four modes are available:

| Mode | Behavior |
|---|---|
| `step` | No smoothing (instantaneous jump) |
| `linear` | Linear interpolation over one slow-rate period |
| `exponential(τ)` | Exponential approach with time constant τ |
| `custom(f)` | Domain-provided smoothing function |

The default is `linear`. The smoothing invariant (Definition 10.5) specifies that smoothing is *always active* on hold-slot reads and *never active* on same-rate recurrence. This prevents double-smoothing: an equation reading its own `self@1` is never smoothed; an equation reading a control-rate value from a hold slot is always smoothed.

**Why this belongs in the substrate.** The substrate's remark on smoothing is worth quoting: "Without smoothing in the substrate, every domain independently reinvents parameter interpolation." This is an abstraction argument: the problem of smoothing fast-rate reads of slow-rate values is universal across audio, robotics, and games. Putting the mechanism in the substrate and letting the domain configure the default mode is strictly better than requiring each domain to rediscover it.

This is analogous to how hold slots themselves ([[hold-slots-prevent-fast-thread-blocking-on-slow-rate-values-without-locks]]) solve the universal problem of cross-rate communication -- both mechanisms exist to spare domains from solving the same structural problem repeatedly.

## Connections

- Directly extends [[hold-slots-prevent-fast-thread-blocking-on-slow-rate-values-without-locks]]; hold slots provide the value, smoothing removes the artifact from the delivery mechanism
- The default linear smoothing is the substrate's answer to the zipper noise problem that plagues control-rate parameter changes in SC, Max/PD, and most audio engines
- The "domain reinvents this" pattern that smoothing avoids is the same pattern that motivated abstracting hold slots into the substrate in the first place -- universal problems belong in the substrate, not in every domain
- In the audio domain instantiation, this connects to why compile-and-swap works without audible glitches in [[atomic-swap-enables-program-updates-at-tick-granularity-without-output-gaps]]: gauge annotations provide seamless transitions, but smoothing handles the continuous parameter updates
