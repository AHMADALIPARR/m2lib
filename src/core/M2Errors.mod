(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2Errors;

FROM StrIO IMPORT WriteString, WriteLn;

FROM NumberIO IMPORT WriteCard;

VAR lastErr: ErrorCode;

PROCEDURE CopyStr(src: ARRAY OF CHAR;

VAR dst: ARRAY OF CHAR);

VAR i:CARDINAL;

BEGIN i:=0;

WHILE (i<=HIGH(src)) AND (i<=HIGH(dst)) AND (src[i]#0C) DO dst[i]:=src[i];

INC(i) END;

IF i<=HIGH(dst) THEN dst[i]:=0C END END CopyStr;

PROCEDURE ErrorToString(code: ErrorCode;

VAR s: ARRAY OF CHAR);

BEGIN CASE code OF Success:CopyStr("Success",s)|ErrGeneric:CopyStr("Generic error",s)|ErrOutOfMemory:CopyStr("Out of memory",s)|ErrInvalidArg:CopyStr("Invalid argument",s)|ErrIndexOutOfBounds:CopyStr("Index out of bounds",s)|ErrNotFound:CopyStr("Not found",s)|ErrAlreadyExists:CopyStr("Already exists",s)|ErrIO:CopyStr("I/O error",s)|ErrOverflow:CopyStr("Overflow",s)|ErrUnderflow:CopyStr("Underflow",s)|ErrDivByZero:CopyStr("Division by zero",s)|ErrDomain:CopyStr("Domain error",s)|ErrRange:CopyStr("Range error",s)|ErrFormat:CopyStr("Format error",s)|ErrEOF:CopyStr("End of file",s)|ErrPermission:CopyStr("Permission denied",s)|ErrNotSupported:CopyStr("Not supported",s)|ErrTimeout:CopyStr("Timeout",s)|ErrBusy:CopyStr("Busy",s)|ErrInterrupted:CopyStr("Interrupted",s)|ErrCorrupt:CopyStr("Corrupt data",s) ELSE CopyStr("Unknown error",s) END END ErrorToString;

PROCEDURE ReportError(code: ErrorCode;

msg: ARRAY OF CHAR);

BEGIN lastErr:=code;

WriteString("M2Lib Error [");

WriteCard(ORD(code),0);

WriteString("]: ");

WriteString(msg);

WriteLn END ReportError;

PROCEDURE ClearError;

BEGIN lastErr:=Success END ClearError;

PROCEDURE LastError(): ErrorCode;

BEGIN RETURN lastErr END LastError;

BEGIN lastErr:=Success END M2Errors.
