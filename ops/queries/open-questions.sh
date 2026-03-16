#!/usr/bin/env bash
# open-questions.sh — List all open-question type claims
# Open questions represent research gaps and future work directions.
# These are the frontier of the knowledge graph.

set -euo pipefail

VAULT_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$VAULT_ROOT"

echo "=== Open Questions ==="
echo ""

# Find all claims with type: open-question
{ rg -l '^type:\s*open-question' notes/ 2>/dev/null || true; } | sort | while read -r file; do
  basename_no_ext=$(basename "$file" .md)
  description=$(rg '^description:' "$file" 2>/dev/null | head -1 | sed 's/^description:\s*//')
  topics=$(rg '^topics:' "$file" 2>/dev/null | head -1 | sed 's/^topics:\s*//')
  echo "  - $basename_no_ext"
  [ -n "$description" ] && echo "    $description"
  [ -n "$topics" ] && echo "    areas: $topics"
  echo ""
done

# Count
OQ_COUNT=$({ rg -c '^type:\s*open-question' notes/ 2>/dev/null || true; } | wc -l | tr -d ' ')
TOTAL_CLAIMS=$(find notes/ -name '*.md' -not -name 'index.md' \
  -not -name 'audio-dsp.md' -not -name 'language-design.md' \
  -not -name 'concurrent-systems.md' -not -name 'rust-ecosystem.md' \
  -not -name 'ai-ml.md' -not -name 'competing-systems.md' \
  -not -name 'formal-methods.md' 2>/dev/null | wc -l | tr -d ' ')

echo "Total open questions: $OQ_COUNT / $TOTAL_CLAIMS claims"
echo "=== Done ==="
