---
description: Ease of introducing notation in context without prerequisites is a measure of quality, not a teaching preference; notation that requires upfront courses to become usable is unsuitable as a thought tool
type: claim
evidence: moderate
source: [[iverson-1980-notation-as-tool-of-thought]]
created: 2026-02-28
status: active
---

# notation introduced in context is a quality criterion, not a pedagogical shortcut

Iverson makes a design argument from pedagogy: "mathematical notation is always introduced in context rather than being taught, as programming languages commonly are, in a separate course. Notation suited as a tool of thought in any topic should permit easy introduction in the context of that topic."

The implication is that requiring a prerequisite "APL course" before using APL notation is a deficiency signal. If the notation cannot be introduced when needed, in context, then it fails the thought-tool test. The paper itself practices this: APL is introduced incrementally as each new problem is approached, with no upfront tutorial.

An important caveat Iverson adds: "it is important to distinguish the difficulty of describing and of learning a piece of notation from the difficulty of mastering its implications." Matrix multiplication is easy to learn (rules are simple) but difficult to master (associativity, distributivity, linear function representation are non-trivial). The suggestiveness criterion applies here: good notation, like `+.×` for matrix product, cannot make the computation rules harder to learn, but it naturally surfaces the structural questions worth mastering.

The paradox of suggestive notation: it may *seem* harder because it suggests more questions to explore. `+.×` for matrix product makes visible the question "is `v.^` associative? Over what does it distribute?" -- questions that a less suggestive notation would never raise. This apparent difficulty is actually cognitive productivity: the notation is doing useful work.

For [[language-design]] and [[developer-experience]]: this is the design criterion McCartney invokes when he says he wants APL's density without "Chinese notation." The goal is notation learnable in context, where the syntax does not obstruct entry but the semantics reward mastery. [[batch-processing-incurs-avoidable-cognitive-overhead]] describes the friction that results when tools require up-front configuration before first use -- the same friction applies to notations that require up-front courses.
