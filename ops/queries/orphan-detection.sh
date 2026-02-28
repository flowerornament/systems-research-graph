#!/usr/bin/env bash
# orphan-detection.sh — Find notes with no incoming wiki-links
# Orphan claims are disconnected from the knowledge graph and need
# to be linked from topic maps or related claims.

set -euo pipefail

VAULT_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$VAULT_ROOT"

echo "=== Orphan Detection ==="
echo "Notes with no incoming wiki-links:"
echo ""

ORPHAN_COUNT=0

for note in notes/*.md; do
  [ ! -f "$note" ] && continue
  basename_no_ext=$(basename "$note" .md)

  # Skip topic maps and index (they are navigation, not claims)
  case "$basename_no_ext" in
    index|audio-dsp|language-design|concurrent-systems|rust-ecosystem|ai-ml|competing-systems|formal-methods) continue ;;
  esac

  # Search all .md files for wiki-links to this note (excluding self-references)
  incoming=$(rg -l "\[\[$basename_no_ext\]\]" notes/ ops/ 2>/dev/null | grep -v "$note" | wc -l | tr -d ' ')

  if [ "$incoming" -eq 0 ]; then
    ORPHAN_COUNT=$((ORPHAN_COUNT + 1))
    # Show the claim type for context
    claim_type=$(rg '^type:' "$note" 2>/dev/null | head -1 | sed 's/^type:\s*//')
    echo "  - $basename_no_ext (type: ${claim_type:-unknown})"
  fi
done

echo ""
echo "Total orphans: $ORPHAN_COUNT"
echo "=== Done ==="
