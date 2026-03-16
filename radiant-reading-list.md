# Research Reading List for Radiant

Curated from the arscontextica research graph for Alexis Sellier (radiant.computer)

This is organized by the design decisions Radiant is actively making. Each section maps a Radiant
design question to research that bears on it, with specific papers and the key results.

---
## 1. The Growth Question: Small-and-Complete vs Designed-to-Grow

Radiant's stated goal is a system "comprehensible by a single human." This echoes Wirth's Oberon (12k
lines). But there's a deep tension here with language extensibility.

**Read: Guy Steele, "Growing a Language" (OOPSLA 1998)**
- Central thesis: a language must be designed to grow, not to be complete. Every successful language
(Lisp, C, Java) succeeded because users could extend it. Every "finished" language (APL, PL/I)
eventually died.
- The critical criterion: user-defined extensions must be syntactically indistinguishable from built-in
 primitives. If Radiance's stdlib has first-class audio and graphics, the question is whether users can
add first-class networking, physics, or other domain primitives at the same syntactic level -- or
whether there's a visible seam between "blessed" and "user" abstractions.
- The APL case study is directly relevant: APL had extraordinary expressive power but a closed glyph
vocabulary. Users couldn't extend it without breaking the syntax. Steele argues this is what killed it.
- Available freely as PDF from UVA CS.

**Read: Philip Wadler, "The Expression Problem" (1998)**
- The canonical formulation: can you add both new data variants AND new operations over existing data,
without recompiling existing code, while maintaining static type safety?
- Functional languages (Haskell, ML) make adding operations easy but adding cases hard. OO languages
(Java, C#) make adding cases easy but operations hard. Neither solves both simultaneously.
- Radiance, as a statically-typed systems language inspired by Rust/Swift/Zig, will hit this. The
question is whether the type system provides an escape (generics + traits solve one dimension;
algebraic effects potentially solve both).
- Wadler's GJ solution uses virtual type indexing -- relevant if Radiance adopts bounded polymorphism.
- Available as the original email: homepages.inf.ed.ac.uk/wadler/papers/expression/expression.txt

**The tension:** Steele says design for growth. Wirth says design for comprehensibility. Sussman (below)
says design for evolvability, which requires giving up provability. These three positions define a
triangle that Radiance sits inside. Where exactly?

---
## 2. Capabilities and Effects: The Type-Level Security Model

Radiance's capability-based security -- programs declare required OS capabilities in their types, the
OS refuses unauthorized loads -- is one of its most interesting design choices. The algebraic effects
literature provides the formal foundation for this.

**Read: Gordon Plotkin & Matija Pretnar, "Handlers of Algebraic Effects" (2009)**
- The foundational paper. Operations (like "read file" or "allocate memory") are constructors building
up a free algebraic model. Handlers are the unique homomorphism that folds the free model into a
programmer-defined interpretation.
- This is not pattern matching -- it's a categorical universal property. The handler is guaranteed
unique by the freeness of the algebra. This means capability handling is compositional by construction.
- Key result for Radiant: algebraic operations and handlers are categorically dual -- intro/elim rules,
 like algebraic data types. Operations build up; handlers fold down. This duality is the formal basis
for a capability system where the OS is the outermost handler.
- Critical limitation: Plotkin & Pretnar prove that parallel composition cannot be expressed as an
effect handler because it requires folding two structures simultaneously (a binary fold), while
handlers provide only a unary fold. This means audio graph parallelism, CCS-style concurrency, and Unix
 pipes fall OUTSIDE what the capability/effect system can express. Radiant will need a separate
concurrency mechanism alongside effects.
- Available from Edinburgh: homepages.inf.ed.ac.uk/gdp/publications/Effect_Handlers.pdf

**Read: Daan Leijen, "Algebraic Effects for Functional Programming" (Microsoft TR, 2016)**
- The practical compilation paper. Shows how to implement algebraic effects efficiently via selective
CPS translation.
- Key result for Radiant's capability model: an empty effect row <> is a proof of non-interference. If
a function's type says it performs no effects, the compiler has machine-checked that it cannot invoke
any OS capability. This is exactly what Radiant wants: a function typed as capability-free is provably
safe to run in any context.
- The open/close type rules reduce CPS overhead by ~80% -- most functions that appear
effect-polymorphic can be compiled as direct calls.
- The trampoline runtime implements tail resumption as a loop, eliminating stack growth. Important for
a systems language where stack depth must be bounded.
- Deep vs shallow handler distinction matters for Radiant: deep handlers (the default) re-enter the
handler on each resume, making them folds over the full effect algebra. If Radiant uses deep handlers
for OS capabilities, every resume re-checks the capability -- which may be what you want for security,
or may be overhead you don't want on a hot path.
- Available from Microsoft Research.

**Read: Daan Leijen, "Type Directed Compilation of Row-Typed Algebraic Effects" (POPL 2017)**
- The compilation strategy. Row-typed effects compose freely because they're restricted to the free
monad. Handler composition order determines effect scope explicitly -- outer state = shared global
state, inner state = per-branch state.
- The nominal effect types (named effect types instead of structural rows) keep inferred types small
but require complete handlers. Tradeoff relevant to Radiance's "comprehensible by one person" goal.
- Available from Microsoft Research.

**Synthesis for Radiant:** Effects-as-capabilities gives you: (1) compile-time proof that restricted code
can't escape its sandbox, (2) compositional capability delegation (a function can grant a
sub-capability to a callee by installing a handler), (3) a formal boundary on what the capability
system can express (no parallel composition). The remaining question is whether STM (your current
concurrency choice) is the right mechanism for what effects can't express, or whether you need
something else.

