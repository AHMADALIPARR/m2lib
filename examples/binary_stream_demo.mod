(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

(* Assistant-added demo. Written, not executed: gm2 was unavailable. *)
MODULE binary_stream_demo;
FROM M2Binary IMPORT ReadBE32, WriteBE32;
VAR buf: ARRAY [0..7] OF CHAR; v: CARDINAL; ok: BOOLEAN;
BEGIN
  ok:=WriteBE32(buf,0,16#01020304);
  IF NOT ok THEN HALT(1) END;
  ok:=ReadBE32(buf,0,v);
  IF NOT ok OR (v#16#01020304) THEN HALT(2) END;
  ok:=WriteBE32(buf,6,16#01020304);
  IF ok THEN HALT(3) END;
  ok:=ReadBE32(buf,6,v);
  IF ok THEN HALT(4) END;
END binary_stream_demo.
