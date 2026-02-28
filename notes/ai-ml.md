---
description: Neural UGens, differentiable audio, DDSP, and generative composition
type: moc
created: 2026-02-27
---

# ai-ml

AI and machine learning integration research for murail. Covers neural audio synthesis, differentiable signal processing, real-time inference constraints, and how the formal model unifies DSP and ML under one formalism.

## Key Sub-Areas
- Neural UGens (DDSP, RAVE, real-time inference in audio graphs)
- Differentiable audio (gradient flow through signal chains, training loops)
- The DSP-ML unification (murail formal model: "Named Sparse Recurrence System over Rated Tensors")
- Python bindings and offline evaluation pipelines
- ANIRA and real-time neural audio inference

## Claims

### Real-Time Neural Audio Feasibility
- [[autoregressive-synthesis-prevents-real-time-audio-generation-at-usable-sample-rates]] -- autoregressive sampling requires one forward pass per audio sample; WaveNet peaks at 57Hz on CPU, making any RT integration dependent on pre-buffering or architectural redesign
- [[multiband-decomposition-reduces-temporal-dimensionality-enabling-real-time-neural-audio-at-48khz]] -- PQMF 16-band decomposition reduces 48kHz sequences to 3kHz sub-bands, delivering 25x synthesis speedup enabling 985kHz CPU throughput; the DSP technique, not the ML model, is what makes 48kHz RT viable
- [[parallel-non-autoregressive-audio-decoders-match-autoregressive-quality-when-combined-with-adversarial-training]] -- RAVE (17.6M, parallel, adversarial) outperforms NSynth (64.7M, autoregressive) on MOS, showing quality and parallelism are not architecturally in tension
- [[inference-engines-violate-real-time-principles-on-every-inference-not-just-initial-ones]] -- RadSan testing across LibTorch, TFLite, and ONNX Runtime shows persistent malloc/mutex/sleep violations on every inference call, not just startup; no current engine can run in an audio callback without architectural separation
- [[static-thread-pool-decouples-neural-inference-from-the-audio-callback-to-ensure-real-time-safety]] -- anira's architectural response: a shared static ThreadPool handles all inference work so the callback only submits and collects, verified by RadSan as zero-violation; the static (not per-instance) design solves thread oversubscription when multiple neural effects run concurrently
- [[anira-latency-formula-derives-minimum-required-buffering-from-worst-case-inference-time-and-buffer-size-mismatch]] -- the derived lower bound for added latency: L_total = H_adapt + ceil(I_max / H_host) * H_host + M_int; makes explicit that added latency is never zero when inference is involved, and quantifies why autoregressive models are RT-impossible while parallel models are not

### Inference Engine Selection (ANIRA Benchmarks)
- [[onnx-runtime-is-fastest-for-stateless-neural-models-while-libtorch-is-fastest-for-stateful-models]] -- linear mixed effects analysis across CNN and hybrid models: ONNX Runtime consistently wins for stateless inference; LibTorch outperforms TFLite for stateful LSTM on average; engine choice cannot be made at library selection time without knowing model state requirements
- [[onnx-runtime-does-not-support-stateful-lstm-operations-restricting-it-to-stateless-neural-architectures]] -- ONNX Runtime's stateless design makes it unsuitable for guitar amp emulation and LSTM-based effects; narrows ONNX's applicability but explains why it can be fastest: no state management overhead
- [[tensorflow-lite-outperforms-libtorch-for-small-cnn-models-but-libtorch-becomes-faster-as-model-size-grows]] -- model-size nuance to the stateful comparison: TFLite wins for small CNN while LibTorch wins for larger models; the LibTorch vs TFLite decision also requires knowing approximate parameter count
- [[warm-up-inferences-before-the-audio-callback-stabilize-inference-engine-runtimes]] -- LibTorch shows the most pronounced warm-up effect; all performance rankings assume post-warmup runtimes; InferenceConfig.warm_up is the practical lever to achieve stabilized behavior before audio start
- [[larger-model-input-sizes-improve-per-sample-inference-performance-making-latency-tolerance-a-throughput-lever]] -- larger model input windows improve per-sample efficiency across all engines; latency tolerance and engine selection are two independent axes for reducing I_max in the anira formula
- [[host-buffer-to-model-input-mismatch-and-parallel-inference-remain-unbenchmarked-in-real-time-audio-contexts]] -- two gaps in the anira study: buffer size mismatch performance cost and parallel ThreadPool throughput; both are consequential for murail multi-effect scenarios

