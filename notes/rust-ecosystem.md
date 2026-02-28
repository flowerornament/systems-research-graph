---
description: Crate survey, nightly features, type-driven design, and unsafe boundaries
type: moc
created: 2026-02-27
---

# rust-ecosystem

Rust ecosystem research for murail. Covers crate selection and verification, nightly feature dependencies, type-driven design patterns, unsafe code boundaries, and build system considerations.

## Key Sub-Areas
- Verified crate stack (rtrb, arc-swap, bumpalo, slotmap, cpal, criterion)
- Nightly features (portable_simd, allocator_api, pinning)
- Type-driven design (newtype wrappers, zero-cost abstractions, trait objects)
- Unsafe boundaries (loom testing, miri verification, assert_no_alloc)
- Workspace architecture (9-crate tiered dependency DAG)

## Claims

### Library Design Constraints
- [[library-languages-must-not-bundle-a-mandatory-runtime]] -- using a Go library from C requires importing ~2MB Go runtime; Rust's zero-runtime model is the correct choice for murail as an embeddable library
- [[rust-lacks-interactive-programming-despite-suitable-foundations]] -- Rust's multi-stage compilation could support REPL-style exploration but shipped with batch tooling; affects murail graph compiler DX

## Open Questions
- Are there existing Rust-native interactive exploration tools (evcxr, etc.) that could be adapted for murail graph exploration, or does this require custom tooling?

---

Topics:
- [[index]]
