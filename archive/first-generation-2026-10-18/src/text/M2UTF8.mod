(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2UTF8;

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
