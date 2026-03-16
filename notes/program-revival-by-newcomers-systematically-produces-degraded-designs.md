---
description: When a program is modified by programmers who did not build the original theory, modifications tend to be incoherent with the design even when they are technically correct
type: claim
evidence: strong
source: [[naur-1985-programming-as-theory-building]]
created: 2026-02-28
status: active
---

# program revival by newcomers systematically produces degraded designs

Naur's empirical claim: when the programmers who hold the theory of a program leave and a new team takes over, modifications degrade the design even when the modifications are functionally correct. This is not because the newcomers are less skilled. It is because they do not hold the theory.

The mechanism: without the theory, the newcomers cannot distinguish modifications that fit the design from modifications that technically work but violate the underlying structure. They optimize locally -- fixing the bug, adding the feature -- without knowing what global invariants they are disturbing. Over time, the codebase accumulates locally-correct but globally-incoherent changes. The design degrades.

Naur calls this "program revival" -- the act of taking over an existing program and resuming its development. He observes that revival is qualitatively different from continuation by the original team. It is not simply that the newcomers need more time to get up to speed; they cannot fully recover what was lost even with extensive reading.

The practical consequence: program maintenance has a hidden social cost. When teams turn over, the theoretical investment walks out the door. "Maintaining" a program through multiple revivals is not the same program through time -- it is a series of programs that share a text but diverge in their implicit theories.

For murail: this is a direct argument for writing session handoff notes, capturing design rationale in ops/, and maintaining this knowledge graph. The sessions are a sequence of "revivals" by the same agent with no persistent memory. Every mechanism in the CLAUDE.md system is a response to Naur's revival problem in the context of stateless AI agents.

Connects to [[software-quality-degrades-in-proportion-to-distance-from-original-theorists]], which generalizes this degradation pattern across organizational time. Connects to [[vibe-coding-produces-unauditable-architectural-debt]]: vibe coding produces code without any programmer ever having held the theory, so every developer who inherits that code is already in the revival condition at step zero.
