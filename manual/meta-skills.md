---
description: Deep guide to /arscontexta:ask, /arscontexta:architect, /rethink, and /remember
type: manual
generated_from: "arscontexta-0.8.0"
---

# Meta-Skills

Four commands that operate on the vault itself rather than individual claims. These are the tools for querying accumulated knowledge, evolving vault structure, challenging assumptions, and building institutional memory.

## /arscontexta:ask -- Querying the Claim Graph

`/arscontexta:ask` treats the vault as a knowledge base and answers questions grounded in extracted claims. It does not create or modify anything -- it reads, synthesizes, and responds.

### Basic Queries

Direct questions answered by searching across claims:

```
/arscontexta:ask "What constraints does real-time audio impose on memory allocation?"
```

The system searches claims, finds relevant propositions (e.g., "Audio callbacks must never block or allocate," "Lock-free ring buffers prevent priority inversion"), and synthesizes an answer that cites specific claims.

### Cross-Disciplinary Queries

The most valuable queries span discipline boundaries:

```
/arscontexta:ask "How do Rust's type system guarantees interact with murail's concurrency invariants?"
```

This forces the system to bridge claims from PL design (ownership, lifetimes, type-level guarantees) with claims from concurrent systems (lock-free structures, thread safety, priority inversion). The answer reveals connections that may not be explicit in any single claim.

### Gap-Finding Queries

Ask questions the vault should be able to answer but cannot:

```
/arscontexta:ask "What is the formal relationship between buffer size bounds and worst-case latency?"
```

If the vault lacks sufficient claims to answer well, that reveals a gap -- a topic area that needs more extraction from sources, or an open question worth tracking.

### Decision Support Queries

Frame queries around specific architectural decisions:

```
/arscontexta:ask "What evidence supports or contradicts D14's choice of lock-free ring buffers over channels?"
```

This gathers all relevant claims (supporting evidence, contradictions, related properties) to inform decision review.

### Query Patterns to Avoid

- Vague queries ("Tell me about audio") -- too broad, produces shallow summaries
- Queries about things not in the vault ("What does paper X say?") -- use `/extract` first to get the content into claims
- Queries that assume specific claim existence -- /ask searches by content, not by filename

## /arscontexta:architect -- Evolving Vault Structure

`/arscontexta:architect` examines and adjusts the configuration dimensions that govern vault behavior. See [[configuration]] for the full dimension reference. This section covers strategic usage patterns.

### Diagnosis Mode

When the vault feels wrong -- too many orphans, connections feel shallow, extraction produces poor claims -- architect can diagnose:

```
/arscontexta:architect
```

Review each dimension position against your current experience. If atomic granularity is producing claims that are too fragmented, that is a granularity tension. If flat organization makes navigation difficult with 500+ claims, that is an organization tension.

### Targeted Adjustment

Change one dimension at a time and observe the effects:

```
/arscontexta:architect --set maintenance relaxed
```

After adjustment, run `/arscontexta:reseed` to regenerate infrastructure. Then work a few sessions before adjusting further. Dimension changes are not easily reversible -- they affect extraction behavior, template structure, and connection patterns.

### Coherence Checking

Dimensions interact. Architect checks coherence constraints:

- Atomic granularity + Heavy processing = coherent (automation handles the high file count)
- Atomic granularity + Manual processing = tension (too many files to manage by hand)
- Flat organization + 3-tier navigation = coherent (topic maps provide structure without folders)
- Flat organization + no topic maps = incoherent (no way to navigate)

If you try to set a dimension that creates incoherence, architect will warn you and suggest compensating mechanisms.

### When to Use Architect

- After 50+ claims, when initial assumptions can be tested against reality
- When a workflow feels friction-heavy -- the friction may come from a dimension mismatch
- Before adding a new domain with `/arscontexta:add-domain` -- review whether current dimensions suit the new domain
- During review sessions (see [[workflows]]) as part of stepping back

## /rethink -- Challenging Assumptions

`/rethink` examines a claim, topic map, or structural pattern critically. It asks: is this still true? Is this still useful? Has something changed?

### Rethinking a Claim

```
/rethink "notes/Rust's ownership model maps naturally to audio buffer lifetimes.md"
```

