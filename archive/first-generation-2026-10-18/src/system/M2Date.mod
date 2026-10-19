(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2Date;

PROCEDURE IsLeapYear (year: CARDINAL): BOOLEAN;
 BEGIN RETURN (year MOD 4=0) AND ((year MOD 100#0) OR (year MOD 400=0)) END IsLeapYear;

PROCEDURE DaysInMonth (year,month: CARDINAL): CARDINAL;

BEGIN IF month=2 THEN IF IsLeapYear(year) THEN RETURN 29 ELSE RETURN 28 END ELSIF (month=4) OR (month=6) OR (month=9) OR (month=11) THEN RETURN 30 ELSIF (month>=1) AND (month<=12) THEN RETURN 31 ELSE RETURN 0 END END DaysInMonth;

PROCEDURE Valid (d: Date): BOOLEAN;
 BEGIN RETURN (d.year>=1) AND (d.month>=1) AND (d.month<=12) AND (d.day>=1) AND (d.day<=DaysInMonth(d.year,d.month)) END Valid;

PROCEDURE DayOfYear (d: Date;
 VAR day: CARDINAL): BOOLEAN;

VAR m: CARDINAL;

BEGIN IF NOT Valid(d) THEN RETURN FALSE END;
 day:=d.day;
 FOR m:=1 TO d.month-1 DO INC(day,DaysInMonth(d.year,m)) END;
 RETURN TRUE END DayOfYear;

PROCEDURE Weekday (d: Date;
 VAR weekday: CARDINAL): BOOLEAN;

VAR y,m,day: INTEGER;

BEGIN IF NOT Valid(d) THEN RETURN FALSE END;
 y:=INTEGER(d.year);
 m:=INTEGER(d.month);
 day:=INTEGER(d.day);
 IF m<3 THEN DEC(y);
 INC(m,12) END;
 weekday:=CARDINAL((day+2*m+3*(m+1) DIV 5+y+y DIV 4-y DIV 100+y DIV 400) MOD 7);
 RETURN TRUE END Weekday;

END M2Date.