---
## 3. STM and Concurrency: The Performance Question

Radiance chose STM for concurrency. This is a deliberate trade.

**Read: Keir Fraser, "Practical Lock-Freedom" (PhD thesis, Cambridge, 2004)**
- Chapter 8 benchmarks STM (OSTM, WSTM) against lock-free approaches (CAS, MCAS) on real concurrent
data structures.
- Key quantitative result: MCAS and STM trade performance for programmability at a measurable cost. STM
is ~2-5x slower than hand-tuned lock-free code on contended workloads, but dramatically easier to
reason about and compose.
- Fraser's epoch-based reclamation (for garbage-free memory management in concurrent contexts) is
relevant if Radiance avoids GC -- it's the mechanism that makes lock-free data structures practical
without a collector.
- The linearizability framework (concurrent operations reason about as sequential executions) is the
correctness criterion STM provides automatically. Lock-free code must prove linearizability manually.
- Available from Cambridge CS department.

**If Radiant has audio primitives, STM alone won't work for the audio thread:**

**Read: Ross Bencina, "Real-Time Audio Programming 101: Time Waits for Nothing" (2011)**
- The cardinal rule: if you don't know how long it will take, don't do it on the audio thread.
Unbounded execution time is the single root cause of all audio glitches -- not slowness, but
unpredictability.
- Three specific failure mechanisms: (1) lock acquisition (including inside STM transactions -- STM
retry is unbounded), (2) priority inversion (lower-priority task holds a resource the RT thread needs),
(3) page faults (virtual memory lookup blocks on disk I/O).
- STM's retry-on-conflict semantics make it fundamentally unsuitable for hard-real-time audio: a
transaction that conflicts will retry, and retry count is unbounded. On the audio thread, you have ~5ms
to produce output. Any mechanism with unbounded worst-case execution time violates this.
- The practical solution: lock-free SPSC (single-producer, single-consumer) queues between the audio
thread and everything else. The audio thread never waits; it reads what's available and produces output
regardless.
- Available at rossbencina.com/code/real-time-audio-programming-101-time-waits-for-nothing

