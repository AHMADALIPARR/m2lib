(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2SHA256;

FROM M2Errors IMPORT ReportError,ErrNotSupported;

PROCEDURE DigestHex(data:ARRAY OF CHAR;

VAR out:ARRAY OF CHAR):BOOLEAN;

BEGIN IF HIGH(out)>=0 THEN out[0]:=0C END;

ReportError(ErrNotSupported,"SHA-256 backend requires verified 32-bit unsigned arithmetic");

RETURN FALSE END DigestHex;

END M2SHA256.
