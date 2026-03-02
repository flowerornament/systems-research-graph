---
description: Any observable behavior of a system will be depended on by some user, regardless of intent or documentation; even bugs and implementation accidents become binding contracts
type: claim
evidence: strong
source: "[[hadron-supercollider-symposium-2025-keynote]]"
created: 2026-02-28
status: active
---

# hirams law makes all observable interpreter behavior a permanent api commitment

Named after Hiram Wright (formerly of Google), Hiram's Law states: with a sufficient number of users, all observable behaviors of a system will be depended upon by somebody, regardless of what the contract promises. The law was derived from maintaining C libraries used in over a billion lines of code: even documented bugs that users were told not to rely on became broken when fixed, because some code depended on them.

Applied to interpreter development, this means that every quirk, edge case, and implementation detail that is observable becomes a de facto API commitment the moment enough users exist. The canonical example from the Hadron talk: SuperCollider's dictionary iteration order is explicitly undocumented and not guaranteed, yet any change to the hashing algorithm would break existing code. The commitment is made not by documentation but by observable behavior under real workloads.

This principle extends to accidental behaviors like non-deterministic iteration order, deferred initialization timing (see [[deferred-argument-initialization-exposes-sc-frame-setup-order-as-observable-behavior]]), and edge cases in calling conventions. Once depended upon, these cannot be changed without a compatibility strategy.

The constraint is proportional to user count. Hadron's author applies this by running a suite of SC Lang evaluation tests and matching Hadron's output exactly, including behaviors the SC docs describe as undefined. The alternative — deciding unilaterally which behaviors to preserve — is ethically fraught and practically risky.

For murail: [[observable-semantics-lock-in-implementation-details-and-block-optimization]] extends this to optimization specifically. The antidote is explicit compatibility classification up front — which behaviors are guaranteed, version-gated, or explicitly unspecified.
