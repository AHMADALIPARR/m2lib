(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2CRC32;

PROCEDURE Update(crc:CARDINAL;

data:ARRAY OF CHAR):CARDINAL;

VAR c,i,j,n:CARDINAL;

BEGIN c:=crc;

n:=0;

WHILE(n<=HIGH(data))AND(data[n]#0C)DO INC(n)END;

FOR i:=0 TO n-1 DO c:=c XOR ORD(data[i]);

FOR j:=0 TO 7 DO IF ODD(c)THEN c:=(c DIV 2)XOR 16#EDB88320 ELSE c:=c DIV 2 END END END;

RETURN c END Update;

PROCEDURE Compute(data:ARRAY OF CHAR):CARDINAL;

BEGIN RETURN Update(16#FFFFFFFF,data)XOR 16#FFFFFFFF END Compute;

PROCEDURE Init (): State;
 BEGIN RETURN 16#FFFFFFFF END Init;

PROCEDURE Final (state: State): CARDINAL;
 BEGIN RETURN state XOR 16#FFFFFFFF END Final;

END M2CRC32.
