---
description: First session guide -- creating claims, making connections, establishing rhythm
type: manual
generated_from: "arscontexta-0.8.0"
---

# Getting Started

This guide walks through your first session: capturing a source, extracting claims, connecting them, and establishing a working rhythm.

## Your First Claim

A claim is an atomic proposition -- one idea, expressed as a complete sentence in the title, with supporting reasoning in the body. Claims live in notes/.

Here is what a claim looks like:

```yaml
---
description: Lock-free ring buffers eliminate priority inversion in audio callbacks
type: claim
evidence: strong
source: "rt-audio-patterns.pdf"
topics:
  - "[[audio-dsp-map]]"
  - "[[concurrent-systems-map]]"
created: 2026-02-27
---

# Lock-free ring buffers prevent priority inversion between audio and control threads

In real-time audio systems, the audio callback runs at interrupt priority.
Any blocking synchronization (mutexes, channels with backpressure) risks
priority inversion -- a low-priority control thread holding a lock that the
audio thread needs. Lock-free ring buffers sidestep this entirely: the audio
thread never blocks, it only fails to read if the buffer is empty.

This directly informs murail's D14 (inter-thread communication) -- the graph
engine must guarantee that the audio render path never contends on a lock
held by the parameter update path.

---

Relevant Notes:
- [[Audio callbacks must never block or allocate]] -- the broader constraint this serves
- [[Bounded SPSC queues are sufficient for parameter updates]] -- specific implementation

Topics:
- [[audio-dsp-map]]
- [[concurrent-systems-map]]
```

Key properties:
- **Title is a sentence.** Not "ring buffers" but "Lock-free ring buffers prevent priority inversion between audio and control threads."
- **Body is your reasoning.** Transform the source material. Connect it to the domain. Never paste verbatim.
- **Evidence rating.** STRONG, MODERATE, WEAK, or INTERNAL-ONLY.
- **Topics link to topic maps.** Every claim belongs to at least one topic map.

## How Connections Work

Connections are wiki links between claims. They come in two flavors:

**Explicit connections** -- you write them in the "Relevant Notes" section at the bottom of each claim. Add context after the link:

```
- [[Sample-accurate scheduling requires monotonic clock guarantees]] -- upstream constraint
- [[Rust's ownership model maps naturally to audio buffer lifetimes]] -- PL design parallel
```

**Implicit connections** -- discovered by `/arscontexta:connect`. When you run `/arscontexta:connect` on a claim, the system searches for claims that share concepts, contradict findings, or bridge disciplines. A DSP claim about buffer sizing might connect to a formal methods claim about bounded model checking -- because both deal with finite resource bounds.

Cross-disciplinary connections are where the vault earns its keep. The formal model for murail sits at the intersection of audio DSP, PL design, concurrency, and formal methods. A claim from one discipline often constrains or illuminates decisions in another.

## Capturing a Source

Sources land in inbox/ before extraction. Drop raw material there using the source-capture template:

```yaml
---
description: "Faust audio DSP language documentation on signal processing semantics"
source_type: documentation
url: "https://faust.grame.fr/doc/manual/"
author: "GRAME"
date_accessed: 2026-02-27
status: raw
---

# Faust Signal Processing Semantics

{Raw content, quotes, key passages you want to extract claims from.}
```

Then run `/arscontexta:extract` on the source. The system reads the source, identifies atomic claims, and creates individual claim files in notes/. Each gets proper frontmatter, evidence ratings, and topic map links.

## Session Rhythm

A productive session follows this pattern:

1. **Orient.** Review `/arscontexta:stats` to see vault health -- total claims, orphan count, inbox depth. Check `/arscontexta:next` for suggested work.

2. **Process.** If inbox has raw sources, run `/arscontexta:extract` to break them into claims. This is the highest-leverage activity when the inbox is full.

3. **Connect.** Run `/arscontexta:connect` on recent claims to discover cross-disciplinary links. This is where the vault produces insight -- a concurrency claim connecting to a type system decision you hadn't considered.

4. **Verify.** Run `/arscontexta:verify` periodically to check claim accuracy and evidence ratings. `/arscontexta:validate` checks structural integrity -- frontmatter schema, required fields, dangling links.

5. **Maintain.** If `/arscontexta:stats` shows growing orphan count or stale claims, run `/arscontexta:reweave` to integrate orphans into the topic map structure.

Do not try to do everything in one session. Extract before connecting. Connect before reweaving. The pipeline has a natural order -- see [[workflows]] for the full processing pipeline.

## What to Do Next

- [[skills]] -- Learn what each command does
- [[workflows]] -- Understand the full processing pipeline
- [[configuration]] -- Tune the system for your workflow
- [[troubleshooting]] -- When things go sideways
