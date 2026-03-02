---
description: A language intended for use as a library cannot require embedding its full runtime in every consumer, or the cost of adoption eliminates the advantage of the library
type: claim
evidence: strong
source: [[stop-writing-dead-programs-jack-rusher-2022]]
created: 2026-02-28
status: active
---

# library languages must not bundle a mandatory runtime

Rusher's critique of Go as a library language: using a Go library from C or another host requires importing the entire Go runtime (~2MB). This is a disqualifying cost for embedded or plugin contexts where size and startup time are constrained. Go was designed as a standalone application language, not a library, and this shows.

The positive example Rusher implicitly supports: Rust produces native code with no mandatory runtime, making it suitable as a library for C, C++, Python, and other hosts. This is one property Rusher credits to Rust despite his broader critique of its interactive programming shortcomings.

For [[rust-ecosystem]] in murail: this is a foundational design constraint. Murail targets use as an embeddable audio library from DAWs, plugins, and native applications. A mandatory runtime would be incompatible with that target. Rust's zero-runtime library model, combined with C FFI via cbindgen, is the correct choice for this constraint.

Connects to [[language-design]] discussion of what it means for a language to be "embeddable" -- the distinction is not just ABI compatibility but runtime isolation. An embeddable library must not own global state, must not spawn background threads without host cooperation, and must not require a specific allocator.

Relates to [[batch-processing-incurs-avoidable-cognitive-overhead]] in a different dimension: Go's runtime bundling is an architectural consequence of designing for batch-mode operation (compile once, run as a standalone process) rather than for integration.

Historical existence proof: [[sapf-was-factored-into-an-embeddable-c-library-by-replacing-the-parser-with-c-functions]] demonstrates this pattern for a signal processing language. McCartney embedded SAPF in C by eliminating the parser (the runtime-requiring part) and exposing the execution engine as C functions. The execution engine IS the library; the parser is not required.

**Second existence proof:** [[faust-separates-dsp-specification-from-host-architecture-enabling-multi-target-retargeting]] shows the same principle applied in a compiled DSP language. The FAUST compiler generates a self-contained C++ class with no DSP library or runtime dependencies. Architecture files wrap this class for each host environment. The generated class is the library; the FAUST runtime is not required at host embedding time.
