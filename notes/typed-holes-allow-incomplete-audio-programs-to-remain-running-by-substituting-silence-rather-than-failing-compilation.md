---
description: Hazel's typed-hole semantics applied to audio means unfinished signal paths produce silence rather than compilation errors, keeping the audio system alive during composition
type: claim
evidence: moderate
source: [[pl-research-landscape-2026-02-27]]
created: 2026-03-01
status: active
---

# typed holes allow incomplete audio programs to remain running by substituting silence rather than failing compilation

Hazel (Omar et al. Strange Loop 2018, OOPSLA 2023 Distinguished Paper) establishes that programs with holes are not errors -- they are programs with unknown parts that can still be evaluated. A typed hole has a type inferred from its context, and the evaluator propagates holes through computation, producing results that contain holes where missing values would have contributed.

Applied to a live-coding audio environment, this means an unfinished signal path like `sine(440) |> ??? |> out` does not fail to compile. The hole `???` has type `Signal -> Signal` inferred from its context (a filter-shaped slot in the pipeline). The system can substitute a default value for the hole -- the identity function (pass-through), a zero function (silence at the hole), or the last-valid value (freeze) -- and continue producing audio from the completed portions of the signal path.

Each substitution strategy has different musical implications. Silence at the hole is the safest default: the musician hears that the signal path is incomplete there. Pass-through is useful for rapid prototyping: the signal flows through unchanged while the processing node is being designed. Freeze is useful for parameter slots: the signal continues using the last valid parameter value while a new one is being computed. A well-designed composition language would allow the musician to specify which substitution strategy applies to each hole.

The OOPSLA 2023 paper extends Hazel with "fill-and-resume" semantics: when a hole is filled, evaluation resumes from where the hole was, reusing all computation that didn't depend on the hole's value. This is incremental recompilation at the language level. For Murail, filling a typed hole would trigger incremental recompilation of only the subgraph that depended on the hole's identity, consistent with [[stable-node-identities-enable-adapton-style-incremental-recompilation-where-only-affected-subgraphs-are-recompiled]].

The formal model's edit transactions (Definition 14.1) and swap protocol (Definition 14.8) already enable live editing at the graph level. Typed holes extend this to the composition language level: during composition, incomplete programs are represented as graphs with hole-nodes that produce silence (or a default signal) rather than causing compilation failure. This turns the edit-compile-swap cycle into a continuous, always-running experience where the musician never hears silence due to a compilation error.

Connects to [[compile-and-swap-preserves-audio-continuity-during-recompilation]] -- typed holes are the language-level mechanism for audio continuity during composition; compile-and-swap is the graph-level mechanism during recompilation. Together they form a complete answer to the audio continuity requirement across all phases of the creative workflow. See [[interactive-programming-eliminates-the-compile-run-cycle]] for the broader ideal that typed holes advance.

---

Topics:
- [[audio-dsp]]
- [[language-design]]
- [[developer-experience]]
