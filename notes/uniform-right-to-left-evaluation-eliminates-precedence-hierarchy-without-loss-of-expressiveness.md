---
description: APL's single rule (right argument is the entire expression to its right) eliminates operator precedence while preserving readable left-to-right analysis and correct right-to-left execution
type: property
evidence: strong
source: [[iverson-1980-notation-as-tool-of-thought]]
created: 2026-02-28
status: active
---

# uniform right-to-left evaluation eliminates precedence hierarchy without loss of expressiveness

APL's grammar has two simplifications over conventional notation:

**No precedence hierarchy**: all functions are treated alike; there is no rule that `×` executes before `+`. Iverson's historical observation: the familiar hierarchy (power before multiply before add) arose to make polynomials expressible without parentheses. But with vectors, `+/C×X*ι0C` expresses a polynomial cleanly anyway, removing the original motivation. Moreover, eliminating hierarchy enables Horner's method (the efficient polynomial evaluation) to be expressed without parentheses: `3+X×4+X×2+X×5`.

**Uniform argument rule**: the right argument of any function (monadic or dyadic) is the value of the entire expression to its right. This is a single rule covering both function types, replacing the variety of mathematical notation conventions (factorial follows its argument, magnitude surrounds its argument, negation precedes its argument).

The cognitive consequence: "any portion of an expression which is free of parentheses may be read analytically from left to right (since the leading function at any stage is the 'outer' or overall function to be applied to the result on its right), and constructively from right to left (since the rule is simply that execution is carried out from right to left)." The notation supports *two* reading strategies from *one* rule.

A subtle consequence for reductions: `-/V` computes the alternating sum because `-` is applied with right-to-left grouping (`a - (b - (c - d))`). `</B` "isolates" the first 1 in a boolean vector because each subsequent element is dominated by the preceding result. These behaviors emerge from the grammar without special cases.

For [[language-design]]: this illustrates the economy principle from [[economy-of-notation-requires-compositional-grammar-not-a-large-primitive-vocabulary]] applied to grammar rather than vocabulary. Fewer rules produce richer behavior. The design tension for murail's composition language is whether to adopt uniform function application (simpler grammar) or conventional precedence (familiar to programmers).
