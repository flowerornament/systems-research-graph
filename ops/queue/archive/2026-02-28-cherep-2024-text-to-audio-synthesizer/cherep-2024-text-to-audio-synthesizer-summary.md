---
batch: cherep-2024-text-to-audio-synthesizer
date: 2026-02-28
source: /Users/morgan/code/murail/.design/references/papers/archive/cherep-2024-text-to-audio-synthesizer.pdf
claims_created: 9
enrichments: 2
connections_added: 18
topic_maps_updated: 1
existing_claims_updated: 2
---

# Batch Summary: cherep-2024-text-to-audio-synthesizer

## Source
Cherep, M., Singh, N., & Shand, J. (2024). Creative Text-to-Audio Generation via Synthesizer Programming. ICML 2024, Vienna. PMLR 235.

## Claims Created

1. [[synthesis-by-optimization-produces-an-interpretable-parameter-space-that-neural-synthesis-cannot-offer]]
   Iterative parameter search over a 78-parameter synthesizer produces fully inspectable and tweakable controls; neural synthesis offers no equivalent audit trail

2. [[differentiable-synthesizer-gradients-are-unstable-making-gradient-free-optimization-the-practical-choice]]
   Gradient flow through a modular synthesizer is highly unstable in practice; LES evolutionary strategies outperform backpropagation approaches

3. [[abstract-sound-synthesis-captures-conceptual-essence-in-the-way-visual-sketching-captures-form]]
   A synthesized sound that conveys concept without acoustic literalism is the auditory equivalent of a line drawing -- abstract yet recognizable

4. [[clap-similarity-as-synthesis-objective-decouples-sound-generation-from-acoustic-realism]]
   LAION-CLAP cosine similarity as optimization target steers toward semantic alignment rather than acoustic reproduction

5. [[synthesis-by-optimization-directly-optimizes-its-own-evaluation-metric-making-clap-score-an-invalid-quality-signal]]
   Goodhart's Law in neural audio: CTAG trivially beats all baselines on CLAP score by construction

6. [[synthesizer-parameter-space-interpolation-produces-semantically-coherent-intermediate-sounds]]
   Linear parameter vector interpolation between two CTAG sounds yields coherent acoustic transitions

7. [[a-78-parameter-modular-synthesizer-matches-neural-models-for-sound-identifiability-while-exceeding-them-for-perceived-artistic-quality]]
   Human study: CTAG 56% accuracy vs AudioGen 59.5% (indistinguishable), CTAG 3.54/5 vs AudioGen 2.32/5 artistic rating (p < .0001)

8. [[les-outperforms-gradient-free-alternatives-for-low-dimensional-synthesizer-parameter-optimization]]
   LES significantly outperforms CMA-ES, PSO, DES, random search for 78-dimensional synthesis optimization within 300 iterations

9. [[procedural-sound-design-transcends-acoustic-plausibility-by-constructing-concepts-rather-than-recording-events]]
   Ciani's principle: synthesis constructs concepts no recording can capture; parameter-space design accesses sounds that don't exist in nature

## Source Reference Created

- [[cherep-2024-text-to-audio-synthesizer]] (source note)

## Enrichments

1. [[differentiable-dsp-components-make-classical-synthesis-knowledge-available-as-structural-priors-for-neural-networks]] -- added CTAG finding that gradient instability afflicts even differentiable synthesizer implementations; contrasts DDSP's architectural constraint (harmonic oscillators) as the source of gradient stability

2. [[creative-workflow-friction-should-determine-audio-engine-architecture]] -- added Ciani's principle as a concrete instantiation of friction-removal in sound design; connected synthesis-by-optimization interpretability to the friction-removal framework

## Topic Maps Updated

- [[ai-ml]] -- added "Synthesis-by-Optimization (CTAG 2024)" section with all 9 claims and 3 new open questions

## Connections Added (18 total)

Cross-batch connections from new claims to existing vault:
- creative-workflow-friction: 2 connections
- differentiable-dsp-components: 2 connections
- compile-and-swap: 1 connection (via creative-workflow-friction enrichment)
- persistent-data-structures: 1 connection (via creative-workflow-friction enrichment)
- eliminating-unit-generators: 1 connection (via differentiable-dsp enrichment)
- synthesis-graph-construction: 1 connection (via differentiable-dsp enrichment)
- Plus 10 inter-claim connections among the 9 new claims

## Notable Findings

- CTAG demonstrates a viable training-free synthesis-from-description workflow using LAION-CLAP + LES + SYNTHAX
- The 78-parameter Voice architecture outperforms larger architectures (130-parameter VoiceFM) -- diminishing returns from architectural complexity within gradient-free optimization
- 2-second sound duration is optimal for CLAP score and classifier accuracy; shorter is too sparse, longer introduces temporal complexity the synthesizer can't resolve
- Generation time on a V100: 49.94 seconds for 300 iterations, population size 50 -- feasible for creative workflow but not real-time

## Murail Relevance

High. The paper establishes:
1. Synthesis-by-optimization as a viable design pattern for parameter-space exploration
2. LES as the recommended optimizer for low-dimensional synthesizer search
3. The interpretability/realism tradeoff as a first-class design dimension
4. Gradient instability as a concrete obstacle to differentiable synthesis optimization (modifying DDSP claims)
