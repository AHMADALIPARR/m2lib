(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

MODULE test_core; FROM M2Math IMPORT GCD,LCM,Factorial; FROM M2Strings IMPORT Equal,StartsWith; FROM M2CRC32 IMPORT Compute; FROM M2Sort IMPORT HeapSort; VAR a:ARRAY [0..4] OF CARDINAL;r:CARDINAL; BEGIN IF GCD(48,18)#6 THEN HALT(1)END;IF NOT LCM(6,8,r)OR(r#24)THEN HALT(2)END;IF NOT Factorial(5,r)OR(r#120)THEN HALT(3)END;IF NOT Equal("m2","m2")THEN HALT(4)END;IF NOT StartsWith("library","lib")THEN HALT(5)END;a[0]:=4;a[1]:=1;a[2]:=3;a[3]:=0;a[4]:=2;HeapSort(a);IF(a[0]#0)OR(a[4]#4)THEN HALT(6)END;IF Compute("123456789")#16#CBF43926 THEN HALT(7)END END test_core.
