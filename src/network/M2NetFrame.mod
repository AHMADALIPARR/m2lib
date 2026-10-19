(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2NetFrame;

PROCEDURE Encode(payload:ARRAY OF CHAR;

VAR frame:ARRAY OF CHAR;

VAR frameLen:CARDINAL):BOOLEAN;

VAR n,i:CARDINAL;

BEGIN n:=0;

WHILE(n<=HIGH(payload))AND(payload[n]#0C)DO INC(n)END;

IF n+4>HIGH(frame)THEN RETURN FALSE END;

frame[0]:=CHR(n DIV 16777216);

frame[1]:=CHR((n DIV 65536)MOD 256);

frame[2]:=CHR((n DIV 256)MOD 256);

frame[3]:=CHR(n MOD 256);

FOR i:=0 TO n-1 DO frame[i+4]:=payload[i]END;

frame[n+4]:=0C;

frameLen:=n+4;

RETURN TRUE END Encode;

PROCEDURE Decode(frame:ARRAY OF CHAR;

frameLen:CARDINAL;

VAR payload:ARRAY OF CHAR;

VAR payloadLen:CARDINAL):BOOLEAN;

VAR n,i:CARDINAL;

BEGIN IF frameLen<4 THEN RETURN FALSE END;

n:=ORD(frame[0])*16777216+ORD(frame[1])*65536+ORD(frame[2])*256+ORD(frame[3]);

IF n+4#frameLen THEN RETURN FALSE END;

IF n>HIGH(payload)THEN RETURN FALSE END;

FOR i:=0 TO n-1 DO payload[i]:=frame[i+4]END;

payload[n]:=0C;

payloadLen:=n;

RETURN TRUE END Decode;

END M2NetFrame.
