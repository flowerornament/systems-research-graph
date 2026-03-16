---
description: Hub page for the systems-research-graph knowledge vault manual
type: manual
generated_from: "arscontexta-0.8.0"
---

# Manual

Reference documentation for the systems-research-graph knowledge vault -- an atomic claim graph for murail research spanning audio DSP, programming language design, concurrent systems, and formal methods.

## Guides

- [[getting-started]] -- First session: creating claims, making connections, finding your rhythm
- [[workflows]] -- Processing pipeline, maintenance cycles, session patterns
- [[meta-skills]] -- Deep guide to /arscontexta:ask, /arscontexta:architect, /arscontexta:rethink, /arscontexta:remember

## Reference

- [[skills]] -- Complete command reference grouped by category
- [[configuration]] -- ops/config.yaml structure, /arscontexta:architect, dimension positions
- [[troubleshooting]] -- Diagnosing orphan claims, dangling links, stale content, inbox overflow

## Core Concepts

**Claims, not notes.** Every file in notes/ expresses one atomic proposition -- a single argument, decision, property, pattern, contradiction, or open question. The title is a complete sentence. The body is your reasoning.

**Extract, then connect.** Sources land in inbox/. `/arscontexta:extract` breaks them into atomic claims in notes/. `/arscontexta:connect` finds the cross-disciplinary links -- where a DSP latency constraint meets a type-system guarantee, where a concurrency invariant shapes an API design.

**Topic maps, not folders.** Organization is flat. A topic map in notes/ (e.g., `audio-graph-topology-map.md`) gathers related claims by wiki link. One claim can appear in multiple topic maps. The hub index links to all topic maps.

**The graph serves the work.** The vault exists to inform your evolving projects -- architectural decisions, invariants, cross-cutting concerns across references. Claims are the connective tissue between sources and products.
