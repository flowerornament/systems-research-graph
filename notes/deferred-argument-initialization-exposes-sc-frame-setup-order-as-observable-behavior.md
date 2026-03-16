---
description: SC's two-pass frame initialization makes argument default expressions evaluate with a partially-initialized scope, producing counterintuitive values that users depend on
type: claim
evidence: strong
source: "[[hadron-supercollider-symposium-2025-keynote]]"
created: 2026-02-28
status: active
---

# deferred argument initialization exposes sc frame setup order as observable behavior

SuperCollider's calling convention initializes function frames in two distinct passes. First, a prototype frame is copied with all literal (compile-time-computable) values as defaults; any default that requires computation is marked as deferred (nil in the frame prototype). Second, after argument values are copied over, a code block at the start of every function evaluates deferred defaults for any argument that was not supplied.

This creates a subtlety: during deferred initialization, all variables are in scope but some have their literal default values while others are still nil. A function like `f { arg a = b + c + x + y; ^a }` with `b=1, c=2, x=2, y=1` evaluates to 6 (all available as literal defaults), but `f { arg a = x; var x = 2 + 2; ^a }` evaluates to nil because `x` is deferred (its default requires computation), is therefore nil at argument-initialization time, and is then initialized to 4 — but only after `a` has already captured nil.

This behavior is an implementation detail of the frame initialization sequence. It is not a designed language feature. But via [[hirams-law-makes-all-observable-interpreter-behavior-a-permanent-api-commitment]], it has become observable and therefore locked in: any reimplementation (including Hadron) must reproduce it exactly, or risk breaking code that accidentally depends on it.

The deferred initialization also blocks constant folding: see [[constant-folding-can-silently-change-sc-program-semantics-via-initialization-timing]].