### VAE Training Architecture
- [[two-stage-vae-training-separates-representation-quality-from-synthesis-quality]] -- Stage 1: spectral-loss VAE for representation; Stage 2: frozen encoder + adversarial decoder fine-tuning for perceptual quality; the separation is architecturally necessary, not merely convenient
- [[freezing-the-encoder-during-adversarial-fine-tuning-is-necessary-to-preserve-a-compact-latent-representation]] -- training the encoder against feature matching loss inflates estimated latent dimensionality from 24 to 60+; the frozen encoder is the mechanism that keeps the latent space analysable

### Latent Space Analysis and Control
- [[post-training-svd-on-mode-means-identifies-effective-latent-dimensionality-of-a-vae]] -- SVD on the mode-mean matrix (not sampled Z) isolates input-correlated dimensions from prior-collapsed ones; enables post-hoc dimensionality estimation without retraining
- [[the-fidelity-parameter-trades-latent-compactness-against-reconstruction-accuracy-without-retraining]] -- scalar f ∈ [0,1] controls deployment-time compactness; f=0.99 gives 24/128 dims on strings, f=0.80 gives ~5 dims suitable for performance control surfaces
- [[a-vae-latent-sampled-at-23hz-provides-a-2048-to-1-compression-ratio-usable-as-a-higher-level-generative-model-input]] -- 2048x downsampling creates 23Hz latent sequences where a 3-second receptive field costs only 10 WaveNet layers; enables a two-tier architecture: slow generative model over latents, RAVE decoder for audio-rate synthesis

### Emergent Capabilities
- [[neural-audio-models-trained-without-domain-priors-perform-timbre-transfer-as-an-emergent-capability]] -- out-of-domain audio through a trained encoder generates "mismatched" latents that the decoder renders as a target-domain version of the input; quality unpredictable but no explicit transfer training required

### DDSP (related source -- [[ddsp-2020]])
- [[differentiable-dsp-components-make-classical-synthesis-knowledge-available-as-structural-priors-for-neural-networks]] -- DSP inductive biases (harmonic oscillators, filtered noise) encode periodic audio priors reducing model size 2-10x over baseline architectures
- [[ddsp-autoencoder-achieves-high-fidelity-synthesis-without-autoregressive-or-adversarial-losses]] -- explicit DSP modules serve as a strong prior that removes the need for adversarial training; contrast with RAVE which requires adversarial loss to compensate for lacking DSP structure
- [[multi-scale-spectral-loss-is-perceptually-better-than-pointwise-waveform-loss-for-audio-synthesis]] -- multi-scale STFT amplitude distance is phase-agnostic and captures perceptual features; used by both DDSP and RAVE as primary reconstruction objective
- [[time-and-frequency-domain-neural-synthesis-impose-a-phase-alignment-prior-that-conflicts-with-periodic-audio-structure]] -- strided convolution and STFT models burn capacity on frame-boundary phase alignment--a representation artifact; oscillator-based synthesis avoids this entirely
- [[harmonic-oscillator-amplitude-factorization-separates-loudness-control-from-spectral-shape]] -- A_k = A * c_k factorization is the synthesizer-level disentanglement that makes independent pitch/loudness/timbre control architecturally enforced rather than statistically emergent
- [[disentangled-synthesis-latents-enable-pitch-loudness-and-timbre-control-independent-of-each-other]] -- routing f0 directly to the synthesizer (bypassing the decoder) enables out-of-distribution pitch extrapolation; training-distribution bounds apply only to timbre/spectral parameters
- [[dsp-inductive-biases-reduce-model-size-by-encoding-prior-knowledge-about-periodic-audio]] -- zero-parameter harmonic oscillator + IR-based reverb carry the generative burden; a 0.24M "Tiny" variant shows the architecture scales down for embedded RT deployment
- [[explicit-reverb-factorization-enables-blind-dereverberation-as-a-modular-architectural-side-effect]] -- separating room IR into a bypassable post-synthesis module makes dereverberation and acoustic transfer free consequences of architecture, not separate algorithms
- [[harmonic-plus-noise-model-covers-most-natural-instrument-timbres-with-a-deterministic-plus-stochastic-decomposition]] -- additive harmonic + filtered noise is expressive enough to serve as a general-purpose MPEG-4 audio codec; the primary synthesis architecture for pitched acoustic instruments

