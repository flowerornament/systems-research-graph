---
description: Block-based DSP with sub-block accuracy splits the render block into pre-trigger and post-trigger lambdas, enabling mid-block state transitions without abandoning block processing
type: pattern
evidence: strong
source: [[channel-agnosticism-metasounds-aaron-mcleran-adc]]
created: 2026-02-28
status: active
---

# sample-accurate triggering in block-based audio requires splitting render blocks into sub-block execution lambdas

MetaSounds is block-based for performance -- audio is processed in chunks rather than sample-by-sample. But sample-accurate triggering (events that can occur at any sample within a block, not just at block boundaries) is a first-class feature. These two requirements are in tension.

The solution is a render-block splitting pattern. McLeran shows it in the AD envelope node implementation:

```
trigger.execute_within_block(
    |pre_samples| { render_state_before_trigger(pre_samples) },
    |post_samples| { render_state_after_trigger(post_samples) }
)
```

`execute_within_block` accepts two lambdas: one for the samples before the trigger fires within the block, one for the samples from the trigger to the block end (or the next trigger). The state machine transitions happen at the trigger boundary -- in the middle of the block.

Edge cases this creates:
- Non-modulo-4 sample counts when using SIMD (the pre-trigger segment may be 17 samples, not a multiple of 4). MetaSounds includes a built-in SIMD library that handles non-aligned batches.
- Multiple triggers within a single block: the pattern generalizes by chaining -- each trigger subdivides its segment further.

The value of sample accuracy in audio: artifacts from block-boundary quantization are audible. A trigger that fires 100 samples "late" because it waited for the next block boundary produces a detectable timing error. In granular synthesis (McLeran's demo), sample-accurate grain spawning is what enables tight rhythmic precision.

For murail's [[audio-dsp]] design: this is a known pattern in audio DSP that murail's UGen trait system will need to accommodate. UGens that respond to triggers need either (a) block-boundary rounding with audible tradeoffs, or (b) block-splitting with the sub-lambda pattern or equivalent.
