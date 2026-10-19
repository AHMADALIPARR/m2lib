(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2Limits;

PROCEDURE IsPowerOfTwo(n:CARDINAL):BOOLEAN;

BEGIN IF n=0 THEN RETURN FALSE END;

RETURN (BITSET(n)*BITSET(n-1))=BITSET{} END IsPowerOfTwo;

PROCEDURE Log2Floor(n:CARDINAL):CARDINAL;

VAR r:CARDINAL;

BEGIN IF n=0 THEN RETURN 0 END;

r:=0;

WHILE n>1 DO n:=n DIV 2;

INC(r) END;

RETURN r END Log2Floor;

PROCEDURE NextPowerOfTwo(n:CARDINAL):CARDINAL;

VAR p:CARDINAL;

BEGIN IF n<=1 THEN RETURN 1 END;

IF IsPowerOfTwo(n) THEN RETURN n END;

p:=1;

WHILE p<n DO IF p>MAX(CARDINAL) DIV 2 THEN RETURN n END;

p:=p*2 END;

RETURN p END NextPowerOfTwo;

END M2Limits.
