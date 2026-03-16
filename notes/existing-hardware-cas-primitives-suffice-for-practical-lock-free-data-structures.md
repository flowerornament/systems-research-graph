---
description: Fraser demonstrates that CAS alone, without DCAS or strong LL/SC, is sufficient to implement practical lock-free skip lists, BSTs, and red-black trees with competitive performance
type: claim
evidence: strong
source: "[[fraser-2004-practical-lock-freedom]]"
created: 2026-02-28
status: active
---

# existing hardware CAS primitives suffice for practical lock-free data structures

The prevailing assumption before Fraser's dissertation was that non-trivial lock-free data structures require hardware support for DCAS (double-word compare-and-swap) or a "strong" nestable form of LL/SC — neither of which is available on any modern processor architecture. Fraser refutes this by building MCAS (multi-word CAS) as a software abstraction on top of ordinary CAS, then building a suite of search structures on MCAS and FSTM. Performance results on a 106-processor Sun Fire server show these structures equal or surpass sophisticated lock-based alternatives.

This finding is significant because it breaks the impasse where processor designers declined to add DCAS without proof of demand, and programmers declined to use lock-free techniques without DCAS. The required primitives were available all along.

**Implications for murail:** The lock-free communication channels in murail's NRT→RT path can be built from CAS-capable atomic operations in Rust's `std::sync::atomic` without requiring exotic hardware. This eliminates a common objection to lock-free audio engine design.

Contrast with the widespread belief that "existing lock-free algorithms are complex, slow and impractical" — Fraser shows this is a property of prior *implementations*, not an inherent property of lock-free design.

See [[lock-freedom-guarantees-system-wide-progress-but-not-per-operation-progress]] for the formal progress guarantee these structures provide.
