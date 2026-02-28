---
description: Sussman argues that the dominant engineering challenge is not correctness but evolvability, and that generic extensibility achieves this at the cost of formal verifiability
type: claim
evidence: strong
source: [[we-dont-know-how-to-compute-sussman-2011]]
created: 2026-02-28
status: active
---

# evolvability requires trading provability for extensibility

Sussman's central thesis in the 2011 Strange Loop talk: the dominant unsolved problem in software engineering is not correctness but *evolvability* -- building systems that remain useful for purposes the designer never anticipated. Current practice optimizes for the wrong thing.

The argument proceeds in two steps:

**Step 1: Tight proofs demand tight specs.** Formal verification requires that component interfaces be specified as narrowly as possible (because broad specs are harder to prove). This tightness produces brittle towers: the system works perfectly for the specified case, but changing the problem requires touching the whole tower. Sussman calls this "programming yourself into holes."

**Step 2: Extensibility buys evolvability but breaks proofs.** Dynamically extensible generic operations (operator dispatch that can be extended at runtime) allow existing code to run over new data types without modification. The program written for numbers suddenly works on matrices, functions, or symbolic expressions -- just by registering new dispatch cases. But this extensibility makes proofs very difficult or impossible: you can no longer enumerate what a generic operation will do at compile time.

The design choice is explicit: pay correctness (or proof-of-correctness) for flexibility. Sussman argues this is the right trade for almost all real systems, because the world changes and specs are always wrong.

This is in tension with [[type-systems-have-not-empirically-reduced-defect-rates]] (which argues empirically that type-based proof doesn't improve defect rates anyway) and extends [[debuggability-is-more-valuable-than-correctness-by-construction]] (which argues from the software lifecycle perspective that live debugging outweighs static guarantees). Sussman adds the formal argument: tight specs are brittle by construction.

However, [[rust-safety-with-unsafe-code-requires-semantic-rather-than-syntactic-proof-methods]] suggests a third path: Rust's semantic proof method is itself extensible -- the proof technique scales as new libraries are added. This partially dissolves the tradeoff Sussman identifies: if the proof method is open-world, extensibility does not necessarily break verifiability.

Naur's [[programming-is-theory-building-not-text-production]] adds a social dimension that Sussman's framing omits: evolvability also requires that the theory be transferable across team transitions. Tight specs can be extensible architecturally (Sussman's concern) while still being brittle organizationally (Naur's concern) because the tacit design rationale embedded in [[the-programmers-theory-includes-why-alternatives-were-rejected-not-just-what-was-chosen]] cannot survive team turnover.
