---
description: McLean identifies manipulation feedback (code<>programmer), performance feedback (output<>programmer), and social feedback (audience<>programmer) as the three feedback loops constituting live coding liveness
type: claim
evidence: moderate
source: [[mclean-2014-making-programming-languages-to-dance-to]]
created: 2026-03-01
status: active
---

# live coding performance requires three distinct feedback loops that together define being in time

McLean argues that liveness in programming is not binary but a function of *which* feedback loops are active and how fast they cycle. In a live coded music performance, three distinct loops operate simultaneously:

1. **Manipulation feedback** (Nash & Blackwell 2011): the loop between programmer and code -- making a change and reading it in context alongside syntactical errors or warnings. This is what most interactive programming research targets.

2. **Performance feedback**: the loop between programmer and program output -- in live music coding, this is sound carried in the air. The feedback cycle of software development is shared with the feedback cycle of musical development. This is qualitatively different from the debugging loop: the programmer is evaluating aesthetics and musical effect, not correctness.

3. **Social feedback**: the loop between programmer and audience/co-performers. This is foregrounded at algorave events where the audience is dancing; the programmer is simultaneously shaping and reacting to physical responses in the room.

Together, these three loops connect the programmer with the "live, passing moment." The claim is that *all three must be active* to produce the state McLean describes as "being in time" -- where every change counts not just for what is typed but when. A programming environment that only supports manipulation feedback (e.g., a REPL or type checker) misses the performance and social loops that give live music coding its specific character.

This taxonomy is consequential for composition language design: the performance feedback loop means latency between code change and audible effect must be in the range of musical time (milliseconds to a beat), not engineering time. The social feedback loop means the code must be visible and its effects legible to audiences (projected screens are standard). These constraints are different from those of general interactive programming -- they rule out solutions that are fast but opaque.

Connects to [[compile-and-swap-preserves-audio-continuity-during-recompilation]] -- the "no silence gap" requirement is a direct consequence of the performance feedback loop: silence breaks the loop between programmer and sound. Extends [[interactive-programming-eliminates-the-compile-run-cycle]] -- that claim covers manipulation feedback only; this claim adds the two loops that live music coding uniquely activates. The performance feedback loop is what [[quantizing-live-code-swaps-to-musical-temporal-boundaries-makes-changes-deterministic-and-musically-predictable]] is trying to improve: by making swap timing musically predictable, it gives the programmer reliable performance feedback at musically meaningful boundaries.

Differs from ChucK's focus ([[live-assimilation-of-shreds-into-a-running-vm-enables-coding-composing-and-performing-as-a-single-activity]]): ChucK's "coding, composing, performing as one activity" is the same observation but stated at the activity level; McLean's three-loop model provides the mechanism-level explanation of *why* this unity is possible and what can break it.

For murail: the composition language layer is the site of manipulation feedback. The audio engine is the site of performance feedback. Social feedback is a deployment concern (projected interfaces, audience legibility). Each layer must be designed to minimize its contribution to latency in its respective feedback loop.

---

Topics:
- [[language-design]]
- [[developer-experience]]
- [[competing-systems]]
