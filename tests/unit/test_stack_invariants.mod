(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

(* Invariant checks for M2Stack, encoding docs/invariants.md I1-I10.
   The checks sample; the proofs in docs/invariants.md are the verification.
   Written, not executed: gm2 is unavailable. *)

MODULE test_stack_invariants;

FROM M2Stack IMPORT Stack, Create, Destroy, Push, Pop, Peek, Size, IsEmpty, Clear;

VAR s: Stack; v: CARDINAL; ok: BOOLEAN;

BEGIN
  s := Create();
  (* I3: fresh stack is empty, size 0 *)
  IF NOT IsEmpty(s) THEN HALT(1) END;
  IF Size(s) # 0 THEN HALT(2) END;
  (* I5: Pop on empty fails closed, v untouched *)
  v := 999;
  ok := Pop(s, v);
  IF ok THEN HALT(3) END;
  IF v # 999 THEN HALT(4) END;
  (* I5: Peek on empty fails closed *)
  ok := Peek(s, v);
  IF ok THEN HALT(5) END;
  (* I10: pushes reverse; I2: size accounting *)
  IF NOT Push(s, 1) THEN HALT(6) END;
  IF NOT Push(s, 2) THEN HALT(7) END;
  IF NOT Push(s, 3) THEN HALT(8) END;
  IF Size(s) # 3 THEN HALT(9) END;
  (* I4: Peek non-destructive, I9: Pop/Peek agreement *)
  ok := Peek(s, v);
  IF NOT ok OR (v # 3) THEN HALT(10) END;
  IF Size(s) # 3 THEN HALT(11) END;
  ok := Pop(s, v);
  IF NOT ok OR (v # 3) THEN HALT(12) END;
  IF Size(s) # 2 THEN HALT(13) END;
  (* I1: LIFO roundtrip restores prior stack *)
  IF NOT Push(s, 7) THEN HALT(14) END;
  ok := Pop(s, v);
  IF NOT ok OR (v # 7) THEN HALT(15) END;
  ok := Peek(s, v);
  IF NOT ok OR (v # 2) THEN HALT(16) END;
  (* I10: remaining pops yield 2, then 1 *)
  ok := Pop(s, v);
  IF NOT ok OR (v # 2) THEN HALT(17) END;
  ok := Pop(s, v);
  IF NOT ok OR (v # 1) THEN HALT(18) END;
  IF NOT IsEmpty(s) THEN HALT(19) END;
  (* I7: Clear empties *)
  IF NOT Push(s, 10) THEN HALT(20) END;
  IF NOT Push(s, 20) THEN HALT(21) END;
  Clear(s);
  IF NOT IsEmpty(s) THEN HALT(22) END;
  IF Size(s) # 0 THEN HALT(23) END;
  (* I7: Destroy empties *)
  IF NOT Push(s, 30) THEN HALT(24) END;
  Destroy(s);
  IF NOT IsEmpty(s) THEN HALT(25) END;
  IF Size(s) # 0 THEN HALT(26) END
END test_stack_invariants.
