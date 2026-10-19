(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2Text;

FROM M2Char IMPORT IsSpace;

PROCEDURE Length (s: ARRAY OF CHAR): CARDINAL;

VAR i: CARDINAL;

BEGIN i:=0;
 WHILE (i < HIGH(s)) AND (s[i] # 0C) DO INC(i) END;
 RETURN i END Length;

PROCEDURE Equal (a,b: ARRAY OF CHAR): BOOLEAN;

VAR i: CARDINAL;

BEGIN i:=0;
 LOOP IF a[i] # b[i] THEN RETURN FALSE END;
 IF a[i]=0C THEN RETURN TRUE END;
 INC(i);
 IF (i>HIGH(a)) OR (i>HIGH(b)) THEN RETURN FALSE END END END Equal;

PROCEDURE Compare (a,b: ARRAY OF CHAR): INTEGER;

VAR i: CARDINAL;

BEGIN i:=0;
 LOOP IF ORD(a[i])<ORD(b[i]) THEN RETURN -1 END;
 IF ORD(a[i])>ORD(b[i]) THEN RETURN 1 END;
 IF a[i]=0C THEN RETURN 0 END;
 INC(i);
 IF (i>HIGH(a)) OR (i>HIGH(b)) THEN RETURN 0 END END END Compare;

PROCEDURE Find (s,pattern: ARRAY OF CHAR;
 VAR position: CARDINAL): BOOLEAN;

VAR i,j,n,m: CARDINAL;

BEGIN
 n:=Length(s);
 m:=Length(pattern);
 IF m=0 THEN position:=0;
 RETURN TRUE END;

 IF m>n THEN RETURN FALSE END;

 FOR i:=0 TO n-m DO j:=0;
 WHILE (j<m) AND (s[i+j]=pattern[j]) DO INC(j) END;
 IF j=m THEN position:=i;
 RETURN TRUE END END;

 RETURN FALSE;

END Find;

PROCEDURE StartsWith (s,prefix: ARRAY OF CHAR): BOOLEAN;

VAR i,n: CARDINAL;

BEGIN n:=Length(prefix);
 IF n>Length(s) THEN RETURN FALSE END;
 FOR i:=0 TO n-1 DO IF s[i]#prefix[i] THEN RETURN FALSE END END;
 RETURN TRUE END StartsWith;

PROCEDURE EndsWith (s,suffix: ARRAY OF CHAR): BOOLEAN;

VAR i,n,m: CARDINAL;

BEGIN n:=Length(s);
 m:=Length(suffix);
 IF m>n THEN RETURN FALSE END;
 FOR i:=0 TO m-1 DO IF s[n-m+i]#suffix[i] THEN RETURN FALSE END END;
 RETURN TRUE END EndsWith;

PROCEDURE Copy (src: ARRAY OF CHAR;
 VAR dst: ARRAY OF CHAR): BOOLEAN;

VAR i,n: CARDINAL;

BEGIN n:=Length(src);
 IF n>HIGH(dst) THEN RETURN FALSE END;
 FOR i:=0 TO n-1 DO dst[i]:=src[i] END;
 dst[n]:=0C;
 RETURN TRUE END Copy;

PROCEDURE TrimLeft (s: ARRAY OF CHAR;
 VAR dst: ARRAY OF CHAR);

VAR i,j,n: CARDINAL;

BEGIN n:=Length(s);
 i:=0;
 WHILE (i<n) AND IsSpace(s[i]) DO INC(i) END;
 j:=0;
 WHILE (i<n) AND (j<HIGH(dst)) DO dst[j]:=s[i];
 INC(i);
 INC(j) END;
 dst[j]:=0C END TrimLeft;

PROCEDURE TrimRight (s: ARRAY OF CHAR;
 VAR dst: ARRAY OF CHAR);

VAR i,j,n: CARDINAL;

BEGIN n:=Length(s);
 WHILE (n>0) AND IsSpace(s[n-1]) DO DEC(n) END;
 j:=0;
 WHILE (j<n) AND (j<HIGH(dst)) DO dst[j]:=s[j];
 INC(j) END;
 dst[j]:=0C END TrimRight;

PROCEDURE Trim (s: ARRAY OF CHAR;
 VAR dst: ARRAY OF CHAR);

VAR i,j,n: CARDINAL;

BEGIN n:=Length(s);
 i:=0;
 WHILE (i<n) AND IsSpace(s[i]) DO INC(i) END;
 WHILE (n>i) AND IsSpace(s[n-1]) DO DEC(n) END;
 j:=0;
 WHILE (i<n) AND (j<HIGH(dst)) DO dst[j]:=s[i];
 INC(i);
 INC(j) END;
 dst[j]:=0C END Trim;

PROCEDURE ReplaceChar (s: ARRAY OF CHAR;
 oldChar,newChar: CHAR;
 VAR dst: ARRAY OF CHAR);

VAR i,n: CARDINAL;

BEGIN n:=Length(s);
 IF n>HIGH(dst) THEN n:=HIGH(dst) END;
 FOR i:=0 TO n-1 DO IF s[i]=oldChar THEN dst[i]:=newChar ELSE dst[i]:=s[i] END END;
 dst[n]:=0C END ReplaceChar;

PROCEDURE CountChar (s: ARRAY OF CHAR;
 c: CHAR): CARDINAL;

VAR i,n,k: CARDINAL;

BEGIN n:=Length(s);
 k:=0;
 FOR i:=0 TO n-1 DO IF s[i]=c THEN INC(k) END END;
 RETURN k END CountChar;

END M2Text.
