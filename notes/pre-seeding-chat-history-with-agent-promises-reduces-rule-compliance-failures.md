---
description: Injecting fabricated history where the agent commits to following rules before task start significantly reduces deviation, because the model sees itself as having made commitments
type: claim
evidence: moderate
source: "[[keynote-elixirs-ai-future-chris-mccord-elixirconf-us-2025]]"
created: 2026-02-28
---

# pre-seeding-chat-history-with-agent-promises-reduces-rule-compliance-failures

Because [[an-agent-is-just-a-simulated-chat-in-a-loop]], the chat history before the actual user task begins is manipulable. McCord's Phoenix New agent pre-populates the history with:
1. A message listing rules the agent tends to forget (e.g., "always wrap LiveView templates in the app layout", "never use list index access")
2. A fabricated agent response where it commits to those rules: "I will always do X, I promise"
3. A fabricated user acknowledgment
4. Then the actual user task

Compared to system-prompt-only approaches (where rule reminders often get ignored ~10% of the time for hard-to-follow rules), this approach reduces violations significantly. The mechanism is consistent with next-token prediction: the model has "already committed" in context and subsequent tokens are conditioned on that self-representation.

## Technique origin

McCord reports arriving at this empirically: a plain reminder message didn't work, but if the model itself appeared to have promised compliance in prior turn history, it worked. This is a discovered exploitation of how autoregressive models condition on prior context -- the model's own words in a prior turn are weighted evidence about its behavior.

## Limitations

This is a fragile technique. It manipulates model behavior in a non-transparent way. It may degrade as models improve their meta-reasoning. And it constitutes a form of prompt injection if applied to adversarial contexts. Within controlled agent systems (where the developer owns the full history) it is a legitimate reliability technique.

## Relationship to memory rewriting

A stronger form: [[rescue-model-forking-corrects-syntax-errors-without-poisoning-main-context]] also manipulates chat history to change what the model "remembers" -- in that case, replacing an error with a correct result.

---

Topics:
- [[index]]
