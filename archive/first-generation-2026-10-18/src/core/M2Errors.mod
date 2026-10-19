(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2Errors;

VAR handler: ErrorHandler;

PROCEDURE SetHandler (h: ErrorHandler);

BEGIN handler := h END SetHandler;

PROCEDURE ReportError (code: ErrorCode;
 context: ARRAY OF CHAR);

BEGIN IF handler # NIL THEN handler(code, context) END END ReportError;

BEGIN handler := NIL
END M2Errors.
