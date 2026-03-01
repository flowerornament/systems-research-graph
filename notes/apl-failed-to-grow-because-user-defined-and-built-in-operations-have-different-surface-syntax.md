---
description: APL's growth was stunted because built-in operations use glyphs while user-defined operations use identifiers, creating an unbridgeable seam that locked evolution to a handful of source-code holders
type: claim
evidence: strong
source: [[steele-1998-growing-a-language]]
created: 2026-03-01
status: active
---

# APL failed to grow because user-defined and built-in operations have different surface syntax

Steele's post-mortem on APL: a language designed by one smart person (Iverson) with a fatal structural flaw. In APL, built-in operations are named by glyphs (strange symbols); user-defined operations are named by ordinary words. A user who wants their extension to "feel like APL" must be a "real hacker" and do "a ton of work" to get glyph-like appearance. This surface asymmetry is not cosmetic -- it is the reason APL did not grow.

The consequence: if a user writes something useful and the APL language maintainers agree it should become part of the language, the user's code cannot be adopted unchanged. The maintainers must create a new glyph, and existing user code must be rewritten because the user-form and the built-in form are syntactically distinct. This creates a two-stage process (user code → glyph promotion) that imposes cost on both maintainers and users every time a concept is elevated.

APL grew, but slowly, driven by the few programmers who had access to the source code. The ecosystem did not benefit from the distributed innovation that Lisp enjoyed because the seam between user-space and language-space was too high a barrier.

This is the concrete negative case for [[user-defined-extensions-must-be-syntactically-indistinguishable-from-built-in-primitives]]. APL demonstrates what happens when that criterion is violated: the language grows only at the speed of its maintainer team.

Connects to [[economy-of-notation-requires-compositional-grammar-not-a-large-primitive-vocabulary]] (Iverson 1980): Iverson himself built a language where economy came from a compact glyph set, but this economy was purchased at the cost of user extensibility. The two values are in tension: economy from a fixed glyph vocabulary requires that vocabulary to be closed (or at least costly to extend).

Note the irony: Iverson's paper is a masterpiece of language design theory that accurately describes the cognitive power of well-chosen notation. But the design choice that embodies that theory -- fixed, cryptic glyphs -- is the design choice that killed APL's community.

For murail: if the composition language uses a fixed set of special syntax forms for built-in operations (e.g., special graph-connection syntax) that user code cannot replicate, murail will face the APL outcome. The design must ensure user-defined signal processors can use the same compositional syntax as built-in processors.
