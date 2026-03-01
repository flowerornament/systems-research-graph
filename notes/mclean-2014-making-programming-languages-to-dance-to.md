---
description: Alex McLean, FARM 2014 -- Tidal 0.4 design paper; live coding feedback loops, pattern-as-function, rational time, Applicative combinators, Haskell EDSL accessibility
type: source
created: 2026-03-01
---

# mclean-2014-making-programming-languages-to-dance-to

**Full title:** Making Programming Languages to Dance to: Live Coding with Tidal
**Authors:** Alex McLean
**Venue:** FARM 2014 (Workshop on Functional Art, Music, Modelling and Design), Gothenburg, Sweden
**DOI:** 10.1145/2633638.2633647
**Location:** /Users/morgan/code/arscontextica/inbox/archive/mclean-2014-making-programming-languages-to-dance-to/

## Abstract (paraphrased)
Live coding of music has grown into a vibrant international community. This paper describes the live coding domain, focuses on its programming language design challenges, and shows how a functional approach can meet them. Introduces Tidal 0.4: a Domain Specific Language embedded in Haskell that represents musical pattern as functions from time to events, inspired by Functional Reactive Programming.

## Key claims extracted
- [[live-coding-performance-requires-three-distinct-feedback-loops-that-together-define-being-in-time]]
- [[functional-paradigm-dominates-live-coding-practice-because-it-provides-terseness-and-composability-at-performance-speed]]
- [[representing-musical-pattern-as-a-function-from-time-to-events-unifies-discrete-and-continuous-patterns]]
- [[rational-time-representation-eliminates-rounding-errors-in-rhythmic-subdivision]]
- [[cyclic-time-with-rational-subdivision-provides-the-semantic-anchor-for-pattern-operations-in-electronic-music]]
- [[applicative-functor-lifts-binary-value-functions-to-pattern-combinators-by-matching-co-occurring-events]]
- [[low-cognitive-load-and-high-viscosity-in-a-composition-language-enable-creative-flow-in-live-performance]]
- [[a-haskell-embedded-dsl-can-be-learned-and-used-creatively-without-any-functional-programming-background]]
- [[iterative-redesign-of-core-representations-through-live-performance-is-the-correct-evaluation-methodology-for-music-programming-languages]]

## Relevance to murail
Direct design input for murail's composition language (Stage 9). The pattern representation, time model, and functional combinators are all candidate design patterns. The feedback loop taxonomy frames the experience requirements for the composition layer. The user study finding (no FP background required) is direct evidence for the DSL abstraction strategy.

Topics:
- [[language-design]]
- [[competing-systems]]
- [[developer-experience]]
- [[audio-dsp]]
