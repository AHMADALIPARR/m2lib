(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2JSON;

PROCEDURE IsWhitespace(c:CHAR):BOOLEAN;

BEGIN RETURN(c=' ')OR(c=9C)OR(c=10C)OR(c=13C)END IsWhitespace;

PROCEDURE EscapeString(src:ARRAY OF CHAR;

VAR dst:ARRAY OF CHAR):BOOLEAN;

VAR i,j:CARDINAL;

c:CHAR;

BEGIN i:=0;

j:=0;

WHILE(i<=HIGH(src))AND(src[i]#0C)DO c:=src[i];

IF(c='"')OR(c='\')THEN IF j+2>HIGH(dst)THEN RETURN FALSE END;

dst[j]:='\';

dst[j+1]:=c;

INC(j,2)ELSIF ORD(c)<32 THEN RETURN FALSE ELSE IF j>=HIGH(dst)THEN RETURN FALSE END;

dst[j]:=c;

INC(j)END;

INC(i)END;

dst[j]:=0C;

RETURN TRUE END EscapeString;

END M2JSON.
