IMPLEMENTATION MODULE M2Stack;

FROM M2Errors IMPORT ReportError,ErrOutOfMemory,ErrUnderflow;

PROCEDURE Create():Stack;

BEGIN RETURN NIL END Create;

PROCEDURE Destroy(VAR s:Stack);

VAR p:Stack;

BEGIN WHILE s#NIL DO p:=s;

s:=s^.next;

DISPOSE(p)END END Destroy;

PROCEDURE Push(VAR s:Stack;

v:CARDINAL):BOOLEAN;

VAR p:Stack;

BEGIN NEW(p);

IF p=NIL THEN ReportError(ErrOutOfMemory,"Stack.Push");

RETURN FALSE END;

p^.value:=v;

p^.next:=s;

s:=p;

RETURN TRUE END Push;

PROCEDURE Pop(VAR s:Stack;

VAR v:CARDINAL):BOOLEAN;

VAR p:Stack;

BEGIN IF s=NIL THEN ReportError(ErrUnderflow,"Stack.Pop");

RETURN FALSE END;

p:=s;

v:=p^.value;

s:=p^.next;

DISPOSE(p);

RETURN TRUE END Pop;

PROCEDURE Peek(s:Stack;

VAR v:CARDINAL):BOOLEAN;

BEGIN IF s=NIL THEN RETURN FALSE END;

v:=s^.value;

RETURN TRUE END Peek;

PROCEDURE Size(s:Stack):CARDINAL;

VAR n:CARDINAL;

BEGIN n:=0;

WHILE s#NIL DO INC(n);

s:=s^.next END;

RETURN n END Size;

PROCEDURE IsEmpty(s:Stack):BOOLEAN;

BEGIN RETURN s=NIL END IsEmpty;

END M2Stack.
