#!/usr/bin/env bash
# low-evidence.sh — Find claims with weak or internal-only evidence
# These claims need external validation or stronger sourcing.

set -euo pipefail

VAULT_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$VAULT_ROOT"

echo "=== Low Evidence Claims ==="
echo ""

echo "## evidence: weak"
{ rg -l '^evidence:\s*(weak)' notes/ 2>/dev/null || true; } | while read -r file; do
  basename_no_ext=$(basename "$file" .md)
  source=$(rg '^source:' "$file" 2>/dev/null | head -1 | sed 's/^source:\s*//')
  echo "  - $basename_no_ext (source: ${source:-none})"
done

echo ""
echo "## evidence: internal-only"
{ rg -l '^evidence:\s*(internal-only)' notes/ 2>/dev/null || true; } | while read -r file; do
  basename_no_ext=$(basename "$file" .md)
  source=$(rg '^source:' "$file" 2>/dev/null | head -1 | sed 's/^source:\s*//')
  echo "  - $basename_no_ext (source: ${source:-none})"
done

echo ""

# Summary count
WEAK_COUNT=$({ rg -c '^evidence:\s*weak' notes/ 2>/dev/null || true; } | wc -l | tr -d ' ')
INTERNAL_COUNT=$({ rg -c '^evidence:\s*internal-only' notes/ 2>/dev/null || true; } | wc -l | tr -d ' ')
TOTAL_CLAIMS=$(find notes/ -name '*.md' -not -name 'index.md' \
  -not -name 'audio-dsp.md' -not -name 'language-design.md' \
  -not -name 'concurrent-systems.md' -not -name 'rust-ecosystem.md' \
  -not -name 'ai-ml.md' -not -name 'competing-systems.md' \
  -not -name 'formal-methods.md' 2>/dev/null | wc -l | tr -d ' ')

echo "Summary: $WEAK_COUNT weak + $INTERNAL_COUNT internal-only / $TOTAL_CLAIMS total claims"
echo "=== Done ==="
