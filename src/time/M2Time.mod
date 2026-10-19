IMPLEMENTATION MODULE M2Time;

PROCEDURE IsLeapYear(year:CARDINAL):BOOLEAN;

BEGIN RETURN(year MOD 4=0)AND((year MOD 100#0)OR(year MOD 400=0))END IsLeapYear;

PROCEDURE DaysInMonth(year,month:CARDINAL):CARDINAL;

BEGIN CASE month OF 1,3,5,7,8,10,12:RETURN 31|4,6,9,11:RETURN 30|2:IF IsLeapYear(year)THEN RETURN 29 ELSE RETURN 28 END ELSE RETURN 0 END END DaysInMonth;

PROCEDURE IsValidDate(d:Date):BOOLEAN;

BEGIN RETURN(d.year>0)AND(d.month>=1)AND(d.month<=12)AND(d.day>=1)AND(d.day<=DaysInMonth(d.year,d.month))END IsValidDate;

PROCEDURE DayOfYear(d:Date):CARDINAL;

VAR m,n:CARDINAL;

BEGIN IF NOT IsValidDate(d)THEN RETURN 0 END;

n:=d.day;

FOR m:=1 TO d.month-1 DO INC(n,DaysInMonth(d.year,m))END;

RETURN n END DayOfYear;

END M2Time.
