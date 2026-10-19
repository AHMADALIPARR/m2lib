(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2INI;

FROM M2Strings IMPORT Length,Equal;

PROCEDURE FindValue(line,key:ARRAY OF CHAR;

VAR value:ARRAY OF CHAR):BOOLEAN;

VAR i,j,k,n:CARDINAL;

BEGIN n:=Length(line);

i:=0;

WHILE(i<n)AND((line[i]=' ')OR(line[i]=9C))DO INC(i)END;

j:=0;

WHILE(j<Length(key))AND(i<n)DO IF line[i]#key[j]THEN RETURN FALSE END;

INC(i);

INC(j)END;

IF j#Length(key)THEN RETURN FALSE END;

WHILE(i<n)AND(line[i]=' ')DO INC(i)END;

IF(i>=n)OR(line[i]#'=')THEN RETURN FALSE END;

INC(i);

WHILE(i<n)AND(line[i]=' ')DO INC(i)END;

k:=0;

WHILE(i<n)AND(line[i]#'#')AND(line[i]#';')AND(k<HIGH(value))DO value[k]:=line[i];

INC(k);

INC(i)END;

value[k]:=0C;

RETURN TRUE END FindValue;

PROCEDURE ParseBoolean(s:ARRAY OF CHAR;

VAR value:BOOLEAN):BOOLEAN;

BEGIN IF Equal(s,"true")OR Equal(s,"yes")OR Equal(s,"1")THEN value:=TRUE;

RETURN TRUE END;

IF Equal(s,"false")OR Equal(s,"no")OR Equal(s,"0")THEN value:=FALSE;

RETURN TRUE END;

RETURN FALSE END ParseBoolean;

PROCEDURE ParseCardinal(s:ARRAY OF CHAR;

VAR value:CARDINAL):BOOLEAN;

VAR i,n,d:CARDINAL;

BEGIN n:=Length(s);

IF n=0 THEN RETURN FALSE END;

value:=0;

FOR i:=0 TO n-1 DO IF(s[i]<'0')OR(s[i]>'9')THEN RETURN FALSE END;

d:=ORD(s[i])-ORD('0');

IF value>(MAX(CARDINAL)-d)DIV 10 THEN RETURN FALSE END;

value:=value*10+d END;

RETURN TRUE END ParseCardinal;

END M2INI.
