---
description: Routing LLM-produced syntax errors to a fast cheap side-model and rewriting the main chat history to show success prevents error patterns from propagating via next-token prediction
type: claim
evidence: strong
source: "[[keynote-elixirs-ai-future-chris-mccord-elixirconf-us-2025]]"
created: 2026-02-28
---

# rescue-model-forking-corrects-syntax-errors-without-poisoning-main-context

When the primary agent produces a syntax error (detected by running `mix format` after each file write), the naive approach is to tell the agent about the error and ask it to fix it. This is unreliable: the model sees the syntax error in its history and, conditioned on that pattern, reproduces the same error when correcting -- observed empirically by McCord with near-100% frequency.

The rescue model technique:
1. Detect the syntax error via linter (auto-lint every file tool output)
2. Fork to a separate, fast, cheap model (e.g., Gemini Flash) with a new chat
3. Give the side-model: the error message, the bad file content, and a request to fix it
4. When the side-model writes the corrected file, substitute the corrected content into the main thread's history at the position where the error appeared
5. The main agent now has a history where it wrote correct code the first time; it continues normally

Two benefits:
- **No context pollution**: the error is not in the main thread's history, so next-token prediction is not conditioned on the error pattern
- **No wasted context**: the error + correction exchange doesn't consume main context window

## Foundation

This technique is only coherent because [[an-agent-is-just-a-simulated-chat-in-a-loop]]: the "memory" is just entries in a list that can be rewritten. There is no ground truth to maintain fidelity with.

## Generalization

The pattern generalizes: any undesirable model output can be intercepted before being committed to the main history, corrected externally, and injected as though the primary model produced the correct output. The constraint is that the primary model's subsequent behavior must be consistent with the injected "history" it never actually produced.

---

Topics:
- [[index]]
