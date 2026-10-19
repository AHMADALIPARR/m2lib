(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2Chars;

PROCEDURE IsAlpha(c:CHAR):BOOLEAN;

BEGIN RETURN((c>='A')AND(c<='Z'))OR((c>='a')AND(c<='z'))END IsAlpha;

PROCEDURE IsDigit(c:CHAR):BOOLEAN;

BEGIN RETURN(c>='0')AND(c<='9')END IsDigit;

PROCEDURE IsHexDigit(c:CHAR):BOOLEAN;

BEGIN RETURN IsDigit(c)OR((c>='A')AND(c<='F'))OR((c>='a')AND(c<='f'))END IsHexDigit;

PROCEDURE IsAlNum(c:CHAR):BOOLEAN;

BEGIN RETURN IsAlpha(c)OR IsDigit(c)END IsAlNum;

PROCEDURE IsSpace(c:CHAR):BOOLEAN;

BEGIN RETURN(c=' ')OR(c=9C)OR(c=10C)OR(c=13C)END IsSpace;

PROCEDURE ToUpper(c:CHAR):CHAR;

BEGIN IF(c>='a')AND(c<='z')THEN RETURN CHR(ORD(c)-32)ELSE RETURN c END END ToUpper;

PROCEDURE ToLower(c:CHAR):CHAR;

BEGIN IF(c>='A')AND(c<='Z')THEN RETURN CHR(ORD(c)+32)ELSE RETURN c END END ToLower;

PROCEDURE HexValue(c:CHAR):CARDINAL;

BEGIN IF IsDigit(c)THEN RETURN ORD(c)-ORD('0')END;

IF(c>='A')AND(c<='F')THEN RETURN ORD(c)-ORD('A')+10 END;

IF(c>='a')AND(c<='f')THEN RETURN ORD(c)-ORD('a')+10 END;

RETURN MAX(CARDINAL)END HexValue;

END M2Chars.
