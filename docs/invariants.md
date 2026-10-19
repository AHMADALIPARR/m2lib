<!-- SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 -->
<!-- Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. -->
<!-- Authored by Ahmad Ali Parr. -->
<!-- Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. -->

# Mathematical invariants

Tests sample behavior. Invariants prove it. A `HALT` check shows one input
behaved; an invariant shows *every* input behaves, because it is traced to
the code itself. This file states the invariants of the stack and proves
each one by tracing `src/collections/M2Stack.mod` — not by running it.
`gm2` is unavailable, so no claim here rests on execution. The same
trace-proof method applies to the other containers (`M2List`, `M2Queue`,
`M2Vector`, `M2BST`, `M2RingQueue`); the stack is proven first because it
is the smallest complete case.

## Model

A stack is a finite sequence `S = [a1, a2, ..., an]`, where `a1` is the top
(the head node) and `NIL` is the empty sequence `[]`. The chain is
NULL-terminated: the last node's `next` is `NIL`.

## Invariants of M2Stack (all verified by source trace)

### I1 — LIFO roundtrip: `Pop(Push(S, v)) = (v, S)`

If `Push` returns `TRUE`, the next `Pop` returns exactly the pushed value
and restores the prior stack.

Trace: `Push` does `p^.value := v; p^.next := s; s := p`. `Pop` then does
`p := s; v := p^.value` (= the pushed `v`); `s := p^.next` (= the old
head); `DISPOSE(p)`. The stack after the pair is exactly the stack before
the `Push`.

### I2 — Size accounting

`Size(S)` equals the number of nodes in the chain. A successful `Push`
increases it by exactly 1; a successful `Pop` decreases it by exactly 1;
`Peek` leaves it unchanged; `Clear`/`Destroy` leave it at 0.

Trace: `Size` walks the chain counting nodes and takes `s` by value, so
the walk itself mutates nothing. `Push` inserts exactly one node at the
head; `Pop` removes exactly one node at the head; `Peek` assigns only its
`VAR v` output; `Clear`/`Destroy` consume the whole chain (see I7).

### I3 — `IsEmpty(s) <=> Size(s) = 0 <=> s = NIL`

Trace: `IsEmpty` returns `s = NIL`. `Size` returns 0 exactly when the
walk finds no nodes, i.e. exactly when `s = NIL` on entry. The three
statements are the same fact in three forms.

### I4 — `Peek` is non-destructive

`Peek` returns the top value and leaves the stack byte-for-byte unchanged.

Trace: `Peek` takes `s` by value, assigns only `v := s^.value`, and
performs no `NEW`, no `DISPOSE`, and no assignment to any node. `Size`
and content before and after are identical.

### I5 — `Pop` on empty fails closed

On `s = NIL`, `Pop` reports `ErrUnderflow`, returns `FALSE`, and touches
neither the stack nor its `VAR v` output (the caller's `v` keeps its old
value).

Trace: the `IF s = NIL` branch returns before any assignment to `v` or `s`.

### I6 — `Push` on allocation failure fails closed

If `NEW(p)` returns `NIL`, `Push` reports `ErrOutOfMemory`, returns
`FALSE`, and leaves the stack untouched.

Trace: the `IF p = NIL` branch returns before any assignment to `s` or to
any node.

### I7 — `Clear` / `Destroy` empty the stack

After either procedure, `s = NIL`, so `IsEmpty(s)` is `TRUE` and
`Size(s)` is 0.

Trace: both loop `WHILE s # NIL DO p := s; s := s^.next; DISPOSE(p) END`.
The loop exits only when `s = NIL`. Termination rests on I8.

### I8 — Well-formedness: the chain is always finite, NULL-terminated, acyclic

This is the invariant the others rest on: it is what makes `Size`,
`Clear`, and `Destroy` terminate.

Proof by induction over operations. Base: `Create` returns `NIL`, which
is finite and acyclic. Step: `Push` allocates a fresh node and points its
`next` at the old head; no existing node points at the fresh node, so no
cycle is created and finiteness is preserved. `Pop` removes the head,
which cannot create a cycle. `Clear`/`Destroy` consume the chain without
rewiring any node. No statement in the module ever assigns a node's
`next` to itself or to a later node, so no back-edge ever exists.

### I9 — `Pop` / `Peek` agreement

On a non-empty stack, `Pop` returns the same value `Peek` returns, then
removes the head.

Trace: both read `s^.value` at the head before `Pop` advances `s`.

### I10 — Order: pushes reverse, pops unreverse

Pushing `v1, v2, ..., vk` in that order leaves the stack
`[vk, ..., v2, v1]`. Successive pops yield `vk, ..., v2, v1`.

Proof by induction on `Push`: each `Push` prepends its value (I1), so the
sequence after `k` pushes is the push order reversed.

## What is NOT proven here

- `NEW` / `DISPOSE` memory safety is assumed from the Modula-2 runtime;
  the trace proves the logic, not the allocator.
- Nothing here was executed: `gm2` is unavailable. The proofs hold for
  all inputs because they follow the code paths, not sampled runs.
- `Destroy` and `Clear` have identical observable effect (both end with
  `s = NIL`); the distinction is intent (teardown vs. reuse), not behavior.

## Test encoding

`tests/unit/test_stack_invariants.mod` encodes I1–I10 as 26 `HALT` checks
for the day a compiler exists. The checks sample; the proofs above are
the verification.
