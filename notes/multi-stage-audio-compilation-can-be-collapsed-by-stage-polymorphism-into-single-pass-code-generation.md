---
description: If each compilation layer is written in a stage-polymorphic style, a composition-language expression could compile directly to machine code without materializing intermediate graph representations
type: claim
evidence: moderate
source: [[pl-research-landscape-2026-02-27]]
created: 2026-03-01
status: active
---

# multi-stage audio compilation can be collapsed by stage polymorphism into single-pass code generation

The "Collapsing Towers of Interpreters" result (Amin and Rompf, SPLASH 2017/POPL 2018) shows that multiple layers of interpretation can be collapsed into single-pass compilation via stage polymorphism. A program in language A, interpreted by an interpreter in language B, interpreted by an interpreter in language C, compiles directly from A to machine code if the interpreters are written in a stage-polymorphic style -- the evaluation stages are statically composable rather than dynamically stacked.

Murail has exactly three interpretation layers: the composition language describes musical structure, the graph IR describes signal processing topology, and the compiled schedule describes concrete buffer operations. Each layer interprets the one above it. If these interpreters are designed with stage boundaries that a partial evaluator can collapse, a composition-language expression like `sine(440) |> lpf(1000, 0.7) |> out` could compile directly to a tight buffer-processing loop without materializing the graph IR at all -- the intermediate representation becomes a compile-time artifact that the partial evaluator eliminates.

The practical implication is architectural: the graph IR should be designed not as a necessary runtime object but as a compile-time artifact. Its presence in the final compiled schedule should be optional -- achievable when stages collapse, omittable when they do not need to. This is a different design stance than treating the graph IR as the definitive execution representation.

For v1, this is aspirational rather than immediately actionable. The compile-swap-retire lifecycle (Section 35) and the Deep compilation service level (D65, P99 <= 500ms) make full graph materialization necessary in the near term. But the architectural implication is that the graph IR's interface boundaries should be designed so that stage polymorphism is possible in principle -- that future optimization can eliminate interpretation layers without requiring a pipeline redesign.

The "functions as templates" axiom already reflects one instance of stage collapse: function calls in the composition language stamp equations into the graph at construction time (a compile-time operation). Stage polymorphism generalizes this pattern across all three layers.

Complements [[the-rate-lattice-provides-exactly-the-static-dynamic-parameter-separation-that-partial-evaluation-requires]] -- stage collapse is the more aggressive form of the same partial-evaluation insight. Connects to [[interactive-programming-eliminates-the-compile-run-cycle]] because stage collapse would reduce compilation latency toward the LiveFast service level target. See also [[unifying-program-and-metaprogram-eliminates-two-world-complexity-of-templates]] for the general principle of reducing meta-levels.

---

Topics:
- [[audio-dsp]]
- [[compiler-and-adoption]]
- [[language-design]]
