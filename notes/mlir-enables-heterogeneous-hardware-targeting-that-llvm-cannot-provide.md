---
description: MLIR is a multi-level IR framework that models the hardware diversity of CPUs, GPUs, and ASICs that LLVM, designed for a single-tier CPU world, cannot address without fundamental redesign
type: claim
evidence: strong
source: [[llvm-creator-interview-chris-lattner]]
created: 2026-02-28
status: active
---

# mlir enables heterogeneous hardware targeting that llvm cannot provide

LLVM is over 20 years old. Its architecture assumes a CPU with a relatively flat memory model and straightforward instruction-level parallelism. Modern compute hardware is radically different: multi-socket servers with NUMA memory topology, deep multi-level cache hierarchies, GPU shader pipelines, and custom matrix-multiplication ASICs (Google TPUs, Apple Neural Engine, Intel AMX, NVIDIA Tensor Cores).

MLIR (Multi-Level Intermediate Representation) is a compiler framework Lattner built at Google, now an LLVM umbrella project. Its core insight is that different hardware domains require different intermediate representations operating at different abstraction levels, and these levels should be composable. A GPU kernel needs to reason about warp-level parallelism. A matrix multiplication ASIC needs to know about tile sizes and memory layout. A CPU needs vectorization via SIMD. LLVM's single IR level cannot express all of these concerns simultaneously.

Modular/Mojo's architecture uses MLIR as its compiler backbone -- Lattner states Mojo is effectively "an AST for MLIR." Critically, Modular does not use most of the MLIR dialects from the standard distribution (which Lattner characterizes as "super academic crazy stuff"). They rebuilt their compiler stack from scratch on top of MLIR's infrastructure, giving them a new code generator that LLVM does not have.

The practical consequence: Modular proved it could generate matrix multiplication code that ran faster than Intel MKL (Intel's hand-optimized Math Kernel Library) on Intel CPUs. The mechanism is that a sufficiently advanced compiler can enumerate all hardware configurations and select the optimal one, while human experts can only special-case specific known configurations. This is also the subject of [[compiler-generality-beats-human-specialization-at-scale-because-compilers-can-enumerate-configurations-humans-cannot]].

For [[ai-ml]] intersection with murail: audio DSP and neural audio inference (DDSP, RAVE, real-time ANIRA-style inference) are increasingly targeting accelerator hardware. A murail audio graph that integrates neural UGens may eventually need to target non-CPU backends. MLIR's multi-level approach is the current state of the art for this problem.

For [[language-design]]: Mojo's emergence as MLIR syntax rather than a language designed on its own terms is a concrete example of a compiler-first, language-second design order. The language exposes the compiler's capabilities as first-class syntax rather than being a language that happens to compile well.
