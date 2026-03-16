#!/usr/bin/env bash
# validate-note.sh — PostToolUse(Write|Edit) hook
# Validates that written notes in notes/ have proper YAML frontmatter.
# Only runs when cwd is an Ars Contexta vault.

set -euo pipefail

# Vault-awareness check
if [ ! -f ".arscontexta" ]; then
  exit 0
fi

# Get the file path from the hook input (passed via stdin as JSON)
INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/"file_path"[[:space:]]*:[[:space:]]*"//;s/"$//')

# Only validate files in notes/
if [[ ! "$FILE_PATH" =~ ^(.*/)?notes/ ]]; then
  exit 0
fi

# Only validate .md files
if [[ ! "$FILE_PATH" =~ \.md$ ]]; then
  exit 0
fi

# Check if file exists
if [ ! -f "$FILE_PATH" ]; then
  exit 0
fi

ERRORS=""

# Check for YAML frontmatter
if ! head -1 "$FILE_PATH" | grep -q '^---$'; then
  ERRORS="${ERRORS}\n- Missing YAML frontmatter (file must start with ---)"
  echo "VALIDATION WARNING: $FILE_PATH"
  echo -e "$ERRORS"
  exit 0
fi

# Extract frontmatter
FRONTMATTER=$(sed -n '2,/^---$/{ /^---$/d; p; }' "$FILE_PATH")

# Check required fields: description, type, topics
if ! echo "$FRONTMATTER" | grep -q '^description:'; then
  ERRORS="${ERRORS}\n- Missing required field: description"
fi

if ! echo "$FRONTMATTER" | grep -q '^type:'; then
  ERRORS="${ERRORS}\n- Missing required field: type"
fi

if ! echo "$FRONTMATTER" | grep -q '^topics:'; then
  ERRORS="${ERRORS}\n- Missing required field: topics"
fi

# Warn if description restates the title
if [ -z "$ERRORS" ]; then
  DESCRIPTION=$(echo "$FRONTMATTER" | grep '^description:' | sed 's/^description:[[:space:]]*//' | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9 ]//g')
  TITLE=$(grep '^# ' "$FILE_PATH" | head -1 | sed 's/^# //' | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9 ]//g')
  if [ -n "$DESCRIPTION" ] && [ -n "$TITLE" ] && [ "$DESCRIPTION" = "$TITLE" ]; then
    ERRORS="${ERRORS}\n- Warning: description restates the title. Add context beyond the title."
  fi
fi

if [ -n "$ERRORS" ]; then
  echo "VALIDATION WARNING: $FILE_PATH"
  echo -e "$ERRORS"
fi

exit 0
