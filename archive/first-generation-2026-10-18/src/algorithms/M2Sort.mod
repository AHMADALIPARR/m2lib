(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2Sort;

PROCEDURE InsertionSort (VAR a: ARRAY OF CARDINAL;
 n: CARDINAL);

VAR i,j,key: CARDINAL;

BEGIN IF n>HIGH(a)+1 THEN n:=HIGH(a)+1 END;
 FOR i:=1 TO n-1 DO key:=a[i];
 j:=i;
 WHILE (j>0) AND (a[j-1]>key) DO a[j]:=a[j-1];
 DEC(j) END;
 a[j]:=key END END InsertionSort;

PROCEDURE SelectionSort (VAR a: ARRAY OF CARDINAL;
 n: CARDINAL);

VAR i,j,m,t: CARDINAL;

BEGIN IF n>HIGH(a)+1 THEN n:=HIGH(a)+1 END;
 FOR i:=0 TO n-1 DO m:=i;
 FOR j:=i+1 TO n-1 DO IF a[j]<a[m] THEN m:=j END END;
 t:=a[i];
 a[i]:=a[m];
 a[m]:=t END END SelectionSort;

PROCEDURE ShellSort (VAR a: ARRAY OF CARDINAL;
 n: CARDINAL);

VAR gap,i,j,t: CARDINAL;

BEGIN IF n>HIGH(a)+1 THEN n:=HIGH(a)+1 END;
 gap:=n DIV 2;
 WHILE gap>0 DO FOR i:=gap TO n-1 DO t:=a[i];
 j:=i;
 WHILE (j>=gap) AND (a[j-gap]>t) DO a[j]:=a[j-gap];
 DEC(j,gap) END;
 a[j]:=t END;
 gap:=gap DIV 2 END END ShellSort;

PROCEDURE SiftDown (VAR a: ARRAY OF CARDINAL;
 root,last: CARDINAL);

VAR child,t: CARDINAL;

BEGIN WHILE root*2+1<=last DO child:=root*2+1;
 IF (child<last) AND (a[child]<a[child+1]) THEN INC(child) END;
 IF a[root]>=a[child] THEN RETURN END;
 t:=a[root];
 a[root]:=a[child];
 a[child]:=t;
 root:=child END END SiftDown;

PROCEDURE HeapSort (VAR a: ARRAY OF CARDINAL;
 n: CARDINAL);

VAR i,last,t: CARDINAL;

BEGIN IF n>HIGH(a)+1 THEN n:=HIGH(a)+1 END;
 IF n<2 THEN RETURN END;
 i:=n DIV 2;
 WHILE i>0 DO DEC(i);
 SiftDown(a,i,n-1) END;
 last:=n-1;
 WHILE last>0 DO t:=a[0];
 a[0]:=a[last];
 a[last]:=t;
 DEC(last);
 SiftDown(a,0,last) END END HeapSort;

PROCEDURE IsSorted (a: ARRAY OF CARDINAL;
 n: CARDINAL): BOOLEAN;

VAR i: CARDINAL;

BEGIN IF n>HIGH(a)+1 THEN RETURN FALSE END;
 IF n<2 THEN RETURN TRUE END;
 FOR i:=1 TO n-1 DO IF a[i]<a[i-1] THEN RETURN FALSE END END;
 RETURN TRUE END IsSorted;

END M2Sort.
