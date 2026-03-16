---
description: Skill SKILL.md files in .claude/skills/ were removed after initial setup; skills run from CLAUDE.md directives and manual/ pages, not from bundled skill files
type: methodology
created: 2026-02-28
source: session-mining
---

# Skills run from context, not from .claude/skills/ files

The initial vault generation created 16 skill files in `.claude/skills/` (connect, extract, graph, learn, next, pipeline, ralph, refactor, remember, rethink, reweave, seed, stats, tasks, validate, verify -- total 8,354 lines). These were removed in a bulk operation early in the first session arc (commit `915c370`, 2026-02-28T00:16).

The reasoning: skill behavior is specified in CLAUDE.md and manual/ pages that are already loaded in context. The `.claude/skills/` files duplicate this content and inflate the repository without providing a runtime benefit -- Claude Code loads skills when invoked, but the methodology in CLAUDE.md provides the behavioral specification that matters. Maintaining duplicate specifications creates a drift risk where the skill file and CLAUDE.md diverge.

The current model: `/arscontexta:X` commands are invoked by name and executed according to the methodology in CLAUDE.md plus the relevant manual/ section. If a skill needs detailed reference material, it lives in manual/ (e.g., `manual/workflows.md` for pipeline sequencing, `manual/skills.md` for command reference). Skills do not need their own files to be functional.

If `/arscontexta:setup` or `/arscontexta:reseed` regenerates skill files, they can be removed. The git status shows them as deleted (D prefix) because they were removed from the working tree after being committed by the generator.
