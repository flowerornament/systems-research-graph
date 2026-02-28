---
description: Representing audio as lazy possibly-infinite lists lets programs access individual samples, concatenate them, and apply iterative random processes -- enabling "sonic composting" at the signal level
type: claim
evidence: moderate
source: [[2026-02-06-fmVdfQNPzkE]]
created: 2026-02-28
status: active
---

# lazy infinite lists enable sample-level access and sonic composting in signal graph languages

In SAPF, audio signals are lazy, possibly-infinite lists: they produce samples on demand and can be extended indefinitely. This representation is unusual among audio languages -- SuperCollider uses running unit generators with an internal buffer; Faust generates bounded block-processing C code; Max/MSP chains UGen-equivalent objects with fixed buffer sizes. SAPF's lazy list model makes samples first-class values that can be manipulated like any other list.

The consequence McCartney demonstrates: you can take a signal expression and print out the first N samples while still building the expression. You see the sample values before you play them. This is the "inspect before play" workflow: the lazy list is an intermediate object you can examine, extend with more processing, then realize to audio.

More significantly, the lazy list model enables sample-level composition. McCartney describes generating short noise snippets (a few samples), then repeatedly concatenating, filtering, delaying, and flanging them until they become "tones and noise textures" of increasing complexity. He credits Eric Lyon's concept of "sonic composting" for this pattern: applying arbitrary processes at random to a small initial sample, iterating, and allowing structure to emerge from accumulated transformation.

This is architecturally different from a block-processing model. In a block-processing model, you process N samples, produce N samples, and move on. The block boundary is a natural truncation point. In a lazy list model, there is no natural truncation: you can concatenate the first 3 samples of one signal with the first 7 samples of another, filter the result, and continue extending indefinitely. Composition happens at the sample level, not the block level.

The lazy list model also means SAPF programs can generate audio that is structurally complex before being played: a composition expressed as a lazily-evaluated list can be inspected, modified, and composed with other lists before any audio is rendered.

**Murail implication:** Murail's signal model uses typed matrices (shape × element type × rate). This is a block-oriented model: computation happens per-block, not per-sample. Sample-level access is possible through demand-rate UGens (see [[first-class-control-flow-nodes-in-synthesis-graphs-enable-conditional-and-demand-rate-execution]]) but is not the default. The lazy list model suggests an alternative: a composition layer above the graph IR that operates on lazy sequences, translating to efficient block processing at the runtime layer. This is the architecture of McCartney's newer DSP compiler: the front-end language uses lazy list semantics; the back-end compiler generates efficient block C code from those semantics. The semantic level and the execution level are different layers, not the same thing.

Connects to [[eliminating-unit-generators-exposes-synthesis-graphs-to-cross-boundary-compiler-optimization]] -- both claims point to the same underlying observation: when the "atoms" of a signal language are smaller (samples instead of blocks, arithmetic primitives instead of UGens), more composition is possible but more compiler work is needed to recover efficiency. The lazy list model is the language-level analog of the primitive IR: expressiveness at the cost of compilation work.
