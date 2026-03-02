---
description: A new technology inside an institution survives by delivering a non-zero business result at each step, which earns the credibility to request more resources and scope for the next step
type: claim
evidence: strong
source: [[swift-to-mojo-chris-lattner]]
created: 2026-02-28
status: active
---

# incremental institutional adoption requires non-zero business value at each step

Lattner's pattern for how LLVM went from a university research project to replacing all of Apple's developer toolchain: at every stage, find the smallest possible thing that delivers actual value. Don't wait for the technology to be complete. The first use case at Apple was not the C compiler -- it was a JIT for OpenGL graphics. Small scope, non-zero result. That proved LLVM was "not just a science project." It earned permission to invest in the next use case. Then the next. Over five years, the entire toolchain was replaced.

The critical constraint Lattner names: "After a year, if Apple's not using it in some product, we'll ask you to start doing something else." This is the standard the institution applies, and it is rational. An organization cannot fund indefinite research without business return. The researcher who understands this and aligns their near-term deliverables with the institution's value system will succeed; the researcher who demands complete autonomy to finish the vision before delivering anything will not.

The mechanism: top-down support (a VP frustrated with GCC, wanting change) combined with bottom-up success (a stream of small wins every six months). Neither alone is sufficient. Top-down without bottom-up results in a project that has a champion but no users. Bottom-up without top-down results in orphaned work that gets cancelled when the champion moves on.

The snowball analogy Lattner uses: "You start rolling a small snowball, and you do it for long enough, and suddenly you have a snowman. Where did all that snow come from?" The growth is exponential, but only if you keep rolling -- every six months, a new win, a new use case, a new team adopting it.

This is a decision-pattern (type: pattern) for any technically ambitious project inside an institution. Relevant to murail if it ever needs to justify continued development to stakeholders who are not already invested in the research vision.

Contrasted with [[language-quality-validation-requires-production-use-not-internal-development]]: that claim argues for external validation; this claim argues for institutional survival strategy. Both apply to how a research project becomes a production system.
