---
description: Separating room acoustics as a learned impulse response module rather than folding reverb into the generative model lets you bypass that module to get dereverberated audio for free
type: claim
evidence: strong
source: [[ddsp-2020]]
created: 2026-02-28
status: active
---

# explicit reverb factorization enables blind dereverberation as a modular architectural side effect

Neural synthesis models typically model room acoustics implicitly: the network learns to generate audio that sounds like it was recorded in a particular room, but there is no explicit representation of the room's impulse response. As a consequence, dereverberation -- removing the room acoustics from the output -- requires a separate, dedicated algorithm applied to the synthesized audio.

DDSP instead factorizes the generative model explicitly:

```
synthesized_audio = dry_audio * room_impulse_response
```

The room impulse response (IR) is a learned parameter -- a 4-second (64,000 sample) vector for the solo violin dataset. The dry audio comes from the additive + filtered noise synthesizers. These two are combined via frequency-domain convolution (O(n log n), necessary because realistic IRs can be 10-100k samples long -- intractable to convolve directly via matrix multiplication).

**The architectural side effect:** Because the reverb is a separate, bypassable module, dereverberation is free: run the model but skip the convolution step. No additional training, no post-processing algorithm. The model has learned a dry-to-reverberant factorization as part of its generative architecture.

**Acoustic transfer:** The same IR can be applied to unrelated audio (e.g., a singing voice) to impose the acoustic environment of the training set on new sources. Room acoustics become a transferable, inspectable parameter rather than an implicit statistical artifact.

**Limitation:** The quality of dereverberation and transfer is bounded by the quality of the underlying generative model. For DDSP's solo violin model, which is high quality, the results are compelling.

**Murail implication:** This is a strong argument for making reverb an explicit, first-class node in murail's audio graph rather than relying on users to wire reverb manually. A `ReverbModule` UGen that holds a learnable or loadable impulse response, combined with frequency-domain convolution, would provide this factorization at the graph level. Bypassing the node gives dry audio; the IR parameter can be loaded, saved, and transferred independently. This is the same modularity principle as [[channel-format-metadata-encapsulation-enables-audio-graph-reuse-across-channel-configurations]]: encapsulate an orthogonal concern into a separable module.

The O(n log n) frequency-domain convolution note is directly applicable: room-scale IRs (up to 4 seconds at 44.1kHz = ~176,400 samples) are intractable with direct convolution but routine via FFT. Murail's audio graph should support FFT convolution as a first-class primitive for both reverb and learned filtering applications.

---

Topics:
- [[ai-ml]]
- [[audio-dsp]]
