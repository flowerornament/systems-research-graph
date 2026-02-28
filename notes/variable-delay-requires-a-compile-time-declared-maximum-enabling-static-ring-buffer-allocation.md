---
description: The self@φ_d form allows runtime delay amounts but requires declaring D_max at compile time; this converts an apparently dynamic feature into a statically-bounded one
type: decision
evidence: strong
source: [[murail-substrate-v3]]
created: 2026-02-28
status: active
---

# variable delay requires a compile-time declared maximum enabling static ring buffer allocation

Variable delay (`self@φ_d` and `n@φ_d`) allows the delay amount to be computed at runtime -- a crucial feature for effects like pitch-shifting, chorusing, and doppler simulation where the read position changes per tick. The design tension: how do you support dynamic delay amounts while maintaining the static memory allocation guarantee?

The resolution is `D_max(n)`: a compile-time declared upper bound on the delay. This bound determines ring buffer depth: `depth(n) = 1 + D_max(n) + (M - 1)` where M is the interpolation tap count. The buffer is pre-allocated at startup; the runtime simply updates the head index and reads from the computed offset.

The semantics enforce the bound: if `d(t) < 1` or `d(t) > D_max(n)`, the equation produces the default element `e_n` and sets an error flag. This is the standard Murail degradation pattern -- no crash, no undefined behavior, just flagged fallback.

**Interpolation is integrated.** When the delay amount is non-integer, the result is interpolated between adjacent samples using one of four modes: `none` (nearest sample), `linear` (2 taps), `cubic` (4 taps), or `sinc(W)` (2W taps). The tap count adds to buffer depth, so a sinc interpolator with W=8 on a D_max=100 delay needs a ring buffer of depth 117. All of this is determined at compile time.

**Static delays are a special case.** `self@d` with literal d is variable delay where D_max = d and α = 0 always, so no interpolation is needed. The unified treatment means the compiler handles both through the same mechanism.

## Connections

- This is part of the static state region guarantee ([[all-murail-program-state-fits-in-a-single-pre-allocated-contiguous-region]]); variable delay without D_max would require dynamic allocation
- The fallback behavior on out-of-range delays is governed by the output continuity axiom ([[the-murail-fast-thread-never-halts-errors-degrade-quality-but-do-not-stop-evaluation]])
- [[faust-recursive-composition-with-implicit-one-sample-delay-is-the-primitive-for-all-feedback]] uses only static delays; Murail's variable delay form generalizes this to runtime-computed lookback
