---
description: A single coherent language can combine mathematical notation's suggestivity and economy with programming languages' executability and universality, a combination neither tradition achieves alone
type: claim
evidence: strong
source: [[iverson-1980-notation-as-tool-of-thought]]
created: 2026-02-28
status: active
---

# executable notation combines universality with mathematical suggestivity

Iverson's central thesis: "the advantages of executability and universality found in programming languages can be effectively combined, in a single coherent language, with the advantages offered by mathematical notation." Neither tradition has both. Mathematical notation has suggestivity, subordination of detail, economy, and amenability to proof -- but lacks universality (context-dependent interpretation) and executability (no machine can run it). Programming languages have executability and universality -- but lack the notational properties that make mathematical notation a tool of thought.

APL is proposed as the proof-of-concept: a language that originated in writing and teaching (not from implementation requirements), implemented as a programming language only after years of development as a notation. This origin matters: APL's design was driven by what makes reasoning easier, not by what compiles efficiently. The result is a language where the same expressions that are "run" by a computer can be read analytically (left-to-right, outer function first) and used in formal proofs.

The five criteria for good notation that the paper develops -- ease of expressing constructs, suggestivity, ability to subordinate detail, economy, and amenability to formal proofs -- are all properties that matter for thought. Executability adds a sixth: the ability to test ideas by running them, using the computer as an experimental instrument rather than a target machine.

Connects to [[interactive-programming-eliminates-the-compile-run-cycle]]: Rusher's argument for interactive programming is downstream of Iverson's argument for executable notation. Iverson establishes that executability is a property of the *notation* (not just the implementation); Rusher extends this to argue that the interaction loop should be immediate (compile inside the running program). Together they form the argument that the best tool for thought is a notation you can run interactively.

Grounds [[suggestive-notation-enables-discovery-through-structural-analogy]], [[subordination-of-detail-via-arrays-names-and-operators-extends-reasoning-range]], [[economy-of-notation-requires-compositional-grammar-not-a-large-primitive-vocabulary]], [[uniform-right-to-left-evaluation-eliminates-precedence-hierarchy-without-loss-of-expressiveness]], and [[executable-notation-enables-proof-by-exhaustion-through-systematic-case-enumeration]]. Extended by [[notation-shapes-thought-not-merely-expresses-it]] for the foundational philosophical claim.
