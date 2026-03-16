---
id: mclean-2014-making-programming-languages-to-dance-to-extract
batch: mclean-2014-making-programming-languages-to-dance-to
type: extract
status: pending
source: /Users/morgan/code/systems-research-graph/inbox/archive/mclean-2014-making-programming-languages-to-dance-to/mclean-2014-making-programming-languages-to-dance-to.pdf
original_path: /Users/morgan/code/systems-research-graph/inbox/mclean-2014-making-programming-languages-to-dance-to.pdf
archive_folder: ops/queue/archive/2026-03-01-mclean-2014-making-programming-languages-to-dance-to
created: 2026-03-01
next_claim_start: 350
---

# Extract claims from mclean-2014-making-programming-languages-to-dance-to

## Source
Original: /Users/morgan/code/systems-research-graph/inbox/mclean-2014-making-programming-languages-to-dance-to.pdf
Archived: /Users/morgan/code/systems-research-graph/inbox/archive/mclean-2014-making-programming-languages-to-dance-to/mclean-2014-making-programming-languages-to-dance-to.pdf
Size: 8 pages (PDF, ACM FARM 2014)
Content type: Academic conference paper

## Summary
McLean (University of Leeds) introduces Tidal 0.4, a domain-specific language embedded in Haskell for live coding of music. The paper covers: (1) live coding as a design challenge with specific feedback loop requirements; (2) Tidal's representation of musical pattern as a function from time to events, inspired by FRP; (3) the design rationale for rational time representation and cyclic structure; (4) pattern combinators including Functor and Applicative instances; (5) a history of Tidal's internal representation changes across 5+ rewrites; (6) a survey of 15 Tidal users showing non-functional programmers can effectively use a Haskell-embedded DSL; (7) the argument that functional paradigm dominates live coding practice.

## Scope
Full document. Extract:
- Language design decisions: time representation, pattern-as-function, cyclic structure
- Formal properties: Applicative/Functor pattern combinators, rational time
- Claims: feedback loop taxonomy, functional paradigm dominance, DSL accessibility
- Design methodology: iterative redesign via live performance evaluation
- Comparisons with Max/MSP (dataflow) and other live coding systems

## Acceptance Criteria
- Extract claims with genuine insight for murail's design space
- Duplicate check against notes/ during extraction
- Connections to existing claims on live coding, language design, competing systems
