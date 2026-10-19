(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2Search;

PROCEDURE Linear (a: ARRAY OF CARDINAL;
 n,key: CARDINAL;
 VAR index: CARDINAL): BOOLEAN;

VAR i: CARDINAL;

BEGIN IF n>HIGH(a)+1 THEN n:=HIGH(a)+1 END;
 FOR i:=0 TO n-1 DO IF a[i]=key THEN index:=i;
 RETURN TRUE END END;
 RETURN FALSE END Linear;

PROCEDURE Binary (a: ARRAY OF CARDINAL;
 n,key: CARDINAL;
 VAR index: CARDINAL): BOOLEAN;

VAR lo,hi,mid: CARDINAL;

BEGIN IF n>HIGH(a)+1 THEN n:=HIGH(a)+1 END;
 lo:=0;
 hi:=n;
 WHILE lo<hi DO mid:=lo+(hi-lo) DIV 2;
 IF a[mid]=key THEN index:=mid;
 RETURN TRUE ELSIF a[mid]<key THEN lo:=mid+1 ELSE hi:=mid END END;
 RETURN FALSE END Binary;

PROCEDURE LowerBound (a: ARRAY OF CARDINAL;
 n,key: CARDINAL): CARDINAL;

VAR lo,hi,mid: CARDINAL;

BEGIN IF n>HIGH(a)+1 THEN n:=HIGH(a)+1 END;
 lo:=0;
 hi:=n;
 WHILE lo<hi DO mid:=lo+(hi-lo) DIV 2;
 IF a[mid]<key THEN lo:=mid+1 ELSE hi:=mid END END;
 RETURN lo END LowerBound;

PROCEDURE UpperBound (a: ARRAY OF CARDINAL;
 n,key: CARDINAL): CARDINAL;

VAR lo,hi,mid: CARDINAL;

BEGIN IF n>HIGH(a)+1 THEN n:=HIGH(a)+1 END;
 lo:=0;
 hi:=n;
 WHILE lo<hi DO mid:=lo+(hi-lo) DIV 2;
 IF a[mid]<=key THEN lo:=mid+1 ELSE hi:=mid END END;
 RETURN lo END UpperBound;

END M2Search.
