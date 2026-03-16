---
description: McCartney made SAPF embeddable in C programs by keeping the execution engine, eliminating the parser, and rewriting all SAPF functions as C functions, making it linkable as a library
type: claim
evidence: strong
source: [[2026-02-06-fmVdfQNPzkE]]
created: 2026-02-28
status: active
---

# SAPF was factored into an embeddable C library by replacing the parser with C functions

SAPF (Sound as Pure Form) is a complete language: parser, execution engine, lazy list runtime, auto-mapping, unit generators. McCartney factored out an embeddable subset by making one targeted architectural cut: eliminate the parser entirely, and rewrite every SAPF function as a C function with the same semantics.

The result is a C library: link it into any C program, call the C-function equivalents of SAPF operations, and get the same lazy infinite list audio model running inside that program. No separate process, no interpreter, no script files. The host program constructs audio graphs by calling C functions, exactly as SAPF programs construct them by writing postfix expressions.

The key insight: the parser is the boundary between "language" and "library." By eliminating the parser and making all primitives available as C-callable functions, McCartney converted a language into a library without changing the execution model. The lazy lists, auto-mapping, and unit generator semantics are unchanged; only the syntax for accessing them is replaced by C function call syntax.

McCartney describes this as a deliberate factoring, not an afterthought. He kept the execution engine -- the hard part -- and replaced the parser -- the syntactic wrapper -- with idiomatic C. The resulting library is "still using pre-compiled unit generators, so like SuperCollider it's just chaining them together."

**Murail implication:** Murail is explicitly designed as an embeddable library (no mandatory runtime, no separate process). The SAPF-as-C-library approach is a concrete existence proof for this pattern. McCartney's cut -- parser vs. execution engine -- is the same factoring murail needs: the synthesis graph IR and compiler are the execution engine; the composition language is the parser/frontend. Making the graph API callable from host code (Rust, C, C++ via FFI) without requiring the composition language is the embeddable use case. The SAPF example shows this is achievable without redesigning the execution model.

Connects to [[library-languages-must-not-bundle-a-mandatory-runtime]] -- SAPF-as-library demonstrates this is technically feasible for a signal processing language, not just a theoretical desideratum. Extends [[eliminating-unit-generators-exposes-synthesis-graphs-to-cross-boundary-compiler-optimization]] in the other direction: if UGens are library functions over primitives, the C library is just those primitive-building functions exposed as a C API.
