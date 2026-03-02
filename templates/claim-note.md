---
_schema:
  entity_type: "claim"
  applies_to: "notes/*.md"
  required:
    - description
    - type
    - topics
  optional:
    - evidence
    - source
    - created
  enums:
    type:
      - claim
      - decision
      - property
      - pattern
      - contradiction
      - open-question
    evidence:
      - strong
      - moderate
      - weak
      - internal-only
  constraints:
    description:
      max_length: 200
      format: "One sentence adding context beyond the title"
    topics:
      format: "Array of wiki links to topic maps"

description: ""
type: claim
evidence: moderate
source: ""
topics: []
created: YYYY-MM-DD
---

# {prose-as-title — a complete sentence expressing one claim}

{Content: your argument, evidence, reasoning. Transform the source material — your framing, your connection to the domain. Never verbatim.}

---

Relevant Notes:
- [[related claim]] -- relationship context

Topics:
- [[topic-map]]
