---
description: Agents are chat completions called recursively; tool calls are structured text the program dispatches; no hidden complexity beyond chat history management
type: claim
evidence: strong
source: "[[keynote-elixirs-ai-future-chris-mccord-elixirconf-us-2025]]"
created: 2026-02-28
---

# an-agent-is-just-a-simulated-chat-in-a-loop

Every agent framework -- regardless of branding -- is simulating a conversation. The program calls chat completions with a running history, the model returns text, and when that text matches a tool-call format the program dispatches to a function and appends the result as the next "user" message. There is no additional mechanism: the state is the chat history, the "memory" is the accumulated messages, and the "reasoning" is next-token prediction over the full history on each call.

McCord's formulation: "you can roleplay this already" in ChatGPT by manually pasting tool results back as user messages -- and that is exactly what the agent loop automates.

## Implications

The key consequence is that every apparently complex agent behavior is reducible to chat history management:
- **Context window pressure** -- history grows until it must be compacted or truncated
- **Memory injection** -- inserting hidden messages at any position changes what the model "remembers"
- **Error correction** -- rewriting a message makes the model behave as though a different past occurred (see [[rescue-model-forking-corrects-syntax-errors-without-poisoning-main-context]])
- **Commitment priming** -- inserting a message where the agent commits to rules improves compliance (see [[pre-seeding-chat-history-with-agent-promises-reduces-rule-compliance-failures]])

## Relationship to OTP

The GenServer that manages this chat history loop is straightforward. The hard part -- routing new requests to the right process, keeping state alive, cleaning up when done -- is what OTP already solves. See [[otp-solves-the-hard-parts-of-agent-architecture-that-other-ecosystems-are-still-building]].

---

Topics:
- [[index]]
