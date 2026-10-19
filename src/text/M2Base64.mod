(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2Base64;

CONST alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

PROCEDURE Encode (source: ARRAY OF CHAR;
 length: CARDINAL;
 VAR destination: ARRAY OF CHAR): BOOLEAN;

VAR i,o,a,b,c: CARDINAL;

BEGIN IF length>HIGH(source)+1 THEN RETURN FALSE END;
 IF ((length+2) DIV 3)*4>HIGH(destination) THEN RETURN FALSE END;
 i:=0;
 o:=0;

 WHILE i<length DO a:=ORD(source[i]);
 b:=0;
 c:=0;
 IF i+1<length THEN b:=ORD(source[i+1]) END;
 IF i+2<length THEN c:=ORD(source[i+2]) END;

 destination[o]:=alphabet[a DIV 4];
 destination[o+1]:=alphabet[(a MOD 4)*16+b DIV 16];

 IF i+1<length THEN destination[o+2]:=alphabet[(b MOD 16)*4+c DIV 64] ELSE destination[o+2]:='=' END;

 IF i+2<length THEN destination[o+3]:=alphabet[c MOD 64] ELSE destination[o+3]:='=' END;

 INC(i,3);
 INC(o,4) END;
 destination[o]:=0C;
 RETURN TRUE END Encode;

PROCEDURE Value (c: CHAR;
 VAR v: CARDINAL): BOOLEAN;

VAR i: CARDINAL;

BEGIN FOR i:=0 TO 63 DO IF alphabet[i]=c THEN v:=i;
 RETURN TRUE END END;
 RETURN FALSE END Value;

PROCEDURE Decode (source: ARRAY OF CHAR;
 VAR destination: ARRAY OF CHAR;
 VAR written: CARDINAL): BOOLEAN;

VAR n,i,o,a,b,c,d: CARDINAL;
 ch: CHAR;

BEGIN n:=0;
 WHILE (n<=HIGH(source)) AND (source[n]#0C) DO INC(n) END;
 written:=0;
 IF n MOD 4#0 THEN RETURN FALSE END;
 IF (n DIV 4)*3>HIGH(destination)+2 THEN RETURN FALSE END;
 i:=0;
 o:=0;

 WHILE i<n DO IF NOT Value(source[i],a) OR NOT Value(source[i+1],b) THEN RETURN FALSE END;

 ch:=source[i+2];
 IF ch='=' THEN c:=0 ELSE IF NOT Value(ch,c) THEN RETURN FALSE END END;

 ch:=source[i+3];
 IF ch='=' THEN d:=0 ELSE IF NOT Value(ch,d) THEN RETURN FALSE END END;

 destination[o]:=CHR(a*4+b DIV 16);
 INC(o);

 IF source[i+2]#'=' THEN destination[o]:=CHR((b MOD 16)*16+c DIV 4);
 INC(o) ELSIF source[i+3]#'=' THEN RETURN FALSE END;

 IF source[i+3]#'=' THEN destination[o]:=CHR((c MOD 4)*64+d);
 INC(o) END;

 IF (source[i+2]='=') AND (i+4<n) THEN RETURN FALSE END;
 IF (source[i+3]='=') AND (i+4<n) THEN RETURN FALSE END;

 INC(i,4) END;
 written:=o;
 RETURN TRUE END Decode;

END M2Base64.
