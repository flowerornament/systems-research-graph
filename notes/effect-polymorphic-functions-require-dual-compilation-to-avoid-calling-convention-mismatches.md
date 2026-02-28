---
description: Functions polymorphic in an effect variable need two compiled versions (CPS and direct-style) with a runtime dispatch wrapper because the presence or absence of a continuation argument cannot be resolved at compile time
type: claim
evidence: strong
source: [[leijen-algebraic-effects]]
created: 2026-02-28
status: active
---

# effect polymorphic functions require dual compilation to avoid calling convention mismatches

Leijen identifies a fundamental problem in the selective CPS translation: a function polymorphic in an effect variable `μ` (e.g. `map : (list⟨a⟩, a → e b) → e list⟨b⟩`) may be called in both CPS and non-CPS contexts at the same call site. The caller's context determines whether a continuation argument `k` is present.

The naive fix -- default `k = λx.x` if absent -- fails. The problem is that inside `mapcps`, the function argument `f` is called as a CPS function with a continuation argument. If `map` is instantiated at the empty effect, `f` is a non-CPS function (no continuation argument), but `mapcps` calls it as if it were CPS. Crash.

The solution is **polymorphic code duplication**: generate two versions of every effect-polymorphic function:
- `mapcps`: CPS-translated body, accepts continuation `k`
- `mapplain`: direct-style body, no continuation
- `map`: wrapper that checks `k?` at runtime and dispatches to the appropriate version

In JavaScript: `k !== undefined` is the check. In .NET: check whether the `Apply` method's `k` parameter was provided.

The code size cost: modest (20% increase in Koka's standard library despite many higher-order polymorphic functions). The benefit: call sites that can be resolved statically (monomorphized) get the plain version with full compiler optimization opportunity; effectful call sites get CPS.

This connects to a compiler design principle for [[language-design]]: polymorphism over effects requires materialized dual implementations, not just type erasure. Languages that want effect polymorphism must either pay this code-size cost or restrict what can be polymorphic. The comparison to worker-wrapper transformation in GHC is apt -- the dual-translation pattern mirrors the GHC technique of separating the "wrapper" (external interface) from the "worker" (actual implementation) for optimization.

See also [[type-directed-selective-cps-translation-eliminates-overhead-for-total-functions]] for the broader context of the selective CPS translation this duplication solves a problem within.
