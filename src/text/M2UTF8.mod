(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2UTF8;

PROCEDURE DecodeRune(s:ARRAY OF CHAR;

pos:CARDINAL;

VAR rune,width:CARDINAL):BOOLEAN;

VAR n,b,b1,b2,b3:CARDINAL;

BEGIN n:=0;

WHILE(n<=HIGH(s))AND(s[n]#0C)DO INC(n)END;

IF pos>=n THEN RETURN FALSE END;

b:=ORD(s[pos]);

IF b<128 THEN rune:=b;

width:=1;

RETURN TRUE END;

IF(b>=194)AND(b<=223)THEN width:=2 ELSIF(b>=224)AND(b<=239)THEN width:=3 ELSIF(b>=240)AND(b<=244)THEN width:=4 ELSE RETURN FALSE END;

IF pos+width>n THEN RETURN FALSE END;

b1:=ORD(s[pos+1]);

IF(b1<128)OR(b1>191)THEN RETURN FALSE END;

IF width=2 THEN rune:=(b MOD 32)*64+(b1 MOD 64);

RETURN TRUE END;

b2:=ORD(s[pos+2]);

IF(b2<128)OR(b2>191)THEN RETURN FALSE END;

IF width=3 THEN IF(b=224)AND(b1<160)THEN RETURN FALSE END;

IF(b=237)AND(b1>159)THEN RETURN FALSE END;

rune:=(b MOD 16)*4096+(b1 MOD 64)*64+(b2 MOD 64);

RETURN TRUE END;

b3:=ORD(s[pos+3]);

IF(b3<128)OR(b3>191)THEN RETURN FALSE END;

IF(b=240)AND(b1<144)THEN RETURN FALSE END;

IF(b=244)AND(b1>143)THEN RETURN FALSE END;

rune:=(b MOD 8)*262144+(b1 MOD 64)*4096+(b2 MOD 64)*64+(b3 MOD 64);

RETURN TRUE END DecodeRune;

PROCEDURE IsValid(s:ARRAY OF CHAR):BOOLEAN;

VAR p,r,w,n:CARDINAL;

BEGIN n:=0;

WHILE(n<=HIGH(s))AND(s[n]#0C)DO INC(n)END;

p:=0;

WHILE p<n DO IF NOT DecodeRune(s,p,r,w)THEN RETURN FALSE END;

INC(p,w)END;

RETURN TRUE END IsValid;

PROCEDURE CountRunes(s:ARRAY OF CHAR;

VAR count:CARDINAL):BOOLEAN;

VAR p,r,w,n:CARDINAL;

BEGIN n:=0;

WHILE(n<=HIGH(s))AND(s[n]#0C)DO INC(n)END;

p:=0;

count:=0;

WHILE p<n DO IF NOT DecodeRune(s,p,r,w)THEN RETURN FALSE END;

INC(count);

INC(p,w)END;

RETURN TRUE END CountRunes;


PROCEDURE Continuation (b: CARDINAL): BOOLEAN;
 BEGIN RETURN (b>=128) AND (b<=191) END Continuation;

PROCEDURE DecodeOne (data: ARRAY OF CHAR;
 length,offset: CARDINAL;
 VAR codePoint,nextOffset: CARDINAL): BOOLEAN;

VAR a,b,c,d: CARDINAL;

BEGIN
 IF (length>HIGH(data)+1) OR (offset>=length) THEN RETURN FALSE END;
 a:=ORD(data[offset]);

 IF a<128 THEN codePoint:=a;
 nextOffset:=offset+1;
 RETURN TRUE END;

 IF (a>=194) AND (a<=223) THEN IF offset+1>=length THEN RETURN FALSE END;
 b:=ORD(data[offset+1]);
 IF NOT Continuation(b) THEN RETURN FALSE END;
 codePoint:=(a-192)*64+(b-128);
 nextOffset:=offset+2;
 RETURN TRUE END;

 IF (a>=224) AND (a<=239) THEN IF offset+2>=length THEN RETURN FALSE END;
 b:=ORD(data[offset+1]);
 c:=ORD(data[offset+2]);
 IF NOT Continuation(b) OR NOT Continuation(c) THEN RETURN FALSE END;
 IF ((a=224) AND (b<160)) OR ((a=237) AND (b>=160)) THEN RETURN FALSE END;
 codePoint:=(a-224)*4096+(b-128)*64+(c-128);
 nextOffset:=offset+3;
 RETURN TRUE END;

 IF (a>=240) AND (a<=244) THEN IF offset+3>=length THEN RETURN FALSE END;
 b:=ORD(data[offset+1]);
 c:=ORD(data[offset+2]);
 d:=ORD(data[offset+3]);
 IF NOT Continuation(b) OR NOT Continuation(c) OR NOT Continuation(d) THEN RETURN FALSE END;
 IF ((a=240) AND (b<144)) OR ((a=244) AND (b>143)) THEN RETURN FALSE END;
 codePoint:=(a-240)*262144+(b-128)*4096+(c-128)*64+(d-128);
 nextOffset:=offset+4;
 RETURN TRUE END;

 RETURN FALSE;

END DecodeOne;

PROCEDURE Validate (data: ARRAY OF CHAR;
 length: CARDINAL;
 VAR badOffset: CARDINAL): BOOLEAN;

VAR i,j,cp: CARDINAL;

BEGIN IF length>HIGH(data)+1 THEN badOffset:=0;
 RETURN FALSE END;
 i:=0;
 WHILE i<length DO IF NOT DecodeOne(data,length,i,cp,j) THEN badOffset:=i;
 RETURN FALSE END;
 i:=j END;
 badOffset:=length;
 RETURN TRUE END Validate;

PROCEDURE CountCodePoints (data: ARRAY OF CHAR;
 length: CARDINAL;
 VAR count: CARDINAL): BOOLEAN;

VAR i,j,cp: CARDINAL;

BEGIN count:=0;
 IF length>HIGH(data)+1 THEN RETURN FALSE END;
 i:=0;
 WHILE i<length DO IF NOT DecodeOne(data,length,i,cp,j) THEN RETURN FALSE END;
 i:=j;
 INC(count) END;
 RETURN TRUE END CountCodePoints;
END M2UTF8.
