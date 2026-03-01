---
description: E-graph saturation is monotonic and naturally terminates, making hand-enumerated termination guards unnecessary if optimization is formulated as saturation then extraction
type: claim
evidence: strong
source: [[pl-research-landscape-2026-02-27]]
created: 2026-03-01
status: active
---

# equality saturation can replace hand-coded rewrite rules with automatically discovered provably terminating optimizations

The equality saturation research program (egg library and descendants, Nandi et al. OOPSLA 2021, 2023; Goharshady et al. OOPSLA 2024) offers an alternative to manually enumerating algebraic rewrite rules for graph optimization. Rather than maintaining a catalogue of 120+ rules, the approach is: specify the algebraic properties of your domain (commutativity, associativity, distributivity, identity elements), let the system discover valid rewrites by exploring the e-graph, then extract the optimal program by applying a cost function to all equivalent representations.

The critical property for Murail is that saturation is monotonic -- the e-graph only grows as new equivalences are discovered, never shrinks. This means saturation naturally terminates when no new equivalences can be found. The three-guard termination protocol in D67-D68 (which prevents rewrite divergence in the current hand-coded rule set) becomes structurally unnecessary: divergence is not possible in the saturation model because equivalences are recorded, not applied destructively.

The Nandi et al. 2023 paper (Enumo) addresses scalability via guided exploration: domain experts define the *shape* of the search space via "rule lifting" -- prove rules for scalar arithmetic, lift them to tensor arithmetic, lift again to rate-annotated operations. For Murail, this maps to a natural three-tier lifting: scalar float operations lift to rated tensors (the formal model's algebraic spaces, Definition 7.1), which lift again to operations with rate annotations (the rate lattice, Definition 8.1). Rate conversion identities (`audio_to_control(control_to_audio(x)) = x` when compatible) and algebraic space properties define the exploration shape.

The extraction phase (Goharshady et al. 2024) is particularly valuable for audio: "optimal" is context-dependent. The LiveFast compilation service level (D65) wants the fastest-to-compile equivalent graph; the Deep service level wants the one minimizing RT CPU usage. Different cost functions applied to the same e-graph produce different optimal programs -- multiple compilation strategies without paying exponential cost for any.

The formal model's algebraic spaces (Definition 7.1) have exactly the rich algebraic structure that equality saturation excels at exploiting: addition and multiplication over signal spaces, rate lattice properties, scalar-signal interactions, DSP identities like `gain(1.0, x) = x` and `delay(0, x) = x`. This suggests the graph optimizer could be mechanized almost entirely from the formal model's specifications rather than from hand-coded rules.

Connects forward to [[construction-time-graph-optimization-distributes-compiler-cost-across-node-creation]], which describes the current construction-time approach that equality saturation could replace or complement. The formal model's space algebra (Definition 7.1) provides the algebraic specification equality saturation needs. See also [[faust-symbolic-propagation-normalizes-structurally-different-programs-that-compute-identical-functions]] for the FAUST prior art on symbolic normalization.

---

Topics:
- [[audio-dsp]]
- [[compiler-and-adoption]]
- [[formal-methods]]
