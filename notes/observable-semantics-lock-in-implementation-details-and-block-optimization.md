---
description: When interpreter internals are observable, they become permanent user dependencies; future rewrites and optimizations are constrained by what was accidentally exposed
type: claim
evidence: strong
source: "[[hadron-supercollider-symposium-2025-keynote]]"
created: 2026-02-28
status: active
---

# observable semantics lock in implementation details and block optimization

A language runtime's internal implementation details — frame layout, initialization pass ordering, dictionary iteration order, calling convention edge cases — are not intended to be user-visible. But they become user-visible whenever they produce consistent observable output, and via [[hirams-law-makes-all-observable-interpreter-behavior-a-permanent-api-commitment]], any consistent observable output becomes a user dependency.

Once internals are locked as de facto observable behavior, three things become impossible without a compatibility strategy: (1) replacing the internals with a cleaner implementation that produces different outputs on edge cases; (2) applying standard optimizations that alter the timing or sequencing of operations (see [[constant-folding-can-silently-change-sc-program-semantics-via-initialization-timing]]); (3) adding new language features that require rethinking scope or initialization rules (see [[deferred-argument-initialization-exposes-sc-frame-setup-order-as-observable-behavior]]).

The Hadron developer frames this as "designing an interpreter in a vacuum is a foolish exercise" — you will produce technical artifacts that cannot be adopted because their observable behavior is not the old observable behavior, and a changed observable behavior breaks existing code. At the same time, maintaining the old observable behavior means inheriting all its constraints.

The antidote is not secrecy about internals, but explicit compatibility classification: which behaviors are guaranteed (publicly committed), which are version-gated (subject to change with notice), and which are explicitly unspecified (no compatibility promise). For murail, this maps directly to the IR specification: evaluation order, scheduling timing, and graph mutation semantics must each be explicitly placed into a compatibility class before optimization work begins.
