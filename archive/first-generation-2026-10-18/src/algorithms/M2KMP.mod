(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2KMP;

PROCEDURE Len (s: ARRAY OF CHAR): CARDINAL;

VAR n: CARDINAL;

BEGIN n:=0;

WHILE (n<=HIGH(s)) AND (s[n]#0C) DO INC(n) END;

RETURN n;

END Len;

PROCEDURE Prefix (pattern: ARRAY OF CHAR;
 n: CARDINAL;
 VAR pi: ARRAY OF CARDINAL);

VAR i,j: CARDINAL;

BEGIN IF n=0 THEN RETURN END;

pi[0]:=0;
 j:=0;

FOR i:=1 TO n-1 DO
WHILE (j>0) AND (pattern[i]#pattern[j]) DO j:=pi[j-1] END;

IF pattern[i]=pattern[j] THEN INC(j) END;

pi[i]:=j;

END;

END Prefix;

PROCEDURE Find (text,pattern: ARRAY OF CHAR;
 startAt: CARDINAL;
 VAR position: CARDINAL): BOOLEAN;

VAR n,m,i,j: CARDINAL;
 pi: ARRAY [0..1023] OF CARDINAL;

BEGIN n:=Len(text);
 m:=Len(pattern);

IF m=0 THEN position:=startAt;
 RETURN startAt<=n END;

IF (m>1024) OR (startAt>n) THEN RETURN FALSE END;

Prefix(pattern,m,pi);
 i:=startAt;
 j:=0;

WHILE i<n DO
WHILE (j>0) AND (text[i]#pattern[j]) DO j:=pi[j-1] END;

IF text[i]=pattern[j] THEN INC(j) END;

IF j=m THEN position:=i+1-m;
 RETURN TRUE END;

INC(i);

END;

RETURN FALSE;

END Find;

PROCEDURE CountMatches (text,pattern: ARRAY OF CHAR): CARDINAL;

VAR n,m,i,j,count: CARDINAL;
 pi: ARRAY [0..1023] OF CARDINAL;

BEGIN n:=Len(text);
 m:=Len(pattern);
 IF m=0 THEN RETURN 0 END;
 IF m>1024 THEN RETURN 0 END;

Prefix(pattern,m,pi);
 i:=0;
 j:=0;
 count:=0;

WHILE i<n DO
WHILE (j>0) AND (text[i]#pattern[j]) DO j:=pi[j-1] END;

IF text[i]=pattern[j] THEN INC(j) END;

IF j=m THEN INC(count);
 j:=pi[j-1] END;

INC(i);

END;

RETURN count;

END CountMatches;

END M2KMP.
