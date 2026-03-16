---
description: Language transitions that succeed allow existing code to remain unchanged while new code is added in the target language; transitions that require all-at-once migration reliably fail
type: claim
evidence: strong
source: [[llvm-creator-interview-chris-lattner]]
created: 2026-02-28
status: active
---

# incremental migration between languages requires binary-level interoperability not just semantic-compatibility

Lattner contrasts Python 2→3 (15 years, still contentious) with Objective-C→Swift (complete in less time): the structural difference is not language quality but migration mode.

Python 2→3: the transition requires the entire dependency graph to move simultaneously. If any one package you depend on has not migrated, you are blocked. The whole-ecosystem-at-once constraint turns a language upgrade into a coordination problem that affects thousands of independent maintainers.

Objective-C→Swift: Swift apps can call Objective-C code directly. You can take a million-line Objective-C app, move one class to Swift, ship it, and nothing else changes. The migration is incremental at the class level. No cross-ecosystem coordination is required; each team migrates at their own pace.

The C/C++ analogy: C++ is technically not a strict superset of C (it takes some new keywords, and some C constructs are invalid C++). Despite this, C and C++ coexist in the same binary; features even migrated in both directions (C gained `void` from C++). The two communities thrived in parallel precisely because binary-level interoperability made them composable without requiring allegiance to one.

Mojo's Python compatibility story follows this exact pattern: any Python package can be imported and used in Mojo code with no modification (the Python interpreter runs via CPython embedding; Mojo calls it through stable C API interfaces). Mojo code and Python code coexist in the same program. The migration path is opt-in and incremental.

For [[language-design]] in murail's composition language (Stage 9): if murail's composition language needs to interoperate with its host environment (DAW scripting, user code, Python offline evaluation pipelines), the interoperability architecture matters as much as the language semantics. A composition language that requires all user code to be in the murail DSL is a whole-ecosystem-at-once migration problem for existing users.

Connects to [[source-incompatibility-as-explicit-commitment-converts-forced-migration-to-opt-in-experiment]] which describes the complementary organizational insight: even with good interoperability, framing compatibility explicitly changes the adoption dynamic.
