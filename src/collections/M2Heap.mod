(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2Heap;

PROCEDURE Sift(VAR a:ARRAY OF CARDINAL;

r,last:CARDINAL);

VAR c,t:CARDINAL;

BEGIN WHILE r*2+1<=last DO c:=r*2+1;

IF(c<last)AND(a[c]<a[c+1])THEN INC(c)END;

IF a[r]>=a[c]THEN RETURN END;

t:=a[r];

a[r]:=a[c];

a[c]:=t;

r:=c END END Sift;

PROCEDURE HeapSort(VAR a:ARRAY OF CARDINAL);

VAR s,l,t:CARDINAL;

BEGIN IF HIGH(a)<1 THEN RETURN END;

s:=(HIGH(a)+1)DIV 2;

WHILE s>0 DO DEC(s);

Sift(a,s,HIGH(a))END;

l:=HIGH(a);

WHILE l>0 DO t:=a[0];

a[0]:=a[l];

a[l]:=t;

DEC(l);

Sift(a,0,l)END END HeapSort;

PROCEDURE IsHeap(a:ARRAY OF CARDINAL):BOOLEAN;

VAR i:CARDINAL;

BEGIN IF HIGH(a)<1 THEN RETURN TRUE END;

FOR i:=1 TO HIGH(a)DO IF a[(i-1)DIV 2]<a[i]THEN RETURN FALSE END END;

RETURN TRUE END IsHeap;

END M2Heap.
