---
description: Darwin Gross interviews James McCartney (SuperCollider creator) covering SC version history, Pyrite origins, Core Audio work, APL influence, post-retirement new language, and audio education
type: claim
source: https://www.youtube.com/watch?v=qmayIRViJms
created: 2026-02-28
status: active
---

# 2026-02-06-qmayIRViJms

Source reference for "Podcast 350: James McCartney," hosted by Darwin Gross. Recorded 2026-02-06, duration 42:01.

Primary source: `/Users/morgan/code/murail/.design/references/transcripts/archive/2026-02-06-qmayIRViJms.md`

## Key Topics

- McCartney's post-retirement personal project: a successor to SuperCollider (not a product, not aiming for wide adoption -- suits what he personally wants to do)
- SuperCollider version history: SC1 (Pyrite + Synthomatic merged), SC2 (Smalltalk-inspired, no client-server), SC3 (client-server split)
- Pyrite: scripting language for Max with Scheme-style closures; also preceded by "Xcode" (C-like, abandoned) and "Script" (cryptic score language with Power Glove)
- Synthomatic: software modular synthesizer (pre-SC), patch-cord model with computed samples; options taken by DEC predecessor before Macromedia acquisition killed the deal; Curtis Roads wrote to McCartney about it
- The C-emit pipeline experiment: SC code generating C code that was compiled -- abandoned because 45s compile times killed interactivity; presented at ICMC; "before Faust"
- Apple Core Audio: core audio group 10-12 people in 2002, 200+ by retirement; success traced to foundational low-latency architectural insight made before McCartney joined; McCartney worked on audio toolbox, audio units, sample rate conversion
- APL influence: brevity of expression, "composing functions to compose music"; Stanley Jordan wrote papers on using APL for music composition; Jordan also wrote a MIDI sequencer in APL
- Vanjanko isomorphic keyboard: whole-tone rows offset by semitone; invented 1880s; 50+ manufacturers until ~1920; Franz Liszt knew of it; McCartney has an acoustic piano with this keyboard
- Audio programming education: read CSound, VCV Rack, SuperCollider, Chuck, Pure Data source code to understand how engines solve the same problems differently
- JUCE as crutch: Apple interviews revealed JUCE-trained developers understood DSP inner loops but not threading/resource management; Core Audio needed the latter
- Level Control Systems (pre-Apple contract): 128x128 digital audio mixing matrix, 5-band EQ and delay per I/O, space maps (triangular speaker mesh, used by Cirque du Soleil Mysterio show, Hollywood Bowl)

## Claims Extracted

- [[supercollider-version-1-merged-a-scripting-language-with-a-software-synthesizer-when-hardware-reached-real-time-speed]]
- [[supercollider-client-server-architecture-moved-the-scripting-language-out-of-the-real-time-audio-thread]]
- [[supercollider-version-2-used-a-smalltalk-inspired-language-without-client-server-separation]]
- [[core-audio-low-latency-performance-traces-to-an-architectural-insight-made-at-the-projects-inception]]
- [[juce-abstracts-away-audio-engine-fundamentals-producing-developers-who-cannot-reason-about-threading-and-resource-management]]
- [[audio-programming-education-requires-reading-production-engine-source-code-across-multiple-systems]]
- [[pyrite-introduced-closures-into-max-patching-enabling-separation-of-ui-and-logic]]

## Cross-Referenced In

- [[mccartney-ideas-2026-02-15]] -- synthesized across four McCartney transcripts including this one
