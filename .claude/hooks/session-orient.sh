#!/usr/bin/env bash
# session-orient.sh — SessionStart hook
# Injects vault structure, loads goals, checks maintenance triggers and reminders.
# Only runs when cwd is an Ars Contexta vault.

set -euo pipefail

# Vault-awareness check
if [ ! -f ".arscontexta" ]; then
  exit 0
fi

VAULT_ROOT="$(pwd)"

echo "=== Ars Contexta Session Orient ==="
echo ""

# --- Vault structure overview ---
echo "## Vault Structure"
echo '```'
find "$VAULT_ROOT" -maxdepth 2 -type d \
  -not -path '*/.git/*' \
  -not -path '*/.git' \
  -not -path '*/node_modules/*' \
  | sed "s|$VAULT_ROOT/||" | sort
echo '```'
echo ""

# --- Load goals ---
if [ -f "ops/goals.md" ]; then
  echo "## Active Goals"
  sed -n '/^## Active Threads/,/^## /{ /^## Active Threads/d; /^## /d; p; }' ops/goals.md
  echo ""
fi

# --- Claim count ---
CLAIM_COUNT=$(find notes/ -name '*.md' -not -name 'index.md' \
  -not -name 'audio-dsp.md' -not -name 'language-design.md' \
  -not -name 'concurrent-systems.md' -not -name 'rust-ecosystem.md' \
  -not -name 'ai-ml.md' -not -name 'competing-systems.md' \
  -not -name 'formal-methods.md' 2>/dev/null | wc -l | tr -d ' ')
echo "## Stats"
echo "- Claims: $CLAIM_COUNT"
echo "- Inbox items: $(find inbox/ -name '*.md' 2>/dev/null | wc -l | tr -d ' ')"
echo ""

# --- Maintenance triggers ---
echo "## Maintenance Check"

# Orphan detection (notes with no incoming wiki-links)
ORPHAN_THRESHOLD=10
ORPHAN_COUNT=0
for note in notes/*.md; do
  [ ! -f "$note" ] && continue
  basename_no_ext=$(basename "$note" .md)
  # Skip topic maps and index
  case "$basename_no_ext" in
    index|audio-dsp|language-design|concurrent-systems|rust-ecosystem|ai-ml|competing-systems|formal-methods) continue ;;
  esac
  # Check if any other file links to this note
  incoming=$(grep -rl "\[\[$basename_no_ext\]\]" notes/ 2>/dev/null | grep -v "$note" | wc -l | tr -d ' ')
  if [ "$incoming" -eq 0 ]; then
    ORPHAN_COUNT=$((ORPHAN_COUNT + 1))
  fi
done
if [ "$ORPHAN_COUNT" -gt "$ORPHAN_THRESHOLD" ]; then
  echo "- WARNING: $ORPHAN_COUNT orphan claims (threshold: $ORPHAN_THRESHOLD). Run /reweave."
else
  echo "- Orphans: $ORPHAN_COUNT (threshold: $ORPHAN_THRESHOLD)"
fi

# Pending observations
OBS_COUNT=$(find ops/observations/ -name '*.md' 2>/dev/null | wc -l | tr -d ' ')
OBS_THRESHOLD=5
if [ "$OBS_COUNT" -gt "$OBS_THRESHOLD" ]; then
  echo "- WARNING: $OBS_COUNT pending observations (threshold: $OBS_THRESHOLD). Run /connect."
else
  echo "- Pending observations: $OBS_COUNT (threshold: $OBS_THRESHOLD)"
fi

# Pending tensions
TENSION_COUNT=$(find ops/tensions/ -name '*.md' 2>/dev/null | wc -l | tr -d ' ')
TENSION_THRESHOLD=3
if [ "$TENSION_COUNT" -gt "$TENSION_THRESHOLD" ]; then
  echo "- WARNING: $TENSION_COUNT pending tensions (threshold: $TENSION_THRESHOLD). Run /rethink."
else
  echo "- Pending tensions: $TENSION_COUNT (threshold: $TENSION_THRESHOLD)"
fi

echo ""

# --- Reminders ---
if [ -f "ops/reminders.md" ]; then
  TODAY=$(date +%Y-%m-%d)
  REMINDERS=$(grep -E "^\| *[0-9]{4}-" ops/reminders.md 2>/dev/null | while IFS='|' read -r _ due reminder status _; do
    due=$(echo "$due" | xargs)
    status=$(echo "$status" | xargs)
    if [ -n "$due" ] && [ "$due" \<= "$TODAY" ] && [ "$status" != "done" ]; then
      echo "  - [$due] $reminder"
    fi
  done)
  if [ -n "$REMINDERS" ]; then
    echo "## Due Reminders"
    echo "$REMINDERS"
    echo ""
  fi
fi

echo "=== Ready ==="
