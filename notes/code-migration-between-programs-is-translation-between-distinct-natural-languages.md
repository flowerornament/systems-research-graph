---
description: Moving code from one program to another requires semantic translation between distinct program languages, not mere syntactic copying; false cognates cause silent corruption of meaning
type: claim
evidence: moderate
source: [[baniassad-myers-2009-program-as-language]]
created: 2026-03-01
status: active
---

# code migration between programs is translation between distinct natural languages

Baniassad & Myers observe that code copying within a program (intra-program migration) is nearly pathologically common and almost always works. Code copying between programs (inter-program migration) frequently produces code that runs but has the wrong semantics. This asymmetry is explained by program language uniqueness.

Within a program, the source and destination code share the same program language. Copied code retains its meaning. Between programs, the code is written in different languages. The symbols look identical (both are C, or both are Python) but carry different program-semantic content. The programmer has no visual cue that translation is required.

**False cognates**: The same identifier name in two programs may mean entirely different things. A method named `foo` migrated from program A to program B runs correctly under the programming language semantics but silently fails in terms of program semantics. Natural language false cognates (English "gift" vs. German "Gift" meaning poison) are at least visually detectable. Program language false cognates are invisible -- the code looks identical in both contexts.

**Scale of difficulty**: Baniassad identifies three levels of migration difficulty:
1. Renaming: same data, different identifier (trivial mismatch)
2. Interface variation: same concept, slightly different structure (requires adapters)
3. Paradigm difference: entire organization of related concepts is different (requires rewriting, not translating)

At the most extreme, cross-paradigm migration (e.g., object-oriented to functional) requires reconstructing the program language from scratch in the target idiom. This is not refactoring; it is a new language definition that must implement the same program semantics.

The implication for library and API design: APIs designed to be imported and used across programs must minimize the program-language overhead they impose. APIs with elaborate implicit grammar rules (which methods must be called in which order, which combinations are forbidden) export their program language complexity to every user. Generic, composable interfaces with semantics close to the programming language semantics minimize this burden.

Relates to [[incremental-migration-between-languages-requires-binary-level-interoperability-not-just-semantic-compatibility]]: language migration has this same translation problem at the ecosystem scale. Connects to [[dataflow-languages-lack-explicit-formal-semantics-making-program-behavior-engine-dependent]]: implicit program language in Max/PD patches makes cross-engine migration especially hazardous.
