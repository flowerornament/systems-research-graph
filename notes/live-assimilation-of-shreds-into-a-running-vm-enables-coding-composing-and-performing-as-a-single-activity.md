---
description: ChucK assimilates new shreds into a running VM without stopping audio, collapsing coding, composing, and performing into one activity via additive rather than substitutive live modification
type: claim
evidence: strong
source: [[wang-cook-2003-chuck]]
created: 2026-03-01
status: active
---

# live assimilation of shreds into a running vm enables coding, composing, and performing as a single activity

ChucK's on-the-fly programming model is the integration of a runtime compiler into the ChucK Virtual Machine itself (see Figure 3 in the paper). At any moment during execution, a new shred can be compiled and *assimilated* into the running VM process without stopping audio, restarting the system, or interrupting any currently running shred. The reverse -- removing a shred (*dissimilation*) -- is equally supported.

The mechanism has three paths:
1. **External shell injection**: write new ChucK code in an editor, send it via the OS shell to the running VM process; the VM's on-the-fly compiler integrates it
2. **Language-internal generation**: `code` is a native ChucK type; programs can write and compile other programs from within ChucK itself
3. **Network assimilation**: shreds can accept shreds from remote hosts over the network and assimilate them; enables distributed, collaborative performance where performers on different machines contribute shreds to a single VM

The practical consequence is that "coding, composing, and performing are identical in ChucK." A performer at a laptop music session writes synthesis code in real-time, sends it to the running VM, and hears the result immediately -- without ever stopping. This is not a simulation of live performance but a genuine collapse of the activities: the artifact being "performed" is the program itself as it is being written.

This extends [[compile-and-swap-preserves-audio-continuity-during-recompilation]]: where murail's compile-and-swap preserves audio continuity during whole-graph recompilation, ChucK's assimilation does the same for individual shreds. The key structural difference is that ChucK assimilates additional concurrent processes, while murail swaps the entire running program. ChucK's model is additive (assimilation adds to a running set of shreds); murail's is substitutive (swap replaces the running program atomically). Both solve the "don't stop the audio" constraint but with different compositional semantics.

The connection to [[quantizing-live-code-swaps-to-musical-temporal-boundaries-makes-changes-deterministic-and-musically-predictable]] is direct: ChucK's assimilation takes effect "immediately" (at the next available scheduling point), without the musical-boundary quantization that Sonic Pi provides. This means ChucK gives maximum responsiveness at the cost of potential musical discontinuity -- a new shred may begin at an arbitrary point in a musical phrase. Sonic Pi's beat-quantized swaps address exactly this problem.

For murail's composition layer: the on-the-fly assimilation model is a specific design option for how the composition environment exposes live coding. The assimilation/dissimilation vocabulary (add a voice, remove a voice, modify a voice while others continue) maps naturally to the musical concept of polyphonic voice management. Murail's typed holes ([[typed-holes-allow-incomplete-audio-programs-to-remain-running-by-substituting-silence-rather-than-failing-compilation]]) address the partial-state problem (what happens during editing), while ChucK addresses the multi-voice problem (what happens when the program is a set of concurrent processes). These are complementary.

The historical parallel with [[real-time-incremental-garbage-collection-eliminates-static-voice-count-limits-in-synthesis-engines]] is instructive: SC1's RT GC solved the same dynamic-voice problem at the *memory* level (voices can be instantiated and collected without preallocating a fixed pool), while ChucK's shred assimilation solves it at the *scheduling* level (shreds can be added and removed without stopping the VM). Both eliminate the static ceiling on concurrent voices, but through complementary mechanisms: SC1 removes the allocation constraint; ChucK removes the scheduling constraint.

---

Topics:
- [[audio-dsp]]
- [[language-design]]
- [[competing-systems]]
