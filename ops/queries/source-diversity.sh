#!/usr/bin/env bash
# source-diversity.sh — Count claims per source, find over-reliance
# Flags sources that account for a disproportionate share of claims,
# indicating potential bias or under-exploration of other references.

set -euo pipefail

VAULT_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$VAULT_ROOT"

echo "=== Source Diversity ==="
echo "Claims per source (sorted by count):"
echo ""

# Extract all source values from claim frontmatter
{ rg '^source:\s*(.+)' notes/ -o --no-filename 2>/dev/null || true; } \
  | sed 's/^source:\s*//' \
  | sed 's/^"//;s/"$//' \
  | sort \
  | uniq -c \
  | sort -rn \
  | while read -r count source; do
    if [ "$count" -ge 5 ]; then
      echo "  [$count] $source  ** HIGH CONCENTRATION"
    else
      echo "  [$count] $source"
    fi
  done

echo ""

# Count claims with no source
NO_SOURCE=$({ rg -l '^source:\s*""' notes/ 2>/dev/null || true; } | wc -l | tr -d ' ')
NO_SOURCE_FIELD=$(find notes/ -name '*.md' -not -name 'index.md' \
  -not -name 'audio-dsp.md' -not -name 'language-design.md' \
  -not -name 'concurrent-systems.md' -not -name 'rust-ecosystem.md' \
  -not -name 'ai-ml.md' -not -name 'competing-systems.md' \
  -not -name 'formal-methods.md' 2>/dev/null \
  | while read -r f; do
    if ! rg -q '^source:' "$f" 2>/dev/null; then
      echo "$f"
    fi
  done | wc -l | tr -d ' ')

echo "Claims with empty source: $NO_SOURCE"
echo "Claims missing source field: $NO_SOURCE_FIELD"
echo "=== Done ==="
