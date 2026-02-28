---
description: Notational economy comes from grammar generating many expressions from few primitives, not from a primitive per concept; each primitive must earn its place by serving multiple contexts
type: claim
evidence: strong
source: [[iverson-1980-notation-as-tool-of-thought]]
created: 2026-02-28
status: active
---

# economy of notation requires compositional grammar, not a large primitive vocabulary

Iverson: "Economy requires that a large number of ideas be expressible in terms of a relatively small vocabulary. A fundamental scheme for achieving this is the introduction of grammatical rules by which meaningful phrases and sentences can be constructed by combining elements of the vocabulary."

The key demonstration: the sum of the first N integers is not introduced as a primitive but as a phrase composed from two more general primitives -- the integer-sequence function `ι` and the sum-reduction `+/`. `+/` is itself a derived function (reduction operator applied to `+`). No primitive was added; composition created the needed concept.

Two additional economy mechanisms in APL:

**Symbol overloading by arity**: every symbol represents both a monadic function (one argument) and a dyadic function (two arguments). `*Y` is exponential; `X*Y` is power. `-Y` is negation; `X-Y` is subtraction. `ρY` gives the shape of Y; `XρY` replicates Y into the shape X. This halves the symbol count needed while keeping related functions visually associated with a single symbol.

**Generality in function domains**: the factorial function `!` is not restricted to integers; `!X-1` gives the gamma function. Relations on reals, when applied to booleans, yield exclusive-or, material implication, and equivalence -- without adding new primitives.

APL's assessed vocabulary in the paper: `ι`, `ρ`, `/`, `\`, `∘`, `T`, `,`, plus the familiar arithmetic/logical functions. Five novel functions and three novel operators cover all the topics in the paper. This is the economy claim quantified.

Connects to [[evolvability-requires-trading-provability-for-extensibility]] from Sussman: both arguments address how to design a notation/system for long-term growth. Iverson's answer is compositional grammar; Sussman's is generic dispatch. They are complementary strategies for different problems (expression economy vs. type extensibility).

Contrasts with most DSL designs that add new primitives whenever new concepts appear. For murail's language design context: [[first-class-control-flow-nodes-in-synthesis-graphs-enable-conditional-and-demand-rate-execution]] extends the control-flow concept by making it compositional with the existing graph model -- this is the Iverson move, not the "add a new primitive" move.
