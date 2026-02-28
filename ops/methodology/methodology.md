---
description: How this knowledge system works and why it was designed this way
type: moc
created: 2026-02-27
---

# methodology

This vault uses Ars Contexta, a systematic approach to research knowledge management. It was derived from a structured conversation that mapped research needs to configuration dimensions.

## How It Works
1. **Extract** — Decompose sources into atomic claims (one idea per note)
2. **Connect** — Find cross-disciplinary links between claims via wiki-links and semantic search
3. **Reweave** — Restructure topic maps as the claim graph evolves
4. **Verify** — Check claims against sources, evidence ratings, and formal models
5. **Validate** — Ensure vault health: no orphans, no stale claims, consistent schema

## Design Rationale
- [[derivation-rationale]] — Why each dimension was chosen

## System Files
- ops/derivation.md — Raw derivation record (dimension positions, vocabulary, signals)
- ops/derivation-manifest.md — Machine-readable manifest for runtime skill configuration
- ops/config.yaml — Human-editable configuration overrides

## Maintenance
- Condition-based: triggered when orphan count, pending observations, or pending tensions exceed thresholds
- Session capture: metadata saved on session end for continuity

---

Topics:
- [[index]]
