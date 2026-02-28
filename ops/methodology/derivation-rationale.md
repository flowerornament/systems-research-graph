---
description: Narrative explanation of why each configuration dimension was chosen
type: system
created: 2026-02-27
---

# Derivation Rationale

This document explains the reasoning behind each dimension position in the Ars Contexta configuration, as derived from the initial conversation.

## Platform Tier: Claude Code (Full Automation)

The vault runs on Claude Code, which provides the richest automation surface: session hooks (SessionStart, PostToolUse, Stop), custom skills (/arscontexta:extract, /arscontexta:connect, etc.), and file system access. This enables a fully automated processing pipeline where extraction, validation, and maintenance happen through commands rather than manual editing.

## Dimension Rationale

### Granularity: Atomic

The research domain involves formal models with discrete theorems, 69 architectural decisions as individually-numbered units (D1-D69), and invariants expressed as precise propositions. The conversation signal "extract out what's going on" pointed directly at decomposing dense source material into individual, linkable units. Each claim stands alone so it can participate in multiple cross-disciplinary connections.

### Organization: Flat

The domain spans at least six sub-fields (audio DSP, programming language design, concurrent systems, Rust ecosystem, AI/ML, formal methods). A hierarchical folder structure would force claims into a single category, but the entire value proposition is discovering connections across these boundaries. A flat notes/ folder with wiki-links as the primary organizational mechanism allows any claim to belong to multiple topic maps.

### Linking: Explicit + Implicit

Explicit wiki-links are the backbone — every claim links to its topic maps, sources, and related claims. But with a projected volume of 500-1000+ claims from 107 references across six sub-domains, manual linking cannot discover all connections. Semantic search (via qmd, when configured) supplements explicit links by surfacing claims that share conceptual similarity even when the author did not manually connect them.

### Processing: Heavy

370 files of existing research, 107 indexed references, a 4,300-line specification, and Lean proofs. This is not a casual note-taking use case — it is systematic research synthesis. The processing pipeline (/extract -> /connect -> /reweave) automates the labor-intensive work of decomposing dense sources into claims and weaving them into the knowledge graph.

### Navigation: 3-Tier

With 107+ references and six sub-domains, a flat list of claims is unnavigable. The 3-tier hierarchy (index hub -> discipline topic maps -> individual claims) provides progressive disclosure: start at the index, drill into a discipline, find specific claims. Seven topic maps cover the domain intersections around murail.

### Maintenance: Condition-Based (Tight)

Active research with iterative refinement means claims will be superseded as the formal model evolves. Tight thresholds for orphan detection, stale claim warnings, and pending observation processing prevent the vault from accumulating dead weight. The session-orient hook checks these conditions at startup.

### Schema: Moderate

The existing research already uses a structured evidence rating system (STRONG/MODERATE/WEAK/INTERNAL-ONLY) and numbered decision classification (D1-D69). The schema captures this structure (evidence, source, type, topics) without over-constraining. The validate-note hook enforces required fields (description, type, topics) but does not mandate every optional field.

### Automation: Full

Claude Code's hook system enables end-to-end automation: session orientation on start, note validation on write, auto-commit on write, and session capture on stop. Skills handle the processing phases (/extract, /connect, /verify). This matches the heavy processing requirement — manual invocation of each step would be impractical at this scale.

## Active Feature Blocks

All kernel blocks are active (wiki-links, processing-pipeline, schema, maintenance, self-evolution, methodology-knowledge, session-rhythm, templates, ethical-guardrails, helper-functions, graph-analysis). Additionally:

- **atomic-notes** — activated by granularity = atomic
- **mocs** — activated by navigation = 3-tier
- **semantic-search** — activated by linking = explicit+implicit (conditional on qmd installation)

Disabled blocks:
- **personality** — no strong signals in conversation; using neutral defaults
- **self-space** — research default; goals route to ops/goals.md, identity in CLAUDE.md
- **multi-domain** — starting with murail; expandable via /add-domain

## Coherence Validation

All hard constraints passed. No soft constraint adjustments needed. No compensating mechanisms required. The dimension positions form a coherent configuration: atomic granularity pairs naturally with heavy processing (many small notes need automated creation), flat organization pairs with 3-tier navigation (topic maps replace folders), and full automation supports the scale implied by 107 references.

---

Topics:
- [[methodology]]
