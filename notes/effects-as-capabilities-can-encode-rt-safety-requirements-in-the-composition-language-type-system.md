---
description: Representing RT-unsafe capabilities as value-level tokens means functions lacking the allocation and I/O tokens are statically guaranteed RT-safe without burdening users with annotations
type: claim
evidence: moderate
source: [[pl-research-landscape-2026-02-27]]
created: 2026-03-01
status: active
---

# effects as capabilities can encode RT-safety requirements in the composition language type system

The effects-as-capabilities approach (Brachthaeuser, Schuster, Lee, Ostermann. OOPSLA 2020) represents effects not as type-level annotations but as value-level capability tokens. A function that performs I/O receives an I/O capability as an argument; a function that doesn't perform I/O simply doesn't have the capability in scope. This achieves lightweight polymorphism: a function is generic over its effects without heavyweight type annotations -- it either has the capability or it doesn't.

Murail's RT-safety requirement (D53) is a set of capability absences: RT-thread code must not perform I/O, must not allocate, must not block. In the effects-as-capabilities model, this is expressible as: RT functions lack the I/O capability, the allocation capability, and the blocking capability. The NRT thread has all capabilities. Code that runs on the RT thread simply has no path to invoke these capabilities -- not by convention enforced by code review, but by the type system of the composition language.

This is architecturally distinct from Rust's ownership system, which enforces memory safety and some allocation discipline but does not statically prevent all RT-unsafe patterns (calling allocating library functions, performing syscalls through unsafe wrappers, etc.). The composition language could provide an additional layer: functions written for RT execution receive only the "pure computation" capability, statically preventing them from calling anything that would block.

The implementation path matters here. The Leijen-family algebraic effects approach (which Murail has already examined via [[algebraic-effects-implement-domain-specific-dsls-by-separating-the-operation-interface-from-evaluation-strategy]]) uses type-level effect rows. The capability approach uses value-level tokens. The capability approach is lighter-weight: no effect polymorphism, no row-type inference -- just "does this function have access to the capability object?" This may be more appropriate for Murail's composition language than full algebraic effects.

The connection to the existing effects analysis is important. The earlier Sussman research analysis concluded that full algebraic effects are likely redundant with the rate lattice for core signal processing. But the RT-safety use case is different from tracking computational effects in signal paths: RT-safety is about preventing entire categories of operations (system calls, allocation), not about tracking which computations run at which rate. Effects as capabilities addresses this orthogonal concern without requiring the full apparatus of effect type systems.

Complements [[effect-type-absence-is-a-proof-of-non-interference]] -- that claim establishes the soundness result; this claim applies the capability pattern specifically to RT-safety. Contrasts with [[row-typed-effects-compose-freely-because-they-are-restricted-to-the-free-monad]] which addresses a heavier-weight approach to the same problem. See also [[well-typed-algebraic-effect-programs-cannot-invoke-unhandled-operations]] for the soundness basis.

---

Topics:
- [[language-design]]
- [[concurrent-systems]]
- [[formal-methods]]
- [[algebraic-effects]]
