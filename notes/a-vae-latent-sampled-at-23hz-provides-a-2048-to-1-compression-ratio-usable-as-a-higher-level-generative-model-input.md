---
description: RAVE's 2048x downsampling compresses 48kHz to a 23Hz latent; a WaveNet-inspired model needs only 9M params and 10 layers for a 3-second receptive field over this latent, enabling a two-tier generative architecture
type: claim
evidence: strong
source: [[rave-2021]]
created: 2026-02-28
status: active
---

# a VAE latent sampled at 23Hz provides a 2048-to-1 compression ratio usable as a higher-level generative model input

The RAVE encoder's 2048x temporal downsampling factor maps 48kHz audio to a latent sequence sampled at ~23Hz. This is not a limitation -- it is a feature that enables a two-tier generative architecture: RAVE handles audio-rate synthesis; a separate high-level model (WaveNet-inspired autoregressive model in the paper) generates the latent trajectory.

The efficiency gain is dramatic: at 23Hz, a 3-second context window requires only 69 latent frames. An autoregressive model with a 3-second receptive field over the latent needs 10 WaveNet layers and 9M parameters -- versus hundreds of layers and billions of parameters to achieve equivalent receptive field at audio rate. The combined system (latent model + RAVE decoder) still achieves 5x faster than real-time synthesis.

This architecture maps cleanly to a two-level murail node graph: a slow "composition" rate node (23Hz) generates latent trajectories, and a fast "synthesis" rate node (audio rate, using the RAVE decoder) converts them to waveforms. The latent-rate node can use any generative strategy -- autoregressive sampling, interpolation, rule-based sequencing -- without that strategy needing to run at audio rate.

The compression is lossy (2048:1 is aggressive) but perceptually near-lossless for the tested datasets. The key tradeoff: higher compression means more musical-level control; lower compression means higher reconstruction fidelity. This is the same fidelity tradeoff as [[the-fidelity-parameter-trades-latent-compactness-against-reconstruction-accuracy-without-retraining]], applied at the architecture level rather than the inference level.

---

Topics:
- [[ai-ml]]
- [[audio-dsp]]
