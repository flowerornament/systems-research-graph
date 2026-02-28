---
_schema:
  entity_type: "observation"
  applies_to: "ops/observations/*.md"
  required:
    - description
    - category
    - observed
    - status
  enums:
    category:
      - methodology
      - process
      - friction
      - surprise
      - quality
    status:
      - pending
      - promoted
      - implemented
      - archived

description: ""
category: friction
observed: YYYY-MM-DD
status: pending
---

# {what was observed — prose sentence}

{Context: what happened, what was expected, what actually occurred.}
