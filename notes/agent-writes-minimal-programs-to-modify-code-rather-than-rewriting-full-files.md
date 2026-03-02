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

McCord's approach in the Phoenix New agent: have the agent write a Lua script that parses the file and makes targeted modifications. Lua is chosen because it is simple enough that frontier models produce reliable code -- this aligns with [[llm-friendly-language-design-reduces-to-readability-not-llm-specific-features]], where Lattner argues the same point from the language design side: the properties that make code readable to humans are the properties that make it producible by LLMs. Lua's simplicity (unlike Perl, which confused Elixir's own delimiter syntax), embeddability, and expressiveness for pattern-matching edits make it a natural fit.

At ~80% success rate (as of the talk), the Lua script runs directly and patches the file. On failure, the same script is passed to a fast model as a "specification of intent" and the full file is rewritten from it -- the poor-man's version of Cursor's fine-tuned model approach. This fallback shares a structural similarity with [[rescue-model-forking-corrects-syntax-errors-without-poisoning-main-context]]: both techniques route failure to a secondary model rather than letting the primary model see and repeat its own errors.

## Why this matters

The model is writing code to write code -- and adding self-annotating comments to its own Lua scripts without being told to. This points toward a general direction: agents increasingly generate minimal programs that specify their intent, rather than directly manipulating targets. A program is a minimal specification of what the computer should do; an LLM-authored micro-program is a minimal specification of what the LLM wanted to do.

This stands in direct opposition to [[vibe-coding-produces-unauditable-architectural-debt]]: where vibe coding produces opaque text that no one understands, the Lua micro-program is an *auditable* specification of intent. A developer can read the Lua script and verify what the agent intended to change -- the specification is transparent even if the developer did not write it. In Naur's framing from [[programming-is-theory-building-not-text-production]], the micro-program externalizes the agent's "theory" of what change is needed, making it inspectable in a way that raw file rewrites are not.

## Relationship to macro systems

In Elixir, this becomes "code that writes code that writes code" if macros are involved -- a pattern McCord notes as especially natural to Lisp-descended languages like Elixir. This is a lightweight variant of the metaprogramming unification that [[unifying-program-and-metaprogram-eliminates-two-world-complexity-of-templates]] describes: instead of a language where program and metaprogram share the same language, the agent selects a *different* simple language (Lua) specifically for the meta-level task. The two-world complexity remains, but the meta-world is intentionally kept trivial.

## Cross-domain pattern

The specification-vs-execution separation here echoes [[faust-separates-dsp-specification-from-host-architecture-enabling-multi-target-retargeting]] at a different scale: FAUST separates DSP specification from host architecture so one algorithm targets many platforms; the Lua micro-program separates change specification from file manipulation so one intent can be applied by different execution strategies (direct Lua execution or fast-model rewrite). Both demonstrate that separating *what* from *how* enables fallback and retargeting.

---

Topics:
- [[herald]]
- [[developer-experience]]
