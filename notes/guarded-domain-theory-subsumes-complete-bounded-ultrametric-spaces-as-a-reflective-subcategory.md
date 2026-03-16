---
description: The category BiCBUlt of bisected complete bounded ultrametric spaces embeds as a co-reflective subcategory of the topos of trees, making guarded domain theory strictly more expressive
type: claim
evidence: strong
source: [[birkedal-2012-guarded-domain-theory]]
created: 2026-02-28
status: active
---

# guarded domain theory subsumes complete bounded ultrametric spaces as a reflective subcategory

The category BiCBUlt of bisected, complete bounded ultrametric spaces was the prior state-of-the-art for solving recursive domain equations that arise in step-indexed models of programming languages with higher-order store. Birkedal et al. (Section 5) show that BiCBUlt is a **co-reflective subcategory of S** (the topos of trees), meaning there is a full, faithful embedding BiCBUlt → S with a right adjoint.

The practical consequence is that every model previously built over BiCBUlt can be rebuilt inside S's internal logic, with two improvements:
1. S supports **full higher-order logic** (it is a topos, so it has a subobject classifier and full dependent type theory), while BiCBUlt supports only metric-space reasoning
2. Inside S, all functions are automatically "non-expansive" (in metric terms: Lipschitz constant ≤ 1) by the topos structure — no proof obligation needed. Previous BiCBUlt-based models required explicit non-expansiveness proofs at every step

The metric notion of contractiveness (Lipschitz constant < 1) corresponds exactly to the internal contractiveness condition in S: `✄(x=x') → f(x)=f(x')`. This correspondence is made precise in Section 5, where the ultrametric ball `B(x,y,ε) = d(x,y) < ε` is interpreted in terms of the Kripke worlds of S.

## Connections

- The internal Banach fixed-point theorem ([[the-internal-banach-fixed-point-theorem-proves-unique-solutions-for-contractive-guarded-recursive-predicates]]) directly generalizes the ultrametric Banach theorem, now available without importing BiCBUlt machinery
- The embedding establishes that [[the-topos-of-trees-internalizes-step-indexing-eliminating-explicit-index-arithmetic-from-proofs]] is a strict improvement over the BiCBUlt approach, not just an alternative
- [[guarded-domain-theory-generalizes-to-sheaves-over-any-well-founded-complete-heyting-algebra]] extends the framework further, beyond both S and BiCBUlt, to general well-founded sheaf toposes
