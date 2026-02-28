---
description: In SC, replacing a computed default like `2 + 2` with its literal `4` changes whether initialization is deferred or eager, producing an observable behavioral difference
type: claim
evidence: strong
source: "[[hadron-supercollider-symposium-2025-keynote]]"
created: 2026-02-28
status: active
---

# constant folding can silently change sc program semantics via initialization timing

Constant folding — evaluating compile-time-constant expressions ahead of runtime — is one of the most basic compiler optimizations. Replacing `2 + 2` with `4` in a compiled artifact is universally considered semantics-preserving. In SuperCollider, it is not.

SC's frame initialization distinguishes between literal defaults (placed in the frame prototype) and computed defaults (deferred to a per-call initialization block). Whether a default is literal or computed depends on whether it contains any expression — even `2 + 2`. If the compiler folds `2 + 2` to `4`, a default that was previously deferred (init value: nil, then computed to 4 at call time) becomes a literal (init value: 4, placed in prototype). The change is invisible in the source but produces different observable behavior: any argument that reads the now-literal value before its own initialization completes will see 4 instead of nil.

This means that a standard optimization pass in a Hadron compiler would silently break user code that happens to depend on the nil-then-four sequencing. The Hadron developer cites this as a concrete example of how [[deferred-argument-initialization-exposes-sc-frame-setup-order-as-observable-behavior]] creates irreversible implementation lock-in: [[observable-semantics-lock-in-implementation-details-and-block-optimization]].

For murail: initialization timing and evaluation order in the graph compiler must be explicitly specified as part of the compatibility surface. Optimization passes that alter evaluation timing must be classified as semantics-changing and handled through versioning.
