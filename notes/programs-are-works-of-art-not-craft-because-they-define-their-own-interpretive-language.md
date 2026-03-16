---
description: Baniassad proposes that artifacts which define their own interpretive language are art; those that work within a pre-existing external language are craft; programs are art by this definition
type: claim
evidence: weak
source: [[baniassad-myers-2009-program-as-language]]
created: 2026-03-01
status: active
---

# programs are works of art not craft because they define their own interpretive language

Baniassad & Myers propose a new boundary between art and craft based on linguistic self-definition:

**Art**: Artifacts that comprise a unique, self-defining language. Every artistic artifact must be interpreted separately. Bringing a symbol from one work of art into another results in misinterpretation -- the symbol acquires new meaning in the new context. Examples: poems (Jabberwocky defines nonce words and their grammar), paintings (a red stroke means blood in one, love in another).

**Craft**: Artifacts that work entirely within a language defined for them externally. Substitution does not result in misinterpretation. A chair leg transplanted to another chair remains a chair leg. The craftsperson adheres to or violates the external language's rules, but does not define new rules.

Programs are art by this criterion: each program defines its own program language (see [[each-program-defines-a-unique-program-specific-language-with-its-own-symbols-and-grammar]]). A symbol from one program placed in another is a false cognate -- it looks the same but carries different program-semantic content.

The practical implication within programming teams: some programmers are "artists" (defining the language: designing abstractions, setting naming conventions, establishing idioms and grammar) while others are "crafters" (working within the established language). Database administrators who design schemas are artists; programmers who write queries against those schemas are crafters (though their application layer may define new art). Neither role is superior, but conflating them creates architectural problems -- a crafter making artist-level changes without understanding the existing language risks incoherence.

**Caveats**: Baniassad acknowledges this is an "inline sidebar" -- a speculative extension of the main thesis rather than its core argument. The art/craft distinction has normative appeal but is harder to operationalize than the program language claim itself. The classification of any specific programming activity as art vs. craft would require knowing how much of the existing program language the programmer is following versus redefining.

This connects to [[programming-is-theory-building-not-text-production]]: theory builders are artists in Baniassad's sense; those who implement without theory-building are crafters. The distinction is not pejorative -- both are necessary, and artists' programs also contain craft components.
