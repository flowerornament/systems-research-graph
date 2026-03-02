---
description: Murail substrate specification v3 (Feb 2026) -- domain-independent four-layer formal model for real-time recurrence over tensors
type: source
created: 2026-02-28
status: active
---

# murail-substrate-v3

**Source:** `/Users/morgan/code/murail/.design/formal-model/murail-substrate-v3.md`
**Date:** February 2026
**Relation to v8/v9:** Complementary. v8/v9 are the full Murail formal model; v3 substrate extracts the domain-independent core.

## Overview

A domain-independent specification for real-time recurrence over tensors, organized in four layers:

- **Layer 0 — The Calculus.** Named equations, guarded self-reference, dependency graph, shapes, rate lattice, dispatch
- **Layer 1 — The Execution Model.** State region, tick function, hold slots, smoothing, event queues, error model, threading, compilation
- **Layer 2 — The Liveness Model.** Edit transactions, migration, atomic swap, incremental recompilation
- **Layer 3 — The Domain Interface.** What a domain must provide to instantiate the substrate

The substrate is correct when three domains (audio, robotics, games) can each be instantiated from Layer 3 without modifications to Layers 0-2.

## Key Changes from v2 to v3

- §8.2: Explicit delay-by-type semantics for sets (j independent sub-buffers)
- §8.4: State region formula accounts for extern equation opaque state
- §11.2: Exclusion of `flag` overflow policy (violates output continuity axiom)
