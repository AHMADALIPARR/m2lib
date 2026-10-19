(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2Strings;

PROCEDURE Length(s:ARRAY OF CHAR):CARDINAL;

VAR i:CARDINAL;

BEGIN i:=0;

WHILE(i<=HIGH(s))AND(s[i]#0C)DO INC(i)END;

RETURN i END Length;

PROCEDURE Copy(src:ARRAY OF CHAR;

VAR dst:ARRAY OF CHAR);

VAR i:CARDINAL;

BEGIN i:=0;

WHILE(i<Length(src))AND(i<HIGH(dst))DO dst[i]:=src[i];

INC(i)END;

IF i<=HIGH(dst)THEN dst[i]:=0C END END Copy;

PROCEDURE Append(src:ARRAY OF CHAR;

VAR dst:ARRAY OF CHAR);

VAR i,j:CARDINAL;

BEGIN i:=Length(dst);

j:=0;

WHILE(j<Length(src))AND(i<HIGH(dst))DO dst[i]:=src[j];

INC(i);

INC(j)END;

IF i<=HIGH(dst)THEN dst[i]:=0C END END Append;

PROCEDURE Compare(a,b:ARRAY OF CHAR):INTEGER;

VAR i:CARDINAL;

BEGIN i:=0;

LOOP IF a[i]<b[i]THEN RETURN -1 END;

IF a[i]>b[i]THEN RETURN 1 END;

IF(a[i]=0C)OR(i>=HIGH(a))OR(i>=HIGH(b))THEN EXIT END;

INC(i)END;

RETURN 0 END Compare;

PROCEDURE Equal(a,b:ARRAY OF CHAR):BOOLEAN;

BEGIN RETURN Compare(a,b)=0 END Equal;

PROCEDURE Index(s,pattern:ARRAY OF CHAR):INTEGER;

VAR i,j,ns,np:CARDINAL;

BEGIN ns:=Length(s);

np:=Length(pattern);

IF np=0 THEN RETURN 0 END;

IF np>ns THEN RETURN -1 END;

i:=0;

WHILE i+np<=ns DO j:=0;

WHILE(j<np)AND(s[i+j]=pattern[j])DO INC(j)END;

IF j=np THEN RETURN VAL(INTEGER,i)END;

INC(i)END;

RETURN -1 END Index;

PROCEDURE RIndex(s,pattern:ARRAY OF CHAR):INTEGER;

VAR i,j,ns,np:CARDINAL;

BEGIN ns:=Length(s);

np:=Length(pattern);

IF np=0 THEN RETURN VAL(INTEGER,ns)END;

IF np>ns THEN RETURN -1 END;

i:=ns-np+1;

WHILE i>0 DO DEC(i);

j:=0;

WHILE(j<np)AND(s[i+j]=pattern[j])DO INC(j)END;

IF j=np THEN RETURN VAL(INTEGER,i)END END;

RETURN -1 END RIndex;

PROCEDURE SubString(s:ARRAY OF CHAR;

start,count:CARDINAL;

VAR dst:ARRAY OF CHAR);

VAR i:CARDINAL;

BEGIN i:=0;

WHILE(i<count)AND(start+i<Length(s))AND(i<HIGH(dst))DO dst[i]:=s[start+i];

INC(i)END;

IF i<=HIGH(dst)THEN dst[i]:=0C END END SubString;

PROCEDURE Trim(s:ARRAY OF CHAR;

VAR dst:ARRAY OF CHAR);

VAR i,n:CARDINAL;

BEGIN n:=Length(s);

i:=0;

WHILE(i<n)AND((s[i]=' ')OR(s[i]=9C)OR(s[i]=10C)OR(s[i]=13C))DO INC(i)END;

WHILE n>i DO IF(s[n-1]=' ')OR(s[n-1]=9C)OR(s[n-1]=10C)OR(s[n-1]=13C)THEN DEC(n)ELSE EXIT END END;

SubString(s,i,n-i,dst)END Trim;

PROCEDURE ToUpper(s:ARRAY OF CHAR;

VAR dst:ARRAY OF CHAR);

VAR i:CARDINAL;

c:CHAR;

BEGIN i:=0;

WHILE(i<Length(s))AND(i<HIGH(dst))DO c:=s[i];

IF(c>='a')AND(c<='z')THEN c:=CHR(ORD(c)-32)END;

dst[i]:=c;

INC(i)END;

IF i<=HIGH(dst)THEN dst[i]:=0C END END ToUpper;

PROCEDURE ToLower(s:ARRAY OF CHAR;

VAR dst:ARRAY OF CHAR);

VAR i:CARDINAL;

c:CHAR;

BEGIN i:=0;

WHILE(i<Length(s))AND(i<HIGH(dst))DO c:=s[i];

IF(c>='A')AND(c<='Z')THEN c:=CHR(ORD(c)+32)END;

dst[i]:=c;

INC(i)END;

IF i<=HIGH(dst)THEN dst[i]:=0C END END ToLower;

PROCEDURE StartsWith(s,prefix:ARRAY OF CHAR):BOOLEAN;

VAR i:CARDINAL;

BEGIN i:=0;

WHILE i<Length(prefix)DO IF(i>=Length(s))OR(s[i]#prefix[i])THEN RETURN FALSE END;

INC(i)END;

RETURN TRUE END StartsWith;

PROCEDURE EndsWith(s,suffix:ARRAY OF CHAR):BOOLEAN;

VAR i,ns,np:CARDINAL;

BEGIN ns:=Length(s);

np:=Length(suffix);

IF np>ns THEN RETURN FALSE END;

i:=0;

WHILE i<np DO IF s[ns-np+i]#suffix[i]THEN RETURN FALSE END;

INC(i)END;

RETURN TRUE END EndsWith;

PROCEDURE IsEmpty(s:ARRAY OF CHAR):BOOLEAN;

BEGIN RETURN Length(s)=0 END IsEmpty;

PROCEDURE Fill(ch:CHAR;

n:CARDINAL;

VAR dst:ARRAY OF CHAR);

VAR i:CARDINAL;

BEGIN i:=0;

WHILE(i<n)AND(i<HIGH(dst))DO dst[i]:=ch;

INC(i)END;

IF i<=HIGH(dst)THEN dst[i]:=0C END END Fill;

PROCEDURE Reverse(s:ARRAY OF CHAR;

VAR dst:ARRAY OF CHAR);

VAR i,n:CARDINAL;

BEGIN n:=Length(s);

i:=0;

WHILE(i<n)AND(i<HIGH(dst))DO dst[i]:=s[n-i-1];

INC(i)END;

IF i<=HIGH(dst)THEN dst[i]:=0C END END Reverse;

END M2Strings.
