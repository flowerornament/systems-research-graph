# systems-research-graph

A cross-disciplinary research knowledge graph operated by [Claude Code](https://claude.ai/code) via the [Ars Contexta](https://github.com/flower-ornament/ars-contexta) methodology plugin. Contains 350+ atomic claims covering agent architecture, concurrency, audio DSP, language design, algebraic effects, formal methods, AI/ML, and developer experience.

## Structure

```
notes/          Atomic claims (one insight per file) + topic maps
inbox/          Raw sources queued for extraction
templates/      Claim and topic map templates with schema definitions
ops/            Operational state: goals, queue, config, session logs, queries
manual/         System documentation (getting started, workflows, skills)
```

**Claims** are markdown files with YAML frontmatter. Each title is a complete prose sentence expressing one proposition (e.g., `lock-free-ring-buffers-prevent-priority-inversion-between-audio-and-control-threads.md`). Claims connect via `[[wiki links]]`.

**Topic maps** are navigation hubs that organize claims by research area. 15 maps cover domains like audio DSP, language design, concurrent systems, formal methods, and agentic design. The `index.md` file is the entry point.

## How it works

Content flows through a pipeline: **capture -> extract -> connect -> verify**.

1. Drop raw material (papers, transcripts, web captures) into `inbox/`
2. Run `/arscontexta:extract` to break sources into atomic claims in `notes/`
3. Run `/arscontexta:connect` to discover cross-disciplinary links
4. Run `/arscontexta:verify` to check claim quality and evidence ratings

All processing is done by Claude Code using skills defined in `CLAUDE.md`. The system is not a static wiki -- it's an agent-operated knowledge graph where Claude is the primary operator, maintaining connections, surfacing contradictions, and keeping the graph healthy.

## Querying

Claims have structured YAML frontmatter (`type`, `evidence`, `source`, `description`) that makes the graph queryable with standard tools:

```bash
rg '^type: decision' notes/           # All architectural decisions
rg '^evidence: strong' notes/         # High-confidence claims
rg '\[\[audio-dsp\]\]' notes/         # Claims in the audio DSP topic
rg '^description:.*real-time' notes/  # Search claim descriptions
```

Pre-built query scripts live in `ops/queries/`:

```bash
ops/queries/orphan-detection.sh    # Claims with no incoming links
ops/queries/cross-discipline.sh    # Claims bridging multiple domains
ops/queries/low-evidence.sh        # Claims needing stronger evidence
ops/queries/open-questions.sh      # Unresolved research gaps
ops/queries/source-diversity.sh    # Source coverage analysis
```

## Configuration

`ops/config.yaml` controls system behavior: processing depth, maintenance thresholds, feature flags, and automation level. `ops/derivation.md` documents why the system is configured the way it is.

## Requirements

- [Claude Code](https://claude.ai/code) with the [Ars Contexta](https://github.com/flower-ornament/ars-contexta) skill plugin
- Optional: [qmd](https://github.com/tobilu/qmd) for semantic search (`bun install -g @tobilu/qmd`)

## Using the graph from other projects

Other repos can reference this graph for design decisions by invoking the `/research-graph` skill in Claude Code, which searches claims by topic. See the global `CLAUDE.md` instructions for integration details.
