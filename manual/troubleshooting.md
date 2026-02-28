---
description: Diagnosing and resolving common vault issues -- orphan claims, dangling links, stale content, inbox overflow
type: manual
generated_from: "arscontexta-0.8.0"
---

# Troubleshooting

Common problems, their causes, and how to resolve them.

## Orphan Claims

**Symptom:** `/stats` shows orphan count climbing. Claims exist in notes/ but are not linked from any topic map. They are invisible to navigation -- you can only find them by filename or full-text search.

**Why it happens:**
- `/extract` created claims but did not assign topic map links (or assigned links to maps that do not exist yet)
- Topic maps were restructured without updating claim references
- Manual claim creation without adding topic map membership

**Diagnosis:**

```
/validate
```

The validation report lists orphan claims explicitly. Review the list -- some may be legitimate new claims that need homes, others may be extraction artifacts.

**Resolution:**

```
/reweave
```

Reweave examines each orphan, determines which topic map(s) it belongs to, and adds the links. It may also create new topic maps if orphans cluster around a topic not yet represented.

For individual orphans:

```
/connect "notes/orphaned-claim-title.md"
```

Connect will find related claims and topic maps, integrating the orphan into the graph.

**Prevention:**
- After `/extract`, check that every new claim has at least one topic map link
- `/learn "Always assign topic map links during extraction"` if extraction consistently misses them
- Run `/validate` after bulk extraction before doing other work

## Dangling Links

**Symptom:** Wiki links in claims point to files that do not exist. The link renders as plain text in any viewer. Clicking it goes nowhere.

**Why it happens:**
- A claim was renamed or archived without updating references
- `/extract` created a link to a claim that was supposed to be created but was not (e.g., extraction was interrupted)
- Manual typo in a wiki link
- Topic map was renamed or merged via `/refactor` without full link update

**Diagnosis:**

```
/validate
```

Reports all dangling links with the source file and target that does not exist.

**Resolution:**

For small numbers of dangling links, fix them manually -- either create the missing target or update the link to point to the correct claim.

For systematic dangling links (e.g., after a refactor), check if the targets were renamed:

```
/arscontexta:ask "Was there a claim about [topic of dangling link target]?"
```

If the claim exists under a different name, update the link. If the claim was archived, decide whether to remove the link or create a replacement claim.

**Prevention:**
- Use `/refactor` for renaming rather than manual file operations -- it updates all references
- Run `/validate` after any structural changes
- After archiving claims, check for incoming links from other claims

## Stale Content

**Symptom:** Claims reference outdated information. A decision claim says "D14 uses channels" but the spec has moved to lock-free ring buffers. Evidence ratings no longer reflect the current source landscape.

**Why it happens:**
- The formal model evolved but claims were not updated to match
- New sources were extracted that supersede older claims but no one ran `/verify` on the old ones
- Claims were written early in the research process when understanding was partial

**Diagnosis:**

```
/stats
```

Check for claims older than 30 days without verification. These are staleness candidates.

For targeted diagnosis:

```
/arscontexta:ask "What does the vault say about [topic that has evolved]?"
```

If the answer feels wrong or outdated, the underlying claims are stale.

**Resolution:**

```
/verify "notes/stale-claim-title.md"
```

Verify checks the claim against its source and current vault state. It may update the evidence rating or flag content issues.

For claims that need substantive revision:

```
/rethink "notes/stale-claim-title.md"
```

Rethink may update the claim in place, archive it and create a replacement, or flag it as a contradiction with newer claims. See [[meta-skills]] for /rethink patterns.

**Prevention:**
- Run `/verify` on a rolling basis -- 5-10 claims per deep session
- After major changes to the formal model, run `/verify` on decision and property claims in the affected area
- `/ralph` includes staleness checks in its priority assessment

## Inbox Overflow

**Symptom:** inbox/ accumulates raw sources faster than they are extracted. `/stats` shows inbox depth > 20. The vault has a growing body of unprocessed material that creates cognitive overhead and the illusion of progress.

This is the Collector's Fallacy -- the derivation flags it as HIGH risk for research-heavy vaults.

**Why it happens:**
- Research naturally produces more sources than can be immediately processed
- It feels productive to capture sources, so capture outpaces extraction
- Extraction is the most cognitively demanding processing step

**Diagnosis:**

```
/stats
```

Check inbox depth and the ratio of raw to extracted sources. If raw > extracted, the pipeline is backing up.

```
/tasks
```

Shows how many extraction tasks are queued.

**Resolution:**

Stop capturing. Shift all processing effort to `/extract` until inbox depth is manageable (under 10 raw sources).

For bulk processing:

```
/pipeline inbox/source-1.md
/pipeline inbox/source-2.md
```

