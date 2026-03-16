---
description: In postfix concatenative languages, a word's meaning depends on knowing its arity; without that context, you can't determine whether a token is the main subject or setup for a later function
type: claim
evidence: strong
source: [[2026-02-06-fmVdfQNPzkE]]
created: 2026-02-28
status: active
---

# concatenative postfix readability breaks when argument role is ambiguous

Postfix concatenative languages like SAPF, Forth, PostScript, and concatenative portions of Factor have a readability problem McCartney identifies from a decade of experience: you must know every function's arity to parse the code visually. Without knowing how many arguments a word consumes, you cannot determine whether a given token is the "main thing being transformed" or "setup for something later."

McCartney's example: if you drop into the middle of a SAPF expression, you see a sequence of words but cannot tell which one is the primary operand being processed and which ones are auxiliary arguments setting up later operations. The code has no syntactic marker that distinguishes these roles -- everything is a word on the same line.

This is not a problem for the author (who knows the code) but becomes a barrier for reading code written days or weeks earlier, or code written by others. McCartney describes finding his own SAPF code difficult to read after time away from it.

His solution in the newer language: **pipeline the main operand, parenthesize options**. The object being transformed flows through a pipeline (output of one function feeds the next as its first argument, using implicit piping without a dot operator). All auxiliary arguments are in parentheses adjacent to the function that consumes them. Visual parsing now works: the bare words form the main processing chain; the parenthesized groups are locally-scoped configuration.

This is structurally similar to method chaining in object-oriented languages but without the syntactic noise of `obj.method1().method2()` and without requiring the main operand to be an object. It is also related to F#'s pipe operator (`|>`) and Elixir's pipe operator (`|>`), but implicit (no pipe symbol needed).

**Murail implication:** If murail develops a composition language, the readability of synthesis graph construction expressions is a design decision. The postfix concatenative style (SAPF) is maximally dense but hard to read; method chaining is readable but verbose; functional pipeline with implicit piping (McCartney's current approach) offers a middle path. The tradeoff: implicit piping requires knowing the convention (first argument is the pipeline); postfix requires knowing arities; method chaining requires object orientation. Readability is not just a syntactic preference -- it determines whether a composition language supports the "reading code back" phase of creative practice.

Connects to [[visual-representation-exposes-structure-text-notation-obscures]] -- the readability problem McCartney identifies is specific to linear text notation for what is fundamentally a structured process; the pipeline style partially recovers the visual left-to-right flow. Extends [[universal-auto-mapping-eliminates-explicit-iteration-from-signal-processing-programs]] -- auto-mapping improves density but the density creates the readability problem this claim addresses.
