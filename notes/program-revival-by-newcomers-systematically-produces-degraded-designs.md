---
description: Naur's empirical claim that programs maintained by people who did not build the original theory degrade structurally even when bugs are fixed and features added
type: claim
evidence: moderate
source: [[naur-1985-programming-as-theory-building]]
created: 2026-02-28
status: active
---

# program revival by newcomers systematically produces degraded designs

Naur identifies "program revival" as the attempt to re-establish a working program from its text when the original theorists are no longer available. His claim: this systematically fails to reproduce the original design quality.

The newcomers can:
- Fix reported bugs
- Add requested features
- Understand the code's behavior on test cases
- Make the program pass its test suite

What they cannot do without the original theory:
- Determine whether a proposed change is consistent with the program's design intent
- Choose correctly among multiple technically feasible modifications
- Know which parts of the design are load-bearing and which are incidental
- Explain why the program is structured the way it is

The result is characteristic: the program acquires what is now called "accretion" -- changes that are individually correct (fix the reported bug, pass the test) but cumulatively incoherent. The structure fragments. Features are added in the wrong layer. Work-arounds accumulate. After several revivals, the program may have grown substantially in functionality while shrinking in design coherence.

**Naur's prediction about revival effort:** Complete program revival requires more effort than original development, not less. Building the theory from scratch, from only the text evidence, is a harder problem than building the theory from scratch with domain knowledge in hand.

This prediction is in tension with the intuition that "we have the code, so half the work is done." Naur argues the half that is done is the less important half. The theory that would make the code coherent and evolvable is gone.

The claim is directly relevant to [[vibe-coding-produces-unauditable-architectural-debt]]: Lattner's concern about vibe-coded systems is precisely the revival problem -- the developer is structurally a newcomer to the theory of the system the agent built.

**For murail:** long-lived audio engine development requires active theory transfer, not just source control and documentation. Design decision records should capture the rejected alternatives and constraints considered -- not just the chosen approach.

---

Source: [[naur-1985-programming-as-theory-building]]

Relevant Notes:
- [[programming-is-theory-building-not-text-production]] -- establishes why theory is the product, not the text
- [[the-programmers-theory-includes-why-alternatives-were-rejected-not-just-what-was-chosen]] -- what knowledge is lost in revival
- [[vibe-coding-produces-unauditable-architectural-debt]] -- the AI coding case: agent builds code, developer inherits it as a newcomer
- [[software-quality-degrades-in-proportion-to-distance-from-original-theorists]] -- the organizational generalization of this claim
- [[no-documentation-can-substitute-for-the-programmer-held-theory]] -- why documentation alone cannot solve the revival problem

Topics:
- [[developer-experience]]
