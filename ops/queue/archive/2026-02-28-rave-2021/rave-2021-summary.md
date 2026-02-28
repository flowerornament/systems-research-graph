---
batch: rave-2021
date: 2026-02-28
source: /Users/morgan/code/murail/.design/references/papers/rave-2021.pdf
archive: /Users/morgan/code/murail/.design/references/papers/archive/rave-2021.pdf
---

# Batch Summary: rave-2021

**Source:** RAVE: A Variational Autoencoder for Fast and High-Quality Neural Audio Synthesis
**Authors:** Antoine Caillon & Philippe Esling (IRCAM / Sorbonne Université)
**Venue:** arXiv:2111.05011v2, December 2021

## Extraction Results

- Claims created: 9
- Enrichments: 1 (ddsp-2020.md updated with backward connections to RAVE)
- Connections added: ~14 (forward links in new claims + backward links to DDSP claims)
- Topic maps updated: 2 (ai-ml, index)

## Claims Created

1. [[autoregressive-synthesis-prevents-real-time-audio-generation-at-usable-sample-rates]] -- property
2. [[two-stage-vae-training-separates-representation-quality-from-synthesis-quality]] -- pattern
3. [[freezing-the-encoder-during-adversarial-fine-tuning-is-necessary-to-preserve-a-compact-latent-representation]] -- property
4. [[multiband-decomposition-reduces-temporal-dimensionality-enabling-real-time-neural-audio-at-48khz]] -- claim
5. [[post-training-svd-on-mode-means-identifies-effective-latent-dimensionality-of-a-vae]] -- pattern
6. [[the-fidelity-parameter-trades-latent-compactness-against-reconstruction-accuracy-without-retraining]] -- property
7. [[neural-audio-models-trained-without-domain-priors-perform-timbre-transfer-as-an-emergent-capability]] -- claim
8. [[a-vae-latent-sampled-at-23hz-provides-a-2048-to-1-compression-ratio-usable-as-a-higher-level-generative-model-input]] -- claim
9. [[parallel-non-autoregressive-audio-decoders-match-autoregressive-quality-when-combined-with-adversarial-training]] -- claim

## Source Reference Created

- [[rave-2021]] -- source note with full citation, summary, and claims list

## Files Modified

- `notes/rave-2021.md` -- new source reference file
- `notes/ai-ml.md` -- updated with 9 new claims organized into 4 new sections
- `notes/ddsp-2020.md` -- added "Connections to Later Work" section linking to RAVE
- `notes/index.md` -- added rave-2021 to Source References

## Quality Check

- All 9 claim files: schema-compliant YAML (description, type, evidence, source, created, status)
- All descriptions: <= 200 characters
- All wiki links: verified pointing to real files
- No dangling links introduced
- All claims linked from ai-ml topic map

## Notable Findings

The key murail insight from RAVE: real-time neural audio at 48kHz is achievable today on CPU, but requires architectural choices (parallel decoder, multiband decomposition) not ML sophistication. The 23Hz latent rate maps naturally to a "composition tier" in a multi-rate murail graph, where slow generative models drive audio-rate synthesis via RAVE's decoder. Encoder freezing during adversarial training is an underappreciated constraint that determines whether the resulting latent space is actually usable for interactive control.
