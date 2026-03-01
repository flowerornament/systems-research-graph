---
description: The Koka JavaScript runtime implements effect handlers via a trampoline loop where operations return to the loop rather than growing the call stack, achieving proper tail calls
type: pattern
evidence: strong
source: [[leijen-2016-algebraic-effects-tr]]
created: 2026-03-01
status: active
---

# a trampoline runtime implements tail-resumption as a loop eliminating stack growth for effect handlers

Leijen's Section 5.4 describes the runtime implementation that makes algebraic effects practical on JavaScript (which does not support native stack capture or manipulation). The key challenge: CPS-translated code must handle effect operations, but naive implementation grows the call stack on every handler invocation and resumption.

**The trampoline pattern**: instead of calling operation handlers and continuations directly, operations *return* to a generic handler loop. The handler loop:
1. Receives the operation name and its argument
2. Looks up the appropriate handler clause on the handler stack
3. Calls the operation clause, passing the continuation (the rest of the CPS-translated computation)
4. Receives back either another operation or a final value

This is the trampoline pattern: instead of direct recursion (`f calls g calls f`), each call returns a thunk to the trampoline, and the loop drives execution. Stack depth stays constant regardless of how many operations are issued.

**Tail calls as free**: when an operation clause issues a tail resumption (the most common case -- stateful effects, logging, simple I/O), the continuation `k` is the next thunk returned to the trampoline. The trampoline loop invokes it without growing the stack. This gives proper tail calls for effect-heavy programs even on environments (like JavaScript) that historically did not support TCO.

**Connection to the optimizations already described**: [[tail-resumption-optimization-eliminates-continuation-capture-for-the-common-case]] notes that tail resumptions compile to direct function calls -- this is the runtime mechanism that makes that claim true. The trampoline is the engine; tail resumptions stay in the trampoline loop rather than escaping to a deeper call frame.

**Broader significance**: the trampoline runtime means that algebraic effects over a handler stack are not just theoretically possible on common runtimes -- they are implementable with known engineering patterns. The handler stack is an explicit data structure (not the native call stack), and operations return to the loop rather than invoking nested callbacks. This avoids the "pyramid of doom" problem while maintaining explicit, inspectable control flow.

Connects to [[algebraic-effects-model-async-without-async-await-keywords-by-registering-the-continuation-as-a-callback]]: the async case registers `resume` as an OS callback that eventually returns to the trampoline loop when input is available. The trampoline is the common runtime infrastructure underlying all three cases (sync, async, multi-shot).

Relevance to murail: if the composition language runtime uses algebraic effects for control flow, a trampoline-based implementation on any substrate (Rust, wasm, embedded targets) avoids native stack manipulation and gives bounded stack depth -- relevant for real-time audio contexts where stack overflow is a safety concern.
