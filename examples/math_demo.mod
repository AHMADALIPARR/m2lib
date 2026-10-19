(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

(* Assistant-added demo. Written, not executed: gm2 was unavailable. *)
MODULE math_demo;
FROM M2Math IMPORT GCD, LCM, IsEven, MinCard, MaxCard, Clamp, Factorial;
FROM M2Complex IMPORT Complex, Make, Multiply, MagnitudeSquared;
FROM M2Matrix IMPORT Matrix2, Make2, Multiply2, Determinant2, Apply2;
FROM M2Time IMPORT Date, IsLeapYear, DaysInMonth, DayOfYear, IsValidDate;
FROM M2Limits IMPORT IsPowerOfTwo, NextPowerOfTwo, Log2Floor;
VAR r: CARDINAL; ok: BOOLEAN; z: Complex; m, id: Matrix2; ox, oy: REAL; d: Date;
BEGIN
  IF GCD(48,18)#6 THEN HALT(1) END;
  IF GCD(0,5)#5 THEN HALT(2) END;
  ok:=LCM(6,8,r); IF NOT ok OR (r#24) THEN HALT(3) END;
  ok:=Factorial(5,r); IF NOT ok OR (r#120) THEN HALT(4) END;
  IF NOT IsEven(0) THEN HALT(5) END;
  IF MinCard(3,7)#3 THEN HALT(6) END;
  IF MaxCard(3,7)#7 THEN HALT(7) END;
  IF Clamp(5,10,20)#10 THEN HALT(8) END;
  z:=Multiply(Make(2.0,3.0),Make(2.0,-3.0));
  IF MagnitudeSquared(z)#169.0 THEN HALT(9) END;
  m:=Make2(1.0,2.0,3.0,4.0);
  IF Determinant2(m)#-2.0 THEN HALT(10) END;
  id:=Make2(1.0,0.0,0.0,1.0);
  Apply2(id,3.0,4.0,ox,oy);
  IF (ox#3.0) OR (oy#4.0) THEN HALT(11) END;
  m:=Multiply2(id,Make2(1.0,2.0,3.0,4.0));
  IF (m.a11#1.0) OR (m.a22#4.0) THEN HALT(12) END;
  IF NOT IsLeapYear(2000) THEN HALT(13) END;
  IF IsLeapYear(1900) THEN HALT(14) END;
  IF DaysInMonth(2024,2)#29 THEN HALT(15) END;
  IF DaysInMonth(2023,2)#28 THEN HALT(16) END;
  d.year:=2024; d.month:=12; d.day:=31;
  IF NOT IsValidDate(d) THEN HALT(17) END;
  IF DayOfYear(d)#366 THEN HALT(18) END;
  IF NOT IsPowerOfTwo(1024) THEN HALT(19) END;
  IF IsPowerOfTwo(0) THEN HALT(20) END;
  IF NextPowerOfTwo(9)#16 THEN HALT(21) END;
  IF Log2Floor(9)#3 THEN HALT(22) END;
END math_demo.
