(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

(* Assistant-added demo. Written, not executed: gm2 was unavailable.
   Covers M2Endian only: M2Binary has same-named ReadBE32/WriteBE32, so it
   gets its own file (binary_stream_demo.mod) to avoid an import collision. *)
MODULE binary_demo;
FROM M2Endian IMPORT Swap16, Swap32, ReadBE16, ReadBE32, WriteBE16, WriteBE32;
VAR b0, b1, b2, b3, v: CARDINAL;
BEGIN
  IF Swap16(16#0102)#16#0201 THEN HALT(1) END;
  IF Swap32(16#01020304)#16#04030201 THEN HALT(2) END;
  IF ReadBE16(1,2)#16#0102 THEN HALT(3) END;
  IF ReadBE32(1,2,3,4)#16#01020304 THEN HALT(4) END;
  WriteBE16(16#0102,b0,b1);
  IF (b0#1) OR (b1#2) THEN HALT(5) END;
  WriteBE32(16#01020304,b0,b1,b2,b3);
  IF (b0#1) OR (b1#2) OR (b2#3) OR (b3#4) THEN HALT(6) END;
END binary_demo.
