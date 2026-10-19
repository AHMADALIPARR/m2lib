(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2Hash;

PROCEDURE FNV1a32(s:ARRAY OF CHAR):CARDINAL;

VAR h,i:CARDINAL;

BEGIN h:=2166136261;

i:=0;

WHILE(i<=HIGH(s))AND(s[i]#0C)DO h:=(h XOR ORD(s[i]))*16777619;

INC(i)END;

RETURN h END FNV1a32;

PROCEDURE DJB2(s:ARRAY OF CHAR):CARDINAL;

VAR h,i:CARDINAL;

BEGIN h:=5381;

i:=0;

WHILE(i<=HIGH(s))AND(s[i]#0C)DO h:=h*33+ORD(s[i]);

INC(i)END;

RETURN h END DJB2;

PROCEDURE Mix32(x:CARDINAL):CARDINAL;

BEGIN x:=x XOR(x DIV 65536);

x:=x*16#7FEB352D;

x:=x XOR(x DIV 32768);

x:=x*16#846CA68B;

RETURN x XOR(x DIV 65536)END Mix32;

END M2Hash.
