---
id: anira-2024-extract
batch: anira-2024
type: extract
status: pending
source: /Users/morgan/code/murail/.design/references/papers/anira-2024.pdf
original_path: /Users/morgan/code/murail/.design/references/papers/anira-2024.pdf
archive_folder: ops/queue/archive/2026-02-28-anira-2024
created: 2026-02-28T00:00:00Z
next_claim_start: 140
---

# Extract claims from anira-2024

## Source
Original: /Users/morgan/code/murail/.design/references/papers/anira-2024.pdf
Archived: /Users/morgan/code/murail/.design/references/papers/anira-2024.pdf
Size: 9 pages (PDF, 1.2 MB)
Content type: Academic research paper (arXiv:2506.12665v1, cs.SD, Jun 2025)

## Summary
Ackva and Schulz (TU Berlin) present anira, a C++ library for running neural network inference safely inside real-time audio callbacks. The core problem: inference engines (ONNX Runtime, LibTorch, TensorFlow Lite) all violate real-time principles (malloc, mutex, sleep) and therefore cannot run directly on the audio thread. Anira decouples inference to a static thread pool, handles buffer-size mismatches, manages latency, and provides built-in benchmarking. The paper includes a benchmarking study across three neural network architectures (CNN, RNN, hybrid), three systems, and eight buffer sizes, analyzed with linear mixed effects models.

## Scope
Full document. Extract:
- Architectural decisions: how the thread pool, InferenceManager, SessionElement, and ThreadSafeStructs solve the real-time inference problem
- Design patterns: static thread pool (oversubscription prevention), semaphore vs atomic data sharing, warm-up inference, latency formula
- Properties: formal latency calculation (equations 1 and 2), real-time safety guarantee conditions
- Empirical findings: ONNX fastest for stateless, LibTorch fastest for stateful, warm-up phases required, larger buffer sizes improve per-sample performance
- Contradictions: conflicts with prior claims (e.g., Stefani 2022 claimed engines are RT-safe after initial inference; anira paper disagrees)
- Open questions: host buffer / model input size mismatch not benchmarked, parallel inference not benchmarked

## Acceptance Criteria
- Extract claims, architectural decisions, formal properties, patterns, contradictions, and open questions
- Duplicate check against notes/ during extraction
- Near-duplicates create enrichment tasks (do not skip)
- Each output type gets appropriate handling per derivation-manifest.md extraction categories

## Execution Notes

Extracted 2026-02-28. Full PDF text read via pdftotext (9 pages). No duplicate claims found in notes/. No enrichments needed — all extracted insights are new to the vault. Source reference file created at notes/anira-2024.md.

## Outputs

**Claims extracted: 9** (IDs 140-148)

| ID | Claim | Type |
|----|-------|------|
| 140 | inference engines violate real-time principles on every inference not just initial ones | contradiction |
| 141 | static thread pool decouples neural inference from the audio callback to ensure real-time safety | decision |
| 142 | anira latency formula derives minimum required buffering from worst-case inference time and buffer size mismatch | property |
| 143 | onnx runtime is fastest for stateless neural models while libtorch is fastest for stateful models | claim |
| 144 | warm-up inferences before the audio callback stabilize inference engine runtimes | pattern |
| 145 | larger model input sizes improve per-sample inference performance making latency tolerance a throughput lever | claim |
| 146 | onnx runtime does not support stateful lstm operations restricting it to stateless neural architectures | property |
| 147 | host buffer to model input mismatch and parallel inference remain unbenchmarked in real-time audio contexts | open-question |
| 148 | tensorflow lite outperforms libtorch for small cnn models but libtorch becomes faster as model size grows | claim |

Task files: ops/queue/archive/2026-02-28-anira-2024/anira-2024-{140..148}.md
