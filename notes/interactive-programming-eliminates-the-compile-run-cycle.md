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

Contrasted with [[batch-processing-incurs-avoidable-cognitive-overhead]], which describes the inherited costs this approach eliminates. The structural case is even stronger: since [[long-running-servers-require-continuity-oriented-programming-models]], the batch model fails precisely for the programs that dominate production -- servers, GUIs, and audio engines that accumulate state over hours or days and never start from blank. Related to [[static-languages-prevent-runtime-introspection]], which explains why most compiled languages cannot provide this.

MetaSounds ([[channel-agnosticism-metasounds-aaron-mcleran-adc]]) presents an interesting partial case: [[JIT-graph-compilation-enables-context-aware-channel-format-inference-at-playback-time]] is a form of compilation inside a live system, but the "live" moment is playback start rather than edit time. MetaSounds explicitly rejects mid-execution graph mutation -- the interactive programming ideal applied to audio systems conflicts with the RT stability requirement, showing that interactive programming's benefits have domain-specific limits. This tension has deep historical precedent: [[supercollider-client-server-architecture-moved-the-scripting-language-out-of-the-real-time-audio-thread]] documents how SC2's approach of running scripting in the RT thread caused audio glitches, forcing the SC3 client-server split -- an architectural concession that traded interactivity immediacy for RT safety.

Short feedback loops produced by interactive environments are also the mechanism behind productive data science tooling (R, Jupyter): Rusher notes the data science community rediscovered interactive programming because re-loading large datasets on every compile is obviously unacceptable.

Iverson's [[executable-notation-combines-universality-with-mathematical-suggestivity]] provides the deeper grounding: executability is a property of the *notation*, not just the runtime. APL was designed to be run experimentally, to test ideas expressed in the notation. Rusher's interactive programming ideal extends this from "run in a REPL" to "run inside the live running program." The through-line is that notation as a thought tool requires execution to complete the cognitive loop: express -> run -> observe -> refine. Without executability, notation is theory; without interactivity, executability is still batch science.

McCartney's 40-year trajectory ([[mccartney-ideas-2026-02-15]]) demonstrates concretely how the interactive programming ideal drives audio architecture. [[compile-and-swap-preserves-audio-continuity-during-recompilation]] is his specific solution to the latency-interactivity tradeoff: audio continues playing during whole-graph recompilation, achieving continuity without instant compilation. [[pervasive-immutability-dissolves-concurrency-problems-rather-than-managing-them]] enables another interactive property: lossless history via [[persistent-data-structures-make-lossless-undo-an-architectural-side-effect]]. Together, these three claims show how the abstract interactive programming ideal maps to concrete architecture in an audio-specific context.
