---
description: Every program is both the definition and sole use of a language whose symbols are its abstractions and whose grammar is the implicit rules for combining them
type: claim
evidence: moderate
source: [[baniassad-myers-2009-program-as-language]]
created: 2026-03-01
status: active
---

# each program defines a unique program-specific language with its own symbols and grammar

Baniassad & Myers argue that the abstractions a programmer introduces -- identifiers, classes, data structures, function names -- are not merely organizational conveniences. They constitute the symbols (terminal and non-terminal) of a language that exists only in that program. The grammar of this "program language" is the set of implicit rules about allowable combinations: you must lock before you do stuff; these three variables always travel together; the invariant must be maintained by removing from A before adding to B.

The program language is not the programming language. A C program and its programmer share the same underlying syntax and type system, but each specific program defines its own vocabulary of meaningful abstractions and its own conventions for using them. Two programs could share class names and still define entirely distinct program languages because the context of use determines meaning, not the symbol itself.

Uniqueness has a strong form: no two programs share a program language. Even programs in the same domain that share many symbols define distinct languages because context shifts interpretation. Baniassad uses the analogy of Andy Warhol's banana boxes: exact physical duplication in a new context creates a new interpretive frame, hence a new language.

This makes every codebase a language acquisition task. The complexity of that task is determined by how much of the program's meaning lives in the program language (implicit, human-level) versus the programming language (formal, machine-level). High-level languages with strong type systems push more meaning into the formal layer, simplifying the program language burden.

For murail: every design decision about the composition language is a decision about which program semantics get formalized (and thus made machine-readable) versus which remain in the informal program language layer. See [[higher-level-programming-languages-reduce-program-language-complexity-by-formalizing-more-constraints]].

Connects to [[notation-shapes-thought-not-merely-expresses-it]]: the choice of abstraction names and organization shapes how programmers think about the domain, not merely how they express pre-formed thoughts. Extends [[programming-is-theory-building-not-text-production]]: the program language is the textual precipitate of the theory; the theory is what makes the program language learnable.
