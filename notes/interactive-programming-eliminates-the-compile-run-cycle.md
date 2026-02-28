---
description: Interactive programming environments combine the editor and the running program, enabling compilation inside a live system with preserved state, runtime introspection, and failure recovery without restart
type: claim
evidence: strong
source: [[stop-writing-dead-programs-jack-rusher-2022]]
created: 2026-02-28
status: active
---

# interactive programming eliminates the compile-run cycle

Rusher defines interactive (or "live") programming by four properties that invert batch-mode assumptions: (1) no compile-run cycle -- code is compiled inside the running program; (2) no blank-slate startup -- all program state persists while changes are made; (3) full runtime introspection available during development; (4) failures surface as recovery options rather than program termination.

The productivity of spreadsheets comes almost entirely from these properties. The Common Lisp condition system (pop-up handler with retry, fix-and-continue options) is a 1980s implementation. Smalltalk image-based development makes the text file and the runtime image one thing -- deleting a method removes it from the running system, so there is no file-runtime drift.

For [[language-design]]: an audio graph engine whose graph can be mutated at runtime (as murail targets via compile-and-swap) is moving toward this model. The key property missing from compile-and-swap is state continuity -- swapping a new graph loses the running audio state. A fully interactive audio engine would allow incremental node replacement with state threading.

Contrasted with [[batch-processing-incurs-avoidable-cognitive-overhead]], which describes the inherited costs this approach eliminates. Related to [[static-languages-prevent-runtime-introspection]], which explains why most compiled languages cannot provide this.

Short feedback loops produced by interactive environments are also the mechanism behind productive data science tooling (R, Jupyter): Rusher notes the data science community rediscovered interactive programming because re-loading large datasets on every compile is obviously unacceptable.
