---
description: Naur argues programming education focused on syntax, algorithms, and coding technique fails to develop the capacity for theory-building, which is the core skill of programming
type: claim
evidence: moderate
source: [[naur-1985-programming-as-theory-building]]
created: 2026-02-28
status: active
---

# programming education should develop theory-building capacity not text-writing technique

Naur's educational conclusion: if programming is fundamentally theory-building, then programming education that focuses on text production -- learning syntax, mastering algorithms, practicing coding patterns -- is missing the point. The core skill being developed is the wrong one.

What theory-building capacity involves, by implication:

1. **Problem domain understanding**: The ability to develop a theory of the problem (not just the solution). This requires understanding what the program is *for*, not just what it does.

2. **Design judgment**: The ability to evaluate whether a proposed solution is coherent with the existing design, and to know *why* certain choices are better -- not just that they pass tests.

3. **Tacit knowledge transfer**: Learning to work alongside experienced programmers, absorbing the theory through practice and exposure, not through reading.

4. **Preserved alternatives**: The habit of recording not just decisions but the space of alternatives considered, so that the theory includes the negative knowledge.

The critical implication: programming education that teaches how to produce text -- how to use a language, how to implement algorithms, how to write clean code -- does not develop the ability to hold and build theories. It develops text-production skill, which is a necessary but insufficient condition for programming competence.

This has a direct parallel to [[JUCE-abstracts-away-audio-engine-fundamentals-producing-developers-who-cannot-reason-about-threading-and-resource-management]]: JUCE-based education produces text-writing proficiency (writing the DSP loop) without theory-building capacity (understanding why the architecture is organized as it is). McCartney's prescription ([[audio-programming-education-requires-reading-production-engine-source-code-across-multiple-systems]]) is implicitly a theory-building education: reading multiple engines builds understanding of the design space and why different choices were made.

For murail's design documentation: the knowledge graph is an attempt to make theory-building artifacts visible and transferable. The rationale notes, observations, and derivation files are theory-building artifacts, not just documentation artifacts. They serve a different function than API docs or architecture diagrams.

Connects to [[debuggability-is-more-valuable-than-correctness-by-construction]]: both Rusher and Naur argue that the dominant paradigm optimizes for the wrong thing (correctness guarantees vs. theory building). Naur's educational critique and Rusher's DX critique converge on the same structural point.
