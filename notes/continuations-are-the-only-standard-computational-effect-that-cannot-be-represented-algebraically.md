---
description: All standard computational effects (exceptions, state, I/O, concurrency, nondeterminism, time) have algebraic representations except continuations, which require different treatment
type: property
evidence: strong
source: [[plotkin-pretnar-2009-handlers-of-algebraic-effects]]
created: 2026-03-01
status: active
---

# continuations are the only standard computational effect that cannot be represented algebraically

Plotkin and Pretnar state this explicitly in the introduction: all effects representable by Moggi's monads are algebraic -- "effects that allow a representation by operations and equations" -- with "the notable exception of continuations," which "have to be treated differently."

The algebraic condition is: the computation monad must be the free-model monad of some equational theory. For continuations, the continuation monad `(A → R) → R` is *not* the free model of any equational theory over a reasonable class of theories. This is a theorem, not a design choice: Plotkin and Power proved that the continuation monad cannot arise as the free model of an algebraic theory (see [4-6] in the paper; the result is referenced as [7] -- Flanagan et al., "The essence of compiling with continuations").

**Why continuations violate algebraicity**: an algebraic operation `op : n` has the property that its arguments are computations that come *after* the operation. For continuations, the captured continuation is the entire rest of the computation -- it includes all future context, not just the current argument. This global reach breaks the local substitution property that algebraic operations require. Specifically, the equation `op(x.T) = T[op(x.T')/x]` (which would express "running op twice is the same as running it once on the result of running it again") is not in general valid for continuations.

**The practical boundary**: this is why `callcc` in Scheme, `shift`/`reset` in Racket, or first-class continuations in Ruby cannot be modeled by algebraic effects. They require the full continuation monad, or a separate mechanism like Filinski's reflection/reification [12]. The algebraic effects framework from Plotkin and Pretnar handles everything else -- but at the boundary of its expressiveness, continuations are excluded.

**What this means for the handler framework**: handlers in Plotkin & Pretnar's calculus cannot simulate first-class continuations directly. However, [[effect-handlers-are-resumable-exceptions-that-capture-delimited-continuations]] shows the formal equivalence between algebraic effect handlers and delimited continuations (`shift0`/`reset0`). The difference is that delimited continuations are explicitly bounded -- they capture the context *up to* a reset boundary. Unbounded first-class continuations (capturing the *entire* remaining computation) are strictly more powerful and cannot be algebraically characterized.

**Connection to [[handling-a-computation-is-composing-it-with-the-unique-free-model-homomorphism]]**: the unique homomorphism theorem requires the computation monad to be a free model. Continuations fail this requirement, so the homomorphism-based handling interpretation does not apply to them. This is the categorical explanation of the exclusion.

Relevance to [[language-design]]: murail's composition language need not support first-class continuations. The RT-safety use case ([[effects-as-capabilities-can-encode-rt-safety-requirements-in-the-composition-language-type-system]]) requires only effects with algebraic representations -- exceptions, state, I/O, scheduling -- all of which fall within the Plotkin-Pretnar framework.
