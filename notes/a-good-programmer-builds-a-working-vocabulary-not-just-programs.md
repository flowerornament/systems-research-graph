---
description: At scale, programming requires building up a new vocabulary (doing language design) on top of a base language; a million-line program is necessarily a new language built on the base
type: claim
evidence: strong
source: [[steele-1998-growing-a-language]]
created: 2026-03-01
status: active
---

# a good programmer builds a working vocabulary, not just programs

Steele: "A good programmer in these times does not just write programs. A good programmer builds a working vocabulary. In other words, a good programmer does language design, though not from scratch, but by building on the frame of a base language."

The argument from scale: in the course of the talk, Steele (starting from one-syllable primitives) defined fifty or more new words and sixteen names, and laid out six grammar rules. To write a book from the same starting point would require hundreds of new definitions. A program a million lines long "might need many, many hundreds of new words -- that is to say, a new language built up on the base language." This cannot be done any other way -- either you build up vocabulary, or you use a mature language that already has all the vocabulary you need (which does not yet exist for programming).

The productivity asymmetry: programmers who do not treat their codebase as a language-building task tend to produce code that works for the current problem but is hard to extend, because they have not built up the abstract vocabulary that makes new problems tractable. The programmer who does build vocabulary produces code that is more like prose in a rich language -- each new piece of code can invoke many prior definitions.

This claim connects to [[each-program-defines-a-unique-program-specific-language-with-its-own-symbols-and-grammar]] (Baniassad & Myers 2009): both argue that every program is a language. Steele frames this descriptively and prescriptively -- not just "every program is a language" but "a good programmer recognizes this and acts accordingly." The practical implication is the same: identifier naming, abstraction organization, and idiom choice are acts of language design, not incidental style choices.

Enriches [[program-languages-communicate-naurs-theories-through-identifier-choice-idioms-and-abstraction-organization]] (Naur): the vocabulary-building framing gives the mechanism by which a programmer's theory gets embedded in code. Building vocabulary = building the language through which the theory is expressed.

Tension with [[evolvability-requires-trading-provability-for-extensibility]] (Sussman): Sussman argues for keeping the vocabulary *extensible at runtime* (open-world generic dispatch). Steele argues for *explicitly building* the vocabulary as a design act. These are complementary: Steele describes the intentional work; Sussman describes the mechanism. The tension only arises if "vocabulary building" is interpreted as creating a closed system rather than an extensible one.

For murail: the composition language design task is inseparable from the vocabulary-building task. Defining what "signal", "rate", "graph edge", "scheduling boundary" mean in the composition language is simultaneously language design and conceptual vocabulary work. The quality of the composition language depends on the quality of its vocabulary, not just its grammar.
