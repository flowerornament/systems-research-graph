---
description: Baniassad extends Naur by identifying the specific textual mechanisms through which programmer theories are communicated: abstraction naming, idiomatic patterns, and code organization constitute the program language
type: claim
evidence: moderate
source: [[baniassad-myers-2009-program-as-language]]
created: 2026-03-01
status: active
---

# program languages communicate naur's theories through identifier choice idioms and abstraction organization

Naur argues in [[programming-is-theory-building-not-text-production]] that programmer theories cannot be communicated by rules or documentation. Baniassad & Myers refine this with a linguistic framing: while the theory itself may be tacit, the program language is precisely the medium through which theories communicate to other programmers -- imperfectly, but not arbitrarily.

The paper identifies the specific mechanisms:

**Identifier choice**: Names signal intended use and domain mapping. Calling a variable `num_seconds` rather than `x` communicates program semantics ("this counts elapsed seconds") that the programming language cannot enforce. The name is a program language symbol; its meaning is established by context across the whole program, not by the identifier alone.

**Abstraction boundaries**: How variables are grouped (independently declared vs. aggregated in a struct), which methods are on which classes, and which operations are defined together all communicate the conceptual topology of the program. Separate declaration implies independence; aggregation implies co-dependence. These groupings are not required by the programming language -- they are program language grammar rules.

**Idiomatic patterns**: Recurring sequences communicate constraints. Lock-then-operate-then-unlock appears so often because violation breaks the program. The pattern itself communicates the constraint even when no comment explains it. For program-specific idioms (check preconditions A, B, C before calling operation D), the pattern teaches what the comment would only assert.

**Code organization**: File structure, module boundaries, and the order of definitions all carry program language meaning. What is co-located suggests what must change together; what is separated suggests independence.

The connection to Naur is direct: these mechanisms are what allows the theory to partially survive documentation and turnover. A programmer learning the program language is inductively reconstructing the theory from its textual traces. This process succeeds partially when the program language is coherent (the theory was held well) and fails more when the program language is incoherent (multiple theories, accumulated without reconciliation).

For this knowledge graph: the wiki-link structure, claim naming, and topic map organization constitute this vault's program language. The theory of the murail research is communicated through the choice of which claims to extract, how they are titled, and how they link. `CLAUDE.md` is the explicit grammar; the notes/ directory is the language itself.

Connects forward to [[reading-an-unfamiliar-codebase-is-language-learning-not-mere-symbol-lookup]]: language learning works precisely because these mechanisms are systematic. Also connects to [[no-documentation-can-substitute-for-the-programmer-held-theory]]: these mechanisms communicate the theory's surface, not the theory itself.
