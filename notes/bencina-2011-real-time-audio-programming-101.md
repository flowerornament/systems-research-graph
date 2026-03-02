---
description: Bencina's 2011 web article synthesizing the practitioner rules for RT audio callbacks on general-purpose OSes; canonical source of the "if you don't know how long it will take, don't do it" formulation
type: source-ref
created: 2026-03-01
---

# bencina-2011-real-time-audio-programming-101

Ross Bencina. "Real-time audio programming 101: time waits for nothing." rossbencina.com, 2011. http://www.rossbencina.com/code/real-time-audio-programming-101-time-waits-for-nothing

Web article (lightly updated 13 August 2011) synthesizing the practitioner consensus on real-time audio callback safety for general-purpose operating systems (Windows, Mac OS X, iOS, Linux). Cross-platform: applies equally to JACK, ASIO, ALSA, CoreAudio AUHAL, RemoteIO, WASAPI, SDL, PortAudio, RTAudio.

The article is notable as an accessible, standalone distillation of the same principles in [[dannenberg-bencina-2005-design-patterns-real-time-computer-music]] (Bencina is a co-author of both), with greater emphasis on the *why* behind the rules — particularly priority inversion mechanics, worst-case vs. average-case complexity, and scheduler paranoia. The "if you don't know how long it will take, don't do it" formulation originates here.

## Claims

- [[unbounded-execution-time-is-the-single-root-cause-of-all-audio-glitches-not-just-slowness]]
- [[priority-inversion-blocks-the-rt-thread-behind-a-lower-priority-task-on-general-purpose-oses]]
- [[real-time-audio-code-must-be-designed-for-worst-case-not-amortized-average-case-execution-time]]
- [[general-purpose-os-scheduler-interactions-from-the-rt-thread-have-hidden-priority-and-blocking-risks]]
- [[trylocks-cannot-guarantee-per-callback-resource-access-making-them-unsuitable-for-required-rt-operations]]
