(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

(* Assistant-added edge-case test. Written, not executed: gm2 was unavailable.
   Every expected value below was traced from the corresponding .mod
   implementation (see docs/edge-cases.md). No run claim is made. *)
MODULE test_edge_cases;
FROM M2Limits IMPORT IsPowerOfTwo, Log2Floor, NextPowerOfTwo;
FROM M2Math IMPORT GCD, LCM, Factorial, Clamp;
FROM M2Search IMPORT Linear, Binary, LowerBound, UpperBound;
FROM M2Sort IMPORT HeapSort;
IMPORT M2Stack, M2Queue, M2List;
FROM M2Strings IMPORT Index, RIndex, IsEmpty, StartsWith, EndsWith;
FROM M2Time IMPORT Date, IsValidDate, DayOfYear, DaysInMonth;
FROM M2CRC32 IMPORT Compute;
FROM M2Hash IMPORT FNV1a32, DJB2, Mix32;
VAR a: ARRAY [0..2] OF CARDINAL; single: ARRAY [0..0] OF CARDINAL;
    s: M2Stack.Stack; q: M2Queue.Queue; l: M2List.List; v, n: CARDINAL; ok: BOOLEAN; d: Date;
BEGIN
  IF IsPowerOfTwo(0) THEN HALT(1) END;
  IF Log2Floor(0)#0 THEN HALT(2) END;
  IF NextPowerOfTwo(0)#1 THEN HALT(3) END;
  IF NextPowerOfTwo(1)#1 THEN HALT(4) END;
  IF GCD(0,0)#0 THEN HALT(5) END;
  IF GCD(0,5)#5 THEN HALT(6) END;
  ok:=LCM(0,5,n); IF NOT ok OR (n#0) THEN HALT(7) END;
  ok:=Factorial(0,n); IF NOT ok OR (n#1) THEN HALT(8) END;
  IF Clamp(5,10,3)#10 THEN HALT(9) END;
  a[0]:=1; a[1]:=3; a[2]:=5;
  IF Linear(a,2)#-1 THEN HALT(10) END;
  IF Binary(a,2)#-1 THEN HALT(11) END;
  IF LowerBound(a,2)#1 THEN HALT(12) END;
  IF UpperBound(a,2)#1 THEN HALT(13) END;
  single[0]:=7; HeapSort(single);
  IF single[0]#7 THEN HALT(14) END;
  s:=M2Stack.Create();
  IF NOT M2Stack.IsEmpty(s) THEN HALT(15) END;
  IF M2Stack.Pop(s,v) THEN HALT(16) END;
  M2Stack.Destroy(s);
  q:=M2Queue.Create(0);
  IF M2Queue.Size(q)#0 THEN HALT(17) END;
  IF NOT M2Queue.IsEmpty(q) THEN HALT(18) END;
  IF M2Queue.Dequeue(q,v) THEN HALT(19) END;
  M2Queue.Destroy(q);
  l:=M2List.Create();
  IF M2List.Length(l)#0 THEN HALT(20) END;
  IF M2List.RemoveFirst(l,v) THEN HALT(21) END;
  M2List.Destroy(l);
  IF Index("abc","")#0 THEN HALT(22) END;
  IF RIndex("abc","")#3 THEN HALT(23) END;
  IF NOT IsEmpty("") THEN HALT(24) END;
  IF NOT StartsWith("abc","") THEN HALT(25) END;
  IF NOT EndsWith("abc","") THEN HALT(26) END;
  d.year:=0; d.month:=1; d.day:=1;
  IF IsValidDate(d) THEN HALT(27) END;
  IF DayOfYear(d)#0 THEN HALT(28) END;
  IF DaysInMonth(2024,13)#0 THEN HALT(29) END;
  IF Compute("")#0 THEN HALT(30) END;
  IF FNV1a32("")#2166136261 THEN HALT(31) END;
  IF DJB2("")#5381 THEN HALT(32) END;
  IF Mix32(0)#0 THEN HALT(33) END;
END test_edge_cases.
