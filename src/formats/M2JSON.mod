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

PROCEDURE Length (s: ARRAY OF CHAR): CARDINAL;
 VAR n: CARDINAL;
 BEGIN n:=0;
 WHILE (n<=HIGH(s)) AND (s[n]#0C) DO INC(n) END;
 RETURN n END Length;

PROCEDURE UnescapeString (source: ARRAY OF CHAR;
 VAR destination: ARRAY OF CHAR): BOOLEAN;

VAR i,o,n: CARDINAL;
 c: CHAR;

BEGIN n:=Length(source);
 i:=0;
 o:=0;
 WHILE i<n DO c:=source[i];
 INC(i);
 IF c='\' THEN IF i>=n THEN RETURN FALSE END;
 c:=source[i];
 INC(i);
 IF c='"' THEN c:='"' ELSIF c='\' THEN c:='\' ELSIF c='/' THEN c:='/' ELSIF c='b' THEN c:=CHR(8) ELSIF c='f' THEN c:=CHR(12) ELSIF c='n' THEN c:=CHR(10) ELSIF c='r' THEN c:=CHR(13) ELSIF c='t' THEN c:=CHR(9) ELSE RETURN FALSE END END;
 IF o>=HIGH(destination) THEN RETURN FALSE END;
 destination[o]:=c;
 INC(o) END;
 destination[o]:=0C;
 RETURN TRUE END UnescapeString;

PROCEDURE IsNumber (source: ARRAY OF CHAR): BOOLEAN;

VAR i,n,digits: CARDINAL;
 hasDot,hasExp: BOOLEAN;

BEGIN n:=Length(source);
 IF n=0 THEN RETURN FALSE END;
 i:=0;
 IF (source[i]='-') OR (source[i]='+') THEN INC(i) END;
 digits:=0;
 WHILE (i<n) AND (source[i]>='0') AND (source[i]<='9') DO INC(i);
 INC(digits) END;
 hasDot:=FALSE;
 IF (i<n) AND (source[i]='.') THEN hasDot:=TRUE;
 INC(i);
 WHILE (i<n) AND (source[i]>='0') AND (source[i]<='9') DO INC(i);
 INC(digits) END END;
 IF digits=0 THEN RETURN FALSE END;
 hasExp:=FALSE;
 IF (i<n) AND ((source[i]='e') OR (source[i]='E')) THEN hasExp:=TRUE;
 INC(i);
 IF (i<n) AND ((source[i]='+') OR (source[i]='-')) THEN INC(i) END;
 digits:=0;
 WHILE (i<n) AND (source[i]>='0') AND (source[i]<='9') DO INC(i);
 INC(digits) END;
 IF digits=0 THEN RETURN FALSE END END;
 RETURN i=n END IsNumber;

END M2JSON.
