---
description: Comprehending a new program requires learning its unique program language from scratch; knowing the underlying programming language is necessary but not sufficient
type: claim
evidence: moderate
source: [[baniassad-myers-2009-program-as-language]]
created: 2026-03-01
status: active
---

# reading an unfamiliar codebase is language learning not mere symbol lookup

Baniassad & Myers argue that programmers reading unfamiliar code are not doing "symbol lookup plus pattern matching." They are performing the same cognitive process as learning a new natural language: encountering unknown symbols, inferring grammar rules from context, gradually building a model of how abstractions relate and combine.

The analogy holds at several levels:

**Symbol learning**: Just as a Dutch speaker can leverage their existing Dutch vocabulary to make progress in Flemish, a programmer can leverage programming language knowledge and similar-domain experience. But the program language's specific abstractions must be learned anew. `foo.beConfungedWith(bar.theOtherOne, 3, SomethingOrOther::NotThisOne)` gives the machine a complete, unambiguous instruction. It gives the human reader nothing until they know the program language.

**Incremental acquisition**: Language learners start with conversational vocabulary (enough to order coffee) before mastering complex grammar. Programmers do the same: start with enough understanding to make a small change, then gradually build out knowledge of larger abstractions and their interaction rules. This is why experienced programmers advise new contributors to fix a small bug first.

**Grammar induction**: Natural language learners infer grammar from examples. Programmers infer program language grammar from code: seeing `lock -> do stuff -> unlock` repeatedly establishes the pattern as a grammatical rule. Seeing three variables always declared together before use establishes their co-dependence.

The practical consequence: the difficulty of onboarding to a codebase is not primarily determined by the codebase's logical complexity. It is determined by how much of the program semantics has been formalized (and is therefore readable via the programming language) versus how much lives in the informal program language layer (and must be inductively learned).

This explains why documentation rarely solves onboarding difficulty: documents translate into natural language, not into the program language itself. The program language can only be learned from the program.

Connects to [[program-revival-by-newcomers-systematically-produces-degraded-designs]]: revival fails not because newcomers lack skill but because they are reconstructing a program language from incomplete evidence, inevitably getting some grammar rules wrong.
