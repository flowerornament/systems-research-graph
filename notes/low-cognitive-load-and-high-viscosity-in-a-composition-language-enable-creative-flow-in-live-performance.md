---
description: Tidal's design explicitly targets Green's cognitive dimensions: low cognitive load and high viscosity (expressiveness per keystroke) to support playful engagement and creative flow during live performance
type: claim
evidence: moderate
source: [[mclean-2014-making-programming-languages-to-dance-to]]
created: 2026-03-01
status: active
---

# low cognitive load and high viscosity in a composition language enable creative flow in live performance

McLean invokes Green's (2000) cognitive dimensions of programming notations to explain Tidal's design philosophy. The specific claim is that Tidal is designed to be:

- **Low cognitive load**: the programmer should not need to hold large amounts of state in working memory to write or read code. Short expressions, composable combinators, and the mini-notation string syntax (`"[red black, blue orange green] * 16"`) minimize the mental bookkeeping required per change.

- **High viscosity** (in Green's sense: the ratio of expressiveness to syntactic effort): a small number of keystrokes should produce significant musical change. Tidal's operator-heavy syntax and string mini-notation mean that a 10-character change can restructure the pattern entirely.

McLean connects these cognitive properties directly to creative flow (Csikszentmihalyi's concept): optimal, fully engaged experience where the challenge level matches the practitioner's skill. The argument is that high cognitive load and low viscosity break the flow state -- if making a change requires significant mental overhead or verbose syntax, the performer loses the moment. Flow requires immediate feedback and low friction between intention and action.

The practical expression of this: "Tidal fits within this process by being highly viscous and requiring low cognitive load, therefore supporting playful engagement and a high rate of change. The generality of the pattern transformations means that live coders can apply a set of heuristics for changing code at different levels of abstraction, as tacit knowledge built through play."

This is also the explanation for why the functional paradigm dominates live coding: functional composition is naturally high-viscosity for pattern manipulation (see [[functional-paradigm-dominates-live-coding-practice-because-it-provides-terseness-and-composability-at-performance-speed]]).

The "tacit knowledge built through play" observation is significant: the goal is not that users understand the language formally but that they develop heuristics through repeated use. This is a different design target than most programming languages, which optimize for correct-by-construction or self-documenting code. A live coding language optimizes for the performer's intuition -- the code should feel like an instrument.

For murail: the composition language design should explicitly target this cognitive profile. The Kolmogorov complexity criterion ([[kolmogorov-complexity-provides-a-measurable-criterion-for-composition-language-design-quality]]) is the quantitative proxy for viscosity: if expressing a common musical idea requires more characters in murail than in Tidal, viscosity is too low. The cognitive load criterion translates to: the composition language should not require understanding the audio graph substrate to write patterns. A user should be able to play without knowing what a UGen is.

Connects to [[live-coding-performance-requires-three-distinct-feedback-loops-that-together-define-being-in-time]] -- cognitive load reduction serves all three feedback loops: faster manipulation feedback (less to type), cleaner performance feedback (changes are immediate and legible), and better social feedback (audience can follow code that changes in small, visible increments).

---

Topics:
- [[language-design]]
- [[developer-experience]]
