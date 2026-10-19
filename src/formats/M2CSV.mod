(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2CSV;

PROCEDURE CountFields(line:ARRAY OF CHAR):CARDINAL;

VAR i,n:CARDINAL;

q:BOOLEAN;

BEGIN n:=1;

i:=0;

q:=FALSE;

WHILE(i<=HIGH(line))AND(line[i]#0C)DO IF line[i]='"'THEN IF q AND(i<HIGH(line))AND(line[i+1]='"')THEN INC(i)ELSE q:=NOT q END ELSIF(line[i]=',')AND NOT q THEN INC(n)END;

INC(i)END;

RETURN n END CountFields;

PROCEDURE ParseRow(line:ARRAY OF CHAR;

VAR fields:ARRAY OF ARRAY OF CHAR;

VAR count:CARDINAL):BOOLEAN;

VAR i,j:CARDINAL;

q:BOOLEAN;

BEGIN count:=0;

i:=0;

j:=0;

q:=FALSE;

WHILE(i<=HIGH(line))AND(line[i]#0C)DO IF line[i]='"'THEN IF q AND(i<HIGH(line))AND(line[i+1]='"')THEN IF j>=HIGH(fields[count])THEN RETURN FALSE END;

fields[count][j]:='"';

INC(j);

INC(i)ELSE q:=NOT q END ELSIF(line[i]=',')AND NOT q THEN fields[count][j]:=0C;

IF count>=HIGH(fields)THEN RETURN FALSE END;

INC(count);

j:=0 ELSE IF j>=HIGH(fields[count])THEN RETURN FALSE END;

fields[count][j]:=line[i];

INC(j)END;

INC(i)END;

IF q THEN RETURN FALSE END;

fields[count][j]:=0C;

INC(count);

RETURN TRUE END ParseRow;

END M2CSV.
