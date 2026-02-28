---
description: Vault configuration structure, dimension positions, and /architect usage
type: manual
generated_from: "arscontexta-0.8.0"
---

# Configuration

The vault's behavior is governed by its derivation -- a set of dimension positions that shape how claims are structured, organized, linked, and maintained. Configuration lives in ops/derivation.md and is manipulated via `/arscontexta:architect`.

## The Derivation

ops/derivation.md is the vault's source of truth. It records every architectural decision made during vault setup and enables regeneration of templates, hooks, and skills via `/arscontexta:reseed`.

The derivation is not a config file you edit by hand. Use `/arscontexta:architect` to examine and adjust dimensions, then `/arscontexta:reseed` to propagate changes.

## Configuration Dimensions

Each dimension controls one aspect of vault behavior. The current positions were derived from conversation signals during setup.

### Granularity: Atomic

Claims express one proposition each. Titles are complete sentences. No composite notes that bundle multiple ideas.

This position was chosen because the murail domain requires discrete theorems, decisions, and invariants -- the formal model has 69 individual architectural decisions and 20 named invariants. Atomic granularity lets each be tracked, connected, and revised independently.

**Trade-off:** More files, more linking overhead. Compensated by strong tooling (/extract handles decomposition, /connect handles linking).

### Organization: Flat

No folder hierarchy within notes/. All claims live at the same level. Organization comes from topic maps and wiki links, not directory structure.

This position was chosen because the domain is cross-disciplinary. A claim about Rust ownership semantics belongs to both "programming language design" and "audio buffer management." Folder hierarchies force single-parent classification. Flat + topic maps allow multi-membership.

### Linking: Explicit + Implicit

Claims have both hand-written wiki links (explicit) and system-discovered connections (implicit, via `/connect`). The system also supports semantic search when available.

This position reflects the high volume and cross-disciplinary nature of the vault. With 500+ projected claims across 6 sub-domains, manual linking alone cannot find all relevant connections.

### Processing: Heavy

Full pipeline automation -- extract, connect, verify, reweave. Sources are systematically decomposed rather than casually noted.

This position matches the 370 files of existing research and 107 references. The volume demands automated processing. Manual claim creation is still possible but extraction from sources is the primary intake path.

### Navigation: 3-Tier

Hub index links to topic maps. Topic maps link to claims. Three levels of navigation.

- **Hub** (notes/index.md) -- Links to all topic maps
- **Topic maps** (e.g., notes/audio-dsp-map.md) -- Gathers claims for a research area
- **Claims** (e.g., notes/Lock-free ring buffers prevent priority inversion.md) -- Individual propositions

### Maintenance: Condition-Based (Tight)

Maintenance triggers based on vault state metrics rather than calendar schedule. "Tight" means low thresholds -- orphan drift and staleness are caught early.

Current thresholds:
- Orphan count > 10% of total claims triggers `/reweave`
- Claims older than 30 days without verification flagged for `/verify`
- Inbox depth > 20 triggers extraction priority
- Connection density < 2 links/claim flags thin areas

### Schema: Moderate

Claims have structured frontmatter (description, type, evidence, source, topics, created) but the body is freeform prose. The schema validates structure without constraining expression.

Enum values:
- **type:** claim, decision, property, pattern, contradiction, open-question
- **evidence:** strong, moderate, weak, internal-only
- **source_type** (inbox): paper, talk, documentation, code-analysis, transcript, conversation

### Automation: Full

Claude Code platform with full hook and skill support. Hooks run on session start, file write, and session end. Skills handle all processing phases.

Hooks:
- **session-orient.sh** -- SessionStart: vault state summary
- **validate-note.sh** -- PostToolUse (Write): schema validation on file save
- **auto-commit.sh** -- PostToolUse (Write): git commit on changes
- **session-capture.sh** -- Stop: capture session observations

## Using /architect

### View Current Configuration

```
/arscontexta:architect
```

Displays all dimension positions with confidence levels and the conversation signals that produced them.

### Inspect a Specific Dimension

```
/arscontexta:architect --show maintenance
```

Shows the dimension's current position, alternatives, trade-offs, and active compensating mechanisms.

### Adjust a Dimension

```
/arscontexta:architect --set maintenance relaxed
```

Changes a dimension position. The system will warn about coherence implications -- changing one dimension may create tension with others. After adjustment, run `/arscontexta:reseed` to regenerate affected infrastructure.

**Caution:** Dimension changes can have cascading effects. Moving granularity from "atomic" to "composite" would affect extraction behavior, template structure, and connection patterns. The architect command checks coherence constraints before applying changes.

## Extraction Categories

The derivation defines what kinds of claims to look for during `/extract`:

| Category | What to Find | Output Type |
|----------|-------------|-------------|
| claims | Central arguments, empirical findings | claim |
| decisions | Architectural choices with rationale (D1-D69) | claim (type: decision) |
| properties | Formal invariants, theorems, type-level guarantees | claim (type: property) |
| patterns | Design techniques, implementation idioms | claim (type: pattern) |
| contradictions | Where sources or approaches conflict | claim (type: contradiction) |
| open-questions | Unresolved research gaps | claim (type: open-question) |

## Personality Dimensions

The vault uses a neutral-professional tone. These are not commonly adjusted but are recorded in the derivation:

| Dimension | Position |
|-----------|----------|
| Warmth | neutral-helpful |
| Opinionatedness | neutral |
| Formality | professional |
| Emotional Awareness | task-focused |

## Feature Blocks

Active feature blocks determine which capabilities are available. Current state:

| Feature | Status | Notes |
|---------|--------|-------|
| wiki-links | active | Kernel feature, always on |
| processing-pipeline | active | Extract/connect/verify/reweave |
| schema | active | Frontmatter validation |
| maintenance | active | Condition-based triggers |
| self-evolution | active | /learn, /remember, /rethink |
| methodology-knowledge | active | ops/methodology/ |
| session-rhythm | active | Hook-driven session flow |
| templates | active | claim-note, topic-map, source-capture |
| graph-analysis | active | /graph visualization |
| atomic-notes | active | Granularity = atomic |
| mocs | active | Navigation = 3-tier |
| semantic-search | active | Conditional on qmd availability |
| personality | inactive | No signals provided |
| self-space | inactive | Research default |
| multi-domain | inactive | Single domain (murail); add via /arscontexta:add-domain |

## Platform Configuration

- **Tier:** Claude Code
- **Topology:** fresh-context (subagent per processing phase)
- **Self Space:** Disabled (goals route to ops/goals.md, identity in CLAUDE.md)

## Related Pages

- [[skills]] -- Commands that operate within this configuration
- [[meta-skills]] -- /arscontexta:architect deep patterns
- [[workflows]] -- How configuration shapes processing flow