### Explainability and Provenance
- [[propagator-networks-provide-provenance-for-computed-conclusions]] -- Sussman's propagator model tracks derivation chains; if murail tracks which UGen nodes contributed to an output, that provenance could attribute audio characteristics to generating nodes
- [[truth-maintenance-systems-enable-locally-consistent-reasoning-in-an-inconsistent-knowledge-base]] -- TMSs manage multiple locally consistent worldviews; potential model for reasoning about conflicting neural audio model assumptions

### Synthesis-by-Optimization (CTAG 2024 -- [[cherep-2024-text-to-audio-synthesizer]])
- [[synthesis-by-optimization-produces-an-interpretable-parameter-space-that-neural-synthesis-cannot-offer]] -- 78 interpretable synthesizer parameters enable inspect-and-tweak workflows impossible with billion-parameter neural models; interpretability as a creative feature, not a limitation
- [[differentiable-synthesizer-gradients-are-unstable-making-gradient-free-optimization-the-practical-choice]] -- even differentiable synthesizer implementations produce unstable gradients in practice; LES evolutionary strategies outperform all gradient-based alternatives
- [[clap-similarity-as-synthesis-objective-decouples-sound-generation-from-acoustic-realism]] -- LAION-CLAP cosine similarity as optimization target steers toward semantic alignment; enables abstract sound that conveys concept without acoustic literalism
- [[synthesis-by-optimization-directly-optimizes-its-own-evaluation-metric-making-clap-score-an-invalid-quality-signal]] -- Goodhart's Law in neural audio: CTAG trivially beats all baselines on CLAP score by construction; requires independent evaluation
- [[les-outperforms-gradient-free-alternatives-for-low-dimensional-synthesizer-parameter-optimization]] -- within 300 iterations on a 78-parameter space, LES significantly outperforms CMA-ES, PSO, DES, random search; concrete algorithm selection for synthesis-by-optimization
- [[a-78-parameter-modular-synthesizer-matches-neural-models-for-sound-identifiability-while-exceeding-them-for-perceived-artistic-quality]] -- human study: CTAG 56% vs AudioGen 59.5% accuracy (indistinguishable), CTAG 3.54/5 vs AudioGen 2.32/5 artistic rating (p < .0001)
- [[synthesizer-parameter-space-interpolation-produces-semantically-coherent-intermediate-sounds]] -- linear parameter vector interpolation yields coherent acoustic transitions; not guaranteed in neural latent spaces
- [[abstract-sound-synthesis-captures-conceptual-essence-in-the-way-visual-sketching-captures-form]] -- abstract synthesis : audio as line drawing : visual art; non-literal yet semantically legible and often more evocative
- [[procedural-sound-design-transcends-acoustic-plausibility-by-constructing-concepts-rather-than-recording-events]] -- Ciani's principle: synthesis constructs concepts that no recording can capture; parameter-space design accesses sounds that don't exist in nature

### Compiler Infrastructure for Hardware-Targeted Inference
- [[mlir-enables-heterogeneous-hardware-targeting-that-llvm-cannot-provide]] -- MLIR's composable multi-level IR is the current state of the art for targeting CPUs, GPUs, and ASICs simultaneously; relevant if murail integrates neural UGens on accelerator backends
- [[compiler-generality-beats-human-specialization-at-scale-because-compilers-can-enumerate-configurations-humans-cannot]] -- Modular beat Intel MKL on Intel chips through exhaustive configuration search; applies to real-time neural inference kernels across hardware targets

