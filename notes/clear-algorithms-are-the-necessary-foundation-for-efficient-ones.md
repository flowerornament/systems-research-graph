---
description: A clear statement of an algorithm provides the basis from which efficient variants can be derived; clarity precedes efficiency because an unclear algorithm cannot be systematically improved
type: claim
evidence: strong
source: [[iverson-1980-notation-as-tool-of-thought]]
created: 2026-02-28
status: active
---

# clear algorithms are the necessary foundation for efficient ones

Iverson's Section 5.4 addresses "mode of presentation" and defends the paper's emphasis on clarity over efficiency: "the practice of first developing a clear and precise definition of a process without regard to efficiency, and then using it as a guide and a test in exploring equivalent processes possessing other characteristics, such as greater efficiency, is very common in mathematics. It is a very fruitful practice which should not be blighted by premature emphasis on efficiency in computer execution."

The argument is practical, not aesthetic. A clear algorithm is an *executable specification* that can be used to test derived optimizations. Iverson demonstrates this with the STEP function (Newton's method generalized to vector functions): the clear definition using matrix inverse and inner products reveals that the off-diagonal elements are all zero, enabling replacement with vector division -- a more efficient algorithm derived by inspection of the clear form.

Three concrete transformations shown:
- Replace `(~M)+.×B` with `B÷D` when M is diagonal (STEP function)
- Replace `+/C×2*-1+ι0C` with `X±0C` or `X±C` (Horner evaluation)
- Transform recursive definitions into non-recursive forms (general technique for reduction)

The efficiency concern Iverson dismisses: "measures of efficiency are often unrealistic because they concern counts of 'substantive' functions such as multiplication and addition, and ignore the housekeeping (indexing and other selection processes) which is often greatly increased by less straightforward algorithms." The clear algorithm often *is* efficient when housekeeping overhead is counted.

Connected to [[debuggability-is-more-valuable-than-correctness-by-construction]]: both claims prioritize understanding over performance, arguing that comprehensibility is the precondition for correctness and optimization. Iverson's framing adds the construction principle: clear = testable, therefore clear = derivable-into-efficient.

For murail: the audio graph compiler's design follows this principle. [[construction-time-graph-optimization-distributes-compiler-cost-across-node-creation]] and [[delay-merging-collapses-structurally-identical-delays-enabling-implicit-multi-tap-sharing]] are optimizations derived from a clear model of graph construction -- the clarity enables the optimization.
