---
description: Pyrite's Scheme-style closures allowed Max patches to contain only UI wiring while all algorithmic logic lived in a single Pyrite object, eliminating "a big mass of wires"
type: claim
evidence: strong
source: [[2026-02-06-qmayIRViJms]]
created: 2026-02-28
status: active
---

# Pyrite introduced closures into Max patching enabling separation of UI and logic

McCartney built Pyrite as a Max object that implemented a scripting language with Scheme-style closures: functions were first-class values that could be passed around, called with arguments, and returned results. This was a specific capability Max lacked -- in Max, you cannot "send a patcher down a wire" and have things send values into it and get results back out.

The practical result: Max patches using Pyrite could delegate all algorithmic logic to a single Pyrite script object. The patch itself contained only UI elements (buttons, sliders, number boxes) and IO wiring (MIDI in, audio out). The logic -- event generation, conditional branching, data transformation -- lived in the Pyrite object as a script. McCartney describes this as cleaning up his Max patches "hugely."

Two specific Max limitations that Pyrite addressed:
1. **Data structures**: Max's `coll` object (and similar) required wiring -- anything that needed to interact with the data structure sent a message down a wire and retrieved the result. This is harder than passing data around as values, which Pyrite allowed.
2. **Functions as values**: Max had no equivalent to closures -- you could not write a sub-patch and pass it as a value to something else that would call it. Pyrite's closures enabled higher-order programming patterns unavailable in the Max data flow model.

This is the kernel of what became SuperCollider's design philosophy: the scripting language provides sequential/algorithmic expressiveness that the visual patching model cannot; the visual layer provides UI and IO that the scripting language should not have to manage. SC3 made this explicit with client-server separation; Pyrite was the proof of concept inside Max.

The Max limitation McCartney describes -- "you can't really send a patcher down a wire" -- is still true of Max today. It explains why Max/MSP has gen~ and a whole codegen sub-environment for cases where the patching model is insufficient for algorithmic synthesis.

Connects to [[visual-representation-exposes-structure-text-notation-obscures]] -- Pyrite's text scripting handled sequential logic where visual notation fails, while Max's visual model handled graph topology where text notation fails. The two representations are complementary rather than competing.
