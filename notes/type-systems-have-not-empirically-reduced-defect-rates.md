---
description: Empirical studies have found no reliable evidence that static type systems reduce defect rates relative to dynamically typed languages, excluding memory safety issues
type: claim
evidence: moderate
source: [[stop-writing-dead-programs-jack-rusher-2022]]
created: 2026-02-28
status: active
---

# type systems have not empirically reduced defect rates

Rusher, who has shipped OCaml and Haskell in production over 45 years, states that empirical studies consistently find no evidence that static type systems produce fewer defects than dynamically typed alternatives -- with the exception of memory safety violations. He cites personal experience across many languages as consistent with the research record.

His positive framing: for systems where fault tolerance matters most, Erlang's runtime guarantees (supervisor trees, process isolation, live patching) provide more practical reliability than type-level correctness proofs. Type systems are aesthetic and ergonomic tools, not reliability mechanisms.

Important caveat Rusher makes explicitly: for protocols and high-consequence systems (cryptocurrencies risking billion-dollar losses), model checking (Coq, TLA+) is justified. The claim is specifically about ordinary software engineering defect rates.

Relevance to [[formal-methods]] for murail: the Lean 4 proof work targets formal model correctness (mathematical properties of the "Named Sparse Recurrence System"), not defect reduction in application code. Rusher's claim is about application-layer defects, not formal model verification. The two concerns are orthogonal -- proving correctness of the formal model does not conflict with pragmatic runtime guarantees at the application layer.

Contrasted with [[debuggability-is-more-valuable-than-correctness-by-construction]], which draws the practical conclusion from this observation. Rusher's memory safety exception is formally vindicated by [[rust-provides-provably-memory-and-data-race-safe-programs-without-garbage-collection]], which establishes that Rust's type system does provide proved memory and data-race safety guarantees -- precisely the exception Rusher names.
