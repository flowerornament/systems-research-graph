---
description: Parameters at constant and init rate are compile-time known; partial evaluation can specialize generic DSP code to them, eliminating abstraction overhead on the RT path
type: claim
evidence: strong
source: [[pl-research-landscape-2026-02-27]]
created: 2026-03-01
status: active
---

# the rate lattice provides exactly the static/dynamic parameter separation that partial evaluation requires

AnyDSL (Leissa et al. OOPSLA 2018) demonstrates partial evaluation for high-performance library code: write generic DSP functions with annotations marking which parameters will be known at compile time; the partial evaluator specializes the code to those parameters, producing tight target-specific loops without abstraction overhead. The demonstration covers CPU, GPU, and FPGA targets from a single generic library.

Murail's rate lattice (Definition 8.1) provides the static/dynamic separation that partial evaluation exploits, without requiring programmer annotations. The lattice levels are exactly: constant rate (known at definition time, fully static), init rate (known at graph construction time, static for a given compilation), control rate (varies between audio blocks, dynamic), audio rate (varies within blocks, maximally dynamic). The formal model's rate inference (Definition 8.2) computes this separation automatically for every expression in the graph.

The practical consequence is direct: a generic one-pole filter function takes sample rate, coefficient, and input signal. At graph compilation time, sample rate and coefficient (if constant or init rate) are known. Partial evaluation specializes the generic filter to a tight loop that multiplies by a pre-computed constant, eliminating the coefficient lookup, rate check, and abstraction overhead. The resulting code is what a hand-specialized implementation would write -- achieved automatically from a generic library.

The "functions as templates" axiom in Murail's composition language design resonates with this. In McCartney's system, calling a function stamps equations into the graph; the function call is a compile-time operation, the equations are the generated program. This is literally staged compilation: the composition language is a program generator (static stage), and the graph IR is the generated program (dynamic stage). Partial evaluation could collapse these stages further by specializing the graph IR with respect to compile-time-known parameters.

The broader implication for library design: UGens written as generic functions with clear rate annotations are automatically specializable by the compiler without any target-specific code in the UGen library itself. This is McCartney's "there are no unit generators" idea -- primitives rather than opaque objects -- mechanized through partial evaluation.

Extends [[eliminating-unit-generators-exposes-synthesis-graphs-to-cross-boundary-compiler-optimization]] by providing the mechanism through which primitive-level graphs enable optimization. Connects to [[construction-time-graph-optimization-distributes-compiler-cost-across-node-creation]] -- construction-time rate inference is the prerequisite for effective partial evaluation at compile time. See also [[faust-signal-type-inference-classifies-computation-rate-to-enable-appropriate-caching]] for the FAUST prior art on rate classification.

---

Topics:
- [[audio-dsp]]
- [[compiler-and-adoption]]
- [[language-design]]
