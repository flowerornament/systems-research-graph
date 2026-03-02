#!/usr/bin/env bash
# cross-discipline.sh — Find claims that appear in multiple topic maps
# Claims linked to 2+ topic maps are cross-disciplinary bridges — the most
# valuable notes in the vault.

set -euo pipefail

VAULT_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$VAULT_ROOT"

TOPIC_MAPS="audio-dsp language-design concurrent-systems rust-ecosystem ai-ml competing-systems formal-methods"

echo "=== Cross-Discipline Claims ==="
echo "Claims appearing in 2+ topic maps:"
echo ""

for note in notes/*.md; do
  [ ! -f "$note" ] && continue
  basename_no_ext=$(basename "$note" .md)

  # Skip topic maps and index
  case "$basename_no_ext" in
    index|audio-dsp|language-design|concurrent-systems|rust-ecosystem|ai-ml|competing-systems|formal-methods) continue ;;
  esac

  # Count how many topic maps reference this claim
  count=0
  maps=""
  for tm in $TOPIC_MAPS; do
    if grep -q "\[\[$basename_no_ext\]\]" "notes/$tm.md" 2>/dev/null; then
      count=$((count + 1))
      maps="$maps $tm"
    fi
  done

  if [ "$count" -ge 2 ]; then
    echo "  [$count maps] $basename_no_ext —$maps"
  fi
done

echo ""
echo "=== Done ==="
