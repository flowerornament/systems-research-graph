---
_schema:
  entity_type: "source"
  applies_to: "inbox/*.md"
  required:
    - description
    - source_type
  optional:
    - url
    - author
    - date_accessed
    - status
  enums:
    source_type:
      - paper
      - talk
      - documentation
      - code-analysis
      - transcript
      - conversation
    status:
      - raw
      - extracting
      - extracted

description: ""
source_type: paper
url: ""
author: ""
date_accessed: YYYY-MM-DD
status: raw
---

# {source title}

{Raw content, quotes, or notes from the source. This will be processed by /extract into atomic claims in notes/.}
