#!/usr/bin/env bash
# session-capture.sh — Stop hook
# Saves session metadata to ops/sessions/ for continuity across sessions.
# Only runs when cwd is an Ars Contexta vault with session_capture enabled.

set -euo pipefail

# Vault-awareness check
if [ ! -f ".arscontexta" ]; then
  exit 0
fi

# Check session capture is enabled
if ! grep -q 'session_capture: true' .arscontexta 2>/dev/null; then
  exit 0
fi

# Ensure sessions directory exists
mkdir -p ops/sessions

TIMESTAMP=$(date +%Y-%m-%dT%H-%M-%S)
SESSION_FILE="ops/sessions/session-${TIMESTAMP}.md"

# Gather session stats
CLAIM_COUNT=$(find notes/ -name '*.md' -not -name 'index.md' \
  -not -name 'audio-dsp.md' -not -name 'language-design.md' \
  -not -name 'concurrent-systems.md' -not -name 'rust-ecosystem.md' \
  -not -name 'ai-ml.md' -not -name 'competing-systems.md' \
  -not -name 'formal-methods.md' 2>/dev/null | wc -l | tr -d ' ')

INBOX_COUNT=$(find inbox/ -name '*.md' 2>/dev/null | wc -l | tr -d ' ')
OBS_COUNT=$(find ops/observations/ -name '*.md' 2>/dev/null | wc -l | tr -d ' ')
TENSION_COUNT=$(find ops/tensions/ -name '*.md' 2>/dev/null | wc -l | tr -d ' ')

# Get recent git activity for this session (last hour)
RECENT_COMMITS=""
if git rev-parse --is-inside-work-tree &>/dev/null; then
  RECENT_COMMITS=$(git log --since="1 hour ago" --oneline 2>/dev/null | head -20)
fi

# Write session file
cat > "$SESSION_FILE" << EOF
---
description: Session capture at ${TIMESTAMP}
type: system
created: $(date +%Y-%m-%d)
---

# Session ${TIMESTAMP}

## Vault State
- Claims: ${CLAIM_COUNT}
- Inbox items: ${INBOX_COUNT}
- Pending observations: ${OBS_COUNT}
- Pending tensions: ${TENSION_COUNT}

## Recent Activity
\`\`\`
${RECENT_COMMITS:-No git commits in the last hour.}
\`\`\`
EOF

# Auto-commit the session file if git is enabled
if grep -q 'git: true' .arscontexta 2>/dev/null && git rev-parse --is-inside-work-tree &>/dev/null; then
  git add "$SESSION_FILE" 2>/dev/null || true
  git commit -m "session: capture ${TIMESTAMP}" --quiet 2>/dev/null || true
fi

exit 0
