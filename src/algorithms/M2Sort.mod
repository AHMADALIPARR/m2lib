(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2Sort;

PROCEDURE Swap(VAR a,b:CARDINAL);

VAR t:CARDINAL;

BEGIN t:=a;

a:=b;

b:=t END Swap;

PROCEDURE InsertionSort(VAR a:ARRAY OF CARDINAL);

VAR i,j,x:CARDINAL;

BEGIN IF HIGH(a)<1 THEN RETURN END;

FOR i:=1 TO HIGH(a)DO x:=a[i];

j:=i;

WHILE(j>0)AND(a[j-1]>x)DO a[j]:=a[j-1];

DEC(j)END;

a[j]:=x END END InsertionSort;

PROCEDURE SelectionSort(VAR a:ARRAY OF CARDINAL);

VAR i,j,m:CARDINAL;

BEGIN IF HIGH(a)<1 THEN RETURN END;

FOR i:=0 TO HIGH(a)-1 DO m:=i;

FOR j:=i+1 TO HIGH(a)DO IF a[j]<a[m]THEN m:=j END END;

IF m#i THEN Swap(a[i],a[m])END END END SelectionSort;

PROCEDURE Sift(VAR a:ARRAY OF CARDINAL;

root,last:CARDINAL);

VAR child,t:CARDINAL;

BEGIN WHILE root*2+1<=last DO child:=root*2+1;

IF(child<last)AND(a[child]<a[child+1])THEN INC(child)END;

IF a[root]>=a[child]THEN RETURN END;

t:=a[root];

a[root]:=a[child];

a[child]:=t;

root:=child END END Sift;

PROCEDURE HeapSort(VAR a:ARRAY OF CARDINAL);

VAR start,last,t:CARDINAL;

BEGIN IF HIGH(a)<1 THEN RETURN END;

start:=(HIGH(a)+1)DIV 2;

WHILE start>0 DO DEC(start);

Sift(a,start,HIGH(a))END;

last:=HIGH(a);

WHILE last>0 DO t:=a[0];

a[0]:=a[last];

a[last]:=t;

DEC(last);

Sift(a,0,last)END END HeapSort;

END M2Sort.
