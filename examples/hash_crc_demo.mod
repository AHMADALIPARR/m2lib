(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

(* Assistant-added demo. Written, not executed: gm2 was unavailable. *)
MODULE hash_crc_demo;
FROM M2Hash IMPORT FNV1a32, DJB2, Mix32;
FROM M2CRC32 IMPORT Compute, Update;
FROM M2Strings IMPORT Equal;
VAR h1, h2: CARDINAL; s: ARRAY [0..63] OF CHAR;
BEGIN
  IF FNV1a32("")#2166136261 THEN HALT(1) END;
  IF DJB2("")#5381 THEN HALT(2) END;
  IF Mix32(0)#0 THEN HALT(3) END;
  h1:=FNV1a32("a"); h2:=FNV1a32("b");
  IF h1=h2 THEN HALT(4) END;
  h1:=DJB2("a"); h2:=DJB2("b");
  IF h1=h2 THEN HALT(5) END;
  IF Compute("")#0 THEN HALT(6) END;
  IF Compute("123456789")#16#CBF43926 THEN HALT(7) END;
  IF Update(16#FFFFFFFF,"123456789") XOR 16#FFFFFFFF # Compute("123456789") THEN HALT(8) END;
END hash_crc_demo.
