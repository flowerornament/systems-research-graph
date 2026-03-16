---
description: Audio buffers are use-exactly-once resources in the processing loop; linear types enforce write-before-read and no-double-write as compile-time guarantees rather than runtime assertions
type: claim
evidence: moderate
source: [[pl-research-landscape-2026-02-27]]
created: 2026-03-01
status: active
---

# linear types can make audio buffer management errors type errors rather than runtime bugs

Audio buffers in the block-processing loop follow a strict usage pattern: each buffer is written by exactly one node (its producer), then read by exactly one or more nodes (its consumers), then released at block end. Violating this -- writing a buffer twice, reading before writing, or reading after release -- produces audio corruption: cross-talk between nodes, stale sample data, or undefined memory contents. These are runtime bugs with audio-artifact symptoms that can be difficult to diagnose.

Linear types (Li et al. OOPSLA 2022 demonstrate at real system scale) guarantee that a resource is used exactly once. If audio buffers are linearly typed, the scheduler must statically prove that each buffer is written before read and not written again until the next block. A schedule that reads a buffer before its producer runs becomes a type error, caught at schedule-generation time. A schedule that accidentally aliases two output buffers (causing both producers to write to the same memory) becomes a type error.

The Li et al. paper is significant because it demonstrates linear types at the scale of verified storage systems and network stacks -- not toy examples. The key result is that linear types *compose*: if module A uses a buffer linearly and passes it to module B which also uses it linearly, the composed system maintains linearity. This compositionality is critical for Murail's graph architecture, where buffer passing spans multiple nodes and scheduling phases.

The mapping to Murail's buffer management (D50) is direct. The slotmap (D51) already manages buffer ownership; linear types would formalize that ownership as a type discipline. Buffer allocation assigns each node a typed linear buffer; schedule generation must prove that each node's linear buffer is consumed (read) before the buffer is repurposed for the next block. This is Rust's ownership and borrowing system strengthened at the audio-scheduling-semantics level.

Rust's ownership already provides some of these guarantees (no data races, no use-after-free), but not all. Two mutable references to the same buffer are prevented by Rust's borrow checker in normal code, but scheduler-generated code that computes buffer addresses at runtime might not benefit from these static checks. Explicit linear types at the scheduling level would close this gap.

Connects to [[all-murail-program-state-fits-in-a-single-pre-allocated-contiguous-region]] -- linear typing of buffers is compatible with the pre-allocated state region model; the linear type tracks logical ownership within the region. See [[unsafe-encapsulation-is-the-foundational-soundness-obligation-for-rust-library-authors]] for the formal basis of Rust's unsafe-code guarantees that linear types would complement. Also connects to [[effects-as-capabilities-can-encode-rt-safety-requirements-in-the-composition-language-type-system]] -- both apply type-system techniques to enforce correctness properties of RT-thread code.

---

Topics:
- [[concurrent-systems]]
- [[formal-methods]]
- [[audio-dsp]]
