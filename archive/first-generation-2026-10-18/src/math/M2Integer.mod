(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2Integer;

PROCEDURE GCD (a,b: CARDINAL): CARDINAL;

VAR t: CARDINAL;

BEGIN WHILE b#0 DO t:=a MOD b;
 a:=b;
 b:=t END;
 RETURN a END GCD;

PROCEDURE LCM (a,b: CARDINAL;
 VAR value: CARDINAL): BOOLEAN;

VAR g: CARDINAL;

BEGIN IF (a=0) OR (b=0) THEN value:=0;
 RETURN TRUE END;
 g:=GCD(a,b);
 a:=a DIV g;
 IF a>MAX(CARDINAL) DIV b THEN value:=0;
 RETURN FALSE END;
 value:=a*b;
 RETURN TRUE END LCM;

PROCEDURE IsEven (n: CARDINAL): BOOLEAN;
 BEGIN RETURN n MOD 2=0 END IsEven;

PROCEDURE IsOdd (n: CARDINAL): BOOLEAN;
 BEGIN RETURN n MOD 2=1 END IsOdd;

PROCEDURE IsPowerOfTwo (n: CARDINAL): BOOLEAN;
 BEGIN IF n=0 THEN RETURN FALSE END;
 WHILE n MOD 2=0 DO n:=n DIV 2 END;
 RETURN n=1 END IsPowerOfTwo;

PROCEDURE CeilDiv (n,d: CARDINAL;
 VAR value: CARDINAL): BOOLEAN;

BEGIN IF d=0 THEN value:=0;
 RETURN FALSE END;
 value:=n DIV d;
 IF n MOD d#0 THEN INC(value) END;
 RETURN TRUE END CeilDiv;

PROCEDURE Clamp (value,low,high: CARDINAL): CARDINAL;

BEGIN IF low>high THEN RETURN low END;
 IF value<low THEN RETURN low END;
 IF value>high THEN RETURN high END;
 RETURN value END Clamp;

END M2Integer.