**Read: Roger Dannenberg & Ross Bencina, "Design Patterns for Real-Time Computer Music Systems" (ICMC 2005)**
- Seven named design patterns for RT audio, distilled from SuperCollider, Pure Data, Ardour, JACK, and
PortAudio.
- The most relevant: cached evaluation order -- compile the graph's execution order once, cache it, and
replay it on the audio thread. Topology changes happen on a non-RT thread and swap atomically. This is
the structural basis for "compile-and-swap" (murail's approach) and would apply equally to Radiant if
it processes audio graphs.
- Thread count minimization: reduce to 2-3 threads, assign by latency requirement. The audio callback
is one thread. Everything else is another. Mixing concerns (STM transactions sharing data with the
audio callback) is the primary architectural error.
- Memory strategy spectrum: from up-front fixed allocation (safest, what murail does) through free
lists, pools, incremental GC (what SC1 did), to full stop-the-world GC (never acceptable for audio). R'
currently excludes dynamic allocation -- this is actually correct for audio-thread code.
- Available from CMU CS.

**Synthesis for Radiant:** STM is fine for general application concurrency. It is categorically wrong for
the audio thread. If Radiance has first-class audio, you need two concurrency regimes: STM for
application logic, lock-free communication for the audio callback. The type system (via
effects/capabilities) could enforce which regime applies where -- a function running in the Audio
capability context cannot perform STM transactions.

---
## 4. Audio Language Design: What Worked and What Didn't

Since Radiance plans first-class audio primitives, the 30-year history of audio programming languages
is directly relevant.

**Read: James McCartney, "SuperCollider: A New Real Time Synthesis Language" (ICMC 1996)**
- The original SC1 paper. The key architectural insight: signal buffers as a type amortize interpreter
overhead across hundreds of samples, making a high-level GC'd language viable for real-time DSP. This
is why SC worked when Csound required C.
- SC1 used closures as UGens (environment holds oscillator phase and filter state), real-time
incremental GC (no static voice count limits), and manual rate specialization (12 variants of each
oscillator for audio/control/static input combinations).
- The rate specialization problem is what Radiance will face: how does the language know which code
runs at audio rate vs control rate? SC1 did it manually (12 variants). Faust infers it from the type
system. Murail infers it at construction time. What will Radiance do?
- Available at audiosynth.com/icmc96paper.html

**Read: Ge Wang & Perry Cook, "ChucK: A Concurrent, On-the-fly Audio Programming Language" (ICMC 2003)**
- ChucK's "strongly timed" model: time is suspended until the programmer explicitly advances it
(1::second => now). This gives deterministic, reproducible timing across machines -- no OS jitter.
- Cooperative "shreds" (user-space green threads) achieve sample-accurate concurrency without OS
scheduling. The VM schedules shreds; the OS never touches them.
- The additive vs substitutive distinction: ChucK adds concurrent shreds to a running program
(additive). Murail replaces the running program atomically (substitutive). These are fundamentally
different approaches to live modification. Radiance needs to decide which model it uses.
- ChucK's VM trades raw performance for determinism. The VM overhead is real (~3-5x vs compiled C) but
determinism is more valuable than throughput for music. Relevant to Radiance's
compilation-vs-interpretation tradeoff.
- Available from Princeton: soundlab.cs.princeton.edu/publications/chuck_icmc2003.pdf

**Read: Alex McLean, "Making Programming Languages to Dance To" (FARM 2014)**
- TidalCycles: live coding with Haskell-embedded DSL. The central representation: Pattern a = Arc ->
[Event a] -- a pattern is a function from time to events. This unifies discrete events and continuous
signals under one type.
- Rational time representation eliminates rounding errors in rhythmic subdivision. type Time = Rational
 means triplets, quintuplets, and polyrhythms are exact -- no floating-point drift.
- The three feedback loops of live coding performance: manipulation (editing code), performance
(hearing results), social (audience response). Each imposes different latency requirements on the
language runtime.
- McLean rewrote TidalCycles's core representation 5+ times, each time evaluated through live
performance. The methodology claim: iterative redesign through live performance is the correct
evaluation methodology for music programming languages -- not benchmarks, not type theory proofs, but
creative use under time pressure.
- Available from ACM SIGPLAN.

---
## 5. Notation, Thought, and Language Design Philosophy

These connect to Alexis's devlog #002 (intent/instruct spectrum) and the overall Radiance design
philosophy.

**Read: Kenneth Iverson, "Notation as a Tool of Thought" (1979 Turing Award Lecture)**
- The argument that notation is not merely a way to express thoughts but actively shapes what thoughts
are possible. APL's notation extended the range of what a single programmer could hold in working
memory.
- Five criteria for good notation: ease of expression, suggestivity (notation suggests
generalizations), subordination of detail (important things prominent, details suppressed), economy
(few rules, broadly applicable), amenability to formal proof.
- Economy of notation requires compositional grammar, not a large primitive vocabulary. A small set of
orthogonal combinators that compose freely is more powerful than a large library of special-purpose
primitives. Directly relevant to Radiance's "small language" goal.
- The tension with Steele: Iverson argues for a closed, perfectly-designed notation. Steele argues for
an open, growable one. Both are right in different contexts. Radiance needs to decide which it is.
- Available from ACM Digital Library (1980 CACM).

**Read: Gerald Sussman, "We Really Don't Know How to Compute!" (Strange Loop 2011)**
- The argument for evolvability over provability. Current software is brittle because it's designed to
be correct rather than to adapt. Biological systems are robust because they're designed to be
evolvable.
- Generic operations allow extending existing code over new types without modification. Sussman's
propagator networks accumulate partial information monotonically -- no retracting conclusions, only
refining them.
- Dependency-directed backtracking uses provenance (why was this conclusion reached?) to prune search
efficiently. Relevant if Radiance implements any kind of constraint solving or type inference.
- The core challenge to Radiant's design: "comprehensible by a single human" implies tight
specification, which Sussman argues makes systems brittle. How does Radiance stay comprehensible AND
evolvable?
- Available on YouTube (Strange Loop 2011) with transcript.

**Read: Peter Naur, "Programming as Theory Building" (1985)**
- The argument that the primary artifact of programming is the programmer's mental theory of the
program, not the source text. Documentation, comments, and specifications cannot substitute for this
theory.
- Program revival by newcomers systematically produces degraded designs -- modifications by programmers
 who don't hold the theory are locally correct but globally incoherent. Quality degrades in proportion
to distance from original theorists.
- Directly relevant to Radiant's comprehensibility goal: if a single person can hold the theory of the
entire system, they can maintain it coherently. But this means Radiant's theory must be transferable --
 Naur argues this is categorically hard.
- Also relevant to open-source strategy: if Radiance is open-source, how do contributors develop the
theory? Naur's answer is pessimistic: they can't, from source alone.
- Available from various CS archives; originally published in Microprocessing and Microprogramming.

---
## 6. The Bootstrap Problem

Alexis is living through this right now (R' in C → R' self-hosting → Radiance).

**Read: The vault claim on bootstrapping (from the PL research landscape synthesis)**
- Language runtime bootstrap requires broad infrastructure before any program can run. The feedback
loop is completely blocked during the bootstrap phase. Invisible progress creates burnout risk.
- The practical observation: incremental migration between languages requires binary-level
interoperability, not just semantic compatibility. R' → Radiance transition needs the C-compiled R' and
 the R'-compiled Radiance to link against each other during the transition. This is where Zig's "C
interop as first-class" and Rust's extern "C" matter.

---
## 7. The Kolmogorov Criterion

One claim from the PL research landscape synthesis that maps directly onto Radiance's "small and
comprehensible" goal:

Kolmogorov complexity provides a measurable criterion for composition language design quality. If a
common pattern requires N tokens in language A and M tokens in language B (where M < N), language B has
lower Kolmogorov complexity for that pattern class. This gives a concrete, measurable way to evaluate
whether Radiance's notation is actually more expressive than alternatives -- not by argument, but by
measurement. Count tokens for equivalent programs across Radiance, Zig, Rust, and C. The language that
consistently requires fewer tokens for the same semantics has better notation for that problem domain.

---
## Source Papers (in recommended reading order)

1. Steele 1998 -- "Growing a Language" (OOPSLA keynote) -- UVA CS PDF
2. Bencina 2011 -- "Real-Time Audio Programming 101" -- rossbencina.com
3. Plotkin & Pretnar 2009 -- "Handlers of Algebraic Effects" -- Edinburgh
4. Wadler 1998 -- "The Expression Problem" -- Edinburgh
5. McCartney 1996 -- "SuperCollider" (ICMC) -- audiosynth.com
6. Wang & Cook 2003 -- "ChucK" (ICMC) -- Princeton
7. Iverson 1980 -- "Notation as a Tool of Thought" -- ACM
8. Naur 1985 -- "Programming as Theory Building"
9. Fraser 2004 -- "Practical Lock-Freedom" (PhD thesis) -- Cambridge
10. Leijen 2016 -- "Algebraic Effects for Functional Programming" (MS TR)
11. Dannenberg & Bencina 2005 -- "Design Patterns for RT Computer Music" (ICMC)
12. McLean 2014 -- "Making Programming Languages to Dance to" (FARM)