## Open Questions
- What is the practical inference latency floor for RAVE's decoder on a modern CPU at block sizes used in audio workstations (256-512 samples)? The 985kHz throughput figure is batch throughput, not block latency.
- Can RAVE-style latent compression be used as murail's node interface for high-level generative models? The 23Hz latent rate maps naturally to a "composition rate" tier in a multi-rate graph.
- How do out-of-domain KL divergences (Table 3) affect synthesis quality when the RAVE encoder is used as a feature extractor for signals that murail generates rather than records?
- What is the minimum synthesis parameter count before synthesis-by-optimization becomes intractable with LES within practical iteration budgets (300 iterations)?
- Can DDSP-style architectural discipline (harmonic oscillators, filtered noise) be layered onto a general modular synthesizer to restore gradient stability without losing flexibility?
- If murail exposed synthesis graph parameters as a searchable space, what would a synthesis-from-description workflow API look like in practice?

---

Agent Notes:
- 2026-02-28: host-buffer-to-model-input-mismatch is the gap note for the ANIRA cluster — what the study didn't measure. Gap 1 (mismatch) is bounded by the anira-latency-formula's H_adapt term. Gap 2 (parallel inference) is bounded by memory-bandwidth-is-the-binding-constraint (why optimal thread count is hardware-dependent) and scoped by onnx-runtime-does-not-support-stateful (only applies to stateless models). The engine ranking in onnx-runtime-is-fastest is the controlled-condition baseline that both gaps extend.
- 2026-02-28: The ANIRA cluster (inference-engines-violate-*, static-thread-pool-*, warm-up-inferences-*, anira-latency-formula-*, larger-model-input-sizes-*, host-buffer-to-model-input-mismatch-*, onnx-runtime-is-fastest-*, onnx-runtime-does-not-support-*, tensorflow-lite-outperforms-*) forms a dense sub-graph. Entry point depends on question: RT safety architecture -> static-thread-pool; violation severity data -> inference-engines-violate; engine selection for murail UGens -> onnx-runtime-is-fastest. Violation severity and performance rank correlate: ONNX Runtime fastest and lightest violations, LibTorch slowest and most invasive.
- 2026-02-28: anira-latency-formula bridges the ANIRA cluster to the broader RT feasibility discussion. Follow formula -> autoregressive-synthesis to understand why I_max makes autoregressive models categorically unsuitable. Formula -> onnx-runtime-is-fastest shows engine selection as an I_max lever. The formula is the quantitative spine of the cluster: every other ANIRA claim either constrains an input variable or explains a gap.
- 2026-02-28: onnx-runtime-is-fastest is the practical engine-selection hub. Three axes qualify its ranking: (1) warm-up-inferences shows the ranking assumes stabilized runtimes; (2) larger-model-input-sizes shows buffer size is an orthogonal performance lever; (3) static-thread-pool shows stateless models (ONNX's domain) unlock parallel inference that stateful models cannot use. Together these four claims give a complete decision surface for murail neural UGen engine selection.
- 2026-02-28: onnx-runtime-does-not-support-stateful is not merely a capability gap — it is the precise architectural condition that determines whether ThreadPool parallelism applies. The chain: stateless model -> ONNX Runtime -> parallel ThreadPool inference available. Stateful model -> LibTorch (or TFLite) -> parallel inference blocked -> higher I_max -> higher L_total via formula. The stateless/stateful split is a three-level consequence tree: engine, parallelism, latency budget.
- 2026-02-28: larger-model-input-sizes connects to the broader RT feasibility cluster: autoregressive-synthesis contextualizes why latency tolerance is necessary for the lever to exist; multiband-decomposition is a parallel strategy operating at the input representation level rather than inference scheduling. These three claims (autoregressive, multiband, larger-input-sizes) form a design toolkit: rule out autoregressive, then apply both remaining strategies independently.
- 2026-02-28: tensorflow-lite-outperforms-libtorch bridges the ANIRA cluster to the DDSP sub-cluster: dsp-inductive-biases produces sub-1M parameter models (DDSP Tiny: 0.24M) which fall in TFLite's advantageous range. This makes the size-dependent engine ranking immediately actionable for murail DDSP-backed neural UGens without empirical measurement — the 1k-parameter boundary is already clear from LMM-III. Start with TFLite or ONNX for DDSP models; verify LibTorch only for effect models approaching 30k parameters.

Topics:
- [[index]]
