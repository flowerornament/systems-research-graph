---
description: Jack Rusher's Strange Loop 2022 talk arguing that modern programming inherits batch-processing pathologies from the punch-card era and that interactive programming environments are the remedy
type: claim
evidence: strong
source: https://www.youtube.com/watch?v=8Ab3ArE8W3s
created: 2026-02-28
status: active
---

# stop writing dead programs jack rusher 2022

Strange Loop 2022, 43 minutes. Jack Rusher traces how the compile-run cycle, 80-column terminals, VT100 codes, and batch job submission persist in modern tooling not because they are optimal but because programmers who mastered them perpetuate them. The alternative -- interactive programming environments where the editor and the running system are unified -- has existed since the 1970s (Lisp, Smalltalk) and produces dramatically shorter feedback loops, preserved runtime state, and live introspection.

**Archive location:** `/Users/morgan/code/murail/.design/references/transcripts/stop-writing-dead-programs-jack-rusher-2022.md`

## Claims extracted

- [[batch-processing-incurs-avoidable-cognitive-overhead]]
- [[interactive-programming-eliminates-the-compile-run-cycle]]
- [[erlang-actor-model-enables-safe-process-kill]]
- [[clojure-csp-channels-sacrifice-introspectability]]
- [[type-systems-have-not-empirically-reduced-defect-rates]]
- [[debuggability-is-more-valuable-than-correctness-by-construction]]
- [[library-languages-must-not-bundle-a-mandatory-runtime]]
- [[rust-lacks-interactive-programming-despite-suitable-foundations]]
- [[visual-representation-exposes-structure-text-notation-obscures]]
- [[propagator-networks-provide-provenance-for-computed-conclusions]]
- [[long-running-servers-require-continuity-oriented-programming-models]]
- [[static-languages-prevent-runtime-introspection]]
- [[smalltalk-image-model-prevents-source-runtime-drift]]
