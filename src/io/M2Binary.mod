(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2Binary;

PROCEDURE ReadBE32(b:ARRAY OF CHAR;

pos:CARDINAL;

VAR value:CARDINAL):BOOLEAN;

BEGIN IF pos+3>HIGH(b)THEN RETURN FALSE END;

value:=ORD(b[pos])*16777216+ORD(b[pos+1])*65536+ORD(b[pos+2])*256+ORD(b[pos+3]);

RETURN TRUE END ReadBE32;

PROCEDURE WriteBE32(VAR b:ARRAY OF CHAR;

pos,value:CARDINAL):BOOLEAN;

BEGIN IF pos+3>HIGH(b)THEN RETURN FALSE END;

b[pos]:=CHR(value DIV 16777216);

b[pos+1]:=CHR((value DIV 65536)MOD 256);

b[pos+2]:=CHR((value DIV 256)MOD 256);

b[pos+3]:=CHR(value MOD 256);

RETURN TRUE END WriteBE32;

END M2Binary.
