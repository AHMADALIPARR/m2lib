IMPLEMENTATION MODULE M2Assert;

FROM M2Errors IMPORT ReportError,ErrGeneric;

FROM StrIO IMPORT WriteString,WriteLn;

PROCEDURE Fail(kind:ARRAY OF CHAR;

msg:ARRAY OF CHAR);

BEGIN WriteString(kind);

WriteString(": ");

WriteString(msg);

WriteLn;

ReportError(ErrGeneric,msg);

HALT END Fail;

PROCEDURE Assert(cond:BOOLEAN);

BEGIN IF NOT cond THEN Fail("Assert","assertion failed") END END Assert;

PROCEDURE AssertMsg(cond:BOOLEAN;

msg:ARRAY OF CHAR);

BEGIN IF NOT cond THEN Fail("Assert",msg) END END AssertMsg;

PROCEDURE Require(cond:BOOLEAN;

msg:ARRAY OF CHAR);

BEGIN IF NOT cond THEN Fail("Require",msg) END END Require;

PROCEDURE Ensure(cond:BOOLEAN;

msg:ARRAY OF CHAR);

BEGIN IF NOT cond THEN Fail("Ensure",msg) END END Ensure;

PROCEDURE Invariant(cond:BOOLEAN;

msg:ARRAY OF CHAR);

BEGIN IF NOT cond THEN Fail("Invariant",msg) END END Invariant;

END M2Assert.
