(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2Stats;

PROCEDURE Sum (a: ARRAY OF REAL;
 n: CARDINAL): REAL;

VAR i: CARDINAL;
 s: REAL;

BEGIN IF n>HIGH(a)+1 THEN n:=HIGH(a)+1 END;
 s:=0.0;
 FOR i:=0 TO n-1 DO s:=s+a[i] END;
 RETURN s END Sum;

PROCEDURE Mean (a: ARRAY OF REAL;
 n: CARDINAL;
 VAR value: REAL): BOOLEAN;

BEGIN IF (n=0) OR (n>HIGH(a)+1) THEN value:=0.0;
 RETURN FALSE END;
 value:=Sum(a,n)/FLOAT(n);
 RETURN TRUE END Mean;

PROCEDURE Variance (a: ARRAY OF REAL;
 n: CARDINAL;
 sample: BOOLEAN;
 VAR value: REAL): BOOLEAN;

VAR i: CARDINAL;
 m,d,s,den: REAL;

BEGIN IF (n=0) OR (n>HIGH(a)+1) OR (sample AND (n<2)) THEN value:=0.0;
 RETURN FALSE END;
 m:=Sum(a,n)/FLOAT(n);
 s:=0.0;
 FOR i:=0 TO n-1 DO d:=a[i]-m;
 s:=s+d*d END;
 den:=FLOAT(n);
 IF sample THEN den:=FLOAT(n-1) END;
 value:=s/den;
 RETURN TRUE END Variance;

PROCEDURE MinMax (a: ARRAY OF REAL;
 n: CARDINAL;
 VAR minimum,maximum: REAL): BOOLEAN;

VAR i: CARDINAL;

BEGIN IF (n=0) OR (n>HIGH(a)+1) THEN RETURN FALSE END;
 minimum:=a[0];
 maximum:=a[0];
 FOR i:=1 TO n-1 DO IF a[i]<minimum THEN minimum:=a[i] END;
 IF a[i]>maximum THEN maximum:=a[i] END END;
 RETURN TRUE END MinMax;

END M2Stats.
