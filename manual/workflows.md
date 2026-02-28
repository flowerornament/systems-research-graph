---
description: Processing pipeline, maintenance cycles, and session rhythm patterns
type: manual
generated_from: "arscontexta-0.8.0"
---

# Workflows

How material flows through the vault, how to maintain structural health, and how to structure sessions for sustained research velocity.

## Processing Pipeline

Material moves through the vault in a defined sequence. Each stage transforms the material and increases its value to the claim graph.

```
Source → inbox/ (raw) → /extract → notes/ (claims) → /connect → linked claims → /verify → validated claims
```

### Stage 1: Capture

Drop source material into inbox/ using the source-capture template. Sources can be papers, documentation, code analysis, transcripts, or conversation notes.

```yaml
---
description: "Lean 4 metaprogramming for DSP graph verification"
source_type: paper
url: "..."
status: raw
---
```

Tag with `status: raw`. Do not try to organize or summarize at this stage -- just capture.

**Failure mode to watch:** Collector's Fallacy. It is easy to keep accumulating sources without extracting. Extract before you capture more. Check inbox depth with `/stats`.

### Stage 2: Extract

Run `/extract` on a raw source. The system reads the full source and identifies atomic claims -- individual propositions that can stand alone.

For a paper on lock-free audio architectures, extraction might produce:

- "Lock-free ring buffers prevent priority inversion between audio and control threads" (type: claim)
- "Audio callback thread priority must exceed all non-audio threads" (type: property)
- "SPSC queues are sufficient when parameter updates flow unidirectionally" (type: decision)
- "Wait-free vs lock-free distinction matters for worst-case latency guarantees" (type: claim)

Each claim gets its own file in notes/ with full frontmatter, evidence rating, and topic map links.

**Key discipline:** Transform, do not copy. The claim body must be your reasoning about the source material, not verbatim quotes. This is both an intellectual requirement (the claim must connect to your domain) and a practical one (verbatim copying is a failure mode flagged in the derivation).

### Stage 3: Connect

Run `/connect` on extracted claims. This is where cross-disciplinary value emerges.

A claim about lock-free ring buffers might connect to:
- A formal methods claim about bounded model checking (both deal with finite resource bounds)
- A PL design decision about ownership semantics (Rust's borrow checker can statically enforce single-producer/single-consumer)
- An open question about plugin API boundaries (how do third-party plugins interact with the lock-free core?)

Connections are bidirectional -- the system adds wiki links to both sides of each connection.

### Stage 4: Verify

Run `/verify` on connected claims to check accuracy and evidence quality. Verification may:
- Confirm or adjust evidence ratings
- Flag claims that have been superseded by newer sources
- Identify contradictions with other verified claims
- Note where a claim needs stronger evidence

### Running the Full Pipeline

For end-to-end processing, use `/pipeline`:

```
/pipeline inbox/rust-audio-buffer-lifetimes.md
```

This chains extract, connect, and verify in sequence. For more control, run each stage manually.

For automated sequencing, use `/ralph` -- it analyzes vault state and runs whatever stage needs attention most.

## Maintenance Cycle

The vault degrades without maintenance. Three forms of entropy accumulate:

### Orphan Drift

Claims extracted but never connected to topic maps. They exist in notes/ but are invisible to navigation. `/stats` reports orphan count. `/reweave` integrates them.

**Prevention:** `/extract` should assign topic map links during extraction. If orphans accumulate, the extraction prompts may need tuning via `/learn`.

**Cure:** Run `/reweave` when orphan count exceeds ~10% of total claims.

### Connection Decay

Early claims may lack connections that only become visible after later claims are extracted. A claim about type-level buffer size guarantees gains new relevance after extracting a source on bounded model checking.

**Prevention:** Periodic `/connect` passes over older claims.

**Cure:** `/connect --stale` to re-examine claims that have not been connected since creation.

### Content Staleness

Claims become outdated as the formal model evolves. A decision claim written when D14 was "use channels" becomes stale when D14 shifts to "use lock-free ring buffers."

**Prevention:** `/verify` checks claims against current source state.

**Cure:** `/rethink` on stale claims. May result in updated content, revised evidence, or archival with replacement. See [[meta-skills]] for /rethink patterns.

### Maintenance Triggers

Run maintenance when `/stats` shows any of:
- Orphan count > 10% of total claims
- Average connections per claim < 2
- Claims older than 30 days without verification
- Inbox depth > 20 raw sources

Or simply run `/ralph` and let it decide.

## Session Rhythm

### Short Session (15-30 minutes)

Best for incremental progress when time is limited.

1. `/stats` -- Check vault health
2. `/next` -- Get a recommendation
3. Do one thing: extract one source, or connect a batch of recent claims, or verify a few stale claims
4. `/validate` -- Quick structural check before ending

### Deep Session (1-2 hours)

Best for substantial extraction work or structural maintenance.

1. `/stats` -- Assess vault state
2. `/tasks` -- Review the full work queue
3. **Phase 1: Extract.** Process 2-3 inbox sources with `/extract`. This produces 10-30 new claims.
4. **Phase 2: Connect.** Run `/connect` on each new claim. Look for cross-disciplinary bridges.
5. **Phase 3: Maintain.** If orphans accumulated, run `/reweave`. If stale claims surfaced, run `/rethink` on the most important ones.
6. `/validate` -- Full structural check
7. `/stats` -- Compare to session start. Note what improved.

### Review Session (30-60 minutes)

Best for stepping back and assessing the vault's trajectory.

1. `/graph --global` -- Look at the overall topic map structure
2. Identify thin areas -- topic maps with few claims, or claims with low connection density
3. `/arscontexta:ask` -- Query the graph to test its knowledge (see [[meta-skills]])
4. `/arscontexta:recommend` -- Get suggestions for sources or research directions
5. `/rethink` on any claims that feel outdated or underspecified

### Session Hooks

The vault runs hooks automatically:
- **SessionStart** -- Orients you with vault state summary
- **PostToolUse (Write)** -- Validates written files against schema
- **Stop** -- Captures session observations

These run in the background. You do not need to invoke them.

## Pipeline Topology

Processing uses fresh-context topology -- each pipeline stage (extract, connect, verify) runs in its own subagent context. This prevents context contamination between stages and allows parallel processing of independent claims.

The practical implication: do not assume that the connect stage "remembers" extraction details. Each stage reads from the files in notes/. This is by design -- it forces claims to be self-contained.

## Related Pages

- [[skills]] -- Command reference for each pipeline stage
- [[getting-started]] -- First session walkthrough
- [[troubleshooting]] -- When the pipeline stalls or produces poor results
