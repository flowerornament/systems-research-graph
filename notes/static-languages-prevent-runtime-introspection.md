---
description: Languages that compile to static artifacts cannot support runtime introspection during development because the compilation step severs the connection between source and running system
type: claim
evidence: strong
source: [[stop-writing-dead-programs-jack-rusher-2022]]
created: 2026-02-28
status: active
---

# static languages prevent runtime introspection

Rusher's Go critique: Go has an excellent runtime for CSP concurrency (lightweight goroutines, fast garbage collector), but it is a completely static language. Despite having all the infrastructure for runtime queries -- channels with depth, goroutines with state -- you cannot ask questions of the running system from your editor because the compilation step creates a static artifact that exists separately from the development environment.

The contrast: Common Lisp allows compiling a function and immediately disassembling it to inspect generated machine code, all within the running image. You can set a variable, inspect its value, modify data structures, and query the state of any running subsystem without leaving the REPL. Julia offers the same capabilities for a modern typed language. This is "1980s technology" by Rusher's reckoning; static languages have simply not adopted it.

The practical consequence for debugging: when production failures occur, a static language gives you a core dump or a log with a stack trace. A live system gives you the actual runtime state at the moment of failure. The diagnostic power difference is enormous for complex stateful systems.

For [[language-design]] in murail: the murail graph compiler produces a static compiled graph artifact (the RT-ready `CompiledGraph`). This follows the static artifact pattern. The implication is that debugging a misbehaving audio graph requires logging, not inspection. A more interactive design would allow querying the running graph's node states directly.

This claim provides mechanism for [[batch-processing-incurs-avoidable-cognitive-overhead]] -- the static artifact is the proximate cause of the introspection gap. See also [[interactive-programming-eliminates-the-compile-run-cycle]] for the alternative architecture.
