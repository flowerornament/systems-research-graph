---
description: Naur's organizational corollary that systems maintained by teams with less overlap with the original theorists exhibit lower design coherence, even when functionally adequate
type: claim
evidence: moderate
source: [[naur-1985-programming-as-theory-building]]
created: 2026-02-28
status: active
---

# software quality degrades in proportion to distance from original theorists

Naur's argument about organizational consequences of the theory-building view: the quality of a program's design is a function of the degree to which the original theorists are still involved in its maintenance. As that overlap decreases -- through attrition, team change, or acquisition -- design quality degrades even when the program continues to function.

This is not primarily about bugs. The program may pass all tests. The degradation is in design coherence: the program's response to new requirements becomes less elegant, less principled, and more likely to produce accretion. New features are added in the wrong layer. Work-arounds replace principled changes. The system acquires complexity without acquiring capability.

**Naur's "distance" is not just time.** A team member who was present at the original design but disengaged from the codebase for two years is closer to the theory than a new hire who has been working in the code for six months. The theory degrades with non-engagement as well as with departure.

**The "fresh eyes" objection:** Some argue that new team members improve designs by bringing fresh perspective. Naur acknowledges this: outside critique can be valuable. But critique and maintenance are different activities. Critique operates on the design as proposed and can improve it before theory is built into code. Maintenance without theory produces degradation because every modification requires a judgment the maintainer is not equipped to make.

**For murail:** In a small-team, long-horizon project, the theory-building view argues strongly for documentation of design rationale (not just decisions but why alternatives were rejected), active onboarding that builds theory rather than transferring documentation, and structuring work so that the theorists remain engaged with the parts of the system they built.

Extends [[program-revival-by-newcomers-systematically-produces-degraded-designs]] from a single revival event to a continuous organizational process.

---

Source: [[naur-1985-programming-as-theory-building]]

Relevant Notes:
- [[programming-is-theory-building-not-text-production]] -- establishes the foundational claim
- [[program-revival-by-newcomers-systematically-produces-degraded-designs]] -- the point-in-time version of this organizational claim
- [[the-programmers-theory-includes-why-alternatives-were-rejected-not-just-what-was-chosen]] -- what is being lost as teams evolve
- [[vibe-coding-produces-unauditable-architectural-debt]] -- a contemporary instance: AI-generated code where no human holds the theory

Topics:
- [[developer-experience]]
