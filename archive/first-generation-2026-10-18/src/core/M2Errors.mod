IMPLEMENTATION MODULE M2Errors;

VAR handler: ErrorHandler;

PROCEDURE SetHandler (h: ErrorHandler);

BEGIN handler := h END SetHandler;

PROCEDURE ReportError (code: ErrorCode;
 context: ARRAY OF CHAR);

BEGIN IF handler # NIL THEN handler(code, context) END END ReportError;

BEGIN handler := NIL
END M2Errors.
