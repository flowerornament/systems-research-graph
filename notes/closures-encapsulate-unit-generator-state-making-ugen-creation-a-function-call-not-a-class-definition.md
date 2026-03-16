---
description: SuperCollider 1 implemented UGens as closures whose environments hold oscillator phase and filter delay state, so creating a UGen is a function call that captures state into the closure
type: pattern
evidence: strong
source: "[[mccartney-1996-supercollider-icmc]]"
created: 2026-03-01
status: active
---

# closures encapsulate unit generator state making UGen creation a function call not a class definition

Most synthesis systems implement unit generators as objects: a class definition with named instance variables for state (oscillator phase, filter delay lines), and a `tick()` or `process()` method. Creating a UGen means instantiating a class.

SuperCollider 1 took a different approach: most UGens are implemented as *closures*. A closure is a function and its environment packaged as a single value. To create a UGen, you call a function that creates a closure which encapsulates the UGen's state in its environment -- phase, delay values, etc. The closure, when evaluated, produces the next signal buffer of output. Synthesis functions are expressions that produce a signal buffer each time they are evaluated (once per control period).

This is a specific application of the closure-as-object pattern: the environment plays the role of instance variables, and evaluation plays the role of the `process()` method. The advantage is that UGens require no class definitions -- they are first-class values created by ordinary function calls and usable wherever values are used. They compose naturally with the rest of the language (closures can call closures, return closures, store closures in lists).

The design has direct implications for synthesis graph construction: if every UGen is a closure, then composing a synthesis graph is composing closures. The resulting synthesis function is itself a closure whose evaluation produces a complete output buffer. This is structurally the predecessor to the "synthesis graph construction is a regular program" insight McCartney carries forward in tau5 -- see [[synthesis-graph-construction-is-a-regular-program-not-a-domain-specific-declaration]].

For murail's UGen design, this pattern is relevant but inverted: murail eliminates UGen objects entirely in favor of four arithmetic primitives (see [[eliminating-unit-generators-exposes-synthesis-graphs-to-cross-boundary-compiler-optimization]]). The closure approach encapsulates state behind a function boundary; murail's approach exposes state explicitly in the compiled schedule's state region. The tradeoff is expressiveness vs. compiler visibility: closures are ergonomic but opaque to the optimizer; explicit state in a flat region enables cross-boundary optimization.

The closure pattern is also notable as the original mechanism for what murail now formalizes as the "rate" attribute of graph nodes. In SC1, the closure's evaluation is the audio-rate tick; control-rate or static values are just captured variables in the environment. The rate lattice (see [[faust-signal-type-inference-classifies-computation-rate-to-enable-appropriate-caching]]) is a principled generalization of this informal distinction.

---

Topics:
- [[audio-dsp]]
- [[language-design]]
- [[mccartney-language-design]]
- [[competing-systems]]
