---
description: The visual cortex processes spatial and relational structure in parallel before conscious recognition; text notation forces serial parsing of structure that could be seen at a glance
type: claim
evidence: strong
source: [[stop-writing-dead-programs-jack-rusher-2022]]
created: 2026-02-28
status: active
---

# visual representation exposes structure that text notation obscures

Rusher's demonstration: the same numerical data presented as a teletype-compatible table evokes no pattern; plotted as XY coordinates, the visual cortex identifies a dinosaur shape before conscious recognition completes. The visual cortex is GPU-accelerated parallel processing; the verbal text-reading faculty is a serial CPU.

The graphic design principle he cites (from Kandinsky): visual channels -- point, line, plane, organization, asymmetry -- each carry information directly to the brain without parsing overhead. Representing program structure visually can exploit these channels.

The text-is-good argument (Always Bet on Text, Graydon Hoare) is not wrong about text's advantages, but its advocates mistake "80-column fixed-width monospace" for "text." Rich typographic text (Newton's Principia, Wolfgang Weingart's typography) has entirely different expressive capabilities. The limitation is the teletype-compatible subset of text, not text itself.

Specific structural problems with text for programs: graphs with cycles (Krebs cycle, dependency graphs) cannot be represented naturally in tree-structured text. Programs with cyclic data flows are common; the notation forces them into an unnatural linear order.

For [[language-design]] in murail: audio signal graphs are intrinsically cyclic (feedback paths, bus routing). Text notation for murail's graph DSL will always struggle with cyclic topology. Visual editors or hybrid structure editors (like the Leaf Anderson pattern-matching diagrams Rusher shows) may be a better fit for authoring complex audio graphs, even if text remains the serialization format.

Connects to [[interactive-programming-eliminates-the-compile-run-cycle]] (visual inspection is part of the live programming experience) and [[competing-systems]] (SuperCollider uses a graph editor in SC-IDE alongside its text notation).
