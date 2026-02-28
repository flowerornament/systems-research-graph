---
description: Smalltalk's image-based development makes the source file and the running system one artifact, so deleting a method removes it from the running environment rather than leaving a stale copy
type: claim
evidence: strong
source: [[stop-writing-dead-programs-jack-rusher-2022]]
created: 2026-02-28
status: active
---

# Smalltalk image model prevents source-runtime drift

In file-based interactive systems (Emacs + Clojure, Common Lisp), evaluating a form adds it to the running image. But if you later delete that code from the file, the evaluated form persists in the image. Your text file grows out of sync with the running system. You may save the file, restart, and find things broken that worked during interactive development.

Smalltalk solves this by eliminating the distinction: the source code and the running image are the same object. When you edit a method in the Smalltalk browser, the change is immediately reflected in the running system. When you delete a method, it no longer exists in the running system. There is no separate text file that might diverge.

Rusher describes this as "a direct correspondence between what I'm doing and what the system knows." The Glamorous Toolkit (Tudor Gîrba's project) extends this philosophy with rich visualizations of the running system -- pushing the Smalltalk/Lisp tradition of tool-building for understanding one's own code to its current extreme.

Clerk (Rusher's own project) partially addresses this for Clojure: it refuses to use code that has been removed from the namespace file, surfacing errors when text and runtime diverge. This is a weaker but practical approximation of the Smalltalk model for a file-based system.

For [[language-design]] in murail: the graph compiler faces this exact problem at the audio graph level. If a user removes a node from their graph definition but the compiled RT graph still has it running, the user's mental model diverges from the running audio system. The compile-and-swap architecture prevents this -- a swap is atomic and the new graph is always a fresh compilation of the current definition. This is structurally similar to the Clerk solution: the running system is always derived from the current file state.
