(* Assistant-added demo. Written, not executed: gm2 was unavailable. *)
MODULE core_demo;
FROM M2Version IMPORT Major, Minor, Patch, VersionString;
FROM M2Errors IMPORT Success, ErrInvalidArg, ErrorToString, ReportError, ClearError, LastError;
FROM M2Assert IMPORT Assert, AssertMsg;
FROM M2Strings IMPORT Equal;
VAR buf: ARRAY [0..63] OF CHAR;
BEGIN
  IF Major#0 THEN HALT(1) END;
  IF Minor#1 THEN HALT(2) END;
  IF Patch#0 THEN HALT(3) END;
  VersionString(buf);
  IF buf[0]#'M' THEN HALT(4) END;
  ClearError();
  IF LastError()#Success THEN HALT(5) END;
  ReportError(ErrInvalidArg,"demo");
  IF LastError()#ErrInvalidArg THEN HALT(6) END;
  ErrorToString(ErrInvalidArg,buf);
  IF NOT Equal(buf,"Invalid argument") THEN HALT(7) END;
  ClearError();
  IF LastError()#Success THEN HALT(8) END;
  Assert(TRUE);
  AssertMsg(TRUE,"holds");
END core_demo.
