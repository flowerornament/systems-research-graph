---
description: Using a named effect label (nominal) rather than listing each operation in the type keeps inferred types concise but forces handlers to implement all operations in the effect signature
type: claim
evidence: strong
source: [[leijen-algebraic-effects]]
created: 2026-02-28
status: active
---

# nominal effect types keep inferred types small at the cost of requiring complete handlers

Leijen explicitly contrasts Koka's nominal effect system with the structural approach used in Links. In Koka, the `state` effect is a single label: `state⟨int⟩` in the type, implying both `get` and `put`. In Links, the same information is spelled out structurally:

```
sig state : (s) -> (Comp({Get:s, Put:(s) {}-> ()|e}, a))
         -> Comp({Get{_}, Put{_}|e}, a)
```

The Links type is verbose -- every operation appears in the type -- but it can express the absence of specific operations (using `{_}` absence constraints) and allows handlers that handle only a subset. Koka's nominal approach cannot do either.

The practical tradeoff:
- **Nominal (Koka)**: types remain small and readable even for large programs. Leijen cites "significant experience with large effectful programs" where row-type inference produces manageable types. Handler must cover all operations or the type checker rejects it.
- **Structural (Links/Remy rows)**: more expressive (can describe absence, partial handling), but inferred types become large and difficult to read at scale. Leijen states the Koka approach "works well in practice" and the Links paper itself notes this.

The forced-completeness constraint (every handler must handle every operation in the effect) is a real restriction: partial handlers and effect narrowing (handling only some operations of an effect, leaving others for an outer handler) are not directly expressible. Leijen notes this is a limitation.

For [[language-design]] in murail: if algebraic effects are adopted for the composition language, this is the design choice that most impacts the user experience. Nominal types are more ergonomic (cleaner inferred types, especially in an IDE context); structural types are more expressive but noisier. The choice depends on whether murail users need partial handlers (likely not for audio graph DSL use cases) or primarily need composability and readability (more likely). Koka's empirical experience (14,000 loc programs) is evidence that nominal scales in practice.
