---
description: Complete reference for all vault commands grouped by category
type: manual
generated_from: "arscontexta-0.8.0"
---

# Skills

Every command available in the arscontextica vault, grouped by function. Commands use domain vocabulary -- "claims" not "notes", "extract" not "reduce", "connect" not "reflect", "topic maps" not "MOCs".

## Processing

These commands move material through the extraction pipeline. See [[workflows]] for how they chain together.

### /arscontexta:extract

Extract atomic claims from a source in inbox/. Reads the source, identifies discrete propositions, and creates individual claim files in notes/ with proper frontmatter.

```
/arscontexta:extract inbox/faust-signal-semantics.md
```

Each extracted claim gets:
- A sentence title expressing one proposition
- Evidence rating based on source quality
- Source attribution back to the inbox file
- Topic map links based on content
- Type classification (claim, decision, property, pattern, contradiction, open-question)

The source file's status field updates from `raw` to `extracting` during processing, then `extracted` on completion.

**When to use:** Inbox has raw sources. This is always the first processing step.

### /arscontexta:connect

Discover and create connections between a claim and the rest of the graph. Searches for semantic relationships across all claims -- shared concepts, contradictions, cross-disciplinary bridges.

```
/arscontexta:connect "notes/Lock-free ring buffers prevent priority inversion.md"
```

Produces:
- Wiki links added to the claim's "Relevant Notes" section
- Reciprocal links added to connected claims
- Context annotations explaining each relationship

**When to use:** After extraction, or when a claim feels isolated. Especially valuable for cross-disciplinary claims -- a type system property connecting to an audio scheduling constraint.

### /arscontexta:reweave

Integrate orphan claims into the topic map structure. Finds claims that lack topic map links or have weak connections, and weaves them into the appropriate maps.

```
/arscontexta:reweave
```

Also consolidates topic maps when they grow too large or overlap significantly. May suggest splitting a broad map into focused sub-maps.

**When to use:** When `/arscontexta:stats` shows a rising orphan count. Part of regular maintenance -- see [[workflows]].

### /arscontexta:verify

Check claim accuracy and evidence quality. Reviews a claim's content against its source, validates evidence ratings, flags unsupported assertions.

```
/arscontexta:verify "notes/Bounded SPSC queues are sufficient for parameter updates.md"
```

May update evidence ratings, flag contradictions with other claims, or note where a claim has drifted from its source.

**When to use:** When you suspect a claim is stale, after updating source material, or as part of a maintenance cycle.

### /arscontexta:validate

Structural integrity check. Validates frontmatter schema, required fields, wiki link targets, topic map completeness. Unlike `/arscontexta:verify` (which checks content accuracy), `/arscontexta:validate` checks the vault's structural health.

```
/arscontexta:validate
/arscontexta:validate notes/
/arscontexta:validate "notes/specific-claim.md"
```

Reports:
- Missing required frontmatter fields
- Invalid enum values (type, evidence)
- Dangling wiki links (links to non-existent files)
- Claims without topic map membership
- Topic maps not linked from the hub index

**When to use:** After bulk extraction, before committing, or when something feels structurally off.

## Orchestration

Commands that coordinate multi-step work and manage task flow.

### /arscontexta:seed

Initialize the vault structure. Creates folder hierarchy, templates, ops files, and the hub index. Typically run once during vault setup.

```
/arscontexta:seed
```

Generates: notes/, inbox/, archive/, templates/, ops/, manual/ directories, plus starter templates and configuration.

**When to use:** Vault initialization only. For re-initialization, see `/arscontexta:reseed`.

### /arscontexta:ralph

The processing orchestrator. Analyzes vault state and runs the appropriate pipeline stage -- extract, connect, reweave, verify -- based on current conditions.

```
/arscontexta:ralph
```

Ralph checks inbox depth, orphan count, connection density, and staleness to decide what needs attention. It runs the highest-priority processing step automatically.

**When to use:** When you want the system to decide what to work on. Good for maintaining flow without manually sequencing commands.

### /arscontexta:pipeline

Run the full processing pipeline on a source or set of claims. Chains extract, connect, and verify in sequence.

```
/arscontexta:pipeline inbox/rust-ownership-audio-buffers.md
```

Equivalent to running `/arscontexta:extract`, then `/arscontexta:connect` on each resulting claim, then `/arscontexta:verify` on each.

**When to use:** When you want end-to-end processing of a source without manual sequencing.

### /arscontexta:tasks

Show the current task queue. Lists pending extraction, connection, and maintenance work ranked by priority.

```
/arscontexta:tasks
```

**When to use:** Session start, or when you want to see what needs attention without running `/arscontexta:ralph`.

## Navigation

Commands for understanding vault state and finding what to work on.

### /arscontexta:stats

Vault health dashboard. Shows counts, ratios, and health indicators.

```
/arscontexta:stats
```

Reports:
- Total claims, by type
- Inbox depth (raw / extracting / extracted)
- Orphan count (claims without topic map links)
- Connection density (average links per claim)
- Staleness indicators (claims unchanged since creation)
- Topic map coverage

**When to use:** Session start. Gives you the lay of the land.

### /arscontexta:graph

