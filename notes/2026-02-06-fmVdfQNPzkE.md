---
description: Source reference for McCartney's 2021 "SuperCollider Behind The Scene" talk at Codefest; covers SAPF language, SC history, C library embedding, and pixel synthesis experiments
type: claim
source: https://www.youtube.com/watch?v=fmVdfQNPzkE
created: 2026-02-28
status: active
---

# 2026-02-06-fmVdfQNPzkE

James McCartney's 82-minute talk at the University of Torino's Codefest 2021, moderated by Andrea Valle with participation from Scott Wilson and Marinos Koutsomichalis. McCartney reviews SuperCollider's pre-history (Synfonics, Synthomatic, Pyrite, SC versions 1 through server), demonstrates SAPF live, and discusses his ongoing post-retirement work on DSP code generation and immediate mode UI.

**Key topics covered:**
- SC pre-history: Synfonics (sample generator, 1979-84), Synthomatic (algebraic synthesis, 1990), Pyrite (Scheme-style language as Max object), Script (MIDI sequencer language)
- SC version 1 (Pyrite + Synthomatic merged when Power Mac hit real-time speed), SC version 2 (Smalltalk-inspired, still single-process)
- SC 3D5: an intermediate version between SC2 and the SC3 server, featuring dual virtual machines (RT and non-RT), pixel synthesis (UGens producing pixels not audio), and animated UI -- McCartney came close to inventing immediate mode UI here
- SC server (what became SC3): client-server split for crash protection and network music
- SAPF (Sound as Pure Form): postfix concatenative language, lazy infinite lists as audio signals, auto-mapping from APL, append-only execution log
- SAPF as C library: embedded SAPF by eliminating the parser and rewriting functions as C functions, making it linkable into other programs
- New DSP code generator: multiple front ends (functional language, Lisp, Python, new OO language with multimethods); all emit to a C synthesis engine back end
- Immediate mode user interfaces: dear imgui integration for code-as-prototype UI with history navigation
- Discussion: concatenative language readability problems and McCartney's pipeline-style solution

**Network music discussion (Scott Wilson, Marinos Koutsomichalis):**
- SC3's client-server model (OSC over UDP) made network music a side effect of the architecture
- High-latency network performance (30-40 seconds) as aesthetic opportunity rather than problem
- Marinos's code-projection solution: only *executed* (not typed) code is broadcast to a server; waterfall display shows all performers' concurrent outputs

Archive: `/Users/morgan/code/murail/.design/references/transcripts/archive/2026-02-06-fmVdfQNPzkE.md`

Primary claims extracted from this transcript:
- [[sapf-append-only-execution-log-provides-ten-year-session-provenance]]
- [[sapf-was-factored-into-an-embeddable-c-library-by-replacing-the-parser-with-c-functions]]
- [[supercollider-3d5-applied-signal-graphs-to-pixel-synthesis-demonstrating-graph-generality-beyond-audio]]
- [[concatenative-postfix-readability-breaks-when-argument-role-is-ambiguous]]
- [[lazy-infinite-lists-enable-sample-level-access-and-sonic-composting-in-signal-graph-languages]]
