---
description: Programming models inherited from punch cards impose compile-run separation, blank-slate initialization, and no runtime introspection -- costs that have nothing to do with the actual problem being solved
type: claim
evidence: moderate
source: [[stop-writing-dead-programs-jack-rusher-2022]]
created: 2026-02-28
status: active
---

# batch processing incurs avoidable cognitive overhead

Jack Rusher's central thesis: the compile-run cycle, linear execution, blank-state startup, and absence of runtime introspection are not inherent constraints of computing -- they are artifacts of the punch-card era. The 80-column terminal, VT100 escape codes, and batch job submission are still embedded in modern tooling not because they are optimal but because programmers who mastered the hard way perpetuate it rather than making it easy.

The overhead is specific: developers must emulate the computer in their heads during development because the machine cannot help them. Working memory capacity becomes the bottleneck, not problem complexity. Feedback loops of 45 minutes (card punch era) reappear as Docker/CI cycles of hours -- structurally the same problem.

This matters for [[language-design]]: a language designed for an audio graph engine should not inherit batch-processing assumptions from languages designed for input-output transformers. Murail's compile-and-swap model partially addresses this by separating graph compilation from graph execution, but the interactive programming ideal goes further -- the running graph itself should be inspectable and modifiable without restart.

See also [[interactive-programming-eliminates-the-compile-run-cycle]] which describes the alternative, and [[static-languages-prevent-runtime-introspection]] for the specific mechanism that enforces batch-mode thinking.
