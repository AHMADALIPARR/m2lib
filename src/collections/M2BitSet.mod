(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2BitSet;

PROCEDURE Empty():Bits;

BEGIN RETURN BITSET{}END Empty;

PROCEDURE SetBit(VAR b:Bits;

n:CARDINAL);

BEGIN IF n<=MAX(BITSET)THEN INCL(b,n)END END SetBit;

PROCEDURE ClearBit(VAR b:Bits;

n:CARDINAL);

BEGIN IF n<=MAX(BITSET)THEN EXCL(b,n)END END ClearBit;

PROCEDURE TestBit(b:Bits;

n:CARDINAL):BOOLEAN;

BEGIN IF n>MAX(BITSET)THEN RETURN FALSE END;

RETURN n IN b END TestBit;

PROCEDURE CountBits(b:Bits):CARDINAL;

VAR i,n:CARDINAL;

BEGIN n:=0;

FOR i:=0 TO MAX(BITSET)DO IF i IN b THEN INC(n)END END;

RETURN n END CountBits;

PROCEDURE Union(a,b:Bits):Bits;

BEGIN RETURN a+b END Union;

PROCEDURE Intersection(a,b:Bits):Bits;

BEGIN RETURN a*b END Intersection;

END M2BitSet.