Visualize claim relationships. Generates a local graph view centered on a claim, or a global view of topic map structure.

```
/arscontexta:graph "notes/Audio callbacks must never block or allocate.md"
/arscontexta:graph --global
```

Shows direct connections, shared topic maps, and connection types (supports, contradicts, bridges).

**When to use:** When you want to see how a claim fits into the broader graph, or to find structural gaps.

### /arscontexta:next

Suggest the next piece of work. Analyzes vault state and recommends a specific action -- extract this source, connect this orphan, verify this stale claim.

```
/arscontexta:next
```

**When to use:** When you finish a task and want guidance on what to do next.

## Growth

Commands for expanding the system's capabilities and memory.

### /arscontexta:learn

Teach the system a new processing pattern or domain convention. Persists to ops/methodology/ so it applies in future sessions.

```
/arscontexta:learn "When extracting from Lean proof files, classify invariants as type: property with evidence: strong"
```

**When to use:** When you notice the system making repeated mistakes or missing a domain convention.

### /arscontexta:remember

Store an insight or observation for future reference. Unlike `/arscontexta:learn` (which changes behavior), `/arscontexta:remember` records something worth recalling.

```
/arscontexta:remember "D14 and D37 are tightly coupled -- any change to inter-thread communication affects the plugin API boundary"
```

Persists to ops/observations/. Surfaces in future sessions when relevant claims are being processed. See [[meta-skills]] for advanced usage.

**When to use:** When you notice something important during processing that does not fit in a single claim.

## Evolution

Commands for rethinking and restructuring the vault.

### /arscontexta:rethink

Challenge and potentially revise a claim, topic map, or structural assumption. Examines a piece of the vault critically -- is this claim still accurate? Does this topic map still reflect the domain? Has new evidence changed the picture?

```
/arscontexta:rethink "notes/Rust's ownership model maps naturally to audio buffer lifetimes.md"
/arscontexta:rethink "notes/concurrent-systems-map.md"
```

May result in:
- Updated claim content or evidence rating
- Claim archived and replaced by a revised version
- Topic map restructured
- New contradictions or open questions surfaced

See [[meta-skills]] for deep usage patterns.

**When to use:** When you suspect a claim is outdated, when the formal model has evolved, or during periodic review.

### /arscontexta:refactor

Restructure vault organization without changing claim content. Rename files, merge or split topic maps, reorganize the hub index.

```
/arscontexta:refactor --merge "notes/audio-dsp-map.md" "notes/signal-processing-map.md"
/arscontexta:refactor --split "notes/systems-design-map.md"
```

**When to use:** When topic maps have grown unwieldy, when domain understanding has shifted, or when the navigation structure no longer matches how you think about the research.

## Plugin

Commands provided by the arscontexta plugin for system-level operations.

### /arscontexta:help

Show available commands and brief descriptions. Quick reference when you forget a command name.

```
/arscontexta:help
```

### /arscontexta:health

System health check. Validates ops/ structure, template integrity, hook configuration, and vault consistency. More comprehensive than `/arscontexta:validate` -- checks the system itself, not just the claims.

```
/arscontexta:health
```

### /arscontexta:ask

Ask a question answered by the claim graph. Searches across claims, synthesizes connections, and returns an answer grounded in your extracted knowledge.

```
/arscontexta:ask "What constraints does real-time audio impose on memory allocation strategies?"
/arscontexta:ask "How do murail's concurrency invariants interact with the plugin API?"
```

Does not create or modify claims. Read-only query against the graph. See [[meta-skills]] for advanced query patterns.

### /arscontexta:architect

Examine or modify vault configuration dimensions. Shows current dimension positions (granularity, organization, linking, etc.) and allows adjustment.

```
/arscontexta:architect
/arscontexta:architect --show granularity
```

See [[configuration]] for the full dimension reference.

### /arscontexta:add-domain

Add a new research domain to the vault. Creates domain-specific topic maps and configures extraction categories.

```
/arscontexta:add-domain herald
```

Currently the vault covers murail (audio DSP, PL design, concurrency, formal methods). Future domains like herald (personal OS, Elixir/Ash) can be added without restructuring existing claims.

### /arscontexta:setup

Run initial vault setup. Creates directory structure, generates templates, configures hooks. Typically run once.

```
/arscontexta:setup
```

### /arscontexta:reseed

Regenerate vault infrastructure from the derivation. Re-reads ops/derivation.md and regenerates templates, hooks, and configuration without touching existing claims.

```
/arscontexta:reseed
```

**When to use:** After manually editing the derivation, or when templates/hooks are out of sync with configuration.

### /arscontexta:upgrade

Upgrade the vault to a new engine version. Migrates templates, hooks, and configuration while preserving claims.

```
/arscontexta:upgrade
```

### /arscontexta:tutorial

Interactive tutorial walking through vault concepts and commands. Covers the full lifecycle: source capture, extraction, connection, maintenance.

```
/arscontexta:tutorial
```

### /arscontexta:recommend

Suggest sources, research directions, or structural improvements based on current vault state.

```
/arscontexta:recommend
```

Analyzes graph structure, identifies thin areas in topic coverage, and suggests sources or research directions that would strengthen the claim graph.
