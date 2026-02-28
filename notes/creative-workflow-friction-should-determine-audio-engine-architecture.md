---
description: McCartney's architectural decisions are each traceable to a specific friction point in creative practice -- the architectural insight is that removing felt friction is more productive than optimizing for computer science elegance
type: claim
evidence: strong
source: [[mccartney-ideas-2026-02-15]]
created: 2026-02-28
status: active
---

# creative workflow friction should determine audio engine architecture

McCartney states explicitly and repeatedly that his goal is not to fix SuperCollider's technical flaws. It's to approach "my ideal way of working... I want to be able to have something that's just really interactive in a sort of intimate way where I'm just manipulating the audio as directly as possible." He is not building a product; he is searching for the right *feel*.

Each of his architectural innovations is traceable to a specific creative friction that a previous approach created:

- **Immutability**: because GC bugs and thread locks disrupted the flow of building
- **Universal auto-mapping**: because writing explicit loops disrupted the flow of expressing musical ideas
- **Compile-and-swap**: because 45-second compile waits disrupted the flow of exploration
- **Lossless history**: because losing previous attempts disrupted the flow of iterative composition
- **Immediate-mode UI**: because synchronizing code editor and widgets disrupted the flow of seeing and hearing the same structure

The common thread is not computer science elegance. It is friction removal in the creative process. Each innovation exists because some previous approach produced a gap between the composer's intention and its sonic realization.

The design method implicit here: test every architectural decision against "does this create friction in the creative loop?" rather than "is this the most elegant type theory?" The spec's compile-and-swap model is already motivated by this test. The principle is generalizable to every Murail design decision.

**Implication for Murail:** Murail has a different audience (embeddable library for other tools, not a personal instrument). But the underlying insight transfers: creative workflow requirements should be first-class inputs to architectural decisions. When two technically valid approaches diverge, the question is not "which is more formally correct?" but "which creates less friction for the musician writing the code?"

This is consistent with [[programmer-time-dominates-computation-cost-in-the-post-scarcity-era]] -- when the binding constraint is programmer (or composer) expressiveness, friction in the creative process is the primary cost to optimize. Contrasts with [[type-systems-have-not-empirically-reduced-defect-rates]] in that both challenge the primacy of formal correctness over practical usability. Related to [[debuggability-is-more-valuable-than-correctness-by-construction]] -- both argue that the lived experience of using a tool matters more than its theoretical properties.
