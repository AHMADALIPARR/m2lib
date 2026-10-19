(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

(* Assistant-added demo. Written, not executed: gm2 was unavailable, so no
   compile or run claim is made. Uses only procedures in M2Sort / M2Search .def files. *)
MODULE sort_search_demo;
FROM M2Sort IMPORT HeapSort, InsertionSort;
FROM M2Search IMPORT Linear, Binary, LowerBound, UpperBound;
VAR a: ARRAY [0..4] OF CARDINAL; p: INTEGER; lo, hi: CARDINAL;
BEGIN
  a[0]:=4; a[1]:=1; a[2]:=3; a[3]:=0; a[4]:=2;
  HeapSort(a);
  IF (a[0]#0) OR (a[1]#1) OR (a[2]#2) OR (a[3]#3) OR (a[4]#4) THEN HALT(1) END;
  p:=Binary(a,3); IF p#3 THEN HALT(2) END;
  p:=Binary(a,9); IF p#-1 THEN HALT(3) END;
  p:=Linear(a,0); IF p#0 THEN HALT(4) END;
  p:=Linear(a,9); IF p#-1 THEN HALT(5) END;
  lo:=LowerBound(a,2); IF lo#2 THEN HALT(6) END;
  hi:=UpperBound(a,2); IF hi#3 THEN HALT(7) END;
  a[0]:=5; a[1]:=4; a[2]:=3; a[3]:=2; a[4]:=1;
  InsertionSort(a);
  IF (a[0]#1) OR (a[4]#5) THEN HALT(8) END;
END sort_search_demo.
