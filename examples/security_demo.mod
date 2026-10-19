(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

(* Assistant-added demo. Written, not executed: gm2 was unavailable.
   M2SHA256 fails closed by design: DigestHex returns FALSE and empties out. *)
MODULE security_demo;
FROM M2CRC32 IMPORT Compute;
FROM M2SHA256 IMPORT DigestHex;
VAR out: ARRAY [0..63] OF CHAR; ok: BOOLEAN;
BEGIN
  IF Compute("123456789")#16#CBF43926 THEN HALT(1) END;
  ok:=DigestHex("abc",out);
  IF ok THEN HALT(2) END;
  IF out[0]#0C THEN HALT(3) END;
END security_demo.
