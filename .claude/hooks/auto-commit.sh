#!/usr/bin/env bash
# auto-commit.sh — PostToolUse(Write|Edit) hook (async)
# Auto-commits changes with a descriptive message.
# Only runs when cwd is an Ars Contexta vault with git enabled.

set -euo pipefail

# Vault-awareness check
if [ ! -f ".arscontexta" ]; then
  exit 0
fi

# Check git is enabled in vault config
if ! grep -q 'git: true' .arscontexta 2>/dev/null; then
  exit 0
fi

# Check we're in a git repo
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
  exit 0
fi

# Get the file path from hook input
INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/"file_path"[[:space:]]*:[[:space:]]*"//;s/"$//')

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# Determine a descriptive commit message based on file location
RELATIVE_PATH="${FILE_PATH#$(pwd)/}"
BASENAME=$(basename "$FILE_PATH" .md)

case "$RELATIVE_PATH" in
  notes/*)
    MSG="claim: update $BASENAME"
    ;;
  inbox/*)
    MSG="inbox: add $BASENAME"
    ;;
  ops/*)
    MSG="ops: update $BASENAME"
    ;;
  templates/*)
    MSG="template: update $BASENAME"
    ;;
  *)
    MSG="vault: update $RELATIVE_PATH"
    ;;
esac

# Stage and commit
git add "$FILE_PATH" 2>/dev/null || true
git diff --cached --quiet 2>/dev/null && exit 0
git commit -m "$MSG" --quiet 2>/dev/null || true

exit 0
