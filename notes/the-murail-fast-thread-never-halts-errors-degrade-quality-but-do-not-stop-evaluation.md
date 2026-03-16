---
description: Output continuity is an axiom: no error reachable during TICK can cause the tick function to fail to return within the deadline; NaN/Inf substitution operationalizes it
type: property
evidence: strong
source: [[murail-substrate-v3]]
created: 2026-02-28
status: active
---

# the murail fast thread never halts errors degrade quality but do not stop evaluation

Axiom 12.1 states: "The fast thread never halts. Errors degrade quality but do not stop evaluation. No error condition reachable during TICK causes the tick function to fail to return within the deadline."

This is not a goal or aspiration -- it is an axiom, a design constraint the entire Layer 1 execution model is built to satisfy. Every error handling decision in the substrate follows from it:

| Error | Fast-thread response |
|---|---|
| NaN / Inf result | Substitute last valid value (or e_n if none); set error flag |
| Missing reference | Resolve to e_n; set error flag |
| Division by zero | Produce e_n |
| Variable delay out of range | Produce e_n; set error flag |
| Event queue overflow | Apply overflow policy (drop_newest / drop_oldest / overwrite) |

The NaN/Inf substitution in the TICK pseudocode is the operational content of this axiom. The fast thread actively checks every equation output and substitutes rather than propagating the error downstream. The error flag is readable by the slow thread for logging and diagnostics.

**Why `flag` overflow policy is excluded.** The full Murail model (v8/v9) defines a fourth event queue overflow policy: `flag` (halt until queue drains). The substrate excludes it because halting the fast thread violates this axiom. The three retained policies all degrade gracefully without blocking. This is an example of a design decision that must be justified by the axiom even when the feature seems useful.

**Relation to load shedding.** Load shedding (skipping non-critical equations under deadline pressure) is also governed by this axiom: shed equations hold their last valid value rather than producing stale or undefined results. The fast thread continues producing output, just lower-quality output.

## Connections

- This axiom directly motivates the no-allocation and no-blocking constraints in Axiom 12.2 (resource invariant), which is what [[all-murail-program-state-fits-in-a-single-pre-allocated-contiguous-region]] implements
- [[load-shedding-preserves-the-critical-set-exactly-while-degrading-non-critical-equations]] is the application of this axiom to deadline overruns
- [[inference-engines-violate-real-time-principles-on-every-inference-not-just-initial-ones]] shows what happens when this axiom is violated in practice (blocking the audio callback)
- The SC/Max/PD analog is that these engines stop or glitch on NaN propagation; Murail's explicit substitution policy is the architectural alternative
