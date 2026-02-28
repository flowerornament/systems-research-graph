---
description: Machine-readable manifest for runtime skill configuration
type: system
---

```yaml
# Ars Contexta Derivation Manifest
# This file is consumed by skills at runtime. Edit ops/config.yaml for human changes.

engine_version: "0.8.0"
research_snapshot: "2026-02-27"
generated_at: "2026-02-27T00:00:00Z"
platform: "claude-code"
kernel_version: "0.8.0"

dimensions:
  granularity: atomic
  organization: flat
  linking: explicit+implicit
  processing: heavy
  navigation: 3-tier
  maintenance: condition-based
  schema: moderate
  automation: full

active_blocks:
  - wiki-links
  - processing-pipeline
  - schema
  - maintenance
  - self-evolution
  - methodology-knowledge
  - session-rhythm
  - templates
  - ethical-guardrails
  - helper-functions
  - graph-analysis
  - atomic-notes
  - mocs
  - semantic-search

inactive_blocks:
  - personality
  - self-space
  - multi-domain

vocabulary:
  # Level 1 — Folder names
  notes: notes
  inbox: inbox
  archive: archive

  # Level 2 — Note types
  note: claim
  note_plural: claims

  # Level 3 — Process phases
  reduce: extract
  reflect: connect
  reweave: reweave
  verify: verify
  validate: validate
  rethink: rethink

  # Level 4 — Navigation
  MOC: topic map

  # Level 5 — Schema fields
  description: claim context
  topics: research areas

  # Level 6 — Templates
  topic_map_template: topic-map.md
  base_note_template: claim-note.md

  # Level 7 — Commands
  cmd_reduce: /arscontexta:extract
  cmd_reflect: /arscontexta:connect
  cmd_reweave: /arscontexta:reweave
  cmd_verify: /arscontexta:verify
  cmd_rethink: /arscontexta:rethink

extraction_categories:
  - category: claims
    description: "Central arguments, empirical findings from sources"
    output_type: claim
  - category: decisions
    description: "Architectural choices with rationale"
    output_type: "claim (type: decision)"
  - category: properties
    description: "Formal invariants, theorems, type-level guarantees"
    output_type: "claim (type: property)"
  - category: patterns
    description: "Design techniques, implementation idioms"
    output_type: "claim (type: pattern)"
  - category: contradictions
    description: "Where sources or approaches conflict"
    output_type: "claim (type: contradiction)"
  - category: open-questions
    description: "Unresolved research gaps, future work"
    output_type: "claim (type: open-question)"

platform_hints:
  context: fork
  semantic_search_tool: null
  topology: fresh-context
  hooks:
    - SessionStart
    - PostToolUse
    - Stop

personality:
  enabled: false
  warmth: neutral-helpful
  opinionatedness: neutral
  formality: professional
  emotional_awareness: task-focused

domain:
  primary_project: murail
  description: "Embeddable audio graph engine (Rust)"
  intersections:
    - audio-dsp
    - language-design
    - concurrent-systems
    - rust-ecosystem
    - ai-ml
    - competing-systems
    - formal-methods
  existing_research:
    note: "See each project's .design/ directory for current counts"
  future_domains:
    - herald
    - tau5

failure_mode_risks:
  - name: collectors-fallacy
    severity: high
  - name: orphan-drift
    severity: high
  - name: verbatim-risk
    severity: high
  - name: productivity-porn
    severity: high
```
