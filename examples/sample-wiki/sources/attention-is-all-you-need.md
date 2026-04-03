---
title: "Attention Is All You Need"
type: source-summary
authors: [Vaswani, Shazeer, Parmar, Uszkoreit, Jones, Gomez, Kaiser, Polosukhin]
year: 2017
url: "https://arxiv.org/abs/1706.03762"
tags: [transformer, attention, nlp, machine-translation, seminal-paper]
concepts: [transformer-architecture, attention-mechanism]
created: 2026-04-03
updated: 2026-04-03
---

# Attention Is All You Need

> **Authors**: Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Lukasz Kaiser, Illia Polosukhin
> **Year**: 2017
> **Type**: Research paper (NeurIPS 2017)

## One-Line Summary

Introduces the Transformer, a novel architecture based entirely on attention mechanisms that achieves state-of-the-art machine translation quality while being significantly more parallelizable than RNN-based models.

## Key Contributions

1. **The Transformer architecture** -- A sequence-to-sequence model that replaces recurrence and convolution entirely with multi-head self-attention and feed-forward layers.
2. **Scaled dot-product attention** -- An efficient attention function that uses dot products scaled by dimension size, enabling stable training with large dimensions.
3. **Multi-head attention** -- A technique for running multiple attention operations in parallel across different learned subspaces, allowing the model to jointly attend to information from different representation spaces.
4. **Positional encoding** -- Sinusoidal functions that inject sequence order information into a model that otherwise has no notion of position.
5. **Training efficiency** -- Demonstrated that the Transformer could be trained in a fraction of the time required for comparable RNN models, due to its inherently parallel nature.

## Summary

### Background and Motivation

At the time of publication, dominant sequence transduction models were based on recurrent neural networks (RNNs) and long short-term memory networks (LSTMs), often augmented with attention mechanisms. The sequential nature of RNNs was a fundamental bottleneck: each position depends on the previous one, making parallelization across time steps impossible during training.

The authors hypothesized that a model relying entirely on attention, without recurrence, could be both more effective and more efficient.

### Approach

The Transformer uses an encoder-decoder structure. The encoder maps an input sequence to a continuous representation, and the decoder generates an output sequence one token at a time (autoregressively).

Both encoder and decoder are stacks of identical layers. Each encoder layer has two sub-layers: multi-head self-attention and a position-wise fully connected feed-forward network. Each decoder layer adds a third sub-layer: multi-head attention over the encoder output (cross-attention). Every sub-layer uses residual connections and layer normalization.

The attention mechanism computes compatibility between queries and keys using scaled dot products, applies softmax, and uses the resulting weights to aggregate values. Multi-head attention runs this process multiple times in parallel with different learned projections.

### Results

On WMT 2014 English-to-German translation, the Transformer achieved 28.4 BLEU, surpassing all previous single models and ensembles. On English-to-French, it achieved 41.0 BLEU -- a new state of the art at the time.

Training time was dramatically reduced: the base model trained for 12 hours on 8 P100 GPUs, compared to days or weeks for comparable RNN models.

## Key Quotes

> "The Transformer is the first transduction model relying entirely on self-attention to compute representations of its input and output without using sequence-aligned RNNs or convolution."

> "Attention is computationally faster than recurrent layers when the sequence length is smaller than the representation dimensionality, which is most often the case with sentence representations used by state-of-the-art models."

## Concepts Extracted

The following wiki articles were created from this source:

- [[transformer-architecture]] -- The full encoder-decoder architecture introduced in this paper
- [[attention-mechanism]] -- The scaled dot-product and multi-head attention mechanisms

## Strengths and Limitations

**Strengths:**
- Elegant architecture with few novel components (mostly combines known ideas in a new way)
- Massive parallelization speedup during training
- Strong empirical results on translation benchmarks
- Generality: the architecture proved applicable far beyond machine translation

**Limitations:**
- Self-attention has O(n^2) complexity in sequence length, limiting applicability to very long sequences at the time
- The paper focused on machine translation; broader applicability was demonstrated by subsequent work (BERT, GPT)
- Positional encodings are somewhat ad hoc; later work explored learned and relative position representations

## Personal Notes

<!-- Add your own annotations, questions, and connections here -->

---
*Raw source: `raw/attention-is-all-you-need-2017.pdf`*
