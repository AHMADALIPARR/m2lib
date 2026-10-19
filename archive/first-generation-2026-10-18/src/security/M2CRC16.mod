(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2CRC16;

PROCEDURE CCITT (data: ARRAY OF CHAR;
 length: CARDINAL): CARDINAL;

VAR i,j,crc: CARDINAL;

BEGIN IF length>HIGH(data)+1 THEN length:=HIGH(data)+1 END;
 crc:=16#FFFF;
 FOR i:=0 TO length-1 DO crc:=crc XOR (ORD(data[i])*256);
 FOR j:=0 TO 7 DO IF (crc AND 16#8000)#0 THEN crc:=((crc<<1) XOR 16#1021) AND 16#FFFF ELSE crc:=(crc<<1) AND 16#FFFF END END END;
 RETURN crc END CCITT;

PROCEDURE Modbus (data: ARRAY OF CHAR;
 length: CARDINAL): CARDINAL;

VAR i,j,crc: CARDINAL;

BEGIN IF length>HIGH(data)+1 THEN length:=HIGH(data)+1 END;
 crc:=16#FFFF;
 FOR i:=0 TO length-1 DO crc:=crc XOR ORD(data[i]);
 FOR j:=0 TO 7 DO IF (crc AND 1)#0 THEN crc:=(crc>>1) XOR 16#A001 ELSE crc:=crc>>1 END END END;
 RETURN crc END Modbus;

END M2CRC16.
