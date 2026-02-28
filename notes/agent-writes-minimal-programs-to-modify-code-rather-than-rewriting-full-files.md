---
description: LLM agents can produce executable programs (e.g., Lua scripts) that perform targeted file edits, serving as minimal specifications of changes with full-file rewrite as fallback
type: claim
evidence: moderate
source: "[[keynote-elixirs-ai-future-chris-mccord-elixirconf-us-2025]]"
created: 2026-02-28
---

# agent-writes-minimal-programs-to-modify-code-rather-than-rewriting-full-files

LLMs struggle with partial file edits using standard diff formats (unified diff ranges are hallucinated, off-by-one, or simply wrong). Common solutions:
- **Full file rewrite**: reliable but expensive for large files (many tokens)
- **Cursor approach**: frontier model writes a spec of changes; a fine-tuned fast model applies it to rewrite the full file

McCord's approach in the Phoenix New agent: have the agent write a Lua script that parses the file and makes targeted modifications. Lua is chosen because it's:
- Simple enough that frontier models produce reliable code (unlike Perl, which confused Elixir's own delimiter syntax)
- Embeddable and fast to execute
- Rich enough to express "find this pattern and replace with that" logic

At ~80% success rate (as of the talk), the Lua script runs directly and patches the file. On failure, the same script is passed to a fast model as a "specification of intent" and the full file is rewritten from it -- the poor-man's version of Cursor's fine-tuned model approach.

## Why this matters

The model is writing code to write code -- and adding self-annotating comments to its own Lua scripts without being told to. This points toward a general direction: agents increasingly generate minimal programs that specify their intent, rather than directly manipulating targets. A program is a minimal specification of what the computer should do; an LLM-authored micro-program is a minimal specification of what the LLM wanted to do.

## Relationship to macro systems

In Elixir, this becomes "code that writes code that writes code" if macros are involved -- a pattern McCord notes as especially natural to Lisp-descended languages like Elixir.

---

Topics:
- [[index]]
