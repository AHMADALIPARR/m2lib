(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2Version;

PROCEDURE VersionString(VAR s:ARRAY OF CHAR);

VAR i:CARDINAL;

v:ARRAY [0..10] OF CHAR;

BEGIN v:="M2Lib 0.1.0";

i:=0;

WHILE (i<=HIGH(v)) AND (i<=HIGH(s)) DO s[i]:=v[i];

INC(i) END END VersionString;

END M2Version.