The system:
1. Re-reads the claim and its source
2. Checks for contradicting claims added since the claim was created
3. Examines whether the formal model has evolved past the claim's assumptions
4. Proposes one of: confirm, update, archive-and-replace, or flag-as-contradiction

Example outcome -- a claim about Rust ownership mapping to audio buffers might be updated if new extraction revealed that certain buffer patterns (shared immutable views during render) require `Arc` rather than pure ownership, weakening the "maps naturally" assertion.

### Rethinking a Topic Map

```
/rethink "notes/concurrent-systems-map.md"
```

At the topic map level, rethink examines structural questions:
- Does this map's scope still match a coherent research area?
- Has it grown to cover too many distinct concerns?
- Are there claims that belong here but are missing?
- Should it be split or merged with another map?

### Rethinking a Pattern

You can rethink extraction or processing patterns:

```
/rethink extraction-categories
```

This reviews whether the six extraction categories (claims, decisions, properties, patterns, contradictions, open-questions) still match the kind of material being processed. Maybe a new category is needed (e.g., "benchmark" for empirical performance data).

### Rethink Triggers

Good times to rethink:
- After extracting a source that contradicts existing claims
- When `/verify` flags accuracy concerns
- After a significant change to the formal model or specification
- During review sessions when a claim feels dated
- When `/arscontexta:ask` returns an answer that feels wrong -- the underlying claims may need revision

### Rethink vs Verify

`/verify` checks accuracy against sources: "Is this claim faithful to what the source says?"

`/rethink` challenges the claim's role in the graph: "Is this claim still useful? Has the domain moved past it? Should it be revised or replaced?"

Use `/verify` for maintenance. Use `/rethink` for evolution.

## /remember -- Building Institutional Memory

`/remember` stores observations that do not fit in individual claims but matter for ongoing research. These persist in ops/observations/ and surface when relevant.

### What to Remember

**Cross-cutting concerns:**
```
/remember "D14 (inter-thread communication) and D37 (plugin API boundary) are tightly coupled -- any change to one constrains the other"
```

This is not a single claim -- it is a structural observation about the relationship between two architectural decisions.

**Processing insights:**
```
/remember "Papers from the FAUST team tend to understate the complexity of dynamic graph modification -- extract with skepticism, rate evidence accordingly"
```

This changes how future extraction behaves without being a claim itself.

**Domain conventions:**
```
/remember "In this vault, 'real-time safe' means bounded worst-case execution time with no allocation and no blocking -- not just 'fast enough'"
```

Terminology precision that should inform all future claim writing and connection.

**Methodology observations:**
```
/remember "Extracting from Lean proof files works better when treating each theorem as a property claim and each tactic block as evidence for that property"
```

This improves extraction quality for a specific source type.

### Remember vs Learn

`/remember` stores observations for future recall. It is passive -- the information surfaces when contextually relevant.

`/learn` changes active behavior. When you `/learn` a pattern, the system applies it going forward.

```
/remember "Lean proofs map well to property claims"     -- observation, surfaces when relevant
/learn "Classify Lean theorems as type: property"        -- behavioral change, applied immediately
```

Use `/remember` when you want the system to be aware of something. Use `/learn` when you want the system to do something differently.

### When Observations Surface

Stored observations appear during:
- `/extract` -- processing insights about source types
- `/connect` -- cross-cutting concerns that suggest connections
- `/rethink` -- domain conventions that inform evaluation
- Session start -- relevant observations from previous sessions

The system matches observations to current context. An observation about FAUST papers surfaces during extraction of a FAUST paper, not during extraction of a Rust RFC.

## Combining Meta-Skills

The meta-skills work together in review sessions:

1. `/arscontexta:ask "What are the weakest claims about concurrency guarantees?"` -- Find claims with low evidence or missing connections
2. `/rethink` on the weakest claims -- Challenge them, update or archive
3. `/remember` any structural insights from the rethink process
4. `/arscontexta:architect` if the rethink revealed a dimension mismatch

This cycle -- query, challenge, observe, adjust -- is how the vault evolves from a collection of extracted claims into a living research instrument.

## Related Pages

- [[skills]] -- Full command reference
- [[workflows]] -- How meta-skills fit into session patterns
- [[configuration]] -- Dimension reference for /architect
- [[troubleshooting]] -- When meta-skills reveal structural problems
