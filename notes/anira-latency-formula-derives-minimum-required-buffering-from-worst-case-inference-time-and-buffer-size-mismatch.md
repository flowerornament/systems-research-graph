---
description: Two formal equations compute minimum latency for continuous signal flow from worst-case inference time, host buffer size, and optional semaphore wait fraction
type: property
evidence: strong
source: [[anira-2024]]
created: 2026-02-28
status: active
---

# Anira latency formula derives minimum required buffering from worst-case inference time and buffer size mismatch

Anira's latency guarantee is not a tunable parameter but a derived lower bound. The minimum added latency required to maintain continuous signal flow is determined by three components: buffer size mismatch handling, worst-case inference time, and any internal model latency.

**Equation 1 (baseline):**

```
L_total = H_adapt + ceil(I_max / H_host) * H_host + M_int
```

Where:
- `H_adapt` = adaptation latency from Letz algorithm (zero when model input size equals host buffer size)
- `I_max` = worst-case inference time in samples (measured empirically post-warmup)
- `H_host` = host buffer size in samples
- `M_int` = internal latency of the model (e.g., causal receptive field of a TCN)

The ceil() term rounds I_max up to the next integer multiple of H_host, because inference results are only requested once per audio callback. This means the second term is always at least H_host — added latency is never zero when inference is involved.

**Equation 2 (with semaphore wait):**

```
L_total = H_adapt + ceil((I_max - H_host * W) / H_host) * H_host + M_int
```

Where `W` is a proportional wait fraction (0.0 to 0.95). Setting W > 0 allows the audio callback to block briefly for inference results via semaphore, reducing effective latency. At W = 0.95 with a fast enough inference engine, added latency can reach zero. The cost is minor real-time violations from the semaphore syscall — acceptable if the host platform tolerates them. See [[static-thread-pool-decouples-neural-inference-from-the-audio-callback-to-ensure-real-time-safety]] for the threading architecture that enables this.

**The mismatch problem.** When model input size differs from host buffer size, the Letz algorithm computes the minimum H_adapt by simulating mod(nA, B) until the fill pattern repeats. This is deterministic but can be nonzero. The benchmark study aligned model input size with host buffer size to isolate the buffer-size variable; the mismatch case remains unstudied. See [[host-buffer-to-model-input-mismatch-and-parallel-inference-remain-unbenchmarked-in-real-time-audio-contexts]].

**I_max must be measured, not derived.** Because inference engines have non-deterministic runtimes, the worst-case inference time cannot be computed analytically — it requires empirical benchmarking. Anira's built-in benchmarking infrastructure addresses this. The measurement should run post-warmup (see [[warm-up-inferences-before-the-audio-callback-stabilize-inference-engine-runtimes]]) to capture stabilized runtimes rather than cold-start outliers.

The ceil() relationship here is structurally analogous to the sub-block splitting problem in [[sample-accurate-triggering-in-block-based-audio-requires-splitting-render-blocks-into-sub-block-execution-lambdas]]: both arise when a fixed processing unit (inference call or render block) must be subdivided by an event boundary, and rounding is unavoidable. Anira's solution is to make the rounding cost explicit and computable rather than hidden.

---

Source: [[anira-2024]]

Relevant Notes:
- [[static-thread-pool-decouples-neural-inference-from-the-audio-callback-to-ensure-real-time-safety]] — the threading architecture that this formula assumes
- [[warm-up-inferences-before-the-audio-callback-stabilize-inference-engine-runtimes]] — I_max should be measured post-warmup
- [[host-buffer-to-model-input-mismatch-and-parallel-inference-remain-unbenchmarked-in-real-time-audio-contexts]] — mismatch case (H_adapt > 0) is an open research gap
- [[larger-model-input-sizes-improve-per-sample-inference-performance-making-latency-tolerance-a-throughput-lever]] — H_adapt increases when model input size exceeds host buffer size
- [[sample-accurate-triggering-in-block-based-audio-requires-splitting-render-blocks-into-sub-block-execution-lambdas]] — structurally parallel problem: rounding at processing unit boundaries

Topics:
- [[ai-ml]]
- [[audio-dsp]]