Or let the orchestrator handle sequencing:

```
/ralph
```

Ralph will prioritize extraction when inbox depth is high.

For sources that have been sitting for weeks and are no longer relevant:

Move them to archive/ without extraction. Not every captured source needs to become claims. Be selective.

**Prevention:**
- Adopt a one-in-one-out rule: extract a source before capturing a new one
- During deep sessions, spend the first hour on extraction before doing anything else
- `/remember "Extract before capturing -- inbox overflow is the primary failure mode"`

## Low Connection Density

**Symptom:** `/stats` shows average connections per claim below 2. Claims exist but feel isolated. The graph is sparse -- more a collection of disconnected points than a knowledge network.

**Why it happens:**
- Claims were extracted but `/connect` was not run on them
- Claims are too narrow or too domain-specific to bridge disciplines
- Topic maps are not being used as connection hubs

**Diagnosis:**

```
/graph --global
```

Look at the topology. Are there clusters of well-connected claims with isolated outliers? Or is everything uniformly sparse?

**Resolution:**

Run `/connect` on the least-connected claims:

```
/connect "notes/isolated-claim.md"
```

Focus on claims that sit at discipline boundaries -- these are most likely to have undiscovered connections.

If connection density remains low after running `/connect`, the claims may be too granular or too narrow. Consider:

```
/rethink extraction-categories
```

Are the extraction categories producing claims that are too atomic to connect meaningfully?

**Prevention:**
- Always run `/connect` after `/extract` -- never leave claims unconnected
- Prioritize cross-disciplinary sources that naturally bridge domains
- During review sessions, run `/connect` on older claims that may have new connection targets

## Schema Validation Failures

**Symptom:** `/validate` reports frontmatter errors -- missing required fields, invalid enum values, malformed YAML.

**Why it happens:**
- Manual claim creation without following the template
- Template was modified without updating existing claims
- `/extract` produced claims with incomplete frontmatter

**Diagnosis:**

```
/validate notes/
```

Reports every schema violation with file path and specific error.

**Resolution:**

Fix frontmatter manually or re-extract the source. For bulk fixes after a template change:

```
/arscontexta:health
```

Health check identifies systematic schema issues and can suggest bulk corrections.

**Prevention:**
- Use templates for manual claim creation
- The validate-note.sh hook runs on every file write -- it should catch problems at creation time
- After changing templates via `/arscontexta:reseed`, run `/validate` on existing claims

## Topic Map Sprawl

**Symptom:** Too many topic maps, each with only a few claims. Or topic maps that overlap significantly, making it unclear where a claim belongs.

**Why it happens:**
- New topic maps created for every sub-topic rather than grouping coherently
- Domain understanding evolved but maps were not restructured
- `/reweave` created maps for small orphan clusters that should have joined existing maps

**Diagnosis:**

```
/graph --global
```

Look at topic map sizes and overlap. Maps with fewer than 5 claims may be too narrow. Maps that share many claims may need merging.

**Resolution:**

```
/refactor --merge "notes/narrow-map-1.md" "notes/narrow-map-2.md"
```

Merge overlapping maps. Or:

```
/rethink "notes/sprawling-map.md"
```

Rethink a map's scope and restructure.

**Prevention:**
- Before creating a new topic map, check if an existing one covers the area
- Review map structure during review sessions (see [[workflows]])
- Aim for 10-30 claims per topic map as a rough guideline

## Processing Pipeline Stalls

**Symptom:** `/ralph` does not seem to make progress. The same tasks appear repeatedly. The pipeline feels stuck.

**Why it happens:**
- A claim fails verification repeatedly (maybe the source is ambiguous)
- Circular dependencies between claims being processed
- The vault is in a state that does not match any pipeline trigger condition

**Diagnosis:**

```
/tasks
```

Check if the same tasks keep appearing. Look for tasks that have been in the queue across multiple sessions.

```
/arscontexta:health
```

Full system check may reveal infrastructure issues (hook failures, template problems).

**Resolution:**

Clear the stall manually. If a claim keeps failing verification, `/rethink` it -- maybe it should be archived or rewritten. If `/ralph` is not triggering, run processing commands directly:

```
/extract inbox/specific-source.md
/connect "notes/specific-claim.md"
```

Bypass the orchestrator and process directly until the stall clears.

**Prevention:**
- Do not rely exclusively on `/ralph` -- mix automated and manual processing
- Address verification failures promptly rather than letting them recycle
- `/remember` any processing patterns that cause stalls for future avoidance

## Related Pages

- [[skills]] -- Command reference
- [[workflows]] -- Processing patterns that prevent issues
- [[configuration]] -- Dimension adjustments that may resolve structural problems
- [[meta-skills]] -- /rethink and /arscontexta:ask for diagnosis
