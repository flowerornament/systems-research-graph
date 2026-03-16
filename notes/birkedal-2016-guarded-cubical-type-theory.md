---
description: Birkedal et al. (2016) — combines cubical type theory with guarded dependent type theory to give path equality for guarded recursive types while preserving potential decidability
type: claim
source: /Users/morgan/code/murail/.design/references/papers/archive/birkedal-2016-guarded-cubical-type-theory/birkedal-2016-guarded-cubical-type-theory.pdf
created: 2026-03-01
status: active
---

# birkedal-2016-guarded-cubical-type-theory

Lars Birkedal, Aleš Bizjak, Ranald Clouston, Hans Bugge Grathwohl, Bas Spitters, and Andrea Vezzosi. "Guarded Cubical Type Theory: Path Equality for Guarded Recursion." arXiv:1606.05223v2, 2016.

The paper introduces **guarded cubical type theory (GCTT)**, which combines:
- **CTT** (cubical type theory, Cohen et al. 2016): replaces identity types with abstract path types; gives computational interpretation of functional extensionality and univalence
- **GDTT** (guarded dependent type theory, Bizjak et al. 2016): adds the later modality `▷` and guarded recursive types to dependent type theory; used equality reflection (undecidable)

The key innovation: path equality from CTT is used in place of GDTT's equality reflection, yielding a type theory that supports non-trivial equality proofs about guarded recursive types while retaining potential for decidable type-checking and canonicity.

Prototype type-checker implemented at: http://github.com/hansbugge/cubicaltt/tree/gcubical

Semantics in presheaves over `C × ω`, where C is the category of cubes (opposite of the Kleisli category of the free De Morgan algebra monad on finite sets) and ω is the natural numbers poset.
