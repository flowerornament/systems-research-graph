---
_schema:
  entity_type: "topic-map"
  applies_to: "notes/*-map.md"
  required:
    - description
    - type
  optional:
    - created
  enums:
    type:
      - moc
  constraints:
    description:
      max_length: 200
      format: "What this topic area covers and why it matters"

description: ""
type: moc
created: YYYY-MM-DD
---

# {topic area name}

{Brief description of what this research area covers and its relationship to the broader domain.}

## Key Claims
- [[claim title]] -- context

## Open Questions
- [[open question title]] -- context

---

Topics:
- [[index]]
