---
description: How this knowledge system was derived -- enables architect and reseed commands
created: 2026-02-27
engine_version: "0.8.0"
---

# System Derivation

## Configuration Dimensions
| Dimension | Position | Conversation Signal | Confidence |
|-----------|----------|--------------------|--------------------|
| Granularity | Atomic | "extract out what's going on", formal model with discrete theorems/decisions/invariants, 69 architectural decisions as individual units | High |
| Organization | Flat | Cross-disciplinary domain (DSP + PL + concurrency + AI/ML), "general mapping of the whole domain space" | High |
| Linking | Explicit+Implicit | Cross-disciplinary vocabulary, high projected volume (500-1000+ claims from 107 references), semantic discovery across sub-domains | High |
| Processing | Heavy | 370 files of existing research, "iteratively refine formal models / specs", ongoing extraction from references/papers/transcripts | High |
| Navigation | 3-tier | Hub -> discipline topic maps -> claims. 107+ references, multiple sub-domains, projected 500+ claims | High |
| Maintenance | Condition-based (tight) | Active research with iterative refinement, formal model evolving, older claims may be superseded | High |
| Schema | Moderate | Existing evidence rating system (STRONG/MODERATE/WEAK/INTERNAL-ONLY), source tracking, decision classification (D1-D69 style) | High |
| Automation | Full | Claude Code platform with full hook/skill support, heavy processing requires pipeline automation | High |

## Personality Dimensions
| Dimension | Position | Signal |
|-----------|----------|--------|
| Warmth | neutral-helpful | default — technical research domain |
| Opinionatedness | neutral | default |
| Formality | professional | default — precise but not bureaucratic |
| Emotional Awareness | task-focused | default — intellectual domain |

## Vocabulary Mapping
| Universal Term | Domain Term | Category |
|---------------|-------------|----------|
| notes | notes | folder |
| inbox | inbox | folder |
| archive | archive | folder |
| note (type) | claim | note type |
| note_plural | claims | note type |
| reduce | extract | process phase |
| reflect | connect | process phase |
| reweave | reweave | process phase |
| verify | verify | process phase |
| validate | validate | process phase |
| rethink | rethink | process phase |
| MOC | topic map | navigation |
| description | claim context | schema field |
| topics | research areas | schema field |
| topic map (template) | topic-map.md | template |
| base note (template) | claim-note.md | template |

## Command Name Mapping
| Universal | Domain Command |
|-----------|---------------|
| /reduce | /arscontexta:extract |
| /reflect | /arscontexta:connect |
| /reweave | /arscontexta:reweave |
| /verify | /arscontexta:verify |
| /rethink | /arscontexta:rethink |

## Platform
- Tier: Claude Code
- Automation level: Full
- Hooks: SessionStart, PostToolUse (Write), Stop

## Self Space
- Enabled: false (research default)
- Goals route to: ops/goals.md
- Identity: baked into CLAUDE.md context file
- Methodology: ops/methodology/

## Active Feature Blocks
- [x] wiki-links -- always included (kernel)
- [x] processing-pipeline -- always included
- [x] schema -- always included
- [x] maintenance -- always included
- [x] self-evolution -- always included
- [x] methodology-knowledge -- always included
- [x] session-rhythm -- always included
- [x] templates -- always included
- [x] ethical-guardrails -- always included
- [x] helper-functions -- always included
- [x] graph-analysis -- always included
- [x] atomic-notes -- granularity = atomic
- [x] mocs -- navigation = 3-tier
- [x] semantic-search -- linking = explicit+implicit (conditional on qmd)
- [ ] personality -- not enabled (no signals)
- [ ] self-space -- disabled (research default)
- [ ] multi-domain -- starting single domain (murail), add later via /arscontexta:add-domain

## Extraction Categories
| Category | What to Find | Output Type |
|----------|-------------|-------------|
| claims | Central arguments, empirical findings from sources | claim |
| decisions | Architectural choices with rationale (D1-D69 style) | claim (type: decision) |
| properties | Formal invariants, theorems, type-level guarantees | claim (type: property) |
| patterns | Design techniques, implementation idioms | claim (type: pattern) |
| contradictions | Where sources or approaches conflict | claim (type: contradiction) |
| open-questions | Unresolved research gaps, future work | claim (type: open-question) |

## Coherence Validation Results
- Hard constraints checked: 3. Violations: none
- Soft constraints checked: 7. Auto-adjusted: none. User-confirmed: none
- Compensating mechanisms active: none needed — all dimensions coherent

## Failure Mode Risks
1. Collector's Fallacy (HIGH) — 107 references, ongoing consumption. Extract before accumulating.
2. Orphan Drift (HIGH) — High creation volume from extraction. Every claim needs topic map links.
3. Verbatim Risk (HIGH) — Dense source material (formal models, academic papers). Must transform, not copy.
4. Productivity Porn (HIGH) — 370 files of research artifacts already exist. Vault serves the formal model, not the other way around.

## Domain Context
- Primary project: murail (embeddable audio graph engine, Rust)
- Domain intersection: audio DSP, programming language design, concurrent systems, formal methods, Rust ecosystem, AI/ML
- Existing research: .design/references/ (107 indexed), .design/formal-model/ (Lean proofs), .design/SPEC.md (4,300 lines, 69 decisions, 20 invariants)
- Relationship to vault: .design/ contains sources and products; systems-research-graph/notes/ contains the connective tissue (cross-referenced claim graph)
- Future domains: herald (personal OS, Elixir/Ash), potentially tau5 (bridging PL concerns)

## Generation Parameters
- Folder names: notes/, inbox/, archive/, templates/, ops/, manual/
- Skills to generate: 16 (vocabulary-transformed from plugin sources)
- Hooks to generate: session-orient.sh, validate-note.sh, auto-commit.sh, session-capture.sh
- Templates to create: claim-note.md, topic-map.md, source-capture.md, observation.md
- Topology: fresh-context (subagent per processing phase)
