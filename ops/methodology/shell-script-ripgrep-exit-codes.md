---
description: Ripgrep exits 1 on no matches; all rg invocations in scripts using set -euo pipefail must be guarded with || true
type: methodology
created: 2026-02-28
source: session-mining
---

# Guard rg invocations with || true in strict shell scripts

The query scripts in `ops/queries/` run under `set -euo pipefail`. Ripgrep returns exit code 1 when it finds no matches -- this is normal behavior, not an error. Under `set -e`, an rg invocation that finds no matches kills the script immediately when piped to another command.

The fix is consistent: append `|| true` to any `rg` invocation in scripts. For example:

```bash
rg '^type: decision' notes/ || true
rg '\[\[' --glob '*.md' | wc -l || true
```

This was discovered and fixed in the first session arc (2026-02-27, commit `7a9f4e0`) when the orphan-detection, low-evidence, open-questions, and source-diversity scripts all failed silently on clean vaults. The scripts appeared to work but exited prematurely when any search returned zero results.

Apply this guard to any new query scripts added to `ops/queries/`. Also applies to any shell hooks that invoke rg as part of a pipeline under `set -e`.
