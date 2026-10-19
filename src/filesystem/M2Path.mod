(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2Path;

FROM M2Strings IMPORT Length,Copy,Append,SubString;

PROCEDURE IsAbsolute(path:ARRAY OF CHAR):BOOLEAN;

BEGIN RETURN(Length(path)>0)AND(path[0]='/')END IsAbsolute;

PROCEDURE Join(a,b:ARRAY OF CHAR;

VAR out:ARRAY OF CHAR):BOOLEAN;

VAR n:CARDINAL;

BEGIN Copy(a,out);

n:=Length(out);

IF(n>0)AND(out[n-1]#'/')AND(Length(b)>0)AND(b[0]#'/')THEN Append("/",out)END;

IF IsAbsolute(b)THEN Copy(b,out)ELSE Append(b,out)END;

RETURN Length(out)>0 END Join;

PROCEDURE Basename(path:ARRAY OF CHAR;

VAR out:ARRAY OF CHAR);

VAR i,n:CARDINAL;

BEGIN n:=Length(path);

i:=n;

WHILE i>0 DO DEC(i);

IF path[i]='/'THEN INC(i);

EXIT END END;

SubString(path,i,n-i,out)END Basename;

PROCEDURE Dirname(path:ARRAY OF CHAR;

VAR out:ARRAY OF CHAR);

VAR i,n:CARDINAL;

BEGIN n:=Length(path);

i:=n;

WHILE i>0 DO DEC(i);

IF path[i]='/'THEN IF i=0 THEN SubString(path,0,1,out)ELSE SubString(path,0,i,out)END;

RETURN END END;

Copy(".",out)END Dirname;

PROCEDURE Extension(path:ARRAY OF CHAR;

VAR out:ARRAY OF CHAR);

VAR i,n,b:CARDINAL;

BEGIN n:=Length(path);

b:=0;

FOR i:=0 TO n-1 DO IF path[i]='/'THEN b:=i+1 END END;

i:=n;

WHILE i>b DO DEC(i);

IF path[i]='.'THEN SubString(path,i,n-i,out);

RETURN END END;

Copy("",out)END Extension;

END M2Path.
