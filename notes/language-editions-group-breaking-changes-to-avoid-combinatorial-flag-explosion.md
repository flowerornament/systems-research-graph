---
description: Grouping breaking changes into named edition releases rather than individual feature flags prevents the combinatorial configuration space that makes per-user customization unmanageable
type: claim
evidence: moderate
source: "[[hadron-supercollider-symposium-2025-keynote]]"
created: 2026-02-28
status: active
---

# language editions group breaking changes to avoid combinatorial flag explosion

Rust's edition model (2015, 2018, 2021, 2024) provides the template: breaking changes are collected and released together under an edition name, rather than as individual feature flags. Code from different editions can coexist in the same project, with edition declared at the file or crate level. Old edition code continues to work unchanged; new edition code gets access to breaking improvements.

The Hadron developer proposes this model for SuperCollider evolution. Without it, the alternative is a proliferation of individual feature flags — inline variable declarations, new scope rules, type hints, etc. — each independently toggleable. With 20 proposed improvements and binary on/off per flag, the configuration space exceeds a million combinations, any of which might interact differently with user code. Testing, documentation, and community reasoning all degrade rapidly.

Editions solve this by making the configuration granularity coarse: one choice per code unit (this file is "SuperCollider 2026 edition") with all breaking changes in that edition bundled. Inter-edition code intermixing is allowed, but each file is identified by a single edition, reducing configuration options from exponential to linear in the number of editions.

The Hiram's Law implication: once an edition ships, even its bugs are commitments. The Hadron developer explicitly connects this to the hardware chip example from the audience Q&A — the SID chip's IDC offsets were fixed in a later revision of the chip, but programs that played samples using the offset behavior broke. The chip shipped an "edition" that changed observable behavior and broke existing use.

Editions are a governance mechanism as much as a technical one: [[language-feature-adoption-requires-governance-structures-not-just-technical-readiness]]. The edition boundary is where community consensus gets crystallized into a versioned commitment.
